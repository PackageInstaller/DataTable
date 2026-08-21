if H3DGCloudLuaHelper.MsdkStatus ~= MSDKStatus.MS_International then
  return
end
_class("AuthInternationalModule", GameModule)
AuthInternationalModule = AuthInternationalModule
local authAPI = INTL.INTLAPI
local methodIDDefine = INTL.INTLMethodID
local channelDefine = INTL.INTLChannel
local retCodeDefine = INTL.INTLErrorCode
_class("TmpResult", Object)

function TmpResult:Constructor()
  self.MethodId = 0
  self.RetCode = 0
  self.RetMsg = ""
  self.ThirdCode = 0
  self.ThirdMsg = 0
  self.ExtraJson = ""
end

function TmpResult:Init(ret)
  self.MethodId = ret.MethodId
  self.RetCode = ret.RetCode
  self.RetMsg = ret.RetMsg
  self.ThirdCode = ret.ThirdCode
  self.ThirdMsg = ret.ThirdMsg
  self.ExtraJson = ret.ExtraJson
  if typeof(INTL.INTLAuthResult):IsInstanceOfType(ret) then
    self.BindList = ret.BindList
  end
end

function AuthInternationalModule:Constructor()
  self._tempSaveTaskID = nil
  self._authRetCallback = nil
  self._authLogoutRetCallback = nil
  self._customAccountRetCallback = nil
  self._cacheAuthResult = AuthInternationalResult:New()
  self._isWakeup = false
  self.paring = false
  self.timeNum = 0
  self.timeMax = 3000
  self.timeOut = 100
  self.resultInfo = TmpResult:New()
  self.queryUserResultInfo = TmpResult:New()
  self:RegisterObservers()
end

function AuthInternationalModule:SetAuthRetCallback(callback)
  self._authRetCallback = callback
end

function AuthInternationalModule:SetLogoutRetCallback(callback)
  self._authLogoutRetCallback = callback
end

function AuthInternationalModule:SetCustomAccountRetCallback(callback)
  self._customAccountRetCallback = callback
end

function AuthInternationalModule:AutoAuth(TT)
  if self._isWakeup and self._cacheAuthResult:IsAuthSuccess() then
    self:ResetWakeupStatus()
    return self._cacheAuthResult:CloneSelf()
  end
  return self:_DoAuthImpl(TT, MobileClientLoginChannel.MCLC_AUTO)
end

function AuthInternationalModule:ManualAuth(TT, channelID)
  self:ResetWakeupStatus()
  if self._cacheAuthResult:IsAuthSuccess() and self._cacheAuthResult.channelID == channelID then
    return self._cacheAuthResult:CloneSelf()
  end
  return self:_DoAuthImpl(TT, channelID)
end

function AuthInternationalModule:ManualAuthWithCustomAccount(TT, customAccountInfo)
  self:ResetWakeupStatus()
  if self._cacheAuthResult:IsAuthSuccess() and self._cacheAuthResult.channelID == EngineGameHelper.SAIchannelId() then
    return self._cacheAuthResult:CloneSelf()
  end
  return self:_DoAuthImpl(TT, EngineGameHelper.SAIchannelId(), customAccountInfo)
end

function AuthInternationalModule:SyncAuthInfoToLogin()
  local clientInfo = GameGlobal.GameLogic().ClientInfo
  clientInfo.m_runtime_os = GetPlatformOS()
  clientInfo.m_login_source = self._cacheAuthResult.channelID
  local msdkAuthorityInfo = GameGlobal.GameLogic().msdkAuthorityInfo
  msdkAuthorityInfo.open_id = self._cacheAuthResult.openID
  msdkAuthorityInfo.m_token = self._cacheAuthResult.token
end

function AuthInternationalModule:NotifyLogout()
  self._cacheAuthResult:MakeInvalid()
  self._isWakeup = false
  authAPI.Logout()
end

function AuthInternationalModule:Dispose()
  self:UnRegisterObservers()
  self._authRetCallback = nil
  self._authLogoutRetCallback = nil
  self._customAccountRetCallback = nil
  if self._tempSaveTaskID then
    RESUME(TT, self._tempSaveTaskID)
  end
  self._tempSaveTaskID = nil
end

function AuthInternationalModule:_DoAuthImpl(TT, channel, customAccountInfo)
  self._cacheAuthResult:MakeInvalid()
  local authRes = AuthInternationalResult:New()
  if channel == MobileClientLoginChannel.MCLC_AUTO then
    authAPI.AutoLogin()
  elseif channel == MobileClientLoginChannel.MCLC_FACEBOOK then
    authAPI.Login(channelDefine.Facebook)
  elseif channel == MobileClientLoginChannel.MCLC_GOOGLE_PLAY then
    authAPI.Login(channelDefine.Google)
  elseif channel == MobileClientLoginChannel.MCLC_GUEST then
    authAPI.Login(channelDefine.Guest)
  elseif channel == MobileClientLoginChannel.MCLC_LINE then
    authAPI.Login(channelDefine.Line)
  elseif channel == MobileClientLoginChannel.MCLC_TWITTER then
    authAPI.Login(channelDefine.Twitter)
  elseif channel == MobileClientLoginChannel.MCLC_APPLE then
    authAPI.Login(channelDefine.Apple)
  elseif channel == EngineGameHelper.SAIchannelId() then
    self:_DoAuthCustomAccountImpl(customAccountInfo)
  else
    Log.fatal("[MSDK-INTL] 暂不支持该登录渠道：", channel)
    return authRes
  end
  self._tempSaveTaskID = GetCurTaskId()
  SUSPEND(TT)
  authRes:CopyFrom(self._cacheAuthResult)
  return authRes
end

function AuthInternationalModule:_DoAuthCustomAccountImpl(customAccountInfo)
  if customAccountInfo.authType == AuthINTLCustomAccountType.REG_THEN_AUTH then
    authAPI.Register(customAccountInfo.account, customAccountInfo.password, customAccountInfo.verifyCode, customAccountInfo.phoneAreaCode, customAccountInfo.accountProfile, customAccountInfo.extraJson)
  elseif customAccountInfo.authType == AuthINTLCustomAccountType.AUTH_WITH_PASS then
    authAPI.LoginWithPassword(channelDefine.IEGPassport, customAccountInfo.account, customAccountInfo.password, customAccountInfo.phoneAreaCode)
  elseif customAccountInfo.authType == AuthINTLCustomAccountType.AUTH_WITH_VERIFYCODE then
    authAPI.LoginWithVerifyCode(channelDefine.IEGPassport, customAccountInfo.account, customAccountInfo.verifyCode, customAccountInfo.phoneAreaCode)
  end
end

function AuthInternationalModule:RegisterObservers()
  function self._onAuthRetEvent(ret)
    self:OnAuthRet(ret)
  end
  
  function self._onAuthBaseRetEvent(baseRet)
    self:OnAuthBaseRet(baseRet)
  end
  
  function self._onCustomAccountRetEvent(ret)
    self:OnCustomAccountRet(ret)
  end
  
  authAPI.AddAuthResultObserver(self._onAuthRetEvent)
  authAPI.AddAuthBaseResultObserver(self._onAuthBaseRetEvent)
  authAPI.AddAccountResultObserver(self._onCustomAccountRetEvent)
  
  function self._onCustomerRetEvent(ret)
    self:OnCustomerRet(ret)
  end
  
  authAPI.AddCustomerResultObserver(self._onCustomerRetEvent)
  if _G.APPVER1190 and not IsPc() then
    function self._onLiRetEvent(ret)
      self:OnLiRetRet(ret)
    end
    
    INTL.LevelInfinite.LevelInfinite.AddLIEventObserver(self._onLiRetEvent)
  end
end

function AuthInternationalModule:UnRegisterObservers()
  authAPI.RemoveAuthResultObserver(self._onAuthRetEvent)
  authAPI.RemoveAuthBaseResultObserver(self._onAuthBaseRetEvent)
  authAPI.RemoveAccountResultObserver(self._onCustomAccountRetEvent)
  authAPI.RemoveCustomerResultObserver(self._onCustomerRetEvent)
  if _G.APPVER1190 and not IsPc() then
    INTL.LevelInfinite.LevelInfinite.RemoveLIEventObserver(self._onLiRetEvent)
  end
end

function AuthInternationalModule:OnAuthRet(ret)
  self.paring = false
  self.resultInfo:Init(ret)
  self:HandleAuthRet(ret)
  if self._authRetCallback then
    self._authRetCallback(ret)
  end
  Log.info("[MSDK-INTL] AuthInternationalModule:OnAuthRet, MethodId = ", ret.MethodId, ", loginRet = ", ret:ToString())
  self:AuthDoneAndResumeBack()
end

function AuthInternationalModule:OnAuthBaseRet(baseRet)
  self.paring = false
  self.resultInfo:Init(baseRet)
  if baseRet.MethodId == methodIDDefine.INTL_AUTH_WAKEUP:ToInt() then
    self._isWakeup = true
  elseif baseRet.MethodId == methodIDDefine.INTL_AUTH_LOGOUT:ToInt() and self._authLogoutRetCallback then
    self._authLogoutRetCallback(baseRet)
  end
  Log.info("[MSDK-INTL] AuthInternationalModule:OnAuthBaseRet, MethodId = ", baseRet.MethodId, ", loginRet = ", baseRet:ToString())
end

function AuthInternationalModule:OnCustomAccountRet(ret)
  self.paring = false
  self.resultInfo:Init(ret)
  self:HandleCustomAccountRet(ret)
  if self._customAccountRetCallback then
    self._customAccountRetCallback(ret)
  end
  Log.info("[MSDK-INTL] AuthInternationalModule:OnCustomAccountRet, MethodId = ", ret.MethodId, ", loginRet = ", ret:ToString())
end

function AuthInternationalModule:HandleAuthRet(authRet)
  if authRet.MethodId == methodIDDefine.INTL_AUTH_LOGIN:ToInt() or authRet.MethodId == methodIDDefine.INTL_AUTH_AUTOLOGIN:ToInt() or authRet.MethodId == methodIDDefine.INTL_AUTH_LOGIN_WITH_CONFIRM_CODE:ToInt() then
    self._cacheAuthResult:SyncAndFillResult(authRet)
    if self._cacheAuthResult:IsAuthSuccess() and (self._cacheAuthResult.openID == "" or self._cacheAuthResult.token == "") then
      Log.error("[MSDK-INTL] AuthInternationalModule:HandleAuthRet, MethodId = ", authRet.MethodId, ", 返回登录成功但 openID 或 token 为空，可能是重复登录了，请检查逻辑。")
    end
  end
  if authRet.MethodId == methodIDDefine.INTL_AUTH_QUERY_USER_INFO:ToInt() then
    self.queryUserResultInfo:Init(authRet)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ChangeBindBtnStatus)
  end
end

function AuthInternationalModule:HandleCustomAccountRet(accountRet)
  if accountRet.MethodId == methodIDDefine.INTL_AUTH_REGISTER:ToInt() or accountRet.MethodId == methodIDDefine.INTL_AUTH_REQUEST_VERIFY_CODE:ToInt() then
  end
end

function AuthInternationalModule:OnCustomerRet(ret)
  self.paring = false
  self.resultInfo:Init(ret)
  Log.info("[MSDK-INTL] AuthInternationalModule:OnCustomerRet, MethodId = ", ret.MethodId, ", Customer = ", ret:ToString())
end

function AuthInternationalModule:OnLiRetRet(ret)
  Log.info("[MSDK-INTL] AuthInternationalModule:OnLiRetEvent,", ret.extraJson, ", EventType = ", ret.lIEventType)
  if ret and ret.lIEventType then
    Log.debug("###[AuthInternationalModule] ret.lIEventType:", ret.lIEventType)
    if ret.lIEventType == INTL.LevelInfinite.LIEventType.CLOSE_ACCOUNT_CENTER then
      Log.debug("###[AuthInternationalModule] close uiloginliroot ui !")
      GameGlobal.EventDispatcher():Dispatch(GameEventType.ActiveUILoginLIRoot, false)
    end
  end
end

function AuthInternationalModule:ResetWakeupStatus()
  if self._isWakeup then
    self._isWakeup = false
  end
end

function AuthInternationalModule:AuthDoneAndResumeBack()
  if self._cacheAuthResult:IsAuthSuccess() then
    local thirdPartyModule = self:GetModule(ThirdPartyModule)
    thirdPartyModule:SyncOpenID(self._cacheAuthResult.openID)
  end
  if self._tempSaveTaskID then
    local taskID = self._tempSaveTaskID
    self._tempSaveTaskID = nil
    RESUME(TT, taskID)
  end
end

function AuthInternationalModule:ResetPasswordWithOldPassword(TT, account, oldPassword, phoneAreaCode, newPassword)
  authAPI.ResetPasswordWithOldPassword(account, oldPassword, phoneAreaCode, newPassword, "{}")
  Log.info("[MSDK-INTL] AuthInternationalModule:ResetPasswordWithOldPassword()", account, oldPassword, phoneAreaCode, newPassword)
  self.paring = true
  self.timeNum = 0
  while self.paring do
    self.timeNum = self.timeNum + 1
    if self.timeNum > self.timeMax then
      self.paring = false
      self.resultInfo.MethodId = methodIDDefine.INTL_AUTH_RESET_PASSWORD:ToInt()
      self.resultInfo.RetCode = INTL.INTLErrorCode.TIMEOUT
      self.resultInfo.RetMsg = "gameh3d:net error/time out, sdk net fail"
    end
    YIELD(TT, self.timeOut)
  end
  return self.resultInfo
end

function AuthInternationalModule:ResetPasswordWithVerifyCode(TT, account, verifyCode, phoneAreaCode, newPassword, extraJson)
  INTL.INTLAPI.ResetPasswordWithVerifyCode(account, verifyCode, phoneAreaCode, newPassword, extraJson or "{}")
  Log.info("[MSDK-INTL] AuthInternationalModule:ResetPasswordWithVerifyCode()", account, verifyCode, phoneAreaCode, newPassword, extraJson)
  self.paring = true
  self.timeNum = 0
  while self.paring do
    self.timeNum = self.timeNum + 1
    if self.timeNum > self.timeMax then
      self.paring = false
      self.resultInfo.MethodId = methodIDDefine.INTL_AUTH_RESET_PASSWORD:ToInt()
      self.resultInfo.RetCode = INTL.INTLErrorCode.TIMEOUT
      self.resultInfo.RetMsg = "gameh3d:net error/time out, sdk net fail"
    end
    YIELD(TT, self.timeOut)
  end
  return self.resultInfo
end

function AuthInternationalModule:LaunchCustomerUI(TT, info)
  if APPVER1142 then
    self.paring = true
    local timeNum = 0
    local timeOut = false
    authAPI.InitCustomer(info)
    GameGlobal.UIStateManager():ShowBusy(true)
    while self.paring do
      timeNum = timeNum + 1
      if 300 < timeNum then
        self.paring = false
        timeOut = true
      end
      YIELD(TT, 100)
    end
    GameGlobal.UIStateManager():ShowBusy(false)
    if timeOut then
      Log.exception("LaunchCustomerUI time out 30s")
    else
      authAPI.ShowAllFAQSections()
    end
  else
    authAPI.LaunchCustomerUI(info)
    YIELD(TT, 2000)
  end
  Log.info("[MSDK-INTL] AuthInternationalModule:LaunchCustomerUI()")
end

function AuthInternationalModule:QueryUserInfo(TT)
  authAPI.QueryUserInfo()
  Log.info("[MSDK-INTL] AuthInternationalModule:QueryUserInfo()")
  self.paring = true
  self.timeNum = 0
  while self.paring do
    self.timeNum = self.timeNum + 1
    if self.timeNum > self.timeMax then
      self.paring = false
      self.resultInfo.MethodId = methodIDDefine.INTL_AUTH_QUERY_USER_INFO:ToInt()
      self.resultInfo.RetCode = INTL.INTLErrorCode.TIMEOUT
      self.resultInfo.RetMsg = "gameh3d:net error/time out, sdk net fail"
    end
    YIELD(TT, self.timeOut)
  end
  return self.resultInfo
end

function AuthInternationalModule:BindChannel(TT, channel, extraJson)
  if extraJson == nil then
    extraJson = ""
  end
  authAPI.Bind(channel, "", extraJson)
  Log.info("[MSDK-INTL] AuthInternationalModule:BindChannel() channel = ", channel, ",extraJson = ", extraJson)
  self.paring = true
  self.timeNum = 0
  while self.paring do
    self.timeNum = self.timeNum + 1
    if self.timeNum > self.timeMax then
      self.paring = false
      self.resultInfo.MethodId = methodIDDefine.INTL_AUTH_BIND:ToInt()
      self.resultInfo.RetCode = INTL.INTLErrorCode.TIMEOUT
      self.resultInfo.RetMsg = "gameh3d:net error/time out, sdk net fail"
    end
    YIELD(TT, self.timeOut)
  end
  return self.resultInfo
end

function AuthInternationalModule:ResetGuest(TT)
  authAPI.ResetGuest()
  Log.info("[MSDK-INTL] AuthInternationalModule:ResetGuest() ")
  self.paring = true
  self.timeNum = 0
  while self.paring do
    self.timeNum = self.timeNum + 1
    if self.timeNum > self.timeMax then
      self.paring = false
      self.resultInfo.MethodId = methodIDDefine.INTL_AUTH_RESET_GUEST:ToInt()
      self.resultInfo.RetCode = INTL.INTLErrorCode.TIMEOUT
      self.resultInfo.RetMsg = "gameh3d:net error/time out, sdk net fail"
    end
    YIELD(TT, self.timeOut)
  end
  return self.resultInfo
end

function AuthInternationalModule:RequestVerifyCode(TT, account, codeType, phoneAreaCode, extraJson)
  INTL.INTLAPI.RequestVerifyCode(account, codeType, phoneAreaCode, extraJson or "{}")
  Log.info("[MSDK-INTL] AuthInternationalModule:RequestVerifyCode() ", account, codeType, phoneAreaCode, extraJson)
  self.paring = true
  self.timeNum = 0
  while self.paring do
    self.timeNum = self.timeNum + 1
    if self.timeNum > self.timeMax then
      self.paring = false
      self.resultInfo.MethodId = methodIDDefine.INTL_AUTH_REQUEST_VERIFY_CODE:ToInt()
      self.resultInfo.RetCode = INTL.INTLErrorCode.TIMEOUT
      self.resultInfo.RetMsg = "gameh3d:net error/time out, sdk net fail"
    end
    YIELD(TT, self.timeOut)
  end
  return self.resultInfo
end

function AuthInternationalModule:GetQueryUserInfo()
  return self.queryUserResultInfo
end
