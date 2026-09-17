local this = class("shopStore", G_BaseStore)
this.event = {
  refreshStock = "shopStore_refreshStock",
  syncShopInfosComplete = "syncShopInfosComplete",
  onBuyShopGoodsSucc = "onBuyShopGoodsSucc",
  onOpenShopPage = "onOpenShopPage"
}
this:importPartialClass(require(L_R.store .. "shop.shopState"))
this:importPartialClass(require(L_R.store .. "shop.shopAction"))
return this
