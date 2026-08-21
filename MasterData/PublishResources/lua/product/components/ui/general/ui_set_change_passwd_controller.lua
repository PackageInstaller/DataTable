_class("UISetChangePasswdController", UIController)
UISetChangePasswdController = UISetChangePasswdController

function UISetChangePasswdController:OnShow(uiParams)
  self._oldPasswordInput = self:GetUIComponent("InputField", "OldPassword")
  self._newPasswordInput = self:GetUIComponent("InputField", "NewPassword")
  self._mailInput = self:GetUIComponent("InputField", "Mail")
  self._newPasswordAgainInput = self:GetUIComponent("InputField", "NewPasswordAgain")
  self._onGo = self:GetGameObject("On")
  self._offGo = self:GetGameObject("Off")
  self._isShowPasswd = false
  self:RefreshPasswdShowStatus()
  self._passwordTipsGo = self:GetGameObject("PasswordTips")
  self._passwordTipsGo:SetActive(false)
  self._cancelBtn = self:GetGameObject("CancelBtn")
  self._cancelBtnNormal = self:GetGameObject("CancelBtnNormal")
  self._cancelBtnClick = self:GetGameObject("CancelBtnClick")
  self._passwordAgainPlaceHolder = self:GetGameObject("PasswordAgainPlaceHolder")
  self._passWordText = self:GetGameObject("PassWordText")
  self._busyGo = self:GetGameObject("BusyEffect")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Press, function(go)
    self._cancelBtnNormal:SetActive(false)
    self._cancelBtnClick:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._cancelBtn), UIEvent.Release, function(go)
    self._cancelBtnNormal:SetActive(true)
    self._cancelBtnClick:SetActive(false)
  end)
  self._nextStepBtn = self:GetGameObject("NextStepBtn")
  self._nextStepBtnNormal = self:GetGameObject("NextStepBtnNormal")
  self._nextStepBtnClick = self:GetGameObject("NextStepBtnClick")
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._nextStepBtn), UIEvent.Press, function(go)
    self._nextStepBtnNormal:SetActive(false)
    self._nextStepBtnClick:SetActive(true)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._nextStepBtn), UIEvent.Release, function(go)
    self._nextStepBtnNormal:SetActive(true)
    self._nextStepBtnClick:SetActive(false)
  end)
  self:AddUICustomEventListener(self, UIEvent.InputFieldChanged, function()
    self._passwordAgainPlaceHolder:SetActive(true)
    self._passWordText:SetActive(true)
    self._passwordTipsGo:SetActive(false)
  end)
  self._newPasswordAgainInput.onValueChanged:AddListener(self.OnIptValueChanged)
  local msdkAuthorityInfo = GameGlobal.GameLogic().msdkAuthorityInfo
  self.account = msdkAuthorityInfo.account
  self._mailInput.text = self.account
end

function UISetChangePasswdController:RefreshPasswdShowStatus()
  self._onGo:SetActive(self._isShowPasswd)
  self._offGo:SetActive(not self._isShowPasswd)
  if self._isShowPasswd then
    self._newPasswordInput.contentType = UnityEngine.UI.InputField.ContentType.Standard
    self._newPasswordAgainInput.contentType = UnityEngine.UI.InputField.ContentType.Standard
  else
    self._newPasswordInput.contentType = UnityEngine.UI.InputField.ContentType.Password
    self._newPasswordAgainInput.contentType = UnityEngine.UI.InputField.ContentType.Password
  end
  self._newPasswordInput.gameObject:SetActive(false)
  self._newPasswordInput.gameObject:SetActive(true)
  self._newPasswordAgainInput.gameObject:SetActive(false)
  self._newPasswordAgainInput.gameObject:SetActive(true)
end

function UISetChangePasswdController:ViewPasswordBtnOnClick()
  self._isShowPasswd = not self._isShowPasswd
  self:RefreshPasswdShowStatus()
end

function UISetChangePasswdController:CancelBtnOnClick()
  self:CloseDialog()
end

function UISetChangePasswdController:NextStepBtnOnClick()
  local mail = self.account
  local oldPassword = self._oldPasswordInput.text
  local newPassword = self._newPasswordInput.text
  local newPasswordAgain = self._newPasswordAgainInput.text
  if string.isnullorempty(mail) then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_mail_Is_null"))
    return
  end
  if self:CheckEmail(mail) == false then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_mail_format_error"))
    return
  end
  if string.isnullorempty(oldPassword) then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_error_code_password_is_null"))
    return
  end
  if string.isnullorempty(newPassword) then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_error_code_new_password_is_null"))
    return
  end
  if string.len(newPassword) < 8 or string.len(newPassword) > 20 then
    ToastManager.ShowToast(StringTable.Get("str_login_register_or_forget_password_length_error"))
    return
  end
  if self:CheckPassWordValid(newPassword) == false then
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_error_code_pw_fomart_error"))
    return
  end
  if newPassword ~= newPasswordAgain then
    self._passwordTipsGo:SetActive(true)
    self._passwordAgainPlaceHolder:SetActive(false)
    self._passWordText:SetActive(false)
    return
  end
  self:Lock("UISetChangePasswdController:NextStepBtnOnClick")
  GameGlobal.TaskManager():StartTask(self.ChangePasswdCoro, self, mail, oldPassword, "", newPassword)
end

function UISetChangePasswdController:ChangePasswdCoro(TT, account, oldPassword, phoneAreaCode, newPassword)
  local ret = SDKProxy:GetInstance():ResetPasswordWithOldPassword(TT, account, oldPassword, phoneAreaCode, newPassword)
  if ret.RetCode == INTL.INTLErrorCode.SUCCESS then
    self._busyGo:SetActive(true)
    ToastManager.ShowToast(StringTable.Get("str_set_change_passwd_success"))
    YIELD(TT)
    GameGlobal.GameLogic():BackToLogin(false, LoginModule, "change password", false)
  else
    UICommonHelper:GetInstance():HandleLoginErrorCode(ret.RetCode, ret.ThirdCode)
  end
  self:UnLock("UISetChangePasswdController:NextStepBtnOnClick")
end

function UISetChangePasswdController:CheckEmail(strContent)
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

function UISetChangePasswdController:CheckPassWordValid(info)
  local t = string.match(info, "[^%w_!%[%]%-%+%(%)@#%$%%%^&%*=\\/%?<>,:;|]")
  if t ~= nil then
    return false
  end
  return true
end
