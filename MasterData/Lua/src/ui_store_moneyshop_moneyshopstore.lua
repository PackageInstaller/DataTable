local this = class("moneyShopStore", G_BaseStore)
this.event = {
  refreshStock = "moneyShopStoreRefreshStock"
}
this:importPartialClass(require(L_R.store .. "moneyShop.moneyShopState"))
this:importPartialClass(require(L_R.store .. "moneyShop.moneyShopAction"))

function this:clear()
  this.super.clear(self)
  if self.data ~= nil and self.data.shopList ~= nil then
    table.clear(self.data.shopList)
  end
  if self.slotIdList ~= nil then
    table.clear(self.slotIdList)
  end
end

return this
