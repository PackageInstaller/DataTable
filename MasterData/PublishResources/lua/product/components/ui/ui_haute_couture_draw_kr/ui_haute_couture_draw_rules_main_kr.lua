_class("UIHauteCoutureDrawRulesMainKR", UIHauteCoutureDrawRulesBase)
UIHauteCoutureDrawRulesMainKR = UIHauteCoutureDrawRulesMainKR

function UIHauteCoutureDrawRulesMainKR:Constructor()
end

function UIHauteCoutureDrawRulesMainKR:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawRulesMainKR:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawRulesMainKR:GetRuleItemPrefab()
  return "UISeniorSKinProItemsKR.prefab"
end

function UIHauteCoutureDrawRulesMainKR:GetRuleItemScript()
  return "UISeniorSKinProItems"
end

function UIHauteCoutureDrawRulesMainKR:CloseBtnOnClick()
  self.controller:CloseDialog()
end
