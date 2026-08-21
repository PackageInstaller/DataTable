_class("UIHauteCoutureDrawChargeItemKR", UIHauteCoutureDrawChargeItemBase)
UIHauteCoutureDrawChargeItemKR = UIHauteCoutureDrawChargeItemKR

function UIHauteCoutureDrawChargeItemKR:OnShow(uiParams)
  self:InitWidgets()
end

function UIHauteCoutureDrawChargeItemKR:OnHide()
  self:ClearTimer()
end

function UIHauteCoutureDrawChargeItemKR:InitWidgets(uiParams)
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawChargeItemKR:GetCountStrKey()
  return "str_senior_skin_draw_gift_count_kr"
end
