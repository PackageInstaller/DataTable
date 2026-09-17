local this = class("conditionNode_7001", require(L_R.condition .. "conditionNode"))

function this:ctor()
  this.super.ctor(self)
  L_MoneyShopStore:listenCallFunc(L_MoneyShopStore.event.refreshStock, self.refresh, self)
  self.autoDestroy = false
end

function this:onDestroy()
  this.super.onDestroy(self)
  L_MoneyShopStore:unListenCallFunc(L_MoneyShopStore.event.refreshStock, self.refresh)
end

function this.checkFunc(codData)
  local shopId = codData[2]
  local goodsId = codData[3]
  return L_MoneyShopManager:getShopIsSoldOutForGoodsID(shopId, goodsId)
end

return this
