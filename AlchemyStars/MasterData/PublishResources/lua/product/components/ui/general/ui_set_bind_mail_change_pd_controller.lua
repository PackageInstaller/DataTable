_class("UISetBindMailChangePasswordController", UIController)
UISetBindMailChangePasswordController = UISetBindMailChangePasswordController

function UISetBindMailChangePasswordController:OnShow(uiParams)
  self._mailInput = self:GetUIComponent("InputField", "Mail")
  self._codeInput = self:GetUIComponent("InputField", "Code")
  self._codeTips = self:GetGameObject("CodeTips")
  self._passwordInput = self:GetUIComponent("InputField", "Password")
  self._passwordAgainInput = self:GetUIComponent("InputField", "PasswordAgain")
  self._onGo = self:GetGameObject("On")
  self._offGo = self:GetGameObject("Off")
  self._passwordTipsGo = self:GetGameObject("PasswordTips")
  self._cancelBtn = self:GetGameObject("CancelBtn")
  self._cancelBtnNormal = self:GetGameObject("CancelBtnNormal")
  self._cancelBtnClick = self:GetGameObject("CancelBtnClick")
  self._bindBtn = self:GetGameObject("BindBtn")
  self._bindBtnNormal = self:GetGameObject("BindBtnNormal")
  self._bindBtnClick = self:GetGameObject("BindBtnClick")
  self._busyGo = self:GetGameObject("BusyEffect")
  self._passWordText = self:GetGameObject("PassWordText")
  self._passwordAgainPlaceHolder = self:GetGameObject("PasswordAgainPlaceHolder")
  self._mailAccount = uiParams[1]
  self._mailInput.text = self._mailAccount
  self._sendCodeBtnName = self:GetGameObject("SendCodeBtnName")
  self._timerGo = self:GetGameObject("Timer")
  self._timerLabel = self:GetUIComponent("UILocalizationText", "Timer")
  self._timerGo:SetActive(false)
  self._isInCD = false
  self._timerCoro = nil
  self._isShowPasswd = false
  self._passwordTipsGo:SetActive(false)
  self._codeTips:SetActive(false)
  self:RefreshPasswdShowStatus()
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
  self:AddUICustomEventListener(self, UIEvent.InputFieldChanged, function()
    self._passwordAgainPlaceHolder:SetActive(true)
    self._passWordText:SetActive(true)
    self._passwordTipsGo:SetActive(false)
  end)
  self._passwordAgainInput.onValueChanged:AddListener(self.OnIptValueChanged)
  self._oldChannelId = GameGlobal.GameLogic().ClientInfo.m_login_source
end

function UISetBindMailChangePasswordController:OnHide()
  if self._timerCoro then
    GameGlobal.TaskManager():KillTask(self._timerCoro)
    self._timerCoro = nil
  end
end

function UISetBindMailChangePasswordController:RefreshPasswdShowStatus()
  self._onGo:SetActive(self._isShowPasswd)
  self._offGo:SetActive(not self._isShowPasswd)
  if self._isShowPasswd then
    self._passwordInput.contentType = UnityEngine.UI.InputField.ContentType.Standard
    self._passwordAgainInput.contentType = UnityEngine.UI.InputField.ContentType.Standard
  else
    self._passwordInput.contentType = UnityEngine.UI.InputField.ContentType.Password
    self._passwordAgainInput.contentType = UnityEngine.UI.InputField.ContentType.Password
  end
  self._passwordInput.gameObject:SetActive(false)
  self._passwordInput.gameObject:SetActive(true)
  self._passwordAgainInput.gameObject:SetActive(false)
  self._passwordAgainInput.gameObject:SetActive(true)
end

function UISetBindMailChangePasswordController:ViewPasswordBtnOnClick()
  self._isShowPasswd = not self._isShowPasswd
  self:RefreshPasswdShowStatus()
end

function UISetBindMailChangePasswordController:CancelBtnOnClick()
  self:CloseDialog()
end

function UISetBindMailChangePasswordController:SendCodeBtnOnClick()
  if self._isInCD then
    return
  end
  local mail = self._mailAccount
  if string.isnullorempty(mail) then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_mail_Is_null"))
    return
  end
  if self:CheckEmail(mail) == false then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_mail_format_error"))
    return
  end
  self:Lock("UISetBindMailChangePasswordController_SendCodeBtnOnClick")
  GameGlobal.TaskManager():StartTask(self.SendCodeBtnOnClickCoro, self, mail)
end

function UISetBindMailChangePasswordController:SendCodeBtnOnClickCoro(TT, account)
  local ret = SDKProxy:GetInstance():RequestVerifyCode(TT, account, INTL.VerifyCodeType.ResetPassword, "")
  if ret.RetCode == INTL.INTLErrorCode.SUCCESS then
    ToastManager.ShowToast(StringTable.Get("str_login_code_tip"))
    self._codeTips:SetActive(true)
    self:StartCDTimer()
  else
    UICommonHelper:GetInstance():HandleLoginErrorCode(ret.RetCode, ret.ThirdCode)
  end
  self:UnLock("UISetBindMailChangePasswordController_SendCodeBtnOnClick")
end

function UISetBindMailChangePasswordController:StartCDTimer()
  self._timerCoro = GameGlobal.TaskManager():StartTask(self.StartCDTimerCoro, self)
end

function UISetBindMailChangePasswordController:StartCDTimerCoro(TT)
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

function UISetBindMailChangePasswordController:BindBtnOnClick()
  local mail = self._mailAccount
  local password = self._passwordInput.text
  local passwordAgain = self._passwordAgainInput.text
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
  if string.isnullorempty(password) then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_error_code_new_password_is_null"))
    return
  end
  if string.len(password) < 8 or string.len(password) > 20 then
    ToastManager.ShowToast(StringTable.Get("str_login_register_or_forget_password_length_error"))
    return
  end
  if self:CheckPassWordValid(password) == false then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_error_code_pw_fomart_error"))
    return
  end
  if password ~= passwordAgain then
    self._passwordTipsGo:SetActive(true)
    self._passwordAgainPlaceHolder:SetActive(false)
    self._passWordText:SetActive(false)
    return
  end
  self:Lock("UISetBindMailChangePasswordController:BindBtnOnClick")
  GameGlobal.TaskManager():StartTask(self.BindBtnOnClickCoro, self, mail, password, code)
end

function UISetBindMailChangePasswordController:BindBtnOnClickCoro(TT, mail, password, code)
  local channelName = SDKProxy:GetInstance():GetIntlChannel(EngineGameHelper.SAIchannelId())
  if channelName == nil then
    self:UnLock("UISetBindMailChangePasswordController:BindBtnOnClick")
    return
  end
  local ret = SDKProxy:GetInstance():ResetPasswordWithVerifyCode(TT, mail, code, "", password)
  if ret.RetCode == INTL.INTLErrorCode.SUCCESS then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_success"))
    YIELD(TT)
    self:CloseDialog()
    GameGlobal.GameLogic():BackToLogin(true, LoginModule, "bind account", false)
  else
    UICommonHelper:GetInstance():HandleLoginErrorCode(ret.RetCode, ret.ThirdCode)
  end
  self:UnLock("UISetBindMailChangePasswordController:BindBtnOnClick")
end

function UISetBindMailChangePasswordController:CheckEmail(strContent)
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

function UISetBindMailChangePasswordController:CheckPassWordValid(info)
  local t = string.match(info, "[^%w_!%[%]%-%+%(%)@#%$%%%^&%*=\\/%?<>,:;|]")
  if t ~= nil then
    return false
  end
  return true
end
