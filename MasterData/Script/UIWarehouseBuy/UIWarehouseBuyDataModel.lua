local DataModel = {
  initParams = {},
  curNum = 1,
  curCost = 0,
  priceInfo = 0,
  canBuy = false,
  maxNum = 0,
  minNum = 1,
  goldIcon = ""
}

function DataModel.Init()
  DataModel.curNum = 1
  local stationCA = PlayerData:GetFactoryData(DataModel.initParams.stationId, "HomeStationFactory")
  if stationCA.attachedToCity > 0 then
    stationCA = PlayerData:GetFactoryData(stationCA.attachedToCity, "HomeStationFactory")
  end
  local price = stationCA.buyPrice[1]
  DataModel.priceInfo = price
  local itemCa = PlayerData:GetFactoryData(price.id, "ItemFactory")
  if itemCa then
    DataModel.goldIcon = itemCa.buyPath or ""
  end
  local maxNum, minNum
  maxNum = DataModel.initParams.maxNum
  local canBuyNum = math.floor(PlayerData:GetGoodsById(DataModel.priceInfo.id).num / DataModel.priceInfo.num)
  if maxNum > canBuyNum then
    maxNum = canBuyNum
  end
  if maxNum == 0 then
    maxNum = 1
    DataModel.canBuy = false
  else
    DataModel.canBuy = true
  end
  minNum = 1
  DataModel.maxNum = maxNum
  DataModel.minNum = minNum
end

return DataModel
