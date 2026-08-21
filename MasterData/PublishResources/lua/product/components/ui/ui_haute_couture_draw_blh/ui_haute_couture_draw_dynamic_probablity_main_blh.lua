_class("UIHauteCoutureDrawDynamicProbabilityMainBLH", UIHauteCoutureDrawDynamicProbablityBase)
UIHauteCoutureDrawDynamicProbabilityMainBLH = UIHauteCoutureDrawDynamicProbabilityMainBLH

function UIHauteCoutureDrawDynamicProbabilityMainBLH:Constructor()
end

function UIHauteCoutureDrawDynamicProbabilityMainBLH:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawDynamicProbabilityMainBLH:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawDynamicProbabilityMainBLH:GetProbablityItemScript()
  return "UIHauteCoutureDrawProbabiltyItemBLH"
end
