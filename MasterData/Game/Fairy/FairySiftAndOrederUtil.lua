local FairySiftAndOrederUtil = {}
FairySiftAndOrederUtil.orderType = {
  none = 0,
  level = 1,
  uid = 2
}
FairySiftAndOrederUtil.siftType = {
  star = 1,
  quality = 2,
  race = 3
}
FairySiftAndOrederUtil.siftValues = {
  [FairySiftAndOrederUtil.siftType.star] = function()
    local rank = 0
    local maxRank = #ConfigData.fairy_star_new
    return function()
      rank = rank + 1
      if rank <= maxRank then
        return rank
      end
    end
  end,
  [FairySiftAndOrederUtil.siftType.quality] = function()
    local rarity = 0
    local maxRarityNum = #ConfigData.fairy_skill_weight
    return function()
      rarity = rarity + 1
      if rarity <= maxRarityNum then
        local cfg = ConfigData.fairy_skill_weight[rarity]
        return cfg.name
      end
    end
  end,
  [FairySiftAndOrederUtil.siftType.race] = function()
    local allFairyIdList = {}
    for fairyId, cfg in pairs(ConfigData.fairy_data) do
      table.insert(allFairyIdList, cfg)
    end
    table.sort(allFairyIdList, function(a, b)
      return a.id < b.id
    end)
    local index = 0
    return function()
      index = index + 1
      if index <= #allFairyIdList then
        local cfg = allFairyIdList[index]
        return LanguageUtil.GetLocaleText(cfg.name)
      end
    end
  end
}

function FairySiftAndOrederUtil.BuildSortFunc(orderType, isAsc)
  if orderType == FairySiftAndOrederUtil.orderType.level then
    return function(fairyA, fairyB)
      local levelA = fairyA:GetFairyCurLevel()
      local levelB = fairyB:GetFairyCurLevel()
      if levelA ~= levelB then
        if isAsc then
          return levelA < levelB
        else
          return levelA > levelB
        end
      end
      return fairyA:GetFairyUID() > fairyB:GetFairyUID()
    end
  elseif orderType == FairySiftAndOrederUtil.orderType.uid then
    return function(fairyA, fairyB)
      local UIDA = fairyA:GetFairyUID()
      local UIDB = fairyB:GetFairyUID()
      if isAsc then
        return UIDA < UIDB
      else
        return UIDA > UIDB
      end
    end
  end
end

function FairySiftAndOrederUtil.BuildSiftFunc(kvDic)
  return function(fairyData)
    if kvDic == nil or table.count(kvDic) == 0 then
      return true
    end
    for siftType, argDic in pairs(kvDic) do
      if siftType == FairySiftAndOrederUtil.siftType.star then
        local star = fairyData:GetFairyCurStar()
        if argDic[star] == nil then
          return false
        end
      elseif siftType == FairySiftAndOrederUtil.siftType.quality then
        local quality = fairyData:GetCurFairyQuality()
        if argDic[quality] == nil then
          return false
        end
      elseif siftType == FairySiftAndOrederUtil.siftType.race then
        local race = fairyData:GetFairyID()
        if argDic[race] == nil then
          return false
        end
      end
    end
    return true
  end
end

function FairySiftAndOrederUtil.BuildSiftFuncWith(sortKindData)
  local kvDic = {}
  for type, cfg in pairs(sortKindData) do
    if not cfg.nocondition then
      local argDic = {}
      for key, value in pairs(cfg.selectIndexs) do
        if value then
          argDic[key] = true
        end
      end
      kvDic[type] = argDic
    end
  end
  return FairySiftAndOrederUtil.BuildSiftFunc(kvDic)
end

return FairySiftAndOrederUtil
