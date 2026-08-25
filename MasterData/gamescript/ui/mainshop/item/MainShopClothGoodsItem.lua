local MainShopClothGoodsItem, Super = System.NewComponent("MainShopClothGoodsItem", MainShopGiftBagItem)

function MainShopClothGoodsItem:_OnBindShopItemIcon()
  self.ui.Image_Icon:SetActive(false)
  self.ui.Image_AwakerSkin:SetActive(true)
  self.ui.Image_SkinQuality:SetActive(true)
  local itemTid = ShopCfgUtils.GetShopSellingItemTid(self.viewData.shopItemData.tid)
  local skinTid = AwakerSkinUtils.GetSkinByItem(itemTid)
  AwakerUiUtils.RefreshAwakerSkinStarGroup(self, self.binder, skinTid)
  self.binder:BindToImage(self.ui.Image_AwakerSkin, function()
    local itemCfg = ItemCfgUtils.GetCfg(self.viewData.shopItemData.itemList[1]) or {}
    return itemCfg.SpIcon or itemCfg.Icon
  end)
  self.binder:BindToImage(self.ui.Image_Quality, function()
    do return AwakerSkinCfgUtils.GetSkinShopQualityImage end
    return AwakerSkinCfgUtils.GetSkinShopQualityImage, skinTid
  end)
  self.binder:BindToImage(self.ui.Image_SkinQuality, function()
    do return AwakerSkinCfgUtils.GetSkinShopQualityBottomImage end
    return AwakerSkinCfgUtils.GetSkinShopQualityBottomImage, skinTid
  end)
end

return MainShopClothGoodsItem
