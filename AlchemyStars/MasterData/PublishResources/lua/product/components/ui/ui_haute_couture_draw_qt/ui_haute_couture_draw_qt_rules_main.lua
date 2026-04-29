require("ui_haute_couture_draw_rules_base")
_class("UIHauteCoutureDraw_QT_RulesMain", UIHauteCoutureDrawRulesBase)
UIHauteCoutureDraw_QT_RulesMain = UIHauteCoutureDraw_QT_RulesMain

function UIHauteCoutureDraw_QT_RulesMain:Constructor()
end

function UIHauteCoutureDraw_QT_RulesMain:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDraw_QT_RulesMain:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDraw_QT_RulesMain:GetRuleItemPrefab()
  return "UIHauteCoutureDraw_QT_RulesItem.prefab"
end

function UIHauteCoutureDraw_QT_RulesMain:GetRuleItemScript()
  return "UISeniorSKinProItems"
end

function UIHauteCoutureDraw_QT_RulesMain:CloseBtnOnClick()
  self.controller:CloseDialog()
end
