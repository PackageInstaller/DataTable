_class("UIHauteCoutureDrawRulesMainBLH", UIHauteCoutureDrawRulesBase)
UIHauteCoutureDrawRulesMainBLH = UIHauteCoutureDrawRulesMainBLH

function UIHauteCoutureDrawRulesMainBLH:Constructor()
end

function UIHauteCoutureDrawRulesMainBLH:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawRulesMainBLH:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawRulesMainBLH:GetRuleItemPrefab()
  return "UISeniorSKinProItemsBLH.prefab"
end

function UIHauteCoutureDrawRulesMainBLH:GetRuleItemScript()
  return "UISeniorSKinProItems"
end

function UIHauteCoutureDrawRulesMainBLH:CloseBtnOnClick()
  self.controller:CloseDialog()
end
