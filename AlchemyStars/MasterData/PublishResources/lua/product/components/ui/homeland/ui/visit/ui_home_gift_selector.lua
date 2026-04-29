_class("UIHomeGiftSelector", UIController)
UIHomeGiftSelector = UIHomeGiftSelector

function UIHomeGiftSelector:OnShow(uiParams)
  self:InitWidget()
  local selector = self.operator:SpawnObject("UIHomeStorehouseOperator")
  selector:SetData(function(id, count)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomeVisitAddGift, id, count)
    self:CloseDialog()
  end)
end

function UIHomeGiftSelector:InitWidget()
  self.operator = self:GetUIComponent("UISelectObjectPath", "Operator")
end

function UIHomeGiftSelector:CloseOnClick(go)
  self:CloseDialog()
end
