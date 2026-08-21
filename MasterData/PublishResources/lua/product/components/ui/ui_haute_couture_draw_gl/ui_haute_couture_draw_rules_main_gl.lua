_class("UIHauteCoutureDrawRulesMainGL", UIHauteCoutureDrawRulesBase)
UIHauteCoutureDrawRulesMainGL = UIHauteCoutureDrawRulesMainGL

function UIHauteCoutureDrawRulesMainGL:Constructor()
end

function UIHauteCoutureDrawRulesMainGL:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawRulesMainGL:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawRulesMainGL:GetRuleItemPrefab()
  return "UISeniorSKinProItemsGL.prefab"
end

function UIHauteCoutureDrawRulesMainGL:GetRuleItemScript()
  return "UISeniorSKinProItems"
end

function UIHauteCoutureDrawRulesMainGL:SetReviewRewardContenText()
  self:GetUIComponent("UILocalizationText", "RewardContent"):SetText(StringTable.Get("str_senior_skin_draw_rule_reward_detail_gl_review"))
end

function UIHauteCoutureDrawRulesMainGL:CloseBtnOnClick()
  self.controller:CloseDialog()
end
