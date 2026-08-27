local ShopData_refreshComp = class("ShopData_refreshComp")

function ShopData_refreshComp:ctor()
end

function ShopData_refreshComp:UpdateShopDataComp(shopData, shopDataMsg)
  self.shopData = shopData
  self.shopData.couldFresh = false
  self.shopData.couldFreshCount = 0
  if shopDataMsg ~= nil and 0 < (shopDataMsg.freeFreshTm or 0) then
    self.shopData.freeFreshTm = shopDataMsg.freeFreshTm
    self.shopData.freshCount = shopDataMsg.freshCount
  else
    local timePassCtrl = ControllerManager:GetController(ControllerTypeId.TimePass)
    local counterEltReset = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleStorePurchaseResetTimes, self.shopData.shopId)
    local counterEltSys = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleStoreSystemReset, self.shopData.shopId)
    if counterEltSys == nil then
      self.shopData.isRefreshShop = false
      error("Cant get refrshTm, shopId:" .. tostring(self.shopData.shopId))
      return
    end
    if counterEltReset == nil or counterEltReset.nextExpiredTm < counterEltSys.nextExpiredTm then
      self.shopData.freshCount = 0
      self.shopData.freeFreshTm = counterEltSys.nextExpiredTm
    else
      self.shopData.freshCount = counterEltReset.times
      self.shopData.freeFreshTm = counterEltReset.nextExpiredTm
    end
    for shelfId, goodData in pairs(self.shopData.shopGoodsDic) do
      local counterId = self.shopData.shopId << 32 | shelfId
      local counterEltGood = timePassCtrl:getCounterElemData(proto_object_CounterModule.CounterModuleStoreShelfPurchaseLimit, counterId)
      if counterEltGood ~= nil and 0 < goodData.purchases and counterEltGood.nextExpiredTm < self.shopData.freeFreshTm then
        self.shopData.freeFreshTm = counterEltGood.nextExpiredTm
      end
    end
  end
  local refresh_times = self.shopData.shopCfg.refresh_times
  self.shopData.couldFreshCount = 0
  if #refresh_times ~= 0 then
    for i, refreshTime in ipairs(refresh_times) do
      if 0 <= refreshTime then
        self.shopData.couldFreshCount = refreshTime
      else
        self.shopData.couldFreshCount = "∞"
      end
    end
    for i, refreshTime in ipairs(refresh_times) do
      if refreshTime > self.shopData.freshCount or refreshTime == -1 then
        local costId = self.shopData.shopCfg.refreshCostId
        local costNum = self.shopData.shopCfg.refreshCostNum[i]
        self.shopData.refreshCost = {costId = costId, costNum = costNum}
        self.shopData.couldFresh = true
        break
      end
    end
    if self.shopData.refreshCost == nil then
      self.shopData.refreshCost = {
        costId = self.shopData.shopCfg.refreshCostId,
        costNum = -1
      }
    end
  end
end

function ShopData_refreshComp:GetCouldRefresh()
  local isAbleRefresh = false
  local refreshCostId, refreshCostNum
  if #self.shopData.shopCfg.refresh_times ~= 0 then
    for index, refreshTime in ipairs(self.shopCfg.refresh_times) do
      if refreshTime > self.shopData.freshCount or refreshTime == -1 then
        isAbleRefresh = true
        refreshCostNum = self.shopData.shopCfg.refreshCostNum[index]
        refreshCostId = self.shopData.shopCfg.refreshCostId
        break
      end
    end
  end
  return isAbleRefresh, refreshCostId, refreshCostNum
end

function ShopData_refreshComp:GetRemainAutoRefreshTime(needZero)
  if needZero then
    return math.max(self.shopData.freeFreshTm - PlayerDataCenter.timestamp, 0)
  end
  return self.shopData.freeFreshTm - PlayerDataCenter.timestamp
end

return ShopData_refreshComp
