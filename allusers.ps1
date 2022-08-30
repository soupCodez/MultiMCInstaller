$user = $env:UserName

$installDir = Read-Host -Prompt "What directory should MultiMC be installed to? (Default is Program Files)"

if ([string]::IsNullOrWhiteSpace($installDir)) {
    $installDir = "C:\Program Files\"
}

Invoke-WebRequest -Uri "https://files.multimc.org/downloads/mmc-stable-win32.zip" -OutFile "C:\Users\$user\Downloads\MultiMC.zip"
Expand-Archive "C:\Users\$user\Downloads\MultiMC.zip" -DestinationPath $installDir -Force

$question = 'Do you want to make a Desktop shortcut?'
$choices  = '&Yes', '&No'

$desktopShortcut = $Host.UI.PromptForChoice("Question", $question, $choices, 0)
if ($desktopShortcut -eq 0) {
    $SourceFilePath = "$installDir\MultiMC\MultiMC.exe"
    $ShortcutPath = "C:\Users\$user\Desktop\MultiMC.lnk"
    $WScriptObj = New-Object -ComObject ("WScript.Shell")
    $shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
    $shortcut.TargetPath = $SourceFilePath
    $shortcut.Save()
} else {
    Write-Host 'NO DESKTOP SHORTCUT WILL BE CREATED'
}

$question = 'Do you want to make a start menu shortcut?'
$choices  = '&Yes', '&No'

$startMenuShortcut = $Host.UI.PromptForChoice("Question", $question, $choices, 0)
if ($startMenuShortcut -eq 0) {
    $WScriptObj = New-Object -ComObject ("WScript.Shell")
    $SourceFilePath = "$installDir\MultiMC\MultiMC.exe"
    $ShortcutPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MultiMC.lnk"
    $shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
    $shortcut.TargetPath = $SourceFilePath
    $shortcut.Save()
} else {
    Write-Host 'NO START MENU SHORTCUT WILL BE CREATED'
}