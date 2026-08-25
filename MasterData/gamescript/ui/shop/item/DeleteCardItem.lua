local DeleteCardItem, Super = System.NewComponent("DeleteCardItem")

function DeleteCardItem:ctor(uiNode, userData)
  Super.ctor(self)
  self.ui = UI_Dbgcopy_Item_Shop_CardResource(uiNode)
  self.userData = userData
end

function DeleteCardItem:OnBind(binder)
  self.binder = binder
  self.card = binder:BindComponent(CardBaseComponent(self.ui.Item_Card_Base, self.userData.uid, self.userData.configId, false))
  self:SetUnAbleSale(self.userData.state)
end

function DeleteCardItem:SetUnAbleSale(state)
  Logger.Info("DeleteCardItem", state)
  self.binder:SetActive(self.ui.Group_No_Sell, state)
end

return DeleteCardItem
