_class("UIHauteCoutureDrawDynamicProbabilityMainPLM", UIHauteCoutureDrawDynamicProbablityBase)
UIHauteCoutureDrawDynamicProbabilityMainPLM = UIHauteCoutureDrawDynamicProbabilityMainPLM

function UIHauteCoutureDrawDynamicProbabilityMainPLM:Constructor()
end

function UIHauteCoutureDrawDynamicProbabilityMainPLM:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawDynamicProbabilityMainPLM:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawDynamicProbabilityMainPLM:GetProbablityItemScript()
  return "UIHauteCoutureDrawProbabiltyItemPLM"
end
