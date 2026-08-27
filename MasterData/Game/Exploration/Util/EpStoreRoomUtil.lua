local EpStoreRoomUtil = {}

function EpStoreRoomUtil.GetFinalRefreshPriceWithOriginPrice(originPrice)
  if originPrice == nil then
    return 0
  end
  if ExplorationManager == nil then
    return 0
  end
  local serverArg = 100
  local dynPlayer = ExplorationManager:GetDynPlayer()
  if dynPlayer ~= nil then
    serverArg = dynPlayer:GetEpStoreRefreshCommonPriceArg()
  end
  return originPrice * serverArg // 100
end

function EpStoreRoomUtil.GetFinalChipItemBuyPriceWithOriginPrice(originPrice)
  if originPrice == nil then
    return 0
  end
  if ExplorationManager == nil then
    return 0
  end
  local serverArg = 100
  local dynPlayer = ExplorationManager:GetDynPlayer()
  if dynPlayer ~= nil then
    serverArg = dynPlayer:GetChipItemCommonPriceArg()
  end
  return originPrice * serverArg // 100
end

return EpStoreRoomUtil
