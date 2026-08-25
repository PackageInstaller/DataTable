local MainShopDailyFreeGiftBagItem, Super = System.NewComponent("MainShopDailyFreeGiftBagItem", MainShopGiftBagItem)

function MainShopDailyFreeGiftBagItem:ctor(uiNode, viewData)
  Super.ctor(self, uiNode, viewData)
end

function MainShopDailyFreeGiftBagItem:OnBindAdditionalReward()
  self.ui.Image_Gradient:SetActive(false)
end

function MainShopDailyFreeGiftBagItem:OnBindShopCurrencyIcon()
  self.binder:SetActive(self.ui.Group_CoinNormal, false)
  self.binder:SetActive(self.ui.Image_Currency_Icon, false)
end

function MainShopDailyFreeGiftBagItem:OnBindTextPrice()
  self.binder:SetText(self.ui.Text_Price, LT.Text("ShopItem_Str_Free"))
  self.binder:BindToTextColor(self.ui.Text_Price, function()
    return CommonDefine.ColorType.Dark
  end)
  local groupCoinTrams = self.ui.Group_Coin.transform
  CS.Framework.TransformUtil.SetLocalPos(groupCoinTrams, -16.5, groupCoinTrams.localPosition.y, groupCoinTrams.localPosition.z)
end

function MainShopDailyFreeGiftBagItem:OnBindPerGoodsNum()
  local shopTid = self.viewData.shopItemData.tid
  local shopCfg = DT.Shop[shopTid]
  if not shopCfg then
    return
  end
  self.binder:SetActive(self.ui.Text_PerGoods_num, true)
  local showGoodsNum = shopCfg.Item and shopCfg.Item[2]
  self.binder:SetText(self.ui.Text_PerGoods_num, ItemNumUtils.GetStr(showGoodsNum))
end

function MainShopDailyFreeGiftBagItem:OnBtnBuyClick()
  local shopTid = self.viewData.shopItemData.tid
  local shopTypeTid = MainShopDataUtils.GetCfgByField("ShopType", shopTid)
  MainShopDataUtils.ReqOnShopBuyGoods(self.viewData.shopItemData.uid, shopTypeTid, 1)
end

return MainShopDailyFreeGiftBagItem
