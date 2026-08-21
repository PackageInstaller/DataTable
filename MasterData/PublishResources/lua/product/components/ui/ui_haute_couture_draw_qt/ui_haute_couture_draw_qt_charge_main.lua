require("ui_haute_couture_draw_charge_base")
_class("UIHauteCoutureDraw_QT_ChargeMain", UIHauteCoutureDrawChargeBase)
UIHauteCoutureDraw_QT_ChargeMain = UIHauteCoutureDraw_QT_ChargeMain

function UIHauteCoutureDraw_QT_ChargeMain:Constructor()
end

function UIHauteCoutureDraw_QT_ChargeMain:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
  self:AddEventBase()
end

function UIHauteCoutureDraw_QT_ChargeMain:OnHide()
  self:RemoveEventBase()
end

function UIHauteCoutureDraw_QT_ChargeMain:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDraw_QT_ChargeMain:_OnValue()
  self:_OnValueBase()
end

function UIHauteCoutureDraw_QT_ChargeMain:GetItemImpl()
  return "UIHauteCoutureDraw_QT_ChargeItem"
end
