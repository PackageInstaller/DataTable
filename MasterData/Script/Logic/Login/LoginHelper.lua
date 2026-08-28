local Controller = require("UILogin/UILoginController")
LoginGV = require("Logic/Login/LoginGV")
LoginSetting = require("Logic/Login/LoginSetting")
LoginViewHelper = require("Logic/Login/LoginViewHelper")
EmailLoginHelper = require("Logic/Login/EmailLoginHelper")
EmailLoginMsgHelper = require("Logic/Login/EmailLoginMsgHelper")
DataLinkLoginHelper = require("Logic/Login/DataLinkLoginHelper")
local LoginHelper = {}
LoginHelper.ChannelLoginEnable = true
LoginHelper.SelectedPrivacy = false

function LoginHelper.SetChannelLoginEnable(v)
  LoginHelper.ChannelLoginEnable = v
end

function LoginHelper.GetChannelLoginEnable()
  return LoginHelper.ChannelLoginEnable
end

function LoginHelper.SetSelectPrivacy(f)
  LoginHelper.SelectedPrivacy = f
end

function LoginHelper.IsSelectPrivacy()
  return LoginHelper.SelectedPrivacy
end

function LoginHelper.BeforeLogoutInLogin()
  ChannelLoginMgr:BeforeLogoutInLogin()
end

function LoginHelper.BeforeLoginInit()
  ChannelLoginMgr:BeforeLoginInit()
end

function LoginHelper.IsUseChannelLogin()
  if LoginHelper.GetChannelLoginEnable() == false then
    return false
  end
  if DataLinkLoginHelper.IsUseDataLinkLogin() then
    return false
  end
  local flag = SdkHelper.GetChannelFlag()
  local a, s = CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.UseChannelLogin)
  if s ~= nil and s == 1 then
    return true
  elseif flag == SdkChannelConst.ChannelFlag.HaoPlay then
    return true
  elseif flag == SdkChannelConst.ChannelFlag.Dmm then
    return true
  elseif SdkHelper.IsNotChannelDefault() then
    return true
  end
  return false
end

function LoginHelper.IsShowUserCenterAndService()
  local flag = SdkHelper.GetChannelFlag()
  if flag == SdkChannelConst.ChannelFlag.HaoPlay then
    return true
  end
  return false
end

function LoginHelper.IsShowUserCenter()
  return false
end

function LoginHelper.IsShowService()
  local flag = SdkHelper.GetChannelFlag()
  if flag == SdkChannelConst.ChannelFlag.HaoPlay then
    return LoginSetting.IsShowLoginServiceBtnInHaoplay
  end
  return false
end

function LoginHelper.ClickLoginBtnEnter()
  Controller:ClickLoginBtnEnter()
end

function LoginHelper.StartOfficialLogin()
  Controller:StartOfficialLogin()
end

function LoginHelper.StartChannelLogin()
  if LoginHelper.IsNeedDelayLogin() then
    TimerHelper.Start("LoginHelper_StartChannelLogin", LoginGV.SdkLoginDelay, function()
      LoginHelper.DelayStartChannelLogin()
      TimerHelper.Stop("LoginHelper_StartChannelLogin")
    end)
  else
    LoginHelper.DelayStartChannelLogin()
  end
end

function LoginHelper.DelayStartChannelLogin()
  PhoneIDLogin = false
  LoginHelper.TrySetAdministrationsAddictionFeatureWhenChannelLogin()
  SdkHelper.Login(function(jsonStr)
    Debug.Log("[Login]LoginHelper.StartChannelLogin jsonStr=" .. jsonStr)
    if LoginGV.IsLogin() then
      return
    end
    UIManager:CloseTip("UI/Common/Waiting")
    local data = Json.decode(jsonStr)
    if ChannelLoginMgr:TryHandlerResult(data) then
      return
    end
    if data == nil or data.status ~= 0 then
      Debug.Log("[Login]Login Cancel")
      return
    end
    LoginGV.OnChannelLogin(data)
    if DataLinkLoginHelper.CanAutoLoginInDMM() then
      DataLinkLoginHelper.TryAutoDataLinkLoginInDMM()
      return
    end
    LoginHelper.ReqChannelInfoIndex(data)
  end)
end

function LoginHelper.TrySetAdministrationsAddictionFeatureWhenChannelLogin()
  if SdkChannelHelper.IsCurHarmony() then
    return
  end
  GameSetting.AdministrationsAddictionFeature = false
end

function LoginHelper.SetAdministrationsAddictionFeature(b)
  GameSetting.AdministrationsAddictionFeature = b
end

function LoginHelper.IsNeedDelayLogin()
  if SdkChannelHelper.IsCurHaoplay() then
    return true
  end
  return false
end

function LoginHelper.ReqChannelInfoIndex(data)
  print("[Login]LoginHelper.ReqChannelEnterGame")
  local args = {
    accessToken = LoginGV.GetAccessToken(),
    platform = SdkHelper.GetServerUsePlatformFlag(),
    username = LoginGV.GetUsername()
  }
  if data ~= nil then
    args.openId = data.uid or "0"
    args.channel_code = data.channelCode or "0"
    args.int64Time = data.int64Time or 0
    args.signature = data.signature or ""
    args.channel = data.channel or ""
    LoginGV.SetChannelChannel(args.channel)
  end
  LoginHelper.ReqInfoAndIndex(args)
end

function LoginHelper.ReqInfoAndIndex(args, cb)
  Debug.Log("[SDKLogin]ReqInfoAndIndex args=" .. Json.encode(args))
  if args == nil then
    print("[Login]ReqInfoAndIndex Return args == nil")
    return
  end
  local accessToken = args.accessToken
  local platform = args.platform
  local username = args.username
  local openId = args.openId
  if string.nilorempty(platform) then
    platform = SdkHelper.GetServerUsePlatformFlag()
  end
  local info = ProtocolFactory:CreateProtocol(ProtocolType.Info)
  info.accessToken = accessToken
  info.openId = 0
  info:SetCallback(function(res3)
    print("[Login]LoginHelper.ReqEnterGame OnRecv Info json=" .. res3)
    local json3 = Json.decode(res3)
    PlayerData.ServerData = {}
    PlayerData.ServerData.server_now = json3.server_now
    PlayerData.NoticeAddress = json3.notice_address
    if PlayerData:GetNoPrompt("logintNotice", 1) == false then
      PlayerData:SetNoPrompt("logintNotice", 1, true)
    end
    local rc = json3.rc
    if rc and rc ~= "" then
      SdkReporter.TrackLogin(false)
      if cb ~= nil then
        cb(json3)
        return
      end
      Controller.Tip2(json3.msg, "80600068", function()
        if PhoneIDLogin then
          OpenNewLogin("showPhoneID")
          return
        end
        CBus:Logout(1)
      end)
      return
    end
    local index = ProtocolFactory:CreateProtocol(ProtocolType.Index)
    PlayerData.serverTimeOffset = TimeTool.UnixTimeStamp() - json3.server_now
    index.accessToken = accessToken
    index.openId = openId or "0"
    index.timestamp = TimeTool.UnixTimeStamp() - PlayerData.serverTimeOffset
    index.platform = platform
    index.autoLogin = 0
    index.deviceId = DeviceHelper.GetDeviceId()
    index.channel_code = args.channel_code or "0"
    if index.time ~= nil then
      index.time = args.int64Time or 0
    end
    if index.signature ~= nil then
      index.signature = args.signature or ""
    end
    if index.channel ~= nil then
      index.channel = args.channel or ""
    end
    Debug.Log(string.format("[Login]ReqInfoAndIndex set openId=%s,channel_code=%s", info.openId, info.channel_code))
    LoginHelper.BeforeSendIndex(index, "channel")
    if LoginHelper.CheckIndexArgs(index) == false then
      return
    end
    index:SetCallback(function(res4)
      print("[Login]LoginHelper.ReqEnterGame OnRecv Index json=" .. res4)
      local json4 = Json.decode(res4)
      Controller:OnRecvIndex(json4)
      rc = json4.rc
      if rc and rc ~= "" then
        SdkReporter.TrackLogin(false)
        if cb ~= nil then
          cb(json4)
          return
        end
        Controller.Tip2(json4.msg, "80600068", function()
          if PhoneIDLogin then
            OpenNewLogin("showPhoneID")
            return
          end
          CBus:Logout(1)
          LoginHelper.Logout()
        end)
        return
      end
      if cb ~= nil then
        cb(json4)
      end
      LoginHelper.AfterRecvIndex(json4, "channel")
      SdkReporter.TrackLogin(true)
      local timezone = string.sub(json4.timezone, 4, 6)
      PlayerData.TimeZone = tonumber(timezone)
      PlayerData.ServerTimeZoneOffset = (PlayerData.TimeZone - TimeUtil:GetLocalTimeZone()) * 3600 or 0
      PlayerData.RemoteId = json4.remote_id
      PlayerData.platform = platform
      PlayerData.pid = json4.pid
      Controller.Enter(username)
      CommonTips.CheckOpenNoticeLogin()
    end)
    ServerConnectManager:Add(index)
  end)
  print("[Login]ReqInfoAndIndex")
  ServerConnectManager:Add(info)
end

function LoginHelper.CheckIndexArgs(index)
  if index == nil then
    return true
  end
  local channel = index.channel
  if (channel == nil or channel == "") and SdkRegionHelper.IsRegionUS() then
    return false
  end
  return true
end

function LoginHelper.BeforeSendIndex(send, context)
  ChannelLoginMgr:BeforeSendIndex(send, context)
end

function LoginHelper.AfterRecvIndex(msg, context)
  ChannelLoginMgr:AfterRecvIndex(msg, context)
end

function LoginHelper.ReqChannelMainIndex()
  if LoginGV.IsLogin() then
    LoginHelper.ReqMainIndexCheckGPPCAuth()
  else
    LoginHelper.StartChannelLogin()
  end
end

function LoginHelper.ReqMainIndexCheckGPPCAuth()
  if not GooglePCHelper.IsUseGooglePCAuth() then
    LoginHelper.ReqMainIndex()
    return
  end
  
  local function cbAuth(success, msg)
    if not success then
      return
    end
    LoginHelper.ReqMainIndex()
  end
  
  CS.GameSdkLuaface.CheckGooglePCOauth(cbAuth)
end

function LoginHelper.ReqMainIndex()
  local main = ProtocolHelper.CreateProtocolMainIndex()
  Debug.Log("[Login]LoginHelper.ReqMainIndex rty=" .. main.rty)
  main:SetCallback(function(res)
    Debug.Log("[Login]LoginHelper.ReqMainIndex Recv MainIndex json =" .. res)
    local json = Json.decode(res)
    PlayerData.MultiMissionRefreshAll = true
    PlayerData.RechargeGoods = nil
    if json.rc and json.rc ~= "" then
      Controller.Tip2(json.msg, "80600068", function()
        CBus:Logout(1)
      end)
      return
    end
    if Controller:OnRecvMainIndexCheck(json) == false then
      return
    end
    json.rc = nil
    PlayerData.ServerData = json
    local time = TimeUtil:GetFutureTime(0, 20)
    PlayerData.online_time = json.server_now - time
    PlayerData:GetAllRoleAwakeRed()
    PlayerData:GetAwakeEquipRed()
    Net.Callback(res, nil)
    PlayerData:ResetTempCache()
    local coachInfos = PlayerData:GetHomeInfo().coach_template
    PlayerData:GetHomeInfo().coach = {}
    for k, v in pairs(coachInfos) do
      local uid = v
      local coachInfo = PlayerData:GetHomeInfo().coach_store[uid]
      table.insert(PlayerData:GetHomeInfo().coach, coachInfo)
    end
    PlayerData:SetPanelTriggerGuide()
    local QuestTrace = require("Common/QuestTrace")
    QuestTrace.AddOpenPanelCallBack()
    PlayerData.HandleMainIndex()
    PlayerData:SetChapterLevelTable()
    PlayerData:SetSortChapterLevelTable()
    GameSetting:LoadPlayerSetting()
    EventMgr:SendEvent("event_mainindex_receive", 1)
    Controller:OnRecvMainIndex(json)
    SdkHelper.NotifyZone()
    LoginHelper.OnRecvMainIndex()
    if UseGSDK then
      local info = PlayerData:GetGameUploadInfo()
      GSDKManager:EnterGameUpload(info.RoleName, info.RoleLevel, info.Balance, info.Chapter)
      local order = tonumber(PlayerData:GetUserInfo().older or 1)
      local is_user_first = 0
      if order == 0 then
        local info = PlayerData:GetGameUploadInfo()
        GSDKManager:CreateNewRoleUpload(info.RoleName, info.RoleLevel, info.Balance, info.Chapter)
        is_user_first = 1
      end
    end
    if GameSetting.AdministrationsAddictionFeature then
      if table.count(PlayerData:GetUserInfo().real_info) == 0 then
        CommonTips.OpenAntiAddiction({index = 1})
        return
      end
      local grow = PlayerData:IsCheckYearOld(PlayerData:GetUserInfo().real_info.id_card)
      local time = tonumber(os.date("%H", PlayerData.ServerData.server_now))
      print_r(time)
      local date_time = tostring(os.date("%Y-%m-%d", PlayerData.ServerData.server_now))
      PlayerData.AdministrationsAddictionHolidays = false
      for k, v in pairs(PlayerData:GetFactoryData(99900013).holidayList) do
        if date_time == v.day then
          PlayerData.AdministrationsAddictionHolidays = true
        end
      end
      if grow < 18 then
        if PlayerData.AdministrationsAddictionHolidays == true then
          if 21 <= time or time < 20 then
            CommonTips.OpenAntiAddiction({index = 2}, function()
              CommonTips.OpenAntiAddiction({index = 3})
            end)
            return
          else
            CommonTips.OpenAntiAddiction({index = 2}, function()
              local residue_time
              residue_time = 3600 - PlayerData.online_time
              if 0 < residue_time then
                CommonTips.OpenAntiAddiction({index = 4, time = residue_time}, function()
                  Controller.ChangeScene2Main()
                  require("UIAntiAddiction/AntiaddictionTime").AddOnSecondEvent()
                end)
              end
              if residue_time <= 0 then
                CommonTips.OpenAntiAddiction({index = 6}, function()
                  CBus:NewLogout()
                end)
              end
            end)
            return
          end
        else
          CommonTips.OpenAntiAddiction({index = 2}, function()
            CommonTips.OpenAntiAddiction({index = 3})
          end)
          return
        end
      end
    end
    if UseGSDK and GSDKManager.AppService.ChannelOp == "bsdk" then
      PlayerData:VerifyRealName(function()
        Controller.ChangeScene2Main()
      end)
    else
      Controller.ChangeScene2Main()
    end
    return
  end)
  ServerConnectManager:Add(main)
end

function LoginHelper.OnRecvMainIndex()
  ChannelLoginMgr:OnRecvMainIndex()
  LoginGV.SetIsLogin(true)
end

function LoginHelper.RegAccountUnregister()
  if SdkHelper.IsNotChannelDefault() then
    LoginHelper.RegChanneAccountUnregister()
    return
  end
  local api = ProtocolHelper.CreateProtocolApi(ProtocolType.MainCancel, function()
    LoginHelper.DefaultLogout()
  end)
  ProtocolHelper.SendProtocolApi(api)
end

function LoginHelper.RegChanneAccountUnregister()
  local jsonData = {
    {
      role_name = LoginGV.GetUsername(),
      server_name = "bilibili\229\140\186",
      level = 1,
      time = "2021-01-01"
    }
  }
  local jsonStr = Json.encode(jsonData)
  SdkHelper.AccountUnregister(function(jsonStr2)
    local jsonData2 = Json.decode(jsonStr2)
    if jsonData2.status == 0 then
      LoginHelper.Logout()
      LoginHelper.StartChannelLogin()
    end
  end, jsonStr)
end

function LoginHelper.DefaultLogout()
  CBus:Logout(1)
end

function LoginHelper.Logout()
  LoginGV.SetIsLogin(false)
  SdkHelper.Logout()
  LoginGV.SetIsEnterGame(false)
  ChannelLoginMgr:AfterLogoutInLoginScene()
end

function LoginHelper.ChannelLogout()
  LoginHelper.Logout()
end

function LoginHelper.OnEnterGame()
  LoginGV.SetIsEnterGame(true)
  PayHelper.OnEnterGame()
  LoginHelper.HandleKRFeature()
end

function LoginHelper.HandleKRFeature()
  if SdkRegionHelper.IsRegionKR() == false then
    return
  end
  CommonHelper.SafeCallCsFunc(CS.GameSdkLuaface.ClearCallbackSdkViewShownChanged)
end

function LoginHelper.DeleteLoginCacheIdList()
  if PlayerPrefs.HasKey("LoginCacheIdList") == true then
    PlayerPrefs.DeleteKey("LoginCacheIdList")
  end
end

function LoginHelper.GetLoginCacheIdList()
  local saveStr = PlayerPrefs.GetString("LoginCacheIdList")
  if saveStr == nil or saveStr == "" then
    return nil
  end
  return Json.decode(saveStr)
end

function LoginHelper.SaveLoginCacheIdList(username, access_token, openid, lastLoginTs, logintype, viewid)
  local row = {
    logintype = logintype,
    username = username,
    access_token = access_token,
    openid = openid,
    lastLoginTs = lastLoginTs,
    viewid = viewid or "0"
  }
  local saveList = {}
  saveList[1] = row
  PlayerPrefs.SetString("LoginCacheIdList", Json.encode(saveList))
end

function LoginHelper.GetLoginCacheIdListFirstLoginType()
  local saveList = LoginHelper.GetLoginCacheIdList()
  if saveList == nil then
    return nil
  end
  local account = saveList[1]
  local loginType = account.logintype
  return loginType
end

function LoginHelper.GetLoginCacheIdListFirst()
  local saveList = LoginHelper.GetLoginCacheIdList()
  if saveList == nil then
    return nil
  end
  local account = saveList[1]
  return account
end

function LoginHelper.LoginCacheIdListFirstLoginTypeIsGoogle()
  local loginType = LoginHelper.GetLoginCacheIdListFirstLoginType()
  return loginType ~= nil and loginType == "google"
end

function LoginHelper.LoginCacheIdListFirstLoginTypeIsDataLink()
  local loginType = LoginHelper.GetLoginCacheIdListFirstLoginType()
  return loginType ~= nil and loginType == "datalink"
end

return LoginHelper
