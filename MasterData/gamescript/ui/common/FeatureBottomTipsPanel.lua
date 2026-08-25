local FeatureBottomTipsPanel, Super = System.NewClass("FeatureBottomTipsPanel", UIBasePanel)
FeatureBottomTipsPanel.uiResCls = UI_Feature_Bottom_TipsResource

function FeatureBottomTipsPanel:ctor(desc)
  Super.ctor(self)
  self.desc = desc
end

function FeatureBottomTipsPanel:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Desc, self.desc)
  binder:BindTimer(3, 0, nil, function()
    self:Close()
  end)
end

return FeatureBottomTipsPanel
