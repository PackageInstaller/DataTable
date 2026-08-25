local Level2TipsPanel, Super = System.NewClass("Level2TipsPanel", UIBasePanel)
Level2TipsPanel.uiResCls = Panel_Level2_TipsResource

function Level2TipsPanel:ctor(title, descrition, confirmCb, ...)
  Super.ctor(self)
  self.title = title
  self.descrition = descrition
  self.confirmCb = confirmCb
  self.confirmParam = (...)
end

function Level2TipsPanel:OnBind(binder)
  Super.OnBind(self, binder)
  if self.title then
    binder:SetText(self.ui.Text_Title, self.title)
  else
    binder:SetActive(self.ui.Text_Title, false)
  end
  binder:SetText(self.ui.Text_Desc, self.descrition)
  binder:BindButtonClick(self.ui.Btn_Cancel_New, System.fn(self, self.OnClickCancel))
  binder:BindButtonClick(self.ui.Btn_Confirm_New, System.fn(self, self.OnClickConfirm))
end

function Level2TipsPanel:OnClickCancel()
  self:Close()
end

function Level2TipsPanel:OnClickConfirm()
  if nil ~= self.confirmCb then
    self.confirmCb(self.confirmParam)
  end
  self:Close()
end

return Level2TipsPanel
