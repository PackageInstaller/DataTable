_class("UIHauteCoutureDrawChargeMainGL", UIHauteCoutureDrawChargeBase)
UIHauteCoutureDrawChargeMainGL = UIHauteCoutureDrawChargeMainGL

function UIHauteCoutureDrawChargeMainGL:Constructor()
end

function UIHauteCoutureDrawChargeMainGL:OnShow(uiParams)
  self:InitWidgets()
  self:_OnValue()
  self:AddEventBase()
  self:AttachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
end

function UIHauteCoutureDrawChargeMainGL:OnHide()
  self:RemoveEventBase()
  self:DetachEvent(GameEventType.ItemCountChanged, self.OnItemCountChange)
end

function UIHauteCoutureDrawChargeMainGL:OnItemCountChange()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.RefreshSeniorSkinRedPoint)
end

function UIHauteCoutureDrawChargeMainGL:InitWidgets()
  self:InitWidgetsBase()
end

function UIHauteCoutureDrawChargeMainGL:_OnValue()
  self:_OnValueBase()
end

function UIHauteCoutureDrawChargeMainGL:GetItemImpl()
  return "UIHauteCoutureDrawChargeItemGL"
end
