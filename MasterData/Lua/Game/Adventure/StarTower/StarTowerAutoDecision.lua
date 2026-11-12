local StarTowerAutoDecision = {}
StarTowerAutoDecision.ActionType = {
  None = 0,
  SelectPotential = 1,
  PotentialReroll = 2,
  OpenShop = 3,
  StrengthMachine = 4,
  ShopBuy = 5,
  ShopReroll = 6,
  EventSelect = 7
}
StarTowerAutoDecision.FailReason = {
  None = 0,
  Disabled = 1,
  InvalidParam = 2,
  NoOption = 3,
  NoMatchedTarget = 4,
  TokenNotEnough = 5,
  CoinNotEnough = 6,
  RerollUnavailable = 7
}
StarTowerAutoDecision.PotentialRule = {
  MainChar = 1,
  AssistChar1 = 2,
  AssistChar2 = 3,
  BookLocked = 4,
  PresetNotOwned = 5,
  LevelAdd2 = 6,
  LevelAdd3 = 7,
  RarePotential = 8
}
StarTowerAutoDecision.ShopMode = {BuyFirst = 1, UpgradeFirst = 2}
StarTowerAutoDecision.ShopRule = {
  NeedNote = 1,
  DiscountNote = 2,
  DiscountMainPotential = 3,
  DiscountRandomPotential = 4,
  MainPotentialNoDiscount = 5,
  RandomPotentialNoDiscount = 6
}
StarTowerAutoDecision.EventTendency = {
  Stable = 1,
  Standard = 2,
  Aggressive = 3
}
StarTowerAutoDecision.EventRule = {
  MainPotential = 1,
  AssistPotential = 2,
  RarePotential = 3,
  NormalPotential = 4,
  NeedNote = 5,
  RandomNote = 6,
  Coin = 7
}
StarTowerAutoDecision.OptionTag = {
  Stable = 1,
  Standard = 2,
  Aggressive = 3,
  MainPotential = 4,
  AssistPotential = 5,
  Coin = 6,
  RarePotential = 7,
  NormalPotential = 8,
  RandomPotential = 9,
  RandomNote = 10,
  NeedNote = 11
}
local DEFAULT_DELAY = 2
local DEFAULT_TOKEN_COST = 1
local FALLBACK_SCORE = 1
local PRIORITY_BASE_SCORE = 10000
local PRESET_SCORE = 100000
local TENDENCY_SCORE = 50000
local CORRECT_EVENT_OPTION_SCORE = 1000000

local function _IsTable(value)
  return type(value) == "table"
end

local function _ToNumber(value, nDefault)
  local nValue = tonumber(value)
  if nValue == nil then
    return nDefault or 0
  end
  return nValue
end

local function _IsArrayEmpty(tbList)
  return not _IsTable(tbList) or #tbList <= 0
end

local function _ListContains(tbList, value)
  if not _IsTable(tbList) then
    return false
  end
  for _, v in ipairs(tbList) do
    if v == value then
      return true
    end
  end
  return false
end

local function _BuildSet(tbList, bZeroBasedIndex)
  local mapSet = {}
  if not _IsTable(tbList) then
    return mapSet
  end
  for _, value in ipairs(tbList) do
    mapSet[value] = true
    if bZeroBasedIndex and type(value) == "number" then
      mapSet[value + 1] = true
    end
  end
  return mapSet
end

local function _CopyArray(tbList)
  local tbRet = {}
  if not _IsTable(tbList) then
    return tbRet
  end
  for _, v in ipairs(tbList) do
    table.insert(tbRet, v)
  end
  return tbRet
end

local function _AddReason(mapCandidate, sReason)
  if mapCandidate.tbReasons == nil then
    mapCandidate.tbReasons = {}
  end
  table.insert(mapCandidate.tbReasons, sReason)
end

local function _GetPlan(mapContext)
  if _IsTable(mapContext) and _IsTable(mapContext.mapPlan) then
    return mapContext.mapPlan
  end
  return {}
end

local function _GetTokenCost(mapContext, nActionType)
  if _IsTable(mapContext) and _IsTable(mapContext.mapTokenCostByAction) then
    local nCost = mapContext.mapTokenCostByAction[nActionType]
    if nCost ~= nil then
      return nCost
    end
  end
  if _IsTable(mapContext) and mapContext.nTokenCost ~= nil then
    return _ToNumber(mapContext.nTokenCost, DEFAULT_TOKEN_COST)
  end
  return DEFAULT_TOKEN_COST
end

local function _MakeFail(nFailReason, sReason, tbDebug)
  return {
    bSuccess = false,
    nActionType = StarTowerAutoDecision.ActionType.None,
    nFailReason = nFailReason or StarTowerAutoDecision.FailReason.None,
    sReason = sReason or "",
    tbDebug = tbDebug or {}
  }
end

local function _MakeSuccess(nActionType, mapData)
  mapData = mapData or {}
  mapData.bSuccess = true
  mapData.nActionType = nActionType
  mapData.nFailReason = StarTowerAutoDecision.FailReason.None
  if mapData.nDelay == nil then
    mapData.nDelay = DEFAULT_DELAY
  end
  if mapData.bNeedToken == nil then
    mapData.bNeedToken = false
  end
  return mapData
end

local function _AttachTokenCheck(mapContext, mapDecision)
  if not _IsTable(mapDecision) or not mapDecision.bSuccess then
    return mapDecision
  end
  if mapDecision.bNeedToken ~= true then
    return mapDecision
  end
  local nCost = mapDecision.nTokenCost or _GetTokenCost(mapContext, mapDecision.nActionType)
  mapDecision.nTokenCost = nCost
  if _IsTable(mapContext) and mapContext.nToken ~= nil and nCost > _ToNumber(mapContext.nToken, 0) then
    return _MakeFail(StarTowerAutoDecision.FailReason.TokenNotEnough, "TokenNotEnough", {
      nActionType = mapDecision.nActionType,
      nToken = mapContext.nToken,
      nTokenCost = nCost
    })
  end
  return mapDecision
end

local function _BuildPriorityMap(tbPriority, bMapMode)
  local mapPriority = {}
  if not _IsTable(tbPriority) then
    return mapPriority
  end
  if bMapMode then
    for nRule, nPriority in pairs(tbPriority) do
      if type(nRule) == "number" and type(nPriority) == "number" and 0 < nPriority then
        mapPriority[nRule] = nPriority
      end
    end
    return mapPriority
  end
  for nPriority, nRule in ipairs(tbPriority) do
    if type(nRule) == "number" and 0 < nPriority then
      mapPriority[nRule] = nPriority
    end
  end
  return mapPriority
end

local function _GetPriorityScore(mapPriority, nRule)
  local nPriority = mapPriority[nRule]
  if nPriority == nil or nPriority <= 0 then
    return 0
  end
  return PRIORITY_BASE_SCORE - nPriority
end

local function _RefreshCandidateScore(mapCandidate)
  mapCandidate.nScore = _ToNumber(mapCandidate.nBaseScore, 0) + _ToNumber(mapCandidate.nPriorityScore, 0)
end

local function _AddCandidateBaseScore(mapCandidate, nScore, sReason)
  mapCandidate.nBaseScore = _ToNumber(mapCandidate.nBaseScore, 0) + nScore
  _RefreshCandidateScore(mapCandidate)
  if sReason ~= nil then
    _AddReason(mapCandidate, sReason)
  end
end

local function _AddCandidatePriorityScore(mapCandidate, mapPriority, nRule, sReason)
  local nScore = _GetPriorityScore(mapPriority, nRule)
  if nScore <= 0 then
    return false
  end
  mapCandidate.mapMatchedPriority = mapCandidate.mapMatchedPriority or {}
  mapCandidate.mapMatchedPriority[mapPriority[nRule]] = true
  if nScore > _ToNumber(mapCandidate.nPriorityScore, 0) then
    mapCandidate.nPriorityScore = nScore
    _RefreshCandidateScore(mapCandidate)
  end
  _AddReason(mapCandidate, sReason)
  return true
end

local function _GetPotentialCfg(nPotentialId)
  if ConfigTable == nil then
    return nil
  end
  return ConfigTable.GetData("Potential", nPotentialId)
end

local function _GetItemCfg(nItemId)
  if ConfigTable == nil then
    return nil
  end
  if ConfigTable.GetData_Item ~= nil then
    local mapItem = ConfigTable.GetData_Item(nItemId)
    if mapItem ~= nil then
      return mapItem
    end
  end
  return ConfigTable.GetData("Item", nItemId)
end

local function _GetEventOptionCfg(nOptionId)
  if ConfigTable == nil then
    return nil
  end
  return ConfigTable.GetData("EventOptions", nOptionId)
end

local function _GetPotentialCurLevel(mapContext, nPotentialId, nCharId, mapPotential)
  if _IsTable(mapPotential) and mapPotential[nPotentialId] ~= nil then
    return _ToNumber(mapPotential[nPotentialId], 0)
  end
  if _IsTable(mapContext) and _IsTable(mapContext.mapPotential) then
    if nCharId ~= nil and _IsTable(mapContext.mapPotential[nCharId]) and mapContext.mapPotential[nCharId][nPotentialId] ~= nil then
      return _ToNumber(mapContext.mapPotential[nCharId][nPotentialId], 0)
    end
    if mapContext.mapPotential[nPotentialId] ~= nil then
      return _ToNumber(mapContext.mapPotential[nPotentialId], 0)
    end
  end
  return 0
end

local function _GetMainCharId(mapContext)
  if not _IsTable(mapContext) then
    return 0
  end
  if mapContext.nMainCharId ~= nil then
    return mapContext.nMainCharId
  end
  if _IsTable(mapContext.tbTeam) then
    return mapContext.tbTeam[1] or 0
  end
  return 0
end

local function _GetAssistCharId(mapContext, nIndex)
  if not _IsTable(mapContext) then
    return 0
  end
  if _IsTable(mapContext.tbAssistCharIds) then
    return mapContext.tbAssistCharIds[nIndex] or 0
  end
  if _IsTable(mapContext.tbTeam) then
    return mapContext.tbTeam[nIndex + 1] or 0
  end
  return 0
end

local function _IsRarePotential(mapContext, nPotentialId, mapItemCfg, bSpecial)
  if bSpecial == true then
    return true
  end
  if _IsTable(mapContext) and _IsTable(mapContext.mapRarePotentialIds) and mapContext.mapRarePotentialIds[nPotentialId] == true then
    return true
  end
  if mapItemCfg == nil then
    mapItemCfg = _GetItemCfg(nPotentialId)
  end
  if mapItemCfg == nil then
    return false
  end
  if GameEnum ~= nil and GameEnum.itemStype ~= nil and mapItemCfg.Stype == GameEnum.itemStype.SpecificPotential then
    return true
  end
  local nRareRarity = GameEnum ~= nil and GameEnum.itemRarity ~= nil and GameEnum.itemRarity.SSR or 1
  if _IsTable(mapContext) and _GetPlan(mapContext).nRarePotentialRarity ~= nil then
    nRareRarity = _GetPlan(mapContext).nRarePotentialRarity
  end
  return mapItemCfg.Rarity ~= nil and mapItemCfg.Rarity > 0 and nRareRarity >= mapItemCfg.Rarity
end

local function _NormalizeRecommend(tbRecommend)
  local mapRecommend = {}
  if not _IsTable(tbRecommend) then
    return mapRecommend
  end
  for _, mapData in ipairs(tbRecommend) do
    local nId = mapData.nId or mapData.Id
    if nId ~= nil then
      mapRecommend[nId] = mapData
    end
  end
  return mapRecommend
end

local function _NormalizePotentialOptions(tbPotential)
  local tbCandidates = {}
  if not _IsTable(tbPotential) then
    return tbCandidates
  end
  for nIndex, mapData in ipairs(tbPotential) do
    local nPotentialId = mapData.Id or mapData.nId or mapData.Tid
    if nPotentialId ~= nil then
      table.insert(tbCandidates, {
        nIndex = nIndex,
        nTargetId = nPotentialId,
        nOptionLevel = _ToNumber(mapData.Count or mapData.Level or mapData.nLevel, 0),
        mapRawData = mapData,
        nBaseScore = 0,
        nPriorityScore = 0,
        nScore = 0,
        tbReasons = {}
      })
    end
  end
  return tbCandidates
end

local function _CompareCandidatePriority(mapCandidateA, mapCandidateB)
  if mapCandidateA.nScore ~= mapCandidateB.nScore then
    return mapCandidateA.nScore > mapCandidateB.nScore
  end
  local mapPriorityA = mapCandidateA.mapMatchedPriority or {}
  local mapPriorityB = mapCandidateB.mapMatchedPriority or {}
  local nFirstDifferentPriority = math.huge
  for nPriority in pairs(mapPriorityA) do
    if not mapPriorityB[nPriority] and nPriority < nFirstDifferentPriority then
      nFirstDifferentPriority = nPriority
    end
  end
  for nPriority in pairs(mapPriorityB) do
    if not mapPriorityA[nPriority] and nPriority < nFirstDifferentPriority then
      nFirstDifferentPriority = nPriority
    end
  end
  if nFirstDifferentPriority < math.huge then
    return mapPriorityA[nFirstDifferentPriority] == true
  end
  return nil
end

local function _SortCandidates(tbCandidates)
  table.sort(tbCandidates, function(mapCandidateA, mapCandidateB)
    local bHigherPriority = _CompareCandidatePriority(mapCandidateA, mapCandidateB)
    if bHigherPriority ~= nil then
      return bHigherPriority
    end
    return mapCandidateA.nIndex < mapCandidateB.nIndex
  end)
end

local function _SortShopCandidates(tbCandidates)
  local mapFirstIndexByGroup = {}
  for _, mapCandidate in ipairs(tbCandidates) do
    local sGroup = mapCandidate.sDiscountGroup
    local nFirstIndex = mapFirstIndexByGroup[sGroup]
    if nFirstIndex == nil or nFirstIndex > mapCandidate.nIndex then
      mapFirstIndexByGroup[sGroup] = mapCandidate.nIndex
    end
  end
  table.sort(tbCandidates, function(mapCandidateA, mapCandidateB)
    local bHigherPriority = _CompareCandidatePriority(mapCandidateA, mapCandidateB)
    if bHigherPriority ~= nil then
      return bHigherPriority
    end
    local nGroupIndexA = mapFirstIndexByGroup[mapCandidateA.sDiscountGroup]
    local nGroupIndexB = mapFirstIndexByGroup[mapCandidateB.sDiscountGroup]
    if nGroupIndexA ~= nGroupIndexB then
      return nGroupIndexA < nGroupIndexB
    end
    if mapCandidateA.nDiscountRate ~= mapCandidateB.nDiscountRate then
      return mapCandidateA.nDiscountRate < mapCandidateB.nDiscountRate
    end
    return mapCandidateA.nIndex < mapCandidateB.nIndex
  end)
end

function StarTowerAutoDecision:IsEnabled(mapContext)
  if not _IsTable(mapContext) then
    return false
  end
  if mapContext.bAutoEnabled == false then
    return false
  end
  local mapPlan = _GetPlan(mapContext)
  if mapPlan.bEnabled == false then
    return false
  end
  return true
end

function StarTowerAutoDecision:BuildContext(objLevelData, mapPlan, mapExtra)
  local mapContext = mapExtra or {}
  mapContext.mapPlan = mapPlan or mapContext.mapPlan or {}
  if objLevelData == nil then
    return mapContext
  end
  mapContext.nTowerId = mapContext.nTowerId or objLevelData.nTowerId
  mapContext.nCurFloor = mapContext.nCurFloor or objLevelData.nCurLevel
  mapContext.tbTeam = mapContext.tbTeam or _CopyArray(objLevelData.tbTeam)
  mapContext.mapNote = mapContext.mapNote or objLevelData._mapNote
  mapContext.mapPotential = mapContext.mapPotential or objLevelData._mapPotential
  mapContext.mapItem = mapContext.mapItem or objLevelData._mapItem
  mapContext.mapFateCard = mapContext.mapFateCard or objLevelData._mapFateCard
  mapContext.mapPreselectionData = mapContext.mapPreselectionData or objLevelData.mapPreselectionData
  if mapContext.nCoin == nil and _IsTable(objLevelData._mapItem) and AllEnum ~= nil and AllEnum.CoinItemId ~= nil then
    mapContext.nCoin = objLevelData._mapItem[AllEnum.CoinItemId.FixedRogCurrency] or 0
  end
  if mapContext.bFinalFloor == nil and _IsTable(objLevelData.tbStarTowerAllLevel) and objLevelData.nCurLevel ~= nil then
    mapContext.bFinalFloor = objLevelData.nCurLevel == #objLevelData.tbStarTowerAllLevel
  end
  return mapContext
end

function StarTowerAutoDecision:DecidePotential(mapContext, tbPotential, mapPotential, mapRoll, tbNewIds, tbLuckyIds, tbRecommend)
  if not self:IsEnabled(mapContext) then
    return _MakeFail(StarTowerAutoDecision.FailReason.Disabled, "AutoDisabled")
  end
  local tbCandidates = _NormalizePotentialOptions(tbPotential)
  if _IsArrayEmpty(tbCandidates) then
    return _MakeFail(StarTowerAutoDecision.FailReason.NoOption, "NoPotentialOption")
  end
  local mapPlan = _GetPlan(mapContext)
  local mapPriority = _BuildPriorityMap(mapPlan.tbPotentialRulePriority, false)
  if next(mapPriority) == nil then
    mapPriority = _BuildPriorityMap(mapPlan.mapPotentialRulePriority, true)
  end
  local bHasPreset = _IsTable(mapContext.mapPreselectionData)
  local mapRecommend = bHasPreset and _NormalizeRecommend(tbRecommend) or {}
  local mapNewIds = _BuildSet(tbNewIds)
  local mapLuckyIds = _BuildSet(tbLuckyIds)
  local nMainCharId = _GetMainCharId(mapContext)
  local nAssistCharId1 = _GetAssistCharId(mapContext, 1)
  local nAssistCharId2 = _GetAssistCharId(mapContext, 2)
  local bPreferPreset = bHasPreset and mapPlan.bPreferPresetPotential ~= false
  local bPresetOnly = bPreferPreset and mapPlan.bPresetOnly == true
  local bHasSpecialPotential = false
  for _, mapCandidate in ipairs(tbCandidates) do
    local nPotentialId = mapCandidate.nTargetId
    local mapPotentialCfg = _GetPotentialCfg(nPotentialId)
    local mapItemCfg = _GetItemCfg(nPotentialId)
    local nCharId = mapPotentialCfg and mapPotentialCfg.CharId or 0
    local nCurLevel = _GetPotentialCurLevel(mapContext, nPotentialId, nCharId, mapPotential)
    local mapRecommendData = mapRecommend[nPotentialId]
    local nRecommendLevel = mapRecommendData and _ToNumber(mapRecommendData.nLevel or mapRecommendData.Level, 0) or 0
    local bSpecial = mapCandidate.mapRawData.bSpecial == true or mapItemCfg ~= nil and GameEnum ~= nil and GameEnum.itemStype ~= nil and mapItemCfg.Stype == GameEnum.itemStype.SpecificPotential
    bHasSpecialPotential = bHasSpecialPotential or bSpecial
    mapCandidate.bPresetEligible = mapRecommendData ~= nil and nCurLevel < nRecommendLevel
    mapCandidate.bPresetSpecial = bSpecial and mapCandidate.bPresetEligible
    if mapCandidate.bPresetSpecial then
      _AddCandidateBaseScore(mapCandidate, PRESET_SCORE, "PresetSpecialPotential")
    elseif bPreferPreset and mapCandidate.bPresetEligible then
      _AddCandidateBaseScore(mapCandidate, PRESET_SCORE, "PreferPresetPotential")
    end
    if nCharId == nMainCharId then
      _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.PotentialRule.MainChar, "MainChar")
    end
    if nCharId == nAssistCharId1 then
      _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.PotentialRule.AssistChar1, "AssistChar1")
    end
    if nCharId == nAssistCharId2 then
      _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.PotentialRule.AssistChar2, "AssistChar2")
    end
    if mapNewIds[nPotentialId] then
      _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.PotentialRule.BookLocked, "BookLocked")
    end
    if mapRecommendData ~= nil and nCurLevel <= 0 then
      _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.PotentialRule.PresetNotOwned, "PresetNotOwned")
    end
    if mapCandidate.nOptionLevel == 2 then
      _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.PotentialRule.LevelAdd2, "LevelAdd2")
    end
    if mapCandidate.nOptionLevel == 3 then
      _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.PotentialRule.LevelAdd3, "LevelAdd3")
    end
    if _IsRarePotential(mapContext, nPotentialId, mapItemCfg, mapCandidate.mapRawData.bSpecial) then
      _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.PotentialRule.RarePotential, "RarePotential")
    end
    if mapNewIds[nPotentialId] then
      _AddReason(mapCandidate, "NewId")
    end
    if mapLuckyIds[nPotentialId] then
      _AddReason(mapCandidate, "LuckyId")
    end
  end
  _SortCandidates(tbCandidates)
  local mapBest = tbCandidates[1]
  local mapPresetSpecial
  for _, mapCandidate in ipairs(tbCandidates) do
    if mapCandidate.bPresetSpecial then
      mapPresetSpecial = mapCandidate
      break
    end
  end
  if mapPresetSpecial ~= nil then
    mapBest = mapPresetSpecial
  elseif bPresetOnly then
    mapBest = nil
    for _, mapCandidate in ipairs(tbCandidates) do
      if mapCandidate.bPresetEligible then
        mapBest = mapCandidate
        break
      end
    end
  end
  if mapBest == nil or 0 >= mapBest.nScore then
    local nCoin = _ToNumber(mapContext.nCoin, 0)
    local bCanReroll = not bHasSpecialPotential and _IsTable(mapRoll) and mapRoll.CanReRoll == true
    local nRerollPrice = _ToNumber(_IsTable(mapRoll) and mapRoll.ReRollPrice or 0, 0)
    local nRerollCoinMin = _ToNumber(mapPlan.nPotentialRerollCoinMin, 0)
    if mapPlan.bPotentialReroll == true and bCanReroll and nCoin >= nRerollPrice and nCoin > nRerollCoinMin then
      return _AttachTokenCheck(mapContext, _MakeSuccess(StarTowerAutoDecision.ActionType.PotentialReroll, {
        bReRoll = true,
        bNeedToken = false,
        nTargetIndex = 0,
        nTargetId = 0,
        sReason = "PotentialReroll",
        tbDebug = {nCoin = nCoin, nRerollPrice = nRerollPrice}
      }))
    end
    mapBest = tbCandidates[1]
    if 0 >= mapBest.nScore then
      mapBest.nScore = FALLBACK_SCORE
      _AddReason(mapBest, "FallbackFirst")
    end
  end
  return _AttachTokenCheck(mapContext, _MakeSuccess(StarTowerAutoDecision.ActionType.SelectPotential, {
    nTargetIndex = mapBest.nIndex,
    nTargetId = mapBest.nTargetId,
    bNeedToken = true,
    sReason = mapBest.tbReasons[1] or "SelectPotential",
    tbDebug = {
      nScore = mapBest.nScore,
      tbReasons = mapBest.tbReasons,
      mapRawData = mapBest.mapRawData
    }
  }))
end

local function _DecideUpgradeBeforeShopSpendAll(mapContext, mapShopOption, nCoin)
  local mapPlan = _GetPlan(mapContext)
  if mapContext.bFinalFloor ~= true or mapPlan.bShopSpendAllWhenFinalNoTarget ~= true or (mapPlan.nShopMode or StarTowerAutoDecision.ShopMode.BuyFirst) ~= StarTowerAutoDecision.ShopMode.BuyFirst or mapShopOption.bMachine ~= true then
    return nil
  end
  local nMachineCost = _ToNumber(mapShopOption.nMachineCost, 0)
  local nMaxUpgradePrice = _ToNumber(mapPlan.nShopUpgradeMaxPrice, 180)
  if nMachineCost > nMaxUpgradePrice or nCoin < nMachineCost then
    return nil
  end
  return _AttachTokenCheck(mapContext, _MakeSuccess(StarTowerAutoDecision.ActionType.StrengthMachine, {
    bNeedToken = true,
    sReason = "UpgradeBeforeShopSpendAll",
    tbDebug = {nMachineCost = nMachineCost, nCoin = nCoin}
  }))
end

function StarTowerAutoDecision:DecideShopEntry(mapContext, mapShopOption)
  if not self:IsEnabled(mapContext) then
    return _MakeFail(StarTowerAutoDecision.FailReason.Disabled, "AutoDisabled")
  end
  if not _IsTable(mapShopOption) then
    return _MakeFail(StarTowerAutoDecision.FailReason.InvalidParam, "InvalidShopOption")
  end
  local mapPlan = _GetPlan(mapContext)
  local nMode = mapPlan.nShopMode or StarTowerAutoDecision.ShopMode.BuyFirst
  local nCoin = _ToNumber(mapShopOption.nCoin or mapContext.nCoin, 0)
  local bShop = mapShopOption.bShop == true
  local bMachine = mapShopOption.bMachine == true
  local nMachineCost = _ToNumber(mapShopOption.nMachineCost, 0)
  local nMaxUpgradePrice = _ToNumber(mapPlan.nShopUpgradeMaxPrice, 180)
  if bShop and mapShopOption.bUpgradeBeforeSpendAll == true then
    local mapDecision = _DecideUpgradeBeforeShopSpendAll(mapContext, mapShopOption, nCoin)
    if mapDecision ~= nil then
      return mapDecision
    end
  end
  local bSpendAllOnUpgrade = mapContext.bFinalFloor == true and mapPlan.bShopSpendAllWhenFinalNoTarget == true and mapShopOption.bShopExhausted == true and not bShop
  local bMachineAvailable = bMachine and nCoin >= nMachineCost and (bSpendAllOnUpgrade or nMachineCost <= nMaxUpgradePrice)
  if nMode == StarTowerAutoDecision.ShopMode.UpgradeFirst and bMachineAvailable then
    return _AttachTokenCheck(mapContext, _MakeSuccess(StarTowerAutoDecision.ActionType.StrengthMachine, {
      bNeedToken = true,
      sReason = "UpgradeFirst",
      tbDebug = {nMachineCost = nMachineCost, nCoin = nCoin}
    }))
  end
  if bShop then
    return _MakeSuccess(StarTowerAutoDecision.ActionType.OpenShop, {bNeedToken = false, sReason = "OpenShop"})
  end
  if bMachineAvailable then
    return _AttachTokenCheck(mapContext, _MakeSuccess(StarTowerAutoDecision.ActionType.StrengthMachine, {
      bNeedToken = true,
      sReason = "StrengthMachine",
      tbDebug = {nMachineCost = nMachineCost, nCoin = nCoin}
    }))
  end
  return _MakeFail(StarTowerAutoDecision.FailReason.NoMatchedTarget, "NoShopEntryTarget", {
    bShop = bShop,
    bMachine = bMachine,
    nMachineCost = nMachineCost,
    nCoin = nCoin
  })
end

local function _IsDiscountGood(mapGood)
  return 0 < _ToNumber(mapGood.nDiscount, 0)
end

local function _GetGoodPrice(mapGood)
  if 0 < _ToNumber(mapGood.nDiscount, 0) then
    return _ToNumber(mapGood.nDiscount, 0)
  end
  return _ToNumber(mapGood.Price, 0)
end

local function _GetGoodDiscountRate(mapGood)
  local nOriginalPrice = _ToNumber(mapGood.Price, 0)
  local nDiscountPrice = _ToNumber(mapGood.nDiscount, 0)
  if nOriginalPrice <= 0 or nDiscountPrice <= 0 then
    return 1
  end
  return nDiscountPrice / nOriginalPrice
end

local function _GetShopGoodDiscountGroup(mapGood, bDiscount, bMainPotential, bRandomPotential)
  local nType = _ToNumber(mapGood.nType, 0)
  local sSubType = "Other"
  if nType == 1 then
    if bMainPotential then
      sSubType = "MainPotential"
    elseif bRandomPotential then
      sSubType = "RandomPotential"
    else
      sSubType = "Potential"
    end
  elseif nType == 2 then
    sSubType = "Note"
  end
  return tostring(nType) .. ":" .. sSubType .. ":" .. (bDiscount and "Discount" or "Regular")
end

local function _IsNoteGood(mapGood, mapItemCfg)
  if _ToNumber(mapGood.nType, 0) ~= 2 then
    return false
  end
  if mapItemCfg == nil then
    mapItemCfg = _GetItemCfg(mapGood.nGoodsId)
  end
  return mapItemCfg ~= nil and GameEnum ~= nil and GameEnum.itemStype ~= nil and mapItemCfg.Stype == GameEnum.itemStype.SubNoteSkill
end

local function _IsPotentialGood(mapGood)
  return _ToNumber(mapGood.nType, 0) == 1
end

local function _GetPotentialGoodCharId(mapGood)
  return _ToNumber(mapGood.nCharId, 0)
end

local function _IsMainPotentialGood(mapContext, mapGood)
  if not _IsPotentialGood(mapGood) then
    return false
  end
  local nMainCharId = _GetMainCharId(mapContext)
  local nGoodCharId = _GetPotentialGoodCharId(mapGood)
  return 0 < nMainCharId and 0 < nGoodCharId and nGoodCharId == nMainCharId
end

local function _IsRandomPotentialGood(mapGood)
  if not _IsPotentialGood(mapGood) then
    return false
  end
  return _GetPotentialGoodCharId(mapGood) <= 0
end

local function _HasShopReroll(mapRoll)
  return _IsTable(mapRoll) and mapRoll.CanReRoll == true and 0 < _ToNumber(mapRoll.ReRollTimes, 0)
end

local function _CanShopReroll(mapPlan, mapContext, mapRoll, nCoin)
  local bFinalFloor = mapContext.bFinalFloor == true
  local bAllowReroll = bFinalFloor and mapPlan.bShopRerollWhenFinalNoTarget == true or not bFinalFloor and mapPlan.bShopRerollWhenNoTarget == true
  local bCanReroll = _HasShopReroll(mapRoll)
  local nRerollPrice = _ToNumber(_IsTable(mapRoll) and mapRoll.ReRollPrice or 0, 0)
  local nRerollCoinMin = _ToNumber(mapPlan.nShopRerollCoinMin, 500)
  return bAllowReroll and bCanReroll and nCoin >= nRerollPrice and (bFinalFloor or nCoin > nRerollCoinMin), nRerollPrice
end

function StarTowerAutoDecision:DecideShop(mapContext, tbShopData, mapRoll, nCoin)
  if not self:IsEnabled(mapContext) then
    return _MakeFail(StarTowerAutoDecision.FailReason.Disabled, "AutoDisabled")
  end
  if _IsArrayEmpty(tbShopData) then
    local mapDecision = _MakeFail(StarTowerAutoDecision.FailReason.NoOption, "NoShopGoods")
    mapDecision.bShopExhausted = not _HasShopReroll(mapRoll)
    return mapDecision
  end
  local mapPlan = _GetPlan(mapContext)
  local mapPriority = _BuildPriorityMap(mapPlan.tbShopRulePriority, false)
  if next(mapPriority) == nil then
    mapPriority = _BuildPriorityMap(mapPlan.mapShopRulePriority, true)
  end
  local nCurCoin = _ToNumber(nCoin or mapContext.nCoin, 0)
  local tbCandidates = {}
  for nIndex, mapGood in ipairs(tbShopData) do
    local nPrice = _GetGoodPrice(mapGood)
    if mapGood.bSoldOut ~= true and nCurCoin >= nPrice then
      local mapItemCfg = _ToNumber(mapGood.nType, 0) == 2 and _GetItemCfg(mapGood.nGoodsId) or nil
      local bDiscount = _IsDiscountGood(mapGood)
      local bNote = _IsNoteGood(mapGood, mapItemCfg)
      local bNeedNote = bNote
      if _IsTable(mapContext.mapNeedNote) then
        bNeedNote = bNote and mapContext.mapNeedNote[mapGood.nGoodsId] == true
      end
      local bMainPotential = _IsMainPotentialGood(mapContext, mapGood)
      local bRandomPotential = _IsRandomPotentialGood(mapGood)
      local mapCandidate = {
        nIndex = nIndex,
        nTargetIndex = mapGood.Idx or nIndex,
        nTargetId = mapGood.nSid,
        nGoodsId = mapGood.nGoodsId,
        nPrice = nPrice,
        nDiscountRate = _GetGoodDiscountRate(mapGood),
        sDiscountGroup = _GetShopGoodDiscountGroup(mapGood, bDiscount, bMainPotential, bRandomPotential),
        nBaseScore = 0,
        nPriorityScore = 0,
        nScore = 0,
        tbReasons = {},
        mapRawData = mapGood
      }
      if bNeedNote then
        _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.ShopRule.NeedNote, "NeedNote")
      end
      if bMainPotential and not bDiscount then
        _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.ShopRule.MainPotentialNoDiscount, "MainPotentialNoDiscount")
      end
      if bRandomPotential and not bDiscount then
        _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.ShopRule.RandomPotentialNoDiscount, "RandomPotentialNoDiscount")
      end
      if bNote and bDiscount then
        _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.ShopRule.DiscountNote, "DiscountNote")
      end
      if bMainPotential and bDiscount then
        _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.ShopRule.DiscountMainPotential, "DiscountMainPotential")
      end
      if bRandomPotential and bDiscount then
        _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.ShopRule.DiscountRandomPotential, "DiscountRandomPotential")
      end
      table.insert(tbCandidates, mapCandidate)
    end
  end
  if _IsArrayEmpty(tbCandidates) then
    local bCanReroll, nRerollPrice = _CanShopReroll(mapPlan, mapContext, mapRoll, nCurCoin)
    if bCanReroll then
      return _MakeSuccess(StarTowerAutoDecision.ActionType.ShopReroll, {
        bReRoll = true,
        bNeedToken = false,
        sReason = "ShopRerollNoAffordableGoods",
        tbDebug = {nCoin = nCurCoin, nRerollPrice = nRerollPrice}
      })
    end
    local mapDecision = _MakeFail(StarTowerAutoDecision.FailReason.CoinNotEnough, "NoAffordableGoods", {nCoin = nCurCoin})
    mapDecision.bShopExhausted = not _HasShopReroll(mapRoll)
    return mapDecision
  end
  _SortShopCandidates(tbCandidates)
  local mapBest = tbCandidates[1]
  if 0 >= mapBest.nScore then
    local bFinalFloor = mapContext.bFinalFloor == true
    local bCanReroll, nRerollPrice = _CanShopReroll(mapPlan, mapContext, mapRoll, nCurCoin)
    if bCanReroll then
      return _MakeSuccess(StarTowerAutoDecision.ActionType.ShopReroll, {
        bReRoll = true,
        bNeedToken = false,
        sReason = "ShopReroll",
        tbDebug = {nCoin = nCurCoin, nRerollPrice = nRerollPrice}
      })
    end
    if bFinalFloor and mapPlan.bShopSpendAllWhenFinalNoTarget == true then
      local mapDecision = _DecideUpgradeBeforeShopSpendAll(mapContext, mapContext, nCurCoin)
      if mapDecision ~= nil then
        return mapDecision
      end
      mapBest.nScore = FALLBACK_SCORE
      _AddReason(mapBest, "FinalFloorSpendAll")
    else
      return _MakeFail(StarTowerAutoDecision.FailReason.NoOption, "NoMatchedShopGoods", {bFinalFloor = bFinalFloor, nCoin = nCurCoin})
    end
  end
  return _AttachTokenCheck(mapContext, _MakeSuccess(StarTowerAutoDecision.ActionType.ShopBuy, {
    nTargetIndex = mapBest.nTargetIndex,
    nTargetId = mapBest.nTargetId,
    nGoodsId = mapBest.nGoodsId,
    bNeedToken = true,
    sReason = mapBest.tbReasons[1] or "ShopBuy",
    tbDebug = {
      nScore = mapBest.nScore,
      nPrice = mapBest.nPrice,
      tbReasons = mapBest.tbReasons,
      mapRawData = mapBest.mapRawData
    }
  }))
end

local function _BuildOptionTags(mapContext, nOptionId, mapOptionCfg)
  local mapTags = {}
  if _IsTable(mapContext.mapEventOptionTags) and _IsTable(mapContext.mapEventOptionTags[nOptionId]) then
    for key, value in pairs(mapContext.mapEventOptionTags[nOptionId]) do
      if value == true then
        mapTags[key] = true
      else
        mapTags[value] = true
      end
    end
    return mapTags
  end
  if mapOptionCfg == nil then
    mapOptionCfg = _GetEventOptionCfg(nOptionId)
  end
  if mapOptionCfg == nil then
    return mapTags
  end
  local tbTags = mapOptionCfg.OptionTag or mapOptionCfg.OptionTags or mapOptionCfg.EventOptionTag
  if type(tbTags) == "string" then
    local tbJsonTags = decodeJson(tbTags)
    if tbJsonTags ~= nil then
      tbTags = tbJsonTags
    end
  end
  if type(tbTags) == "number" or type(tbTags) == "string" then
    mapTags[tbTags] = true
  elseif _IsTable(tbTags) then
    for _, tag in ipairs(tbTags) do
      mapTags[tag] = true
    end
  end
  return mapTags
end

local function _HasTag(mapTags, tag)
  return _IsTable(mapTags) and mapTags[tag] == true
end

local function _GetEventOptionTag(sTagName)
  if GameEnum == nil or GameEnum.EventOptionTag == nil then
    return nil
  end
  return GameEnum.EventOptionTag[sTagName]
end

local function _HasEventOptionTag(mapTags, sTagName)
  local nTag = _GetEventOptionTag(sTagName)
  return nTag ~= nil and _HasTag(mapTags, nTag)
end

local function _HasNeededNoteTag(mapContext, mapTags)
  if not _IsTable(mapContext.mapNeedNote) then
    return false
  end
  for nNoteId, bNeed in pairs(mapContext.mapNeedNote) do
    if bNeed == true and _HasEventOptionTag(mapTags, "Note" .. tostring(nNoteId)) then
      return true
    end
  end
  return false
end

function StarTowerAutoDecision:DecideEvent(mapContext, tbOption, tbUnabledOption, nEventId)
  if not self:IsEnabled(mapContext) then
    return _MakeFail(StarTowerAutoDecision.FailReason.Disabled, "AutoDisabled")
  end
  if _IsArrayEmpty(tbOption) then
    return _MakeFail(StarTowerAutoDecision.FailReason.NoOption, "NoEventOption")
  end
  local mapPlan = _GetPlan(mapContext)
  local mapPriority = _BuildPriorityMap(mapPlan.tbEventRulePriority, false)
  if next(mapPriority) == nil then
    mapPriority = _BuildPriorityMap(mapPlan.mapEventRulePriority, true)
  end
  local mapDisabled = _BuildSet(tbUnabledOption, false)
  local nTendency = mapPlan.nEventTendency or StarTowerAutoDecision.EventTendency.Standard
  local mapTendencyTagName = {
    [StarTowerAutoDecision.EventTendency.Stable] = "Preservative",
    [StarTowerAutoDecision.EventTendency.Standard] = "Standard",
    [StarTowerAutoDecision.EventTendency.Aggressive] = "Aggresive"
  }
  local tbCandidates = {}
  for nIndex, nOptionId in ipairs(tbOption) do
    if mapDisabled[nIndex - 1] ~= true then
      local mapOptionCfg = _GetEventOptionCfg(nOptionId)
      local mapTags = _BuildOptionTags(mapContext, nOptionId, mapOptionCfg)
      local mapCandidate = {
        nIndex = nIndex,
        nTargetIndex = nIndex,
        nTargetId = nOptionId,
        nBaseScore = 0,
        nPriorityScore = 0,
        nScore = 0,
        tbReasons = {},
        mapTags = mapTags,
        bNeedToken = true
      }
      if _HasEventOptionTag(mapTags, "Correct") then
        _AddCandidateBaseScore(mapCandidate, CORRECT_EVENT_OPTION_SCORE, "CorrectAnswer")
      end
      local sTendencyTagName = mapTendencyTagName[nTendency]
      if sTendencyTagName ~= nil and _HasEventOptionTag(mapTags, sTendencyTagName) then
        _AddCandidateBaseScore(mapCandidate, TENDENCY_SCORE, "EventTendency")
      end
      local tbRuleToTagName = {
        [StarTowerAutoDecision.EventRule.MainPotential] = "PotentialMain",
        [StarTowerAutoDecision.EventRule.AssistPotential] = "PotentialAssist",
        [StarTowerAutoDecision.EventRule.Coin] = "Coin",
        [StarTowerAutoDecision.EventRule.RarePotential] = "PotentialRare",
        [StarTowerAutoDecision.EventRule.NormalPotential] = "PotentialCommon",
        [StarTowerAutoDecision.EventRule.RandomNote] = "NoteRandom"
      }
      if _HasNeededNoteTag(mapContext, mapTags) then
        _AddCandidatePriorityScore(mapCandidate, mapPriority, StarTowerAutoDecision.EventRule.NeedNote, "NeedNote")
      end
      for nRule, sTagName in pairs(tbRuleToTagName) do
        if _HasEventOptionTag(mapTags, sTagName) then
          _AddCandidatePriorityScore(mapCandidate, mapPriority, nRule, "EventRule" .. tostring(nRule))
        end
      end
      table.insert(tbCandidates, mapCandidate)
    end
  end
  if _IsArrayEmpty(tbCandidates) then
    return _MakeFail(StarTowerAutoDecision.FailReason.NoMatchedTarget, "NoEnabledEventOption", {nEventId = nEventId})
  end
  _SortCandidates(tbCandidates)
  local mapBest = tbCandidates[1]
  if 0 >= mapBest.nScore then
    mapBest.nScore = FALLBACK_SCORE
    _AddReason(mapBest, "FallbackFirst")
  end
  return _AttachTokenCheck(mapContext, _MakeSuccess(StarTowerAutoDecision.ActionType.EventSelect, {
    nTargetIndex = mapBest.nTargetIndex,
    nTargetId = mapBest.nTargetId,
    bNeedToken = mapBest.bNeedToken,
    sReason = mapBest.tbReasons[1] or "EventSelect",
    tbDebug = {
      nEventId = nEventId,
      nScore = mapBest.nScore,
      tbReasons = mapBest.tbReasons,
      mapTags = mapBest.mapTags
    }
  }))
end

function StarTowerAutoDecision:CanConsumeToken(mapContext, nActionType)
  local nCost = _GetTokenCost(mapContext, nActionType)
  if not _IsTable(mapContext) or mapContext.nToken == nil then
    return true, nCost
  end
  return nCost <= _ToNumber(mapContext.nToken, 0), nCost
end

return StarTowerAutoDecision
