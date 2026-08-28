local SdkHelper = {}
SdkConst = require("SDK/Const/SdkConst")
SdkChannelHelper = require("SDK/Channel/SdkChannelHelper")
SdkTrackConst = require("SDK/Const/SdkTrackConst")
SdkTrackExcludeEvents = require("SDK/Const/SdkTrackExcludeEvents")
SdkReporter = require("SDK/SdkReporter")
TrackingIO2Reporter = require("SDK/Track/TrackingIO2Reporter")
ThinkingDataReporter = require("SDK/Track/ThinkingDataReporter")
JuLiangEngineHelper = require("SDK/Track/JuLiangEngineReporter")
RateHelper = require("SDK/Rate/RateHelper")
DeepLinkMgr = require("SDK/DeepLink/DeepLinkMgr")
GoogleHelper = require("SDK/Google/GoogleHelper")
SdkRuntimeSetting = require("SDK/Setting/SdkRuntimeSetting")
SdkRegionHelper = require("SDK/Region/SdkRegionHelper")
SdkLoginHelper = require("SDK/Login/SdkLoginHelper")
SdkShareHelper = require("SDK/Share/SdkShareHelper")
WebViewHelper = require("SDK/WebView/WebViewHelper")
SdkHelper.IsNotifyed = false
SdkHelper.IsNeedReportRegister = false

function SdkHelper.Init()
  SdkHelper.TrackCustom(SdkTrackConst.EvtName.start_menu)
end

function SdkHelper.GetDictStrObj()
  local dict = CsHelper.NewLuaDictStrObj()
  return dict
end

function SdkHelper.ConvertTableToDictStrObj(t)
  local d = SdkHelper.GetDictStrObj()
  if t ~= nil then
    for key, value in pairs(t) do
      d:Add(key, value)
    end
  end
  return d:GetCsDict()
end

function SdkHelper.ConvertTableToListStr(t)
  local d = CsHelper.NewLuaListStr()
  if t ~= nil then
    for key, value in pairs(t) do
      d:Add(value)
    end
  end
  return d:GetCsList()
end

function SdkHelper.ConvertTableToArrayStr(t)
  local d = SdkHelper.ConvertTableToListStr(t)
  return d:ToArray()
end

function SdkHelper.GetSdkLuaface()
  if SdkHelper.IsChannelHaoPlay() then
    return nil
  end
  return CS.SdkLuaface
end

function SdkHelper.GetTKIO()
  return CS.TrackingIO2Luaface
end

function SdkHelper.GetStatusFromBool(isSuccess)
  if isSuccess then
    return SdkConst.success
  end
  return SdkConst.failed
end

function SdkHelper.TrackRegister(registerAttributesTable, propertiesDict)
  if SdkHelper.GetSdkLuaface() == nil then
    return
  end
  SdkHelper.GetSdkLuaface().TrackRegister(registerAttributesTable, propertiesDict)
end

function SdkHelper.TrackRegister2(propertiesDict, registerType, isSuccess)
end

function SdkHelper.TrackRegister3(args)
  if SdkHelper.IsNeedReportRegister == false then
    return
  end
  SdkHelper.IsNeedReportRegister = false
  local bSuccess = args.isSuccess
  local registerStatus = SdkHelper.GetStatusFromBool(args.isSuccess)
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.TrackRegister, args.propertiesDict, args.registerType, registerStatus)
  if SdkHelper.GetSdkLuaface() == nil then
    return
  end
  SdkHelper.GetSdkLuaface().TrackRegister(args.propertiesDict, args.registerType, registerStatus)
  TrackingIO2Reporter.Register(args.account)
  ThinkingDataReporter.OnRegister()
  JuLiangEngineHelper.OnEventRegister("Offical", bSuccess)
end

function SdkHelper.TrackLogin(LoginAttributesTable, propertiesDict)
  if SdkHelper.GetSdkLuaface() == nil then
    return
  end
  SdkHelper.GetSdkLuaface().TrackLogin(LoginAttributesTable, propertiesDict)
end

function SdkHelper.TrackLogin2(propertiesDict, loginType, isSuccess)
end

function SdkHelper.TrackLogin3(args)
  local loginStatus = SdkHelper.GetStatusFromBool(args.isSuccess)
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.TrackLogin, args.propertiesDict, args.loginType, loginStatus)
  if SdkHelper.GetSdkLuaface() == nil then
    return
  end
  SdkHelper.GetSdkLuaface().TrackLogin(args.propertiesDict, args.loginType, loginStatus)
  TrackingIO2Reporter.Login(args.account)
end

function SdkHelper.TrackCustom(eventName, propertiesTable)
  if SdkTrackExcludeEvents.EvtName[eventName] then
    return
  end
  ThinkingDataReporter.OnSdkHelperTrackCustom(eventName, propertiesTable)
  AdjustDataReporter.TryTrackCustomEvent(eventName, propertiesTable)
  local dict = SdkHelper.ConvertTableToDictStrObj(propertiesTable)
  SolarEngineDataReporter.TryTrackCustomEvent(eventName, propertiesTable, dict)
  FirebaseReporter.TryTrackCustomEvent(eventName, propertiesTable, dict)
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.TrackCustom, eventName, dict)
  if SdkHelper.IsChannelHaoPlay() then
    return
  end
  CS.SdkLuaface.TrackCustom(eventName, dict)
end

function SdkHelper.ProcessTrackPropValueType(propertiesTable)
  if propertiesTable == nil then
    return
  end
  for key, value in pairs(propertiesTable) do
    local vt = SdkTrackConst.EvtPropValueType[key]
    if value ~= nil and vt ~= nil and vt == "number" and not SdkHelper.IsTypeNumber(value) then
      propertiesTable[key] = SdkHelper.TryToNumber(value)
    end
  end
end

function SdkHelper.TryToNumber(v)
  if SdkHelper.IsTypeNumber(v) then
    return v
  elseif SdkHelper.IsTypeString(v) then
    return tonumber(v)
  end
  return v
end

function SdkHelper.IsTypeNumber(v)
  return type(v) == "number"
end

function SdkHelper.IsTypeString(v)
  return type(v) == "string"
end

function SdkHelper.Login(callback)
  SdkHelper.SetChannelProducts()
  CS.GameSdkLuaface.Login(callback)
end

function SdkHelper.SetChannelProducts()
  local isNeedSet = false
  if SdkHelper.IsChannelDmm() then
    isNeedSet = true
  end
  if isNeedSet == false then
    return
  end
  local productList = PayHelper.GetProductList()
  if productList ~= nil then
    CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.SetChannelProductList, productList)
  end
end

function SdkHelper.TryLogout()
  if LoginHelper.IsUseChannelLogin() then
    SdkHelper.Logout()
    CBus:Logout()
    LoginHelper.ChannelLogout()
  end
end

function SdkHelper.Logout()
  ThinkingDataReporter.TrackTDLogout()
  SdkHelper.IsNotifyed = false
  CS.GameSdkLuaface.Logout()
end

function SdkHelper.CreateRole(roleId, roleName)
  Debug.Log("[SDK]CreateRole roldId=" .. roleId .. ",roleName=" .. roleName)
  CS.GameSdkLuaface.CreateRole(roleId, roleName)
end

function SdkHelper.NotifyZone()
  if SdkHelper.IsNotifyed == true then
    return
  end
  SdkHelper.IsNotifyed = true
  if SdkHelper.IsBilibiliSelfTest() then
    SdkHelper.CreateRole(PlayerData:GetUserInfo().uid, LoginGV.GetUsername())
  end
  local jsonData = {}
  jsonData.roleId = PlayerData:GetUserInfo().uid
  jsonData.roleName = LoginGV.GetUsername() or ""
  local jsonStr = Json.encode(jsonData)
  Debug.Log("[SDK]NotifyZone")
  CS.GameSdkLuaface.NotifyZone(jsonStr)
end

function SdkHelper.AccountUnregister(jsonStr)
  CS.GameSdkLuaface.AccountUnregister(jsonStr)
end

function SdkHelper.IsUseSdkUserCenter()
  if SdkHelper.GetChannelFlag() == SdkChannelConst.ChannelFlag.HaoPlay then
    return true
  elseif SdkChannelHelper.IsCurUjoy() then
    return true
  end
  return false
end

function SdkHelper.IsUseSdkServices()
  if SdkHelper.GetChannelFlag() == SdkChannelConst.ChannelFlag.HaoPlay then
    return true
  elseif SdkRegionHelper.IsRegionKR() then
    return true
  elseif SdkRegionHelper.IsRegionUS() then
    return true
  end
  return false
end

function SdkHelper.IsBilibiliSelfTest()
  return CS.GameSdkLuaface.IsBilibiliSelfTest()
end

function SdkHelper.GetChannelType()
  return CS.GameSdkLuaface.GetChannelType()
end

function SdkHelper.GetChannelFlag()
  local r, flag = CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.CurChannelIDLower)
  return flag or "official"
end

function SdkHelper.GetChannel2Flag()
  if SdkChannelHelper.IsCurUjoy() then
    return ChannelUJoyHelper.GetChannel()
  end
  return ""
end

function SdkHelper.IsNotChannelDefault()
  return SdkHelper.GetChannelType() ~= SdkConst.ChannelType.Default
end

function SdkHelper.IsChannelBilibili()
  return SdkHelper.GetChannelType() == SdkConst.ChannelType.Bilibili
end

function SdkHelper.IsChannelHaoPlay()
  return SdkHelper.GetChannelFlag() == SdkChannelConst.ChannelFlag.HaoPlay
end

function SdkHelper.IsChannelDmm()
  return SdkHelper.GetChannelFlag() == SdkChannelConst.ChannelFlag.Dmm
end

function SdkHelper.IsChannelUjoy()
  return SdkHelper.GetChannelFlag() == SdkChannelConst.ChannelFlag.Ujoy
end

function SdkHelper.GetPlatformFlag()
  if SdkHelper.IsChannelBilibili() then
    return "biligame"
  end
  return "oc"
end

function SdkHelper.GetServerUsePlatformFlag()
  local flag = SdkHelper.GetChannelFlag()
  local s, serverFlag = CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.GetServerPlatformFlag)
  if s and serverFlag ~= "" then
    return serverFlag
  elseif flag == SdkChannelConst.ChannelFlag.HaoPlay then
    return "haoplay"
  elseif flag == SdkChannelConst.ChannelFlag.Dmm then
    return "dmm"
  elseif flag == SdkChannelConst.ChannelFlag.Ujoy then
    return "ujoy"
  elseif SdkHelper.IsChannelBilibili() then
    return "biligame"
  elseif SdkChannelHelper.IsCurHarmony() then
    return "hmos"
  end
  return "oc"
end

function SdkHelper.OpenWaiting()
  UIManager:OpenSpecialUI("UI/Common/SDKWaiting")
end

function SdkHelper.CloseWaiting()
  UIManager:CloseSpecialUI("UI/Common/SDKWaiting")
end

function SdkHelper.GetPackageName()
  local a, b = CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.GetPackageName)
  return b or ""
end

function SdkHelper.TrySdkServices()
  if SdkHelper.IsUseSdkServices() == false then
    return false
  end
  local uid = PlayerData:GetUserInfo().uid
  local extra = {
    roleid = uid,
    level = PlayerData:GetPlayerLevel()
  }
  local jsonStr = Json.encode(extra)
  SdkHelper.Services(tostring(uid), jsonStr)
  return true
end

function SdkHelper.Services(nickName, jsonExtra)
  if SdkRegionHelper.IsRegionKR() or SdkRegionHelper.IsRegionUS() then
    ChannelUJoyHelper.ShowConversation()
    return
  end
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.Services, nickName, jsonExtra)
end

function SdkHelper.Community()
  if SdkRegionHelper.IsRegionKR() or SdkRegionHelper.IsRegionUS() then
    ChannelUJoyHelper.ShowCafe()
  end
end

function SdkHelper.UserCenter(nickName, jsonExtra)
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.UserCenter, nickName, jsonExtra)
end

function SdkHelper.BindAccount(cb)
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.BindAccount, cb)
end

function SdkHelper.SetLogoutCallback(cb)
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.SetLogoutCallback, cb)
end

function SdkHelper.ClearLogoutCallback()
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.ClearLogoutCallback)
end

function SdkHelper.GetLoginType()
  local s, r = CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.GetLoginType)
  local result = r or -1
  return result
end

SdkHelper.Init()
return SdkHelper
