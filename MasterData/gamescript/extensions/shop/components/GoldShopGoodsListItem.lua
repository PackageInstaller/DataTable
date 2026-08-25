local GoldShopGoodsListItem, Super = NewViewComponent("GoldShopGoodsListItem", ShopGoodsListItemBase)

function GoldShopGoodsListItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view, data)
  self.ui = UI_Shop_Item_CommodityResource(uiNode)
  self.data = data
end

function GoldShopGoodsListItem:OnEnterComponent()
  Super.OnEnterComponent(self)
end

function GoldShopGoodsListItem:_RefreshTimeUI()
  self.ui.Group_Time:SetActive(false)
end

return GoldShopGoodsListItem
