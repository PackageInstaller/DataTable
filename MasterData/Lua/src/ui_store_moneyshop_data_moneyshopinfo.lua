local this = class("moneyShopInfo", require(table.concat({
  L_R.store,
  "shop.data.shopInfo"
})):new())

function this:ctor()
  this.super.ctor(self)
  self.items = nil
end

return this
