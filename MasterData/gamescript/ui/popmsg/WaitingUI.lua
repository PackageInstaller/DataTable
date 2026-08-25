local WaitingUI, Super = System.NewClass("WaitingUI", UIBasePanel)
WaitingUI.uiResCls = Panel_BreakResource

function WaitingUI:ctor(strTitle)
  Super.ctor(self)
  self.strTitle = strTitle
end

function WaitingUI:OnBind(binder)
  Logger.Debug("WaitingUI:OnBind(), 创建 UI")
  binder:SetText(self.ui.Text_Desc, self.strTitle)
end

return WaitingUI
