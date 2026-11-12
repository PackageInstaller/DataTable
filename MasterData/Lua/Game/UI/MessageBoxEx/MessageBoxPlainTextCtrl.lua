local MessageBoxPlainTextCtrl = class("MessageBoxPlainTextCtrl", BaseCtrl)
MessageBoxPlainTextCtrl._mapNodeConfig = {
  aniMessageBox = {
    sNodeName = "goMessageBox",
    sComponentName = "Animator"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Title"
  },
  txtContent = {sComponentName = "TMP_Text"},
  btnClose = {sComponentName = "UIButton"}
}

function MessageBoxPlainTextCtrl:OpenBox(mapMsg, ctrlBase)
  local sContent = mapMsg.sContent
  local sTitle = mapMsg.sTitle
  local callbackCancel = mapMsg.callbackCancel
  NovaAPI.SetTMPText(self._mapNode.txtContent, sContent)
  if sTitle then
    NovaAPI.SetTMPText(self._mapNode.txtWindowTitle, sTitle)
  end
  if self.handlerClose then
    self._mapNode.btnClose.onClick:RemoveListener(self.handlerClose)
  end
  self.handlerClose = nil
  
  local function func_close()
    if self._panel.bBlur then
      self._mapNode.aniMessageBox:Play("t_window_04_t_out")
    end
    ctrlBase:DefaultClick(callbackCancel)
  end
  
  self.handlerClose = ui_handler(self, func_close, self._mapNode.btnClose)
  self._mapNode.btnClose.onClick:AddListener(self.handlerClose)
  self._mapNode.aniMessageBox:Play("t_window_04_t_in", 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MessageBoxPlainTextCtrl:Close()
  if self.handlerClose then
    self.handlerClose()
  end
end

return MessageBoxPlainTextCtrl
