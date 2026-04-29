require("ui_haute_couture_draw_charge_item_base")
_class("UIHauteCoutureDraw_QT_ChargeItem", UIHauteCoutureDrawChargeItemBase)
UIHauteCoutureDraw_QT_ChargeItem = UIHauteCoutureDraw_QT_ChargeItem

function UIHauteCoutureDraw_QT_ChargeItem:OnShow(uiParams)
  self:InitWidgets()
end

function UIHauteCoutureDraw_QT_ChargeItem:OnHide()
  self:ClearTimer()
end

function UIHauteCoutureDraw_QT_ChargeItem:InitWidgets(uiParams)
  self:InitWidgetsBase()
end

function UIHauteCoutureDraw_QT_ChargeItem:GetCountStrKey()
  return "str_senior_skin_draw_gift_count_qt"
end
