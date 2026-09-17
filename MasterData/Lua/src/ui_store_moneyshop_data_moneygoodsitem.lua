local this = class("moneyGoodsItem", require(table.concat({
  L_R.store,
  "shop.data.goodsItem"
})):new())

function this:ctor()
  this.super.ctor()
end

return this
