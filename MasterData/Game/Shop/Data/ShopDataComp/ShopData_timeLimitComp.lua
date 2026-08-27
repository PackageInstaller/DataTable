local ShopData_timeLimitComp = class("ShopData_timeLimitComp")

function ShopData_timeLimitComp:ctor()
end

function ShopData_timeLimitComp:UpdateShopDataComp(shopData, shopDataMsg)
  self.shopData = shopData
  self:__RemoveShopGoods()
end

function ShopData_timeLimitComp:GetNeedRefreshGoodsTs()
  return self.shopData.needRefreshGoodsTs
end

function ShopData_timeLimitComp:__RemoveShopGoods()
  self.shopData.needRefreshGoodsTs = math.maxinteger
  for shelfId, goodData in pairs(self.shopData.shopGoodsDic) do
    local hasTimeLimit, inTime, startTime, endTime = goodData:GetStillTime()
    if hasTimeLimit then
      if inTime then
        self.shopData.needRefreshGoodsTs = math.min(self.shopData.needRefreshGoodsTs, endTime)
      else
        if startTime > PlayerDataCenter.timestamp then
          self.shopData.needRefreshGoodsTs = math.min(self.shopData.needRefreshGoodsTs, startTime)
        end
        self.shopData.shopGoodsDic[shelfId] = nil
      end
    end
  end
end

return ShopData_timeLimitComp
