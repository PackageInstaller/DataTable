_class("UIHauteCoutureDrawRulesMainPLM", UIHauteCoutureDrawRulesBase)
UIHauteCoutureDrawRulesMainPLM = UIHauteCoutureDrawRulesMainPLM

function UIHauteCoutureDrawRulesMainPLM:Constructor()
end

function UIHauteCoutureDrawRulesMainPLM:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawRulesMainPLM:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawRulesMainPLM:GetRuleItemPrefab()
  return "UISeniorSKinProItemsPLM.prefab"
end

function UIHauteCoutureDrawRulesMainPLM:GetRuleItemScript()
  return "UISeniorSKinProItems"
end

function UIHauteCoutureDrawRulesMainPLM:SetReviewRewardContenText()
  self:GetUIComponent("UILocalizationText", "RewardContent"):SetText(StringTable.Get("str_senior_skin_draw_rule_reward_detail_plm"))
end

function UIHauteCoutureDrawRulesMainPLM:CloseBtnOnClick()
  self.controller:CloseDialog()
end
