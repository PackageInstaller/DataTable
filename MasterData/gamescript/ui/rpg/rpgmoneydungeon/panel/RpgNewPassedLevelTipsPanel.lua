local RpgNewPassedLevelTipsPanel, Super = System.NewClass("RpgNewPassedLevelTipsPanel", UIBasePanel)
RpgNewPassedLevelTipsPanel.uiResCls = Popup_Arena_Level_AwardResource

function RpgNewPassedLevelTipsPanel:ctor(data)
  Super.ctor(self)
  self.data = data
end

function RpgNewPassedLevelTipsPanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Confirm, System.fn(self, self.ClosePanel))
end

function RpgNewPassedLevelTipsPanel:ClosePanel()
  self:Close()
end

return RpgNewPassedLevelTipsPanel
