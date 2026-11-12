local MessageBoxDescCtrl = class("MessageBoxDescCtrl", BaseCtrl)
MessageBoxDescCtrl._mapNodeConfig = {
  aniBox = {sNodeName = "goDescBox", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Desc"
  },
  txtContent = {sComponentName = "TMP_Text"},
  btnClose = {sComponentName = "UIButton"},
  btnConfirm2 = {sComponentName = "UIButton"},
  txtConfirm2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  }
}
MessageBoxDescCtrl._mapEventConfig = {}

function MessageBoxDescCtrl:OpenBox(mapMsg, ctrlBase)
  self:Refresh(mapMsg, ctrlBase)
end

function MessageBoxDescCtrl:Refresh(mapMsg, ctrlBase)
  local sContent = mapMsg.sContent
  local sTitle = mapMsg.sTitle
  local sConfirm = mapMsg.sConfirm
  local callbackConfirm = mapMsg.callbackConfirm
  self.bDisableSnap = mapMsg.bDisableSnap
  if sConfirm then
    NovaAPI.SetTMPText(self._mapNode.txtConfirm2, sConfirm)
  end
  NovaAPI.SetTMPText(self._mapNode.txtContent, sContent)
  if sTitle then
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, sTitle)
  end
  if self.handlerConfirm then
    self._mapNode.btnConfirm2.onClick:RemoveListener(self.handlerConfirm)
  end
  self.handlerConfirm = nil
  
  local function func_confirm()
    if self._panel.bBlur then
      self._mapNode.aniBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(callbackConfirm)
  end
  
  self.handlerConfirm = ui_handler(self, func_confirm, self._mapNode.btnConfirm2)
  self._mapNode.btnConfirm2.onClick:AddListener(self.handlerConfirm)
  if self.handlerClose then
    self._mapNode.btnClose.onClick:RemoveListener(self.handlerClose)
  end
  self.handlerClose = nil
  
  local function func_close()
    if self._panel.bBlur then
      self._mapNode.aniBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(callbackConfirm)
  end
  
  self.handlerClose = ui_handler(self, func_close, self._mapNode.btnClose)
  self._mapNode.btnClose.onClick:AddListener(self.handlerClose)
  self._mapNode.aniBox:Play("t_window_04_t_in", 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MessageBoxDescCtrl:Close()
  if self.bDisableSnap then
    return
  end
  if self.handlerClose then
    self.handlerClose()
  end
end

return MessageBoxDescCtrl
