_class("UIHauteCoutureDrawDynamicProbabilityMainKR", UIHauteCoutureDrawDynamicProbablityBase)
UIHauteCoutureDrawDynamicProbabilityMainKR = UIHauteCoutureDrawDynamicProbabilityMainKR

function UIHauteCoutureDrawDynamicProbabilityMainKR:Constructor()
end

function UIHauteCoutureDrawDynamicProbabilityMainKR:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawDynamicProbabilityMainKR:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawDynamicProbabilityMainKR:GetProbablityItemScript()
  return "UIHauteCoutureDrawProbabiltyItemKR"
end
