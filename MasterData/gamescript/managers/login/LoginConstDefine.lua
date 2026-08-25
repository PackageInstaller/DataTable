local Readonly = System.readonly
local M = {}
M.LoginState = Readonly({}, "LoginConstDefine.LoginState")
M.LoginStep = Readonly({
  StepCheckRes = "StepCheckRes",
  StepCheckSdkInit = "StepCheckSdkInit",
  StepGetServerList = "StepGetServerList",
  StepLoginPlatform = "StepLoginPlatform",
  StepAuthPlatformServer = "StepAuthPlatformServer",
  StepConnectServer = "StepConnectServer",
  StepLoginGameServer = "StepLoginGameServer"
}, "LoginConstDefine.LoginStep")
M.GameServerTag = Readonly({
  WithinNetDeveopment = "within_net_deveopment",
  WithinNetPerson = "within_net_person",
  WithinNetTest = "within_net_test",
  KunTest = "kun_test",
  KunOfficial = "kun_official"
}, "LoginConstDefine.GameServerTag")
M.LOGIN_SUCCESSS_CODE = 1
M.LOGIN_FAILED_CODE = 0
M.LOGIN_BANNING_CODE = 15001
M.LOGIN_RISK_CODE = 4001
do return Readonly, M end
return Readonly, M, "LoginConstDefine"
