local DisconnectTipPanel, Super = System.NewClass("DisconnectTipPanel", UIBasePanel)
DisconnectTipPanel.uiResCls = Panel_Level2_TipsResource

function DisconnectTipPanel:ctor(callback)
  Super.ctor(self)
  self._callback = callback
end

function DisconnectTipPanel:OnBind(binder)
  Super.OnBind(self, binder)
  binder:SetText(self.ui.Text_Title, LT.Text("Server_Stop_Tittle"))
  binder:SetText(self.ui.Text_Desc, LT.Text("Server_Stop_Desc"))
  binder:BindButtonClick(self.ui.Btn_Confirm_New, System.fn(self, self.OnClickLeaveGame))
end

function DisconnectTipPanel:OnClickLeaveGame()
  self:Close()
  SceneMgr.Instance:EnterLogin()
  if self._callback then
    self._callback()
  end
end

return DisconnectTipPanel
