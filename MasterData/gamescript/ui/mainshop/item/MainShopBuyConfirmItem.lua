local MainShopBuyConfirmItem, Super = System.NewComponent("MainShopBuyConfirmItem")

function MainShopBuyConfirmItem:ctor(uiNode, data, addCount)
  Super.ctor(self)
  self.viewData = data
  self.addCount = addCount
  self.ui = Item_Shop_Article_ConfirmResource(uiNode)
end

function MainShopBuyConfirmItem:OnBind(binder)
  self.binder = binder
  self:BindText()
  binder:BindComponent(ItemPublicArticle(self.ui.Item_Public_Article, self.viewData.itemTid, self.viewData.count, false, false, false, nil))
end

function MainShopBuyConfirmItem:BindText()
  local itemBinder = self.binder
  local data = self.viewData
  local num = ItemDataUtils.GetItemNum(data.itemTid)
  itemBinder:SetText(self.ui.Text_Name, ItemDataUtils.GetName(data.itemTid))
  itemBinder:SetText(self.ui.Text_Cur_Count, num)
  itemBinder:SetText(self.ui.Text_Next_Count, num + self.addCount)
end

function MainShopBuyConfirmItem:UpdateNextCount(count)
  self.addCount = count
  local num = ItemDataUtils.GetItemNum(self.viewData.itemTid)
  self.binder:SetText(self.ui.Text_Next_Count, num + self.addCount)
end

return MainShopBuyConfirmItem
