local AthSortEnum = {}
AthSortEnum.eKindType = {
  GetOrder = 1,
  Quality = 2,
  Attribute = 3,
  SignHero = 4
}
AthSortEnum.KindTypeMaxCount = 4
AthSortEnum.eKindTypeNum = {
  [AthSortEnum.eKindType.GetOrder] = 1,
  [AthSortEnum.eKindType.Quality] = 1,
  [AthSortEnum.eKindType.SignHero] = 1,
  [AthSortEnum.eKindType.Attribute] = #ConfigData.game_config.athSortAttrList
}

local function normalSortFunc(a, b)
  local powerA = a:GetAthFightPower()
  local powerB = b:GetAthFightPower()
  if powerA == powerB then
    return a.id < b.id
  else
    return powerA > powerB
  end
end

local subAttrQualityWeightDic = {}

local function attrSortFunc(a, b)
  if subAttrQualityWeightDic[a.uid] == nil then
    subAttrQualityWeightDic[a.uid] = a:GetAthSubAttrQualityWeight()
  end
  local weightA = subAttrQualityWeightDic[a.uid]
  if subAttrQualityWeightDic[b.uid] == nil then
    subAttrQualityWeightDic[b.uid] = b:GetAthSubAttrQualityWeight()
  end
  local weightB = subAttrQualityWeightDic[b.uid]
  if weightA ~= weightB then
    return weightA > weightB
  end
  return a.id < b.id
end

function AthSortEnum.ResetAthSort(areaId)
  subAttrQualityWeightDic = {}
end

local curKindValue, curReverseOrder, signHeroId

function AthSortEnum.SetAthSortKindParam(kindValue, reverseOrder, heroId)
  curKindValue = kindValue
  curReverseOrder = reverseOrder
  signHeroId = heroId
end

function AthSortEnum.GetSortFunc(kindType, kindValue, isConsumeSort)
  if isConsumeSort then
    return AthSortEnum.eConsumeSortFunc[kindType]
  end
  return AthSortEnum.eSortFunc[kindType]
end

local function qualitySortFunc(a, b)
  local hasBindA = a.bindInfo ~= nil
  local hasBindB = b.bindInfo ~= nil
  if hasBindA ~= hasBindB then
    return hasBindB
  end
  local qualtyA = a:GetAthQuality()
  local qualtyB = b:GetAthQuality()
  if qualtyA ~= qualtyB then
    if curReverseOrder then
      return qualtyA > qualtyB
    end
    return qualtyA < qualtyB
  end
  local suitNumA = a:GetAthDataSuitNum()
  local suitNumB = b:GetAthDataSuitNum()
  if suitNumA ~= suitNumB then
    if curReverseOrder then
      return suitNumA > suitNumB
    end
    return suitNumA < suitNumB
  end
  local suitIdA, cfltIdA = a:GetAthSuit()
  local suitIdB, cfltIdB = b:GetAthSuit()
  if suitIdA ~= suitIdB then
    return suitIdA > suitIdB
  end
  if cfltIdA ~= cfltIdB then
    return cfltIdA < cfltIdB
  end
  local mainAttrIdA = a.athMainAttrCfg.attrtibute_id[1]
  local mainAttrIdB = b.athMainAttrCfg.attrtibute_id[1]
  local mainAtrOrderA = ConfigData.game_config.athAtrSortDic[mainAttrIdA] or math.maxinteger
  local mainAtrOrderB = ConfigData.game_config.athAtrSortDic[mainAttrIdB] or math.maxinteger
  if mainAtrOrderA ~= mainAtrOrderB then
    return mainAtrOrderA < mainAtrOrderB
  end
  if mainAttrIdA ~= mainAttrIdB then
    return mainAttrIdA < mainAttrIdB
  end
  local attrValueA = a.athMainAttrCfg.attrtibute_num[1]
  local attrValueB = b.athMainAttrCfg.attrtibute_num[1]
  if attrValueA ~= attrValueB then
    if curReverseOrder then
      return attrValueA > attrValueB
    end
    return attrValueA < attrValueB
  end
  return attrSortFunc(a, b)
end

AthSortEnum.eSortFunc = {
  [AthSortEnum.eKindType.GetOrder] = function(a, b)
    local hasBindA = a.bindInfo ~= nil
    local hasBindB = b.bindInfo ~= nil
    if hasBindA == hasBindB then
      if a.athTs == b.athTs then
        return normalSortFunc(a, b)
      else
        if curReverseOrder then
          return a.athTs > b.athTs
        end
        return a.athTs < b.athTs
      end
    else
      return hasBindB
    end
  end,
  [AthSortEnum.eKindType.Quality] = qualitySortFunc,
  [AthSortEnum.eKindType.Attribute] = function(a, b)
    local hasBindA = a.bindInfo ~= nil
    local hasBindB = b.bindInfo ~= nil
    if hasBindA ~= hasBindB then
      return hasBindB
    end
    local attrId = ConfigData.game_config.athSortAttrList[curKindValue]
    local mainAttrIdA = a.athMainAttrCfg.attrtibute_id[1]
    local mainAttrIdB = b.athMainAttrCfg.attrtibute_id[1]
    local attrCfgA = ConfigData.attribute[mainAttrIdA]
    local attrCfgB = ConfigData.attribute[mainAttrIdB]
    local hasAttrA = mainAttrIdA == attrId or attrCfgA.merge_attribute == attrId
    local hasAttrB = mainAttrIdB == attrId or attrCfgB.merge_attribute == attrId
    if hasAttrA ~= hasAttrB then
      return hasAttrA
    end
    local isPersentA = attrCfgA.num_type == 2
    local isPersentB = attrCfgB.num_type == 2
    if isPersentA ~= isPersentB then
      return isPersentA
    end
    local attrValueA = a.athMainAttrCfg.attrtibute_num[1]
    local attrValueB = b.athMainAttrCfg.attrtibute_num[1]
    if attrValueA ~= attrValueB then
      if curReverseOrder then
        return attrValueA > attrValueB
      end
      return attrValueA < attrValueB
    end
    return attrSortFunc(a, b)
  end,
  [AthSortEnum.eKindType.SignHero] = function(a, b)
    local isSignHeroA = a:GetAthSignHeroId() == signHeroId and signHeroId ~= 0
    local isSignHeroB = b:GetAthSignHeroId() == signHeroId and signHeroId ~= 0
    if isSignHeroA ~= isSignHeroB then
      return isSignHeroA
    end
    return qualitySortFunc(a, b)
  end
}
AthSortEnum.eConsumeSortFunc = {
  [AthSortEnum.eKindType.GetOrder] = AthSortEnum.eSortFunc[AthSortEnum.eKindType.GetOrder],
  [AthSortEnum.eKindType.Quality] = AthSortEnum.eSortFunc[AthSortEnum.eKindType.Quality]
}
return AthSortEnum
