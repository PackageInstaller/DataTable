require("ui_haute_couture_draw_dynamic_probablity_base")
_class("UIHauteCoutureDraw_QT_DynamicProbabilityMain", UIHauteCoutureDrawDynamicProbablityBase)
UIHauteCoutureDraw_QT_DynamicProbabilityMain = UIHauteCoutureDraw_QT_DynamicProbabilityMain

function UIHauteCoutureDraw_QT_DynamicProbabilityMain:Constructor()
end

function UIHauteCoutureDraw_QT_DynamicProbabilityMain:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDraw_QT_DynamicProbabilityMain:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDraw_QT_DynamicProbabilityMain:GetProbablityItemScript()
  return "UIHauteCoutureDraw_QT_DynamicProbabilityItem"
end
