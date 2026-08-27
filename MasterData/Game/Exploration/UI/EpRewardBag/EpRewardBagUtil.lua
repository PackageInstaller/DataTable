local EpRewardBagUtil = {}
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

local function GetEpRewardBagStateType(epModuleId, stageId)
  if epModuleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    local cfg = ConfigData.sector_stage[stageId]
    if cfg == nil then
      error("sector stage is null,id:" .. tostring(stageId))
      return 0
    end
    if cfg.difficulty == ExplorationEnum.eDifficultType.Normal then
      return 1
    elseif cfg.difficulty == ExplorationEnum.eDifficultType.Hard then
      return 2
    else
      error("Unsupported exploration difficulty, difficulty = " .. tostring(cfg.difficulty))
      return 0
    end
  elseif epModuleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    return 3
  elseif epModuleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WarChess then
    return 4
  elseif epModuleId == proto_csmsg_SystemFunctionID.SystemFunctionID_WarChessSeason then
    return 5
  end
end

function EpRewardBagUtil.GetEpRewardItemPrice(itemId, epModuleId, stageId, num, original)
  local stateType = GetEpRewardBagStateType(epModuleId, stageId)
  if stateType == nil then
    error(string.format("EpModuleId is invalid,EpModuleId = %s, itemId = %s, stateType = %s", epModuleId, itemId, stateType))
    return 0, nil
  end
  local stageTypeDic = ConfigData.reward_purchase.rewardPurchaseDic[itemId]
  if stageTypeDic == nil then
    error(string.format("Cant get reward_purchase cfg, itemId = %s, stateType = %s", itemId, stateType))
    return 0, nil
  end
  local stageIdList = stageTypeDic[stateType]
  if stageIdList == nil then
    error(string.format("Cant get reward_purchase cfg, itemId = %s, stateType = %s", itemId, stateType))
    return 0, nil
  end
  local price = 0
  local costItemId
  if original then
    local id = stageIdList[1]
    local cfg = ConfigData.reward_purchase[id]
    price = cfg.item_price
    costItemId = cfg.currency
  else
    for k, v in ipairs(stageIdList) do
      local curCfg = ConfigData.reward_purchase[v]
      local nextCfg = ConfigData.reward_purchase[stageIdList[k + 1]]
      if nextCfg == nil then
        price = curCfg.item_price
        costItemId = curCfg.currency
        break
      end
      if stageId < nextCfg.stage_id then
        price = curCfg.item_price
        costItemId = curCfg.currency
        break
      end
    end
  end
  return price * num, costItemId
end

function EpRewardBagUtil:GetEpRewardItemPriceStr(price)
  local dividend = ConfigData.game_config.staminaDividend / 10
  local value = math.ceil(price / dividend)
  value = FormatNum(value / 10)
  return tostring(value)
end

function EpRewardBagUtil:GetEpRewardCurrencyId(epModuleId, stageId)
  local defaultId = ConstGlobalItem.SKey
  local stateType = GetEpRewardBagStateType(epModuleId, stageId)
  if stateType == nil then
    error(string.format("EpModuleId is invalid,EpModuleId = %s, stageId = %s", epModuleId, stageId))
    return defaultId
  end
  local stageCurrencyList = ConfigData.reward_purchase.currencyIndexDic[stateType]
  if stageCurrencyList == nil then
    error(string.format("stageCurrencyList == nil, EpModuleId = %s, stageId = %s", epModuleId, stageId))
    return defaultId
  end
  local currencyId = 0
  for k, curCfg in ipairs(stageCurrencyList) do
    local nextCfg = stageCurrencyList[k + 1]
    if nextCfg == nil then
      currencyId = curCfg.currencyId
      break
    end
    if stageId < nextCfg.stageId then
      currencyId = curCfg.currencyId
      break
    end
  end
  if currencyId == 0 then
    return defaultId
  end
  return currencyId
end

return EpRewardBagUtil
