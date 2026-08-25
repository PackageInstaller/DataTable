local FeatureBottomTipsView, Super = NewClass("FeatureBottomTipsView", BaseView)
FeatureBottomTipsView.uiResCls = UI_Feature_Bottom_TipsResource

function FeatureBottomTipsView:ctor(desc)
  Super.ctor(self)
  self._desc = desc
end

function FeatureBottomTipsView:RegisterNotifications()
end

function FeatureBottomTipsView:RegisterEvents()
end

function FeatureBottomTipsView:OnEnterView()
  Super.OnEnterView(self)
  self:SetText(self.ui.Text_Desc, self._desc)
  self:BindTimer(3, 0, nil, function()
    self:Close()
  end)
end

function FeatureBottomTipsView:OnExitView()
  Super.OnExitView(self)
end

return FeatureBottomTipsView
