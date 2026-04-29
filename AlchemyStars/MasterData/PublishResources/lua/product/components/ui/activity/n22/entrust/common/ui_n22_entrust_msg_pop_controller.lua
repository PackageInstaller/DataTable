_class("UIN22EntrustMsgPopController", UIController)
UIN22EntrustMsgPopController = UIN22EntrustMsgPopController

function UIN22EntrustMsgPopController:OnShow(uiParams)
  local title = uiParams[1]
  local desc = uiParams[2]
  local txtExit = uiParams[3] or ""
  self._exit = uiParams[4]
  local txtConfirm = uiParams[5] or ""
  self._confirm = uiParams[6]
  UIWidgetHelper.SetLocalizationText(self, "_mainTitle", title)
  UIWidgetHelper.SetLocalizationText(self, "_mainDesc", desc)
  local showExit = not string.isnullorempty(txtExit)
  UIWidgetHelper.SetLocalizationText(self, "_txtExitBtn", txtExit)
  self:GetGameObject("ExitBtn"):SetActive(showExit)
  local showConfirm = not string.isnullorempty(txtConfirm)
  UIWidgetHelper.SetLocalizationText(self, "_txtConfirmBtn", txtConfirm)
  self:GetGameObject("ConfirmBtn"):SetActive(showConfirm)
end

function UIN22EntrustMsgPopController:ExitBtnOnClick(go)
  self:CloseDialog()
  if self._exit then
    self._exit()
  end
end

function UIN22EntrustMsgPopController:ConfirmBtnOnClick(go)
  self:CloseDialog()
  if self._confirm then
    self._confirm()
  end
end
