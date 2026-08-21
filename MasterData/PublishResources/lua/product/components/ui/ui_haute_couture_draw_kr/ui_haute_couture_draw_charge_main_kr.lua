_class("UIHauteCoutureDrawChargeMainKR", UIHauteCoutureDrawChargeBase)
UIHauteCoutureDrawChargeMainKR = UIHauteCoutureDrawChargeMainKR

function UIHauteCoutureDrawChargeMainKR:Constructor()
end

function UIHauteCoutureDrawChargeMainKR:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
end

function UIHauteCoutureDrawChargeMainKR:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawChargeMainKR:_OnValue()
  self:_OnValueBase()
end

function UIHauteCoutureDrawChargeMainKR:GetItemImpl()
  return "UIHauteCoutureDrawChargeItemKR"
end
