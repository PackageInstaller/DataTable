local AwakerOriChangeJumpPanel, Super = System.NewClass("AwakerOriChangeJumpPanel", UIBasePanel)
AwakerOriChangeJumpPanel.uiResCls = UI_Awaker_Popup_IeapfrogResource

function AwakerOriChangeJumpPanel:ctor(isBaseToOri)
  Super.ctor(self)
  self.isBaseToOri = isBaseToOri
end

function AwakerOriChangeJumpPanel:OnBind(binder)
  self.binder = binder
  self.ui.Group_Btn_Skip:SetActive(false)
  self.binder:BindTimer(1.5, 0, nil, function()
    self.ui.Group_Btn_Skip:SetActive(self.isBaseToOri)
  end)
  self.binder:BindTimer(5.5, 0, nil, function()
    self.ui.Group_Btn_Skip:SetActive(false)
  end)
  binder:BindButtonClick(self.ui.Group_Btn_Skip, function()
    EventMgr.Instance.JumpAwakerOriSwitch:Dispatch()
    self:Close()
  end)
end

return AwakerOriChangeJumpPanel
