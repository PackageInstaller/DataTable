local UIMaskPanel, Super = System.NewClass("UIMaskPanel", UIBasePanel)
UIMaskPanel.uiResCls = UI_Common_Mask_PanelResource

function UIMaskPanel:ctor(delay)
  Super.ctor(self)
  self.delay = delay
end

function UIMaskPanel:OnBind(binder)
  binder:BindTimer(self.delay or 2, 0, nil, function()
    self:Close()
  end)
end

return UIMaskPanel
