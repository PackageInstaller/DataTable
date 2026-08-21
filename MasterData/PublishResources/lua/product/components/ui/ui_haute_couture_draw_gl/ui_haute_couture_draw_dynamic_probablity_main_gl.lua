_class("UIHauteCoutureDrawDynamicProbabilityMainGL", UIHauteCoutureDrawDynamicProbablityBase)
UIHauteCoutureDrawDynamicProbabilityMainGL = UIHauteCoutureDrawDynamicProbabilityMainGL

function UIHauteCoutureDrawDynamicProbabilityMainGL:Constructor()
end

function UIHauteCoutureDrawDynamicProbabilityMainGL:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawDynamicProbabilityMainGL:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawDynamicProbabilityMainGL:GetProbablityItemScript()
  return "UIHauteCoutureDrawProbabiltyItemGL"
end
