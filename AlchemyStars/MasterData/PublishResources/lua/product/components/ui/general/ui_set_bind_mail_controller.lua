_class("UISetBindMailController", UIController)
UISetBindMailController = UISetBindMailController

function UISetBindMailController:OnShow(uiParams)
  self._mailInput = self:GetUIComponent("InputField", "Mail")
  self._codeInput = self:GetUIComponent("InputField", "Code")
  self._codeTips = self:GetGameObject("CodeTips")
  self._cancelBtn = self:GetGameObject("CancelBtn")
  self._cancelBtnNormal = self:GetGameObject("CancelBtnNormal")
  self._cancelBtnClick = self:GetGameObject("CancelBtnClick")
  self._bindBtn = self:GetGameObject("BindBtn")
  self._bindBtnNormal = self:GetGameObject("BindBtnNormal")
  self._bindBtnClick = self:GetGameObject("BindBtnClick")
  self._busyGo = self:GetGameObject("BusyEffect")
  self._sendCodeBtnName = self:GetGameObject("SendCodeBtnName")
  self._timerGo = self:GetGameObject("Timer")
  self._timerLabel = self:GetUIComponent("UILocalizationText", "Timer")
  self._timerGo:SetActive(false)
  self._isInCD = false
  self._timerCoro = nil
  self._codeTips:SetActive(false)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Press, function(go)
    self._cancelBtnNormal:SetActive(false)
    self._cancelBtnClick:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Release, function(go)
    self._cancelBtnNormal:SetActive(true)
    self._cancelBtnClick:SetActive(false)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._bindBtn), UIEvent.Press, function(go)
    self._bindBtnNormal:SetActive(false)
    self._bindBtnClick:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._bindBtn), UIEvent.Release, function(go)
    self._bindBtnNormal:SetActive(true)
    self._bindBtnClick:SetActive(false)
  end)
  self._oldChannelId = GameGlobal.GameLogic().ClientInfo.m_login_source
end

function UISetBindMailController:OnHide()
  if self._timerCoro then
    GameGlobal.TaskManager():KillTask(self._timerCoro)
    self._timerCoro = nil
  end
end

function UISetBindMailController:CancelBtnOnClick()
  self:CloseDialog()
end

function UISetBindMailController:SendCodeBtnOnClick()
  if self._isInCD then
    return
  end
  local mail = self._mailInput.text
  if string.isnullorempty(mail) then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_mail_Is_null"))
    return
  end
  if self:CheckEmail(mail) == false then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_mail_format_error"))
    return
  end
  self:Lock("UISetBindMailController_SendCodeBtnOnClick")
  GameGlobal.TaskManager():StartTask(self.SendCodeBtnOnClickCoro, self, mail)
end

function UISetBindMailController:SendCodeBtnOnClickCoro(TT, account)
  local ret = SDKProxy:GetInstance():RequestVerifyCode(TT, account, INTL.VerifyCodeType.Login, "")
  if ret.RetCode == INTL.INTLErrorCode.SUCCESS then
    ToastManager.ShowToast(StringTable.Get("str_login_code_tip"))
    self._codeTips:SetActive(true)
    self:StartCDTimer()
  else
    UICommonHelper:GetInstance():HandleLoginErrorCode(ret.RetCode, ret.ThirdCode)
  end
  self:UnLock("UISetBindMailController_SendCodeBtnOnClick")
end

function UISetBindMailController:StartCDTimer()
  self._timerCoro = GameGlobal.TaskManager():StartTask(self.StartCDTimerCoro, self)
end

function UISetBindMailController:StartCDTimerCoro(TT)
  self._isInCD = true
  self._timerGo:SetActive(true)
  self._sendCodeBtnName:SetActive(false)
  local timer = 0
  local CD = 60
  while true do
    self._timerLabel:SetText(StringTable.Get("str_set_send_code_cd_tips", CD - timer))
    YIELD(TT, 1000)
    timer = timer + 1
    if CD <= timer then
      self._timerGo:SetActive(false)
      self._sendCodeBtnName:SetActive(true)
      self._isInCD = false
      self._timerCoro = nil
      break
    end
  end
end

function UISetBindMailController:BindBtnOnClick()
  local mail = self._mailInput.text
  local code = self._codeInput.text
  if string.isnullorempty(mail) then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_mail_Is_null"))
    return
  end
  if self:CheckEmail(mail) == false then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_mail_format_error"))
    return
  end
  if string.isnullorempty(code) then
    ToastManager.ShowToast(StringTable.Get("str_login_msdk_intl_login_reg_vc_error"))
    return
  end
  self:Lock("UISetBindMailController:BindBtnOnClick")
  self:SetShowBusy(true)
  GameGlobal.TaskManager():StartTask(self.BindBtnOnClickCoro, self, mail, "", code)
end

function UISetBindMailController:BindBtnOnClickCoro(TT, mail, password, code)
  local channelName = SDKProxy:GetInstance():GetIntlChannel(EngineGameHelper.SAIchannelId())
  if channelName == nil then
    self:SetShowBusy(false)
    self:UnLock("UISetBindMailController:BindBtnOnClick")
    return
  end
  local str = SDKProxy:GetInstance():SerializeBindJson(mail, password, code)
  local ret = SDKProxy:GetInstance():BindChannel(TT, channelName, str)
  if ret.RetCode == INTL.INTLErrorCode.SUCCESS then
    ToastManager.ShowToast(StringTable.Get("str_set_bind_bind_success"))
    YIELD(TT)
    if self._oldChannelId == MobileClientLoginChannel.MCLC_GUEST then
      SDKProxy:GetInstance():ResetGuest(TT)
    end
    self:CloseDialog()
    self:ShowDialog("UISetBindMailChangePasswordController", mail)
  else
    UICommonHelper:GetInstance():HandleLoginErrorCode(ret.RetCode, ret.ThirdCode)
  end
  self:SetShowBusy(false)
  self:UnLock("UISetBindMailController:BindBtnOnClick")
end

function UISetBindMailController:CheckEmail(strContent)
  if not strContent then
    return false
  end
  if string.len(strContent) < 3 then
    return false
  end
  if strContent:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?") then
    return true
  else
    return false
  end
end

function UISetBindMailController:CheckPassWordValid(info)
  local t = string.match(info, "[^%w_!%[%]%-%+%(%)@#%$%%%^&%*=\\/%?<>,:;|]")
  if t ~= nil then
    return false
  end
  return true
end
