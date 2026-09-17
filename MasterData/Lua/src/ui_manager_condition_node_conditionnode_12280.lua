local this = class("conditionNode_12280", require(L_R.condition .. "conditionNode"))

function this:ctor(condition)
  this.super.ctor(self, condition)
  
  function self._onMallRefresh()
    self:refresh()
  end
  
  L_ShopStore:listenCallFunc(L_ShopStore.event.refreshStock, self._onMallRefresh)
  L_ShopStore:listenCallFunc(L_ShopStore.event.syncShopInfosComplete, self._onMallRefresh)
end

function this:onDestroy()
  L_ShopStore:unListenCallFunc(L_ShopStore.event.refreshStock, self._onMallRefresh)
  L_ShopStore:unListenCallFunc(L_ShopStore.event.syncShopInfosComplete, self._onMallRefresh)
  this.super.onDestroy(self)
end

function this.checkFunc(condition)
  return AzurWorld.ConditionMgr:SafeQuickCheck(condition)
end

return this
