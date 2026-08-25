local AwakerFavorabilityCfgUtils = {}
local ORIGINAL_MAX_LEVEL = 15

local function _GetLevelCfg(cfg, level)
  local datalist = cfg and cfg.data_list
  if not datalist then
    return nil
  end
  for _, v in ipairs(datalist) do
    if v.AwakerFavorabilityLevel == level then
      return v
    end
  end
  return nil
end

function AwakerFavorabilityCfgUtils._ParseBreakoutCost(awakerTid)
  local cfg = DT.AwakerFavorability[awakerTid]
  local datalist = cfg and cfg.data_list
  if not datalist then
    return nil, nil
  end
  for _, v in ipairs(datalist) do
    if v.FavorabilityBreakoutCost and #v.FavorabilityBreakoutCost > 0 then
      local costList = {}
      local cost = v.FavorabilityBreakoutCost
      for i = 1, #cost, 2 do
        table.insert(costList, {
          itemId = cost[i],
          count = cost[i + 1]
        })
      end
      return v.AwakerFavorabilityLevel, costList
    end
  end
  return nil, nil
end

function AwakerFavorabilityCfgUtils.GetBreakthroughStartLevel(awakerTid)
  local lv = AwakerFavorabilityCfgUtils._ParseBreakoutCost(awakerTid)
  return lv or ORIGINAL_MAX_LEVEL
end

function AwakerFavorabilityCfgUtils.GetBreakoutCostList(awakerTid)
  local _, costList = AwakerFavorabilityCfgUtils._ParseBreakoutCost(awakerTid)
  return costList or {}
end

function AwakerFavorabilityCfgUtils.HasBreakoutCost(awakerTid, level)
  local cfg = DT.AwakerFavorability[awakerTid]
  local lvCfg = _GetLevelCfg(cfg, level)
  return lvCfg and lvCfg.FavorabilityBreakoutCost and #lvCfg.FavorabilityBreakoutCost > 0
end

function AwakerFavorabilityCfgUtils.GetBreakoutCostForLevel(awakerTid, level)
  local cfg = DT.AwakerFavorability[awakerTid]
  local lvCfg = _GetLevelCfg(cfg, level)
  if not lvCfg or not lvCfg.FavorabilityBreakoutCost then
    return {}
  end
  local costList = {}
  local cost = lvCfg.FavorabilityBreakoutCost
  for i = 1, #cost, 2 do
    table.insert(costList, {
      itemId = cost[i],
      count = cost[i + 1]
    })
  end
  return costList
end

function AwakerFavorabilityCfgUtils.HasEnoughBreakoutItems(awakerTid, level)
  local costList = AwakerFavorabilityCfgUtils.GetBreakoutCostForLevel(awakerTid, level)
  if 0 == #costList then
    return false
  end
  for _, cost in ipairs(costList) do
    if ItemDataUtils.GetItemNum(cost.itemId) < cost.count then
      return false
    end
  end
  return true
end

function AwakerFavorabilityCfgUtils.IsMaxAwakerLikeLevel(awakerTid, likeLevel)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if awaker and awaker.likeLevelLimit and awaker.likeLevelLimit > 0 then
    return likeLevel >= awaker.likeLevelLimit
  end
  local maxLikeLevel = AwakerFavorabilityCfgUtils.GetAwakerMaxLikeLevel(awakerTid)
  return likeLevel >= maxLikeLevel
end

function AwakerFavorabilityCfgUtils.GetAwakerMaxLikeLevel(awakerTid)
  local cfg = DT.AwakerFavorability[awakerTid]
  return cfg and #cfg.data_list or 1
end

function AwakerFavorabilityCfgUtils.GetAwakerTotalLikeExp(awakerTid, awakerLikeLevel, awakerLikeExp)
  local cfg = DT.AwakerFavorability[awakerTid]
  local datalist = cfg and cfg.data_list
  if not datalist then
    return awakerLikeExp
  end
  local rst = 0
  for i = 1, awakerLikeLevel do
    local exp = datalist[i] and datalist[i].AwakerFavorabilityRequire or 0
    rst = rst + exp
  end
  return rst + awakerLikeExp
end

function AwakerFavorabilityCfgUtils.GetBreakthroughLevel(awakerTid)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker then
    return ORIGINAL_MAX_LEVEL
  end
  return awaker.likeLevelLimit or ORIGINAL_MAX_LEVEL
end

function AwakerFavorabilityCfgUtils.GetAwkerLikeLevel(awakerTid)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  return awaker and awaker.likeLevel or 0
end

function AwakerFavorabilityCfgUtils.IsLikeExpFull(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    return false
  end
  local cfg = DT.AwakerFavorability[awakerTid]
  if not cfg then
    return false
  end
  local curLv = awakerData.likeLevel or 0
  local likeLevelLimit = awakerData.likeLevelLimit or 0
  return curLv >= likeLevelLimit
end

function AwakerFavorabilityCfgUtils.CanBreakthrough(awakerTid, selectLv)
  local breakthroughLv = AwakerFavorabilityCfgUtils.GetBreakthroughLevel(awakerTid)
  local maxLv = AwakerFavorabilityCfgUtils.GetAwakerMaxLikeLevel(awakerTid)
  if breakthroughLv >= maxLv then
    return false
  end
  local curLv = AwakerFavorabilityCfgUtils.GetAwkerLikeLevel(awakerTid)
  return maxLv > curLv and selectLv == curLv + 1
end

function AwakerFavorabilityCfgUtils.GetBreakthroughItemId(awakerTid)
  local costList = AwakerFavorabilityCfgUtils.GetBreakoutCostList(awakerTid)
  return costList[1] and costList[1].itemId
end

return AwakerFavorabilityCfgUtils
