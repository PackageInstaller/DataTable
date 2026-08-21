_class("UIHauteCoutureDrawChargeMainBLH", UIHauteCoutureDrawChargeBase)
UIHauteCoutureDrawChargeMainBLH = UIHauteCoutureDrawChargeMainBLH

function UIHauteCoutureDrawChargeMainBLH:Constructor()
end

function UIHauteCoutureDrawChargeMainBLH:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
  self:AddEventBase()
end

function UIHauteCoutureDrawChargeMainBLH:InitWidgets()
  self:InitWidgetsBase()
  self:RemoveEventBase()
end

function UIHauteCoutureDrawChargeMainBLH:_OnValue()
  self:_OnValueBase()
end

function UIHauteCoutureDrawChargeMainBLH:GetItemImpl()
  return "UIHauteCoutureDrawChargeItemBLH"
end
