@echo off

REM initial choice
:initial
set /P initial=Do You Want To Begin [Y/N]?
if /I "%initial%" EQU "Y" goto :start
if /I "%initial%" EQU "N" goto :exit
goto :initial

REM stopped service
:exit
echo The Operation Was Successfully Stoppped!
pause
exit


:start

echo disabling telnet...
net stop telnet
sc config tlntsvr start= disabled

pause 

echo enabling auto updates...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 0 /f
net start wuauserv
sc config wuauserv start= auto

pause

echo Checking Account Password Setting. Press a Key to Continue...
pause

:password
set /P ap=Do You Want To Change Account Password Setting [Y/N]?
if /I "%ap%" EQU "Y" goto :password1i
if /I "%ap%" EQU "N" goto :
goto :password

:password1i
set /P ap1=Do You Want To Change Minimum Password Limit [Y/N]?
if /I "%ap1%" EQU "Y" goto :password1
if /I "%ap1%" EQU "N" goto :password2i
goto :password1i

:password1
set /P ap2=Type In Your Limit (numerical, reccomend 8).
if /I "%ap2%" EQU "%ap2%" net accounts /minpwlen:"%ap2%"
pause 
goto :password2i

:password2i
set /P ap3=Do You Want To Change Maximum Password Limit [Y/N]?
if /I "%ap3%" EQU "Y" goto :password2
if /I "%ap3%" EQU "N" goto :password3i
goto :password2i

:password2
set /P ap4=Type In Your Max (numerical).
if /I "%ap4%" EQU "%ap4%" net accounts /maxplen:"%ap4%"
pause
goto :password2

:password3i
set /P ap5=Do You Want To Configure Passwords  Being Reusable [Y/N]?
if /I "%ap5%" EQU "Y" goto :password3
if /I "%ap5%" EQU "N" goto :password4i
goto :password3i


:password3
set /P ap6=Type In Your Max (numerical, recommend 0).
if /I "%ap6%" EQU "%ap6%" net accounts /uniquepw:"%ap6%"
pause
goto :password4i


pause

echo enabling default windows defender settings
cd C:\Program Files\Windows Defender
MpCmdRun.exe -RestoreDefaults

echo Click continue to update windows defender
timeout /t -1 


