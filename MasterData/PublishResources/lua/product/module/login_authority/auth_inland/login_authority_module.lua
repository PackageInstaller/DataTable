_class("LoginAuthorityModule", GameModule)
LoginAuthorityModule = LoginAuthorityModule
local INVALID_VALUE = -1
local MSDKLogin, MSDKTools, MSDKMethodNameID, MSDKChannel, MSDKError
if H3DGCloudLuaHelper.MsdkStatus == MSDKStatus.MS_Inland then
  MSDKLogin = GCloud.MSDK.MSDKLogin
  MSDKTools = GCloud.MSDK.MSDKTools
  MSDKMethodNameID = GCloud.MSDK.MSDKMethodNameID
  MSDKChannel = GCloud.MSDK.MSDKChannel
  MSDKError = GCloud.MSDK.MSDKError
end

function LoginAuthorityModule:Constructor()
  self.authorityTaskID = INVALID_VALUE
  self.cacheAuthorityResult = LoginAuthorityResult:New()
  if H3DGCloudLuaHelper.MsdkStatus ~= MSDKStatus.MS_Inland then
    return
  end
  self.wakeupResult = LoginWakeUpResult:New()
  self:RegisterLoginObserver()
end

function LoginAuthorityModule:Dispose()
  if H3DGCloudLuaHelper.MsdkStatus ~= MSDKStatus.MS_Inland then
    return
  end
  self:UnregisterLoginObserver()
  if self.authorityTaskID ~= INVALID_VALUE then
    local id = self.authorityTaskID
    self.authorityTaskID = INVALID_VALUE
    self:ResumeTask(id, "LoginAuthorityModule:Dispose")
  end
end

function LoginAuthorityModule:InitLoginAuthorityInfo()
  if H3DGCloudLuaHelper.MsdkStatus ~= MSDKStatus.MS_Inland then
    return
  end
  local clientInfo = GameGlobal.GameLogic().ClientInfo
  clientInfo.m_runtime_os = GetPlatformOS()
  clientInfo.m_login_source = self.cacheAuthorityResult.loginChannelID
  if not IsUnityEditor() then
    clientInfo.m_reg_channel = MSDKTools.GetConfigChannel()
    Log.debug("[MSDK]LoginAuthorityModule:InitLoginAuthorityInfo, set clientInfo.m_reg_channel=", clientInfo.m_reg_channel)
  end
  local msdkAuthorityInfo = GameGlobal.GameLogic().msdkAuthorityInfo
  local openId = self.cacheAuthorityResult.openId
  msdkAuthorityInfo.open_id = openId
  msdkAuthorityInfo.m_token = self.cacheAuthorityResult.token
  msdkAuthorityInfo.m_pay_token = self:GetPayToken()
  msdkAuthorityInfo.pf, msdkAuthorityInfo.pf_key = self:GetPfInfo()
end

function LoginAuthorityModule:AutoLogin(TT)
  local _, wakeupChannel, wakeupOpenid = self:NeedSelectAccount()
  if wakeupChannel then
    local clientChannel = self:GetClientLoginChannel(wakeupChannel)
    Log.info("[MSDK] LoginAuthorityModule:AutoLogin wakeup login")
    return self:Login(TT, clientChannel)
  end
  local res, authRet = self:MSDKLogin(TT, MobileClientLoginChannel.MCLC_AUTO)
  if authRet.retCode == AuthorityRetCode.ARC_SUCCESS then
    self:CheckGuest(res, authRet, authRet.loginChannelID)
  end
  return res, authRet
end

function LoginAuthorityModule:Login(TT, loginChannel)
  local res = AsyncRequestRes:New()
  local authRet = LoginAuthorityResult:New()
  if not self:CheckGuest(res, authRet, loginChannel) then
    return res, authRet
  end
  self.cacheAuthorityResult.loginChannelID = loginChannel
  if self:GetLoginAuthorityStatus().retCode ~= AuthorityRetCode.ARC_SUCCESS then
    res, authRet = self:MSDKLogin(TT, loginChannel)
    Log.debug("[MSDK]LoginAuthorityModule:Login MSDKLogin Return, authRet.retCode=", authRet.retCode)
  else
    authRet:Copy(self:GetLoginAuthorityStatus())
    res:SetSucc(true)
  end
  if self:GetLoginAuthorityStatus().retCode == AuthorityRetCode.ARC_FAILED_WX_NOT_INSTALL then
    res, authRet = self:MSDKLogin(TT, MobileClientLoginChannel.MCLC_QRCODE)
    Log.debug("[MSDK]LoginAuthorityModule:Login MSDKLogin MCLC_QRCODE Return,authRet.retCode=", authRet.retCode)
  end
  return res, authRet
end

function LoginAuthorityModule:Logout()
  Log.debug("[MSDK]LoginAuthorityModule:Logout")
  self.cacheAuthorityResult.retCode = AuthorityRetCode.ARC_UNKNOWN
  MSDKLogin.Logout()
end

function LoginAuthorityModule:ClearWakeup()
  self.wakeupResult:Reset()
end

function LoginAuthorityModule:GetPayToken()
  return self.payToken
end

function LoginAuthorityModule:GetPfInfo()
  return self.pf, self.pfKey
end

function LoginAuthorityModule:SetPayInfo(loginRet)
  self.pf = loginRet.Pf
  self.pfKey = loginRet.PfKey
  if loginRet.Channel == GCloud.MSDK.MSDKChannel.WeChat then
    self.payToken = loginRet.Token
  elseif loginRet.Channel == GCloud.MSDK.MSDKChannel.QQ then
    local channelInfo = loginRet.ChannelInfo
    self.payToken = H3DGCloudLuaHelper.GetPayToken(channelInfo)
  end
  Log.debug("[MSDK]LoginAuthorityModule:SetPayInfo, self.payToken=", self.payToken, ",channel=", loginRet.Channel)
end

function LoginAuthorityModule:OnLoginRet(loginRet)
  local methodTag
  if loginRet.MethodNameId == MSDKMethodNameID.MSDK_LOGIN_LOGIN:ToInt() then
    methodTag = "Login"
    self:HandleLogin(loginRet, methodTag)
  elseif loginRet.MethodNameId == MSDKMethodNameID.MSDK_LOGIN_AUTOLOGIN:ToInt() then
    methodTag = "AutoLogin"
    self:HandleLogin(loginRet, methodTag)
  elseif loginRet.MethodNameId == MSDKMethodNameID.MSDK_LOGIN_QUERYUSERINFO:ToInt() then
    methodTag = "QueryUserInfo"
  elseif loginRet.MethodNameId == MSDKMethodNameID.MSDK_LOGIN_LOGINWITHCONFIRMCODE:ToInt() then
    methodTag = "LoginWithConfirmCode"
    self:HandleLogin(loginRet, methodTag)
  elseif loginRet.MethodNameId == MSDKMethodNameID.MSDK_LOGIN_SWITCHUSER:ToInt() then
    methodTag = "SwitchUser"
    self.isSwitchUser = false
  end
  Log.info("[MSDK]LoginAuthorityModule:OnLoginRet, ", methodTag, ",loginRet=", loginRet:ToString())
  self:SetPayInfo(loginRet)
end

function LoginAuthorityModule:OnLoginBaseRet(baseRet)
  if baseRet.MethodNameId == MSDKMethodNameID.MSDK_LOGIN_WAKEUP:ToInt() then
    self:HandleDiffAccount(baseRet)
  elseif baseRet.MethodNameId == MSDKMethodNameID.MSDK_LOGIN_LOGOUT:ToInt() then
    Log.error("[MSDK] LoginAuthorityModule:OnLoginBaseRet Logout, ", baseRet:ToString())
  end
end

function LoginAuthorityModule:MSDKLogin(TT, loginChannel)
  Log.debug("[MSDK]LoginAuthorityModule:MSDKLogin, loginChannel=", loginChannel)
  local res = AsyncRequestRes:New()
  local authRet = LoginAuthorityResult:New()
  self.authorityTaskID = GetCurTaskId()
  self.cacheAuthorityResult.retCode = AuthorityRetCode.ARC_FAILED
  if loginChannel == MobileClientLoginChannel.MCLC_QQ then
    MSDKLogin.Login(MSDKChannel.QQ)
  elseif loginChannel == MobileClientLoginChannel.MCLC_WX then
    MSDKLogin.Login(MSDKChannel.WeChat)
  elseif loginChannel == MobileClientLoginChannel.MCLC_GUEST then
    MSDKLogin.Login(MSDKChannel.Guest)
  elseif loginChannel == MobileClientLoginChannel.MCLC_AUTO then
    MSDKLogin.AutoLogin()
  elseif loginChannel == MobileClientLoginChannel.MCLC_QRCODE then
    MSDKLogin.Login(MSDKChannel.WeChat, "", "", "{\"QRCode\":true}")
  else
    Log.fatal("[MSDK]LoginAuthorityModule:MSDKLogin loginChannel Error,", loginChannel)
    return res, authRet
  end
  Log.debug("[MSDK]LoginAuthorityModule:MSDKLogin,Suspend Task ", self.authorityTaskID)
  SUSPEND(TT)
  authRet:Copy(self.cacheAuthorityResult)
  res:SetSucc(authRet.retCode == AuthorityRetCode.ARC_SUCCESS)
  return res, authRet
end

function LoginAuthorityModule:HandleLogin(loginRet, strFrom)
  Log.debug("[MSDK] LoginAuthorityModule:HandleLogin,", strFrom)
  self.cacheAuthorityResult:SetRetCode(loginRet)
  if self.cacheAuthorityResult:IsAuth() then
    local thirdPartyModule = self:GetModule(ThirdPartyModule)
    thirdPartyModule:SyncOpenID(self.cacheAuthorityResult.openId)
  end
  local id = self.authorityTaskID
  self.authorityTaskID = INVALID_VALUE
  self:ResumeTask(id, "LoginAuthorityModule:HandleLogin")
end

function LoginAuthorityModule:CheckGuest(res, authRet, channelID)
  local os = GetPlatformOS()
  if os ~= ClientRuntimeOS.CRO_IOS and channelID == MobileClientLoginChannel.MCLC_GUEST then
    Log.debug("[MSDK]LoginAuthorityModule:CheckGuest Error, os=", os, ",channelID=", channelID)
    authRet.retCode = AuthorityRetCode.ARC_FAILED_GUEST_PLATFORM_NOT_IOS
    res:SetSucc(false)
    return false
  end
  return true
end

function LoginAuthorityModule:GetLoginAuthorityStatus()
  return self.cacheAuthorityResult
end

function LoginAuthorityModule:HandleDiffAccount(wakeupRet)
  local wakeupLoginRet = MSDKLogin.GetWakeUpLoginRet()
  local retCode = wakeupRet.RetCode
  Log.debug("[MSDK]LoginAuthorityModule:HandleDiffAccount,retCode=", retCode, ",channel=", wakeupLoginRet.Channel, ",ThirdMsg=", wakeupRet.ThirdMsg)
  self.wakeupResult:CopyFromMsdk(wakeupLoginRet)
  if self.cacheAuthorityResult:IsAuth() then
    self:WakeupAfterAuth(wakeupLoginRet)
    return
  end
  if retCode == MSDKError.SUCCESS then
  elseif retCode == MSDKError.LOGIN_ACCOUNT_REFRESH then
  elseif retCode == MSDKError.LOGIN_URL_USER_LOGIN then
  elseif retCode == MSDKError.LOGIN_NEED_SELECT_ACCOUNT then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MSDKAutoAuthority)
  elseif retCode == MSDKError.LOGIN_NEED_LOGIN then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MSDKAutoAuthority)
  else
    MSDKLogin.Logout()
  end
end

function LoginAuthorityModule:WakeupAfterAuth(wakeupRet)
  local authedChannelId = self.cacheAuthorityResult.loginChannelID
  local authedOpenId = GameGlobal.GameLogic().msdkAuthorityInfo.open_id
  Log.debug("[MSDK]HandleDiffAccount After Authority, wakeupOpenid=", wakeupRet.OpenId, ",authedOpenid=", self.cacheAuthorityResult.openId, ",wakeupChannelId=", wakeupRet.ChannelId, ",authedChannelId=", authedChannelId, ",retCode=", wakeupRet.RetCode, ",NeedSelectAccountType=", MSDKError.LOGIN_NEED_SELECT_ACCOUNT)
  if wakeupRet.OpenId ~= authedOpenId and wakeupRet.ChannelId ~= authedChannelId then
    Log.info("[MSDK]LoginAuthorityModule:WakeupAfterAuth diff channel")
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, StringTable.Get("str_login_msdk_tip"), StringTable.Get("str_login_msdk_diff_channel"), function(param)
      self:OnWakeupSelectAccount()
    end, "", function(param)
      self:OnWakeupCancelSelectAccount()
    end)
    return
  end
  if wakeupRet.RetCode == MSDKError.LOGIN_NEED_SELECT_ACCOUNT and wakeupRet.OpenId ~= authedOpenId then
    Log.info("[MSDK]LoginAuthorityModule:WakeupAfterAuth diff user")
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, StringTable.Get("str_login_msdk_tip"), StringTable.Get("str_login_msdk_diff_user"), function(param)
      self:OnWakeupSelectAccount()
    end, "", function(param)
      self:OnWakeupCancelSelectAccount()
    end)
  end
end

function LoginAuthorityModule:OnWakeupSelectAccount()
  self.isSwitchUser = true
  if not MSDKLogin.SwitchUser(true) then
    if self.wakeupResult.wakeupChannel == MSDKChannel.WeChat then
      Log.info("[MSDK]LoginAuthorityModule:OnWakeupSelectAccount wakeupChannel wechat failed")
      GameGlobal.TaskManager():StartTask(LoginAuthorityModule.SwitchUserAndLogin, self)
      MSDKLogin.Login(MSDKChannel.WeChat)
    else
      Log.info("[MSDK]LoginAuthorityModule:OnWakeupSelectAccount failed")
      MSDKLogin.Logout()
      GameGlobal.GameLogic():BackToLogin(false)
    end
  else
    Log.info("[MSDK]LoginAuthorityModule:OnWakeupSelectAccount success")
    GameGlobal.TaskManager():StartTask(LoginAuthorityModule.SwitchUserAndLogin, self)
  end
end

function LoginAuthorityModule:SwitchUserAndLogin(TT)
  self.cacheAuthorityResult:Reset()
  while self.isSwitchUser do
    YIELD(TT)
  end
  GameGlobal.GameLogic():BackToLogin(true)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MSDKAutoAuthority)
end

function LoginAuthorityModule:OnWakeupCancelSelectAccount()
  if not MSDKLogin.SwitchUser(false) then
    Log.info("[MSDK]LoginAuthorityModule:OnWakeupCancelSelectAccount failed")
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, StringTable.Get("str_login_msdk_login_fail_title"), StringTable.Get("str_login_msdk_token_expired"))
    MSDKLogin.Logout()
    GameGlobal.GameLogic():BackToLogin(false)
    return
  end
  Log.info("[MSDK]LoginAuthorityModule:OnWakeupCancelSelectAccount success")
end

function LoginAuthorityModule:NeedSelectAccount()
  local needSelect = false
  needSelect = self.wakeupResult.retCode == MSDKError.LOGIN_NEED_SELECT_ACCOUNT
  self.wakeupResult.retCode = MSDKError.LOGIN_ACCOUNT_REFRESH
  local channel = self.wakeupResult.wakeupChannel
  local openid = self.wakeupResult.openid
  return needSelect, channel, openid
end

function LoginAuthorityModule:GetClientLoginChannel(channel)
  if channel == MSDKChannel.QQ then
    return MobileClientLoginChannel.MCLC_QQ
  else
    return MobileClientLoginChannel.MCLC_WX
  end
end

function LoginAuthorityModule:RegisterLoginObserver()
  function self.onLoginRetEvent(loginRet)
    self:OnLoginRet(loginRet)
  end
  
  MSDKLogin.LoginRetEvent = MSDKLogin.LoginRetEvent + self.onLoginRetEvent
  
  function self.onLoginBaseRetEvent(baseRet)
    self:OnLoginBaseRet(baseRet)
  end
  
  MSDKLogin.LoginBaseRetEvent = MSDKLogin.LoginBaseRetEvent + self.onLoginBaseRetEvent
end

function LoginAuthorityModule:UnregisterLoginObserver()
  MSDKLogin.LoginRetEvent = MSDKLogin.LoginRetEvent - self.onLoginRetEvent
  MSDKLogin.LoginBaseRetEvent = MSDKLogin.LoginBaseRetEvent - self.onLoginBaseRetEvent
end

function LoginAuthorityModule:ResumeTask(id, infoFrom)
  if not id then
    Log.fatal("[MSDK]LoginAuthorityModule:ResumeTask id is nil,", infoFrom)
    return
  end
  if TaskManager:GetInstance():FindTask(id) == nil then
    Log.error("[MSDK] LoginAuthorityModule:ResumeTask FindTask nil,taskid=", id, ",", infoFrom)
  else
    Log.debug("[MSDK] LoginAuthorityModule:ResumeTask, taskid=", id, ",", infoFrom)
    RESUME(TT, id)
  end
end
