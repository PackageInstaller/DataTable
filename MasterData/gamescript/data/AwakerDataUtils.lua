local SortOrder = CommonDefine.SortOrder
local string = _ENV.string
local table = _ENV.table
local tableInsert = table.insert
local tableSort = table.sort
local AwakerDataUtils = {}
local baseSkillSlot = DT.GetConstant("AwakerSkillListNum")
local AwakerPotencyEffectType = CommonDefine.AwakerPotencyEffectType
local QualitySortValueTable = CommonDefine.QualitySortValueTable
local AwakerSkillType = CommonDefine.AwakerSkillType
local PotencyType = CommonDefine.AwakerPotencyType
local GOLD_TID = DT.GetConstant("GoldItemTid")
local AUTO_SELECT_FORBID_TRINKET_LEVEL = 12
local boundTrinketIndex, boundTrinketIndexSource
AwakerDataUtils.PotencyEffectType = System.NewEnum({
  Skill = 1,
  Card = 2,
  Attr = 3
})
AwakerDataUtils.SuitCompSource = System.NewEnum({AwakerDetail = 1, EquipPutOn = 2})
AwakerDataUtils.SpecialPotencyLvs = {
  15,
  20,
  25
}
AwakerDataUtils.AwakerSkillMap = {}
AwakerDataUtils.specialSkillTypeMap = {}
AwakerDataUtils.awakerToSpecialSkillMap = {}
AwakerDataUtils.specialSkillTypeMap = {}
AwakerDataUtils.awakerToSpecialSkillMap = {}
AwakerDataUtils.AllSuit = 0
AwakerDataUtils.TrinketMainAttrValueCfgMap = nil
AwakerDataUtils.isPreviewingAwakersData = false
AwakerDataUtils.talentTable = nil
local nonLimitedAwakerMap

function AwakerDataUtils.InitConfig()
  AwakerDataUtils.awakerSortFuncMap = {
    [CommonDefine.AwakerSortType.Level] = AwakerDataUtils.SortByLevel,
    [CommonDefine.AwakerSortType.Quality] = AwakerDataUtils.SortByQuality,
    [CommonDefine.AwakerSortType.Potency] = AwakerDataUtils.SortByPotency,
    [CommonDefine.AwakerSortType.Hp] = AwakerDataUtils.SortByHp,
    [CommonDefine.AwakerSortType.Atk] = AwakerDataUtils.SortByAtk,
    [CommonDefine.AwakerSortType.Def] = AwakerDataUtils.SortByDef,
    [CommonDefine.AwakerSortType.Favorability] = AwakerDataUtils.SortByFavorability
  }
  AwakerDataUtils._sortedExpBottleInfos = nil
  AwakerDataUtils.PreMakeUpgradeConfig()
  AwakerDataUtils.InitAwakerPotencyMap()
  AwakerDataUtils.InitSpecialSkillData()
  AwakerDataUtils.HandleMockDataLock = nil
  AwakerDataUtils.talentTable = nil
  AwakerDataUtils.ResetMockAwakerMap()
  AwakerDataUtils.InitHitTriggerTime()
end

function AwakerDataUtils.ResetAll()
  DataCenter.awakerData.awakerMap = {}
  AwakerDataUtils.isPreviewingAwakersData = false
  AwakerDataUtils.InitConfig()
end

AwakerDataUtils.HandleMockDataLock = nil

function AwakerDataUtils.InitMockAwakerMap(mockMap)
  if not AwakerDataUtils.HandleMockDataLock then
    AwakerDataUtils.ResetMockAwakerMap()
    for sortIdx, awakerData in pairs(mockMap) do
      local awakerData = AwakerDataUtils.CreateDefaultAwakerData(awakerData.tid)
      awakerData.sort = sortIdx
      DataCenter.awakerData.mockAwakerMap[awakerData.tid] = awakerData
    end
    for tid, awakerData in pairs(mockMap) do
      AwakerDataUtils.UpdateAwakerData(awakerData)
    end
  end
end

function AwakerDataUtils.ResetMockAwakerMap()
  if not AwakerDataUtils.HandleMockDataLock then
    DataCenter.awakerData.mockAwakerMap = {}
  end
end

function AwakerDataUtils.InitHitTriggerTime()
  local map = {}
  AwakerDataUtils.HitTriggerTimeMap = map
  local list = DT.GetOriginalConstant("Awaker_EX_24_Voice")
  if nil == list then
    return
  end
  for i = 1, #list, 2 do
    local stateId = list[i]
    local triggerTime = list[i + 1]
    map[stateId] = triggerTime
  end
end

function AwakerDataUtils.GetHitNewTrigger(roleUid)
  local trigger = CommonDefine.AwakerVoiceTrigger.Hit
  local map = AwakerDataUtils.HitTriggerTimeMap or {}
  for stateId, newTrigger in pairs(map) do
    local stateData = bg.battleDataCenter.stateData:GetRoleState(roleUid, stateId)
    if stateData then
      trigger = newTrigger
      break
    end
  end
  return trigger
end

function AwakerDataUtils.OpenHandleMockDataLock(strVal)
  if not AwakerDataUtils.HandleMockDataLock then
    AwakerDataUtils.HandleMockDataLock = strVal
  end
end

function AwakerDataUtils.CloseHandleMockDataLock(strVal)
  if AwakerDataUtils.HandleMockDataLock == strVal then
    AwakerDataUtils.HandleMockDataLock = nil
  end
end

function AwakerDataUtils.GetMockAwakerMap()
  return DataCenter.awakerData.mockAwakerMap
end

function AwakerDataUtils.GetAwakerAnimationID(roleType, awakerConfigId)
  local awakerConfig
  if roleType == bc.RoleType.Monster then
    awakerConfig = DT.MonsterConfig[awakerConfigId]
  else
    awakerConfig = DT.AwakerConfig[awakerConfigId]
  end
  if bg.isPVP then
    return awakerConfig.PVPAnimationID
  else
    return awakerConfig.AnimationID
  end
end

function AwakerDataUtils.GetAwakerAnimationConfig(roleType, awakerConfigId, skinId)
  local animationID = AwakerDataUtils.GetAwakerAnimationID(roleType, awakerConfigId, skinId)
  local animationCfg, originCfg
  if bg.isPVP then
    originCfg = DT.PVPAnimationConfig[animationID]
  else
    originCfg = DT.AnimationConfig[animationID]
  end
  animationCfg = table.clone(originCfg)
  local originCfgMt = getmetatable(originCfg)
  if originCfgMt then
    setmetatable(animationCfg, originCfgMt)
  end
  if skinId and skinId ~= cd.DefaultSkinTid then
    skinId = AwakerSkinUtils.UnifyToSkinTid(skinId)
  end
  if skinId and skinId ~= cd.DefaultSkinTid and AwakerSkinUtils.IsReplaceBattleSpine(skinId) then
    local skinResNum = AwakerSkinUtils.GetSkinResNum(skinId)
    animationCfg.spineName = AwakerDataUtils.ReplaceSkinRes(animationCfg.spineName, awakerConfigId, skinResNum)
  end
  return animationCfg
end

function AwakerDataUtils.GetAwakerExAnimCfgs(roleType, awakerConfigId)
  local awakerConfig
  if roleType == bc.RoleType.Monster then
    awakerConfig = DT.MonsterConfig[awakerConfigId]
  else
    awakerConfig = DT.AwakerConfig[awakerConfigId]
  end
  local exAnimCfgs = {}
  if bg.isPVE then
    for _, animId in ipairs(awakerConfig.ExAnimations or {}) do
      print("animIdanimId====", animId, DT.AnimationConfig[animId], getmetatable(DT.AnimationConfig[animId]))
      table.insert(exAnimCfgs, DT.AnimationConfig[animId])
    end
  end
  return exAnimCfgs
end

function AwakerDataUtils.GetAwakerAllAnimationConfigs(roleType, awakerConfigId, skinId)
  local exAnimations = AwakerDataUtils.GetAwakerExAnimCfgs(roleType, awakerConfigId)
  local allAnimtionCfgs = table.clone(exAnimations)
  local baseAnimtionCfg = AwakerDataUtils.GetAwakerAnimationConfig(roleType, awakerConfigId, skinId)
  table.insert(allAnimtionCfgs, 1, baseAnimtionCfg)
  return allAnimtionCfgs
end

function AwakerDataUtils.GetSkillLevelUpArgs(awakerData, skillId, skillLevel)
  local skillCfg = DT.Skill[skillId]
  assert(skillCfg, "技能不存在:" .. skillId)
  local cmdParser = BattleCmdParserClient({awaker = awakerData})
  cmdParser:SetMemberValue("SkillLevel", skillLevel)
  local argValues = {}
  error("AwakerDataUtils.GetSkillLevelUpArgs,技能数据表读取，未替换，字段=CoefficientTypelist")
  local coefficientStrList = skillCfg.CoefficientTypelist or {}
  for i, val in ipairs(coefficientStrList) do
    error("AwakerDataUtils.GetSkillLevelUpArgs,技能数据表读取，未替换，字段=OriginalCoefficient")
    local originalArgValue = skillCfg["OriginalCoefficient" .. i]
    local coefficientStr = coefficientStrList[i]
    if originalArgValue and coefficientStr then
      cmdParser:SetMemberValue("GrowArgValue", originalArgValue)
      local argValue = cmdParser:GetValueByCmd(coefficientStr)
      argValues[i] = argValue
    end
  end
  return argValues
end

function AwakerDataUtils.GetSkillLevelUpShowData(awakerData, skillId, skillLevel)
  local argValues = SkillUtils.GetSkillLevelUpArgs(awakerData, skillId, skillLevel)
  if not argValues then
    return {}
  end
  local skillCfg = DT.Skill[skillId]
  assert(skillCfg, "技能不存在:" .. skillId)
  local showDataList = {}
  error("AwakerDataUtils.GetSkillLevelUpShowData,技能数据表未替换，字段=PropertyNameList")
  for idx, value in ipairs(argValues) do
    local propertyName = skillCfg.PropertyNameList[idx]
    local isAbsValue = string.sub(propertyName, 1, 1) == "$"
    local showValue
    if isAbsValue then
      propertyName = ""
      showValue = SkillUtils.ToPropertyValueDisplayString(value)
    else
      showValue = tonumber(tostring(value * 100))
      showValue = math.ceil(showValue)
    end
    error("AwakerDataUtils.GetSkillLevelUpShowData,技能数据表未替换，字段=EffectNameList")
    local data = {
      effectName = skillCfg.EffectNameList[idx],
      propertyName = propertyName,
      value = value,
      showValue = showValue,
      isAbsValue = isAbsValue
    }
    table.insert(showDataList, data)
  end
  return showDataList
end

function AwakerDataUtils.GetAwakerDataMap()
  return DataCenter.awakerData.awakerMap
end

function AwakerDataUtils.InitTrinketMainAttrValueCfgMap()
  if not DT.TrinketMainAttrValue then
    return
  end
  AwakerDataUtils.TrinketMainAttrValueCfgMap = {}
  for tid, config in pairs(DT.TrinketainAttrValue) do
    local key = config.Type .. "_" .. config.Level
    local id = AwakerDataUtils.TrinketMainAttrValueCfgMap[key]
    if id then
      Logger.Warn("装备主属性等级表配置重复: key=%s, tid=%s, id=%s", key, tid, id)
    else
      AwakerDataUtils.TrinketMainAttrValueCfgMap[key] = tid
    end
  end
end

function AwakerDataUtils.GetExpUpgrade(tid, lv)
  local config = AwakerDataUtils.GetUpgradeConfig(lv)
  local awakerConfig = DT.AwakerConfig[tid]
  if awakerConfig.Quality == CommonDefine.CommonQuality.Purple then
    return config.SREXP
  end
  if awakerConfig.Quality == CommonDefine.CommonQuality.Orange then
    return config.SSREXP
  end
  return config.EXP
end

function AwakerDataUtils.PreMakeUpgradeConfig()
  AwakerDataUtils.UpgradeConfigMap = {}
  for _, cfg in pairs(DT.AwakerUpgrade) do
    if cfg then
      AwakerDataUtils.UpgradeConfigMap[cfg.Level] = cfg
    end
  end
end

function AwakerDataUtils.GetExpUpgradeEx(tid, from, to)
  local result = 0
  for i = from, to - 1 do
    result = result + AwakerDataUtils.GetExpUpgrade(tid, i)
  end
  return result
end

function AwakerDataUtils.GetSortedExpBottleInfos()
  if AwakerDataUtils._sortedExpBottleInfos then
    return AwakerDataUtils._sortedExpBottleInfos
  end
  local infos = {}
  local oriList = DT.GetOriginalConstant("AwakerExpItem") or {}
  for i = 1, #oriList, 2 do
    local itemId = oriList[i]
    local expValue = oriList[i + 1]
    if itemId and expValue and expValue > 0 then
      tableInsert(infos, {itemId = itemId, expValue = expValue})
    end
  end
  tableSort(infos, function(a, b)
    return a.expValue < b.expValue
  end)
  AwakerDataUtils._sortedExpBottleInfos = infos
  return infos
end

function AwakerDataUtils.CalcLevelUpBillableExp(needExp)
  local bottles = AwakerDataUtils.GetSortedExpBottleInfos()
  local minExp = bottles[1] and bottles[1].expValue or 0
  if needExp <= 0 or minExp <= 0 then
    return 0
  end
  return math.ceil(needExp / minExp) * minExp
end

function AwakerDataUtils.CalcLevelUpCoinCost(needExp)
  if needExp <= 0 then
    return 0
  end
  local rate = DT.GetConstant("AwakerExpCoinRatio") or 0
  local billableExp = AwakerDataUtils.CalcLevelUpBillableExp(needExp)
  local beforeCalc = math.floor(billableExp * rate)
  do return TalentDataUtils.CalReduceCoin_WhenLvUp end
  return TalentDataUtils.CalReduceCoin_WhenLvUp, beforeCalc
end

function AwakerDataUtils.CalcAutoPlaceExpItemUseCounts(needExp, playerGold)
  local bottles = AwakerDataUtils.GetSortedExpBottleInfos()
  if #bottles <= 0 or needExp <= 0 then
    return {}
  end
  local smBot = bottles[1]
  local medBot = bottles[2]
  local lgBot = bottles[3]
  local smallExp = smBot.expValue
  local medExp = medBot and medBot.expValue or smallExp
  local lgExp = lgBot and lgBot.expValue or medExp
  local medium2smallNum = smallExp > 0 and math.floor(medExp / smallExp) or 1
  local large2mediumNum = medExp > 0 and math.floor(lgExp / medExp) or 1
  local large2smallNum = medium2smallNum * large2mediumNum
  local ownSmall = ItemDataUtils.GetItemNum(smBot.itemId)
  local ownMed = medBot and ItemDataUtils.GetItemNum(medBot.itemId) or 0
  local ownLarge = lgBot and ItemDataUtils.GetItemNum(lgBot.itemId) or 0
  local coinRatio = DT.GetConstant("AwakerExpCoinRatio") or 0
  local goldMaxUnits = math.huge
  if coinRatio > 0 and smallExp > 0 and playerGold and playerGold >= 0 then
    goldMaxUnits = math.floor(playerGold / (coinRatio * smallExp))
  end
  local needUnits = math.min(goldMaxUnits, math.ceil(needExp / smallExp))
  local useLarge = 0
  local useMed = 0
  local useSmall = 0
  local isGoldBottleneck = goldMaxUnits < math.ceil(needExp / smallExp)
  if isGoldBottleneck then
    useSmall = math.min(needUnits, ownSmall)
    local remain = needUnits - useSmall
    if medBot and remain > 0 then
      local medUnitsNeeded = math.floor(remain / medium2smallNum)
      useMed = math.min(medUnitsNeeded, ownMed)
      remain = remain - useMed * medium2smallNum
    end
    if lgBot and remain > 0 then
      local lgUnitsNeeded = math.floor(remain / large2smallNum)
      useLarge = math.min(lgUnitsNeeded, ownLarge)
    end
  elseif ownSmall >= needUnits then
    useSmall = needUnits
  else
    useSmall = ownSmall
    local gapAfterSmall = needUnits - ownSmall
    if medBot and gapAfterSmall <= ownMed * medium2smallNum then
      useMed = math.ceil(gapAfterSmall / medium2smallNum)
      local medOverflow = useMed * medium2smallNum - gapAfterSmall
      useSmall = ownSmall - math.min(medOverflow, ownSmall)
    elseif medBot then
      useMed = ownMed
      if lgBot then
        local gapAfterMed = needUnits - ownSmall - ownMed * medium2smallNum
        local lgMaxUnits = ownLarge * large2smallNum
        if gapAfterMed <= lgMaxUnits then
          useLarge = math.ceil(gapAfterMed / large2smallNum)
          local lgOverflow = useLarge * large2smallNum - gapAfterMed
          useMed = ownMed - math.min(math.floor(lgOverflow / medium2smallNum), ownMed)
          useSmall = math.min(ownSmall, needUnits - useLarge * large2smallNum - useMed * medium2smallNum)
          useSmall = math.max(useSmall, 0)
        else
          useLarge = ownLarge
        end
      end
    elseif lgBot then
      gapAfterSmall = needUnits - ownSmall
      if gapAfterSmall <= ownLarge * large2smallNum then
        useLarge = math.ceil(gapAfterSmall / large2smallNum)
        local lgOverflow = useLarge * large2smallNum - gapAfterSmall
        useSmall = ownSmall - math.min(lgOverflow, ownSmall)
      else
        useLarge = ownLarge
      end
    end
  end
  local result = {}
  result[smBot.itemId] = useSmall
  if medBot then
    result[medBot.itemId] = useMed
  end
  if lgBot then
    result[lgBot.itemId] = useLarge
  end
  return result
end

function AwakerDataUtils.CalcRemainSmallExpBottleNeed(needExp, reservedCountMap)
  local bottles = AwakerDataUtils.GetSortedExpBottleInfos()
  if #bottles <= 0 or needExp <= 0 then
    return 0
  end
  local E3 = bottles[1].expValue
  local xNeed = math.ceil(needExp / E3)
  local ownedSmallUnits = 0
  for _, info in ipairs(bottles) do
    local ownNum = ItemDataUtils.GetItemNum(info.itemId) or 0
    local reservedNum = reservedCountMap and reservedCountMap[info.itemId] or 0
    local availableNum = math.max(0, ownNum - reservedNum)
    if availableNum > 0 and E3 > 0 then
      ownedSmallUnits = ownedSmallUnits + math.floor(info.expValue / E3) * availableNum
    end
  end
  do return math.max, 0 end
  return math.max, 0, xNeed - ownedSmallUnits, ipairs(bottles)
end

function AwakerDataUtils.GetUpgradeConfig(level, quality)
  if not level then
    return
  end
  local extraLevel = 0
  if quality then
    extraLevel = DT.GetConstant("AwakerUpgradeLevel_" .. quality)
  end
  level = level + extraLevel
  if not AwakerDataUtils.UpgradeConfigMap then
    AwakerDataUtils.PreMakeUpgradeConfig()
  end
  return AwakerDataUtils.UpgradeConfigMap[level]
end

function AwakerDataUtils.GetNeedExpUpgrade(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  local maxLevel = AwakerDataUtils.GetAwakerCurrLevelLimit(awaker)
  if maxLevel <= awaker.level then
    return 0
  end
  local maxExp = AwakerDataUtils.GetExpUpgrade(tid, awaker.level) or 100
  return maxExp - awaker.exp
end

function AwakerDataUtils.CalReduceUpgradeExp(curExp)
  local effectType = CommonDefine.AwakerSpecialSkillType.ResNeedReduce
  local funcModule = "AwakerLevelUp"
  local resuceExp = TalentDataUtils.GetResouceReduceResult(curExp, effectType, funcModule)
  if resuceExp then
    do return math.floor end
    return math.floor, resuceExp, funcModule
  end
  return curExp
end

function AwakerDataUtils.GetNeedReduceExpUpgrade(tid, curExp, level, targetLevel, maxLevel)
  if maxLevel <= level then
    return 0
  end
  local result = 0
  for i = level, targetLevel - 1 do
    local originValue = AwakerDataUtils.GetExpUpgrade(tid, i)
    result = result + AwakerDataUtils.CalReduceUpgradeExp(originValue)
  end
  return result - curExp
end

function AwakerDataUtils.IsCanUpgrade(tid)
end

function AwakerDataUtils.IsCanBreakthrough(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  if not awaker then
    return false
  end
  local materialEnough = AwakerDataUtils.NextBreakthroughMaterialEnough(tid)
  local goldEnough = AwakerDataUtils.NextBreakthroughGoldEnough(tid)
  local canCompose = ItemAlchemyUtils.OpenUpgradeViewWithAwakerTid(tid, true)
  local tasksFirst = awaker.nextRequireTaskComplete[1]
  local tasksSecond = awaker.nextRequireTaskComplete[2]
  local tasksThrid = awaker.nextRequireTaskComplete[3]
  local taskFirstFinish = TaskDataUtils.CheckTaskListIsAllDone(tasksFirst)
  local taskSecondFinish = TaskDataUtils.CheckTaskListIsAllDone(tasksSecond)
  local taskThridFinish = TaskDataUtils.CheckTaskListIsAllDone(tasksThrid)
  return AwakerDataUtils.IsAwakerReachLevelLimit(tid) and (materialEnough or canCompose) and goldEnough and (taskFirstFinish or taskSecondFinish or taskThridFinish)
end

function AwakerDataUtils.NextBreakthroughMaterialEnough(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  local mtrlCost = awaker.nextBreakthroughStarMtrlCost
  local enough = true
  for _, cost in ipairs(mtrlCost) do
    local item = ItemDataUtils.GetItemByTid(cost.id)
    local currCount = item and item.num or 0
    if currCount < cost.count then
      enough = false
      break
    end
  end
  return enough
end

function AwakerDataUtils.GetAwakerBreakthroughMaxStar(tid)
  if nil == tid or 0 == tid then
    return CommonDefine.AwakerBreakThrough.NullLevel
  end
  local cfg = DT.AwakerBreakThrough[tid]
  if cfg then
    return #cfg.data_list - 1
  else
    Logger.Error("[突破] 找不到唤醒体\"%s\"的突破配置！", tid)
    return CommonDefine.AwakerBreakThrough.NullLevel
  end
end

function AwakerDataUtils:GetAwakerCurrBreakthroughStar(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  if not awaker then
    return 0
  end
  return awaker.currBreakthroughStar
end

function AwakerDataUtils.NextBreakthroughGoldEnough(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  local goldCost = awaker.nextBreakthroughStarGoldCost
  local gold = ItemDataUtils.GetItemByTid(CommonDefine.CurrencyType.JuniorMoney)
  local goldCount = gold and gold.num or 0
  local effectType = CommonDefine.AwakerSpecialSkillType.ResNeedReduce
  local funcModule = "AwakerBreakThrough"
  local effectResultValue = TalentDataUtils.GetResouceReduceResult(goldCost, effectType, funcModule)
  if effectResultValue then
    goldCost = effectResultValue
  end
  return goldCount >= goldCost
end

function AwakerDataUtils.GetNextBreakthroughGold(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  local goldCost = awaker.nextBreakthroughStarGoldCost
  local effectType = CommonDefine.AwakerSpecialSkillType.ResNeedReduce
  local funcModule = "AwakerBreakThrough"
  local effectResultValue = TalentDataUtils.GetResouceReduceResult(goldCost, effectType, funcModule)
  if effectResultValue then
    goldCost = effectResultValue
  end
  return goldCost
end

function AwakerDataUtils.InitAwakerMapByServerData(serverAwakerData)
  if not serverAwakerData then
    return
  end
  for _, awakerData in ipairs(serverAwakerData) do
    AwakerDataUtils.UpdateAwakerData(awakerData, true)
  end
end

function AwakerDataUtils.InitAwakerMap()
  AwakerDataUtils.SetHasRequest(false)
  Logger.Info("重新初始化唤醒体数据....")
  local map = {}
  for tid, cfg in pairs(DT.AwakerConfig) do
    if map[tid] then
      Logger.Error("初始化失败, 存在重复的配置 => %s", tid)
    else
      map[tid] = AwakerDataUtils.CreateDefaultAwakerData(tid)
    end
  end
  DataCenter.awakerData.awakerMap = map
end

function AwakerDataUtils.IsNonLimitedAwaker(awakerTid)
  if nonLimitedAwakerMap then
    return nonLimitedAwakerMap[awakerTid]
  end
  local normalAwakerList = DT.GetOriginalConstant("NonLimitedAwakerList")
  nonLimitedAwakerMap = {}
  for i = 1, #normalAwakerList do
    nonLimitedAwakerMap[normalAwakerList[i]] = true
  end
  return nonLimitedAwakerMap[awakerTid]
end

function AwakerDataUtils.CreateDefaultAwakerData(tid)
  local weaponSlots = {}
  for _, slotType in pairs(CommonDefine.WeaponSlotType) do
    weaponSlots[slotType] = {
      slot = slotType,
      unlocked = false,
      weaponUid = 0
    }
  end
  local rst = {
    tid = tid,
    uid = 0,
    state = CommonDefine.AwakerState.NotOwn,
    star = 0,
    potency = 0,
    interest = false,
    level = 1,
    exp = 0,
    like = 1,
    likeLevel = 1,
    likeReward = {},
    oldLike = 0,
    currBreakthroughStar = 0,
    currBreakthroughStarSkillName = nil,
    currBreakthroughStarSkillIcon = nil,
    nextBreakthroughStarSkillName = nil,
    nextBreakthroughStarSkillIcon = nil,
    currBreakthroughStarAttrAdd = {},
    nextBreakthroughStarAttrAdd = {},
    nextRequireTaskComplete = {},
    nextBreakthroughStarMtrlCost = {},
    nextBreakthroughStarGoldCost = 0,
    currBreakthroughStarAttrChange = {},
    nextBreakthroughStarAttrChange = {},
    breakthroughRewardReceiveState = {},
    breakthroughStarPreview = 0,
    breakthroughMtrlCostPreview = {},
    breakthroughGoldCostPreview = 0,
    breakthroughRewardPreview = {},
    breakthroughRewardReceiveStatePreview = CommonDefine.AwakerBreakThrough.RewardUnavailable,
    voices = AwakerDataUtils.GetAwakerAllVoiceList(tid),
    weaponSlots = weaponSlots,
    show = 0,
    levelLimitIncreaseIdx = 0,
    talents = {},
    boundTrinkets = {}
  }
  if not AwakerDataUtils.IsNonLimitedAwaker(tid) then
    local talentCfgs = AwakerTalentExtModel.Instance:GetTalentCfgList(tid)
    if talentCfgs then
      for _, talentCfg in ipairs(talentCfgs) do
        local talentTid = talentCfg.ID
        if TalentDataUtils.IsAttrTalent(talentTid) then
          rst.talents[talentTid] = {
            lv = #talentCfg.data_list
          }
          break
        end
      end
    end
  end
  rst.attrs = AwakerDataUtils.GetNotOwnAwakerAttrs(tid, 1, rst)
  return rst
end

function AwakerDataUtils.GetAwakerAllVoiceList(numAwakerId)
  local rst = {}
  for voiceId, config in pairs(DT.Voice) do
    if config.AwakerID == numAwakerId then
      rst[voiceId] = 1
    end
  end
  return rst
end

function AwakerDataUtils.SetBoardAwaker(tid, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "SetBoardAwaker", function(success)
    if success == DT.ErrCode.SUCCESS.Data then
      DataCenter.playerData.DRole.boardAwaker = tid
      local awakerName = AwakerDataUtils.GetAwakerName(tid)
      local desc = DT.TipsType[10609] and LT.Textf(DT.TipsType[10609].Desc, awakerName) or ""
      Alert.Show(10609, nil, nil, nil, desc)
      if callback then
        callback()
      end
    end
  end, nil, tid)
end

function AwakerDataUtils.ReqOnIncreaseLimitLevel(awakerId, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnIncreaseLimitLevel", function(data)
    Logger.Info("========== 唤醒体潜能迸发成功 ==========\n", table.tostring(data))
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("========== 唤醒体潜能迸发失败 ==========\n", table.tostring(data))
  end, awakerId)
end

function AwakerDataUtils.RequestAwakersData(callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnReqAwakerList", function(data)
    Logger.Info("========== 请求唤醒体数据成功 ==========\n", table.tostring(data))
    for _, awakerData in ipairs(data.awakers) do
      AwakerDataUtils.UpdateAwakerData(awakerData)
    end
    if callback then
      callback()
    end
    AwakerDataUtils.SetHasRequest(true)
  end, function(data)
    Logger.Info("========== 请求唤醒体数据失败 ==========\n", table.tostring(data))
  end)
end

function AwakerDataUtils.GetNotOwnAwakerAttrs(tid, level, awakerData)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  if not config then
    return {}
  end
  local targetLevel = level or 1
  local attrs = {
    atk = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(tid, targetLevel, "atk", awakerData),
    def = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(tid, targetLevel, "def", awakerData),
    physique = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(tid, targetLevel, "physique", awakerData),
    physique_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "physique_per"),
    atk_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "atk_per"),
    def_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "def_per"),
    ulti_energy_init = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "ulti_energy_init"),
    ulti_energy_max = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "ulti_energy_max"),
    ulti_energy_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "ulti_energy_per"),
    ulti_energy_passive = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "ulti_energy_passive"),
    ulti_energy_passive_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "ulti_energy_passive_per"),
    crit_damage = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "crit_damage"),
    crit = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "crit"),
    ulti_energy_efficiency = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "ulti_energy_efficiency"),
    keeper_energy_eff_2 = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "keeper_energy_eff_2"),
    occupation_master = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "occupation_master"),
    occupation_master_final_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "occupation_master_final_per"),
    blackcoin_upgrade_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "blackcoin_upgrade_per"),
    basic_damage_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "basic_damage_per"),
    death_resist = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "death_resist"),
    block_heal_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "block_heal_per"),
    ulti_energy_plus_3 = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "ulti_energy_plus_3"),
    ulti_energy_return = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "ulti_energy_return"),
    enchant_upgrade_per = AwakerDataUtils.GetAwakerBaseAttrValue(tid, targetLevel, "enchant_upgrade_per")
  }
  return attrs
end

function AwakerDataUtils.GetNotOwnAwakerSkills(tid)
  if not tid then
    return {}
  end
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  if not config then
    return {}
  end
  local skills = {}
  local baseSkillNum = DT.GetConstant("AwakerSkillListNum")
  for i = 1, baseSkillNum do
    local skillTid = config.SkillList[i]
    if not skillTid then
    else
      local skillData = {
        slot = i,
        isUp = true,
        upNum = 0,
        level = 1,
        lock = false,
        tid = skillTid
      }
      tableInsert(skills, skillData)
    end
  end
  local breakthroughSkills = AwakerDataUtils.CreateBreakthroughSkillInfoListByAwakerId(tid, #skills + 1)
  if breakthroughSkills then
    table.append(skills, breakthroughSkills)
  end
  return skills
end

function AwakerDataUtils.HasReqServerData()
  return DataCenter.awakerData.hasReqServerData
end

function AwakerDataUtils.SetHasRequest(state)
  DataCenter.awakerData.hasReqServerData = state
end

function AwakerDataUtils.UpdateAwakerCollectStateData(tid, state)
  local awaker = DataCenter.awakerData.awakerMap[tid]
  if table.next(DataCenter.awakerData.mockAwakerMap) then
    awaker = DataCenter.awakerData.mockAwakerMap[tid]
  end
  awaker.isCollect = state
end

function AwakerDataUtils.UpdateAwakerData(data, isAll)
  local awaker = DataCenter.awakerData.awakerMap[data.tid]
  if table.next(DataCenter.awakerData.mockAwakerMap) then
    awaker = DataCenter.awakerData.mockAwakerMap[data.tid]
  end
  if not awaker then
    return
  end
  if data.slots then
    if isAll then
      local skills = {}
      for _, v in ipairs(data.slots) do
        if v.slot <= baseSkillSlot then
          skills[v.slot] = v
        end
      end
      awaker.skills = skills
      awaker.breakSkillUnlock = data.breakSkillUnlock
      AwakerDataUtils._AddBreakthroughSkillInfo(awaker)
      AwakerDataUtils._AddSpecialSkillInfo(awaker)
    else
      if not awaker.skills then
        awaker.skills = {}
      end
      for _, v in ipairs(data.slots) do
        if v.slot <= baseSkillSlot then
          local skill = v
          skill.upNum = v.upNum or 0
          awaker.skills[v.slot] = v
        end
      end
    end
  end
  awaker.uid = data.uid
  awaker.lastLevel = awaker.level or nil
  awaker.lastExp = awaker.exp or nil
  awaker.exp = data.exp or awaker.exp
  awaker.potency = data.potential or awaker.potency
  awaker.potencyLevel = data.potencyLevel or awaker.potencyLevel
  awaker.star = AwakerDataUtils.GetAwakerStar(data.tid)
  awaker.curSkin = data.curSkin or awaker.curSkin
  if data.like then
    awaker.oldLike = awaker.like
  end
  awaker.like = data.like or awaker.like
  awaker.likeLevel = data.likeLevel or awaker.likeLevel
  awaker.likeReward = data.likeReward or awaker.likeReward
  awaker.interest = data.isCollect or awaker.interest
  awaker.suitAttr = data.suitAttr or awaker.suitAttr or {}
  awaker.fighting = data.fighting or awaker.fighting
  awaker.state = data.state or CommonDefine.AwakerState.Owned
  awaker.weapon = data.weapon or awaker.weapon
  awaker.isCollect = data.isCollect or awaker.isCollect
  if data.weaponSlots then
    for k, v in pairs(data.weaponSlots) do
      awaker.weaponSlots[k] = v
    end
  end
  for _, slot in pairs(awaker.weaponSlots) do
    slot.weaponUid = slot.weaponUid or 0
  end
  awaker.trinkets = data.trinkets or awaker.trinkets
  if data.boundTrinkets ~= nil then
    awaker.boundTrinkets = data.boundTrinkets
  elseif awaker.boundTrinkets == nil then
    awaker.boundTrinkets = {}
  end
  AwakerDataUtils._RefreshBoundTrinketIndex(data.tid)
  awaker.voices = data.voices or awaker.voices
  awaker.stories = data.stories or awaker.stories
  awaker.talents = data.talents or awaker.talents
  awaker.createTime = data.createTime or awaker.createTime
  awaker.levelLimitIncreaseIdx = data.levelLimitIncreaseIdx or awaker.levelLimitIncreaseIdx
  awaker.breakthroughRewardReceiveState = data.breakReward or awaker.breakthroughRewardReceiveState or {}
  if data.level then
    awaker.level = data.level
    AwakerDataUtils._SetupBreakthroughData(awaker, awaker.currBreakthroughStar)
  end
  if data.breakLevel then
    AwakerDataUtils._SetupBreakthroughData(awaker, data.breakLevel)
  end
  if data.attrs then
    if nil == isAll or isAll then
      awaker.attrs = data.attrs
    else
      if nil == awaker.attrs then
        awaker.attrs = {}
      end
      for k, v in pairs(data.attrs) do
        awaker.attrs[k] = v
      end
    end
    AwakerDataUtils.UpdateClientAttrs(awaker, AwakerDataUtils.GetAwakerShowAttrs(awaker.attrs))
  end
  awaker.likeLevelLimit = data.likeLevelLimit or awaker.likeLevelLimit
  awaker.show = data.show or awaker.show
  RedPointDataUtils.UpdateAwakerRed(awaker)
  return awaker
end

function AwakerDataUtils.GetUnselectedSlotType(currSelectedWeaponSlotType)
  if currSelectedWeaponSlotType == CommonDefine.WeaponSlotType.Primary then
    return CommonDefine.WeaponSlotType.Secondary
  elseif currSelectedWeaponSlotType == CommonDefine.WeaponSlotType.Secondary then
    return CommonDefine.WeaponSlotType.Primary
  end
end

function AwakerDataUtils.GetWeaponSlotData(awaker)
  local weaponSlotGroup = {
    CommonDefine.WeaponSlotType.Primary,
    CommonDefine.WeaponSlotType.Secondary
  }
  local rst = {}
  for _, slot in ipairs(weaponSlotGroup) do
    rst[slot] = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, slot)
  end
  return rst
end

function AwakerDataUtils.GetWeaponSlotDataWithType(awaker, slotType)
  local slot = slotType
  local weaponUid, unlocked
  if not (awaker and awaker.weaponSlots) or not awaker.weaponSlots[slot] then
    do return AwakerDataUtils.CreateWeaponSlotData, slot, weaponUid end
    return AwakerDataUtils.CreateWeaponSlotData, slot, weaponUid, unlocked, nil, nil, nil, nil, nil
  end
  local weaponSlotData = awaker.weaponSlots[slot]
  weaponUid = weaponSlotData.weaponUid
  unlocked = weaponSlotData.unlocked
  local rst = AwakerDataUtils.CreateWeaponSlotData(slot, weaponUid, unlocked)
  for key, val in pairs(weaponSlotData) do
    rst[key] = val
  end
  return rst
end

function AwakerDataUtils.CreateWeaponSlotData(slot, weaponUid, unlocked)
  return {
    slot = slot,
    weaponUid = weaponUid or 0,
    unlocked = unlocked or false
  }
end

function AwakerDataUtils.GetWeapon(awaker, slotType)
  local weaponSlot = AwakerDataUtils.GetWeaponSlotDataWithType(awaker, slotType)
  if not weaponSlot.tid or 0 == weaponSlot.tid then
    return
  end
  if weaponSlot.unlocked then
    if weaponSlot.weaponUid > 0 then
      do return ItemDataUtils.GetItemByUid end
      return ItemDataUtils.GetItemByUid, weaponSlot.weaponUid, nil, nil
    else
      do return ItemDataUtils.ConstructWeaponItem, weaponSlot.tid end
      return ItemDataUtils.ConstructWeaponItem, weaponSlot.tid, {
        potencyLv = weaponSlot.level
      }, weaponSlot.level
    end
  end
end

function AwakerDataUtils.GetWeaponConfig(awaker, slotType)
  local weaponItem = AwakerDataUtils.GetWeapon(awaker, slotType)
  if weaponItem then
    return DT.Item[weaponItem.tid]
  end
end

function AwakerDataUtils._SetupBreakthroughData(awaker, star)
  local cfg = DT.AwakerBreakThrough[awaker.tid]
  if not cfg then
    Logger.Error("[突破] 找不到唤醒体\"%s\"的突破配置！", awaker.tid)
    return
  end
  local idx = star + 1
  local currStarCfg = cfg.data_list[idx]
  if not currStarCfg then
    Logger.Error("[突破] 找不到唤醒体\"%s\"的\"%s\"级突破配置！", awaker.tid, star)
    return
  end
  local nextStarCfg = cfg.data_list[idx + 1]
  local nextStarAttrAdd = AwakerDataUtils._GetBreakthroughAttrAdd(nextStarCfg)
  local currStarAttrAdd = AwakerDataUtils._GetBreakthroughAttrAdd(currStarCfg)
  local mtrlCostToNextStar, goldCostToNextStar = AwakerDataUtils._GetBreakthroughCost(currStarCfg)
  awaker.currBreakthroughStar = star
  awaker.currBreakthroughStarSkillName = currStarCfg.PotencyName
  awaker.currBreakthroughStarSkillIcon = currStarCfg.PotencyIcon
  awaker.nextBreakthroughStarSkillName = nextStarCfg and nextStarCfg.PotencyName
  awaker.nextBreakthroughStarSkillIcon = nextStarCfg and nextStarCfg.PotencyIcon
  awaker.currBreakthroughStarAttrAdd = currStarAttrAdd
  awaker.nextBreakthroughStarAttrAdd = nextStarAttrAdd
  awaker.nextRequireTaskComplete = currStarCfg.RequireTaskComplete or {}
  awaker.nextBreakthroughStarMtrlCost = mtrlCostToNextStar
  awaker.nextBreakthroughStarGoldCost = goldCostToNextStar
  for _, skill in ipairs(awaker.skills) do
    if skill.isBreakthroughSkill then
      skill.lock = awaker.currBreakthroughStar < skill.unlockBreakthroughLevel
    end
  end
end

function AwakerDataUtils.CreateBreakthroughSkillInfoList(awaker)
  local awakerTid = awaker.tid
  local targetSlot = #awaker.skills + 1
  local breakSkillUnlock = awaker.breakSkillUnlock
  do return AwakerDataUtils._CreateBreakthroughSkillInfoList, awakerTid, targetSlot end
  return AwakerDataUtils._CreateBreakthroughSkillInfoList, awakerTid, targetSlot, breakSkillUnlock
end

function AwakerDataUtils.CreateBreakthroughSkillInfoListByAwakerId(awakerTid, targetSlot)
  do return AwakerDataUtils._CreateBreakthroughSkillInfoList, awakerTid end
  return AwakerDataUtils._CreateBreakthroughSkillInfoList, awakerTid, targetSlot
end

function AwakerDataUtils._CreateBreakthroughSkillInfoList(awakerTid, targetSlot, breakSkillUnlock)
  local cfg = DT.AwakerBreakThrough[awakerTid]
  if not cfg then
    Logger.Error("[突破] 找不到唤醒体\"%s\"的突破配置！", awakerTid)
    return
  end
  local preSkill
  local extraSkillList = {}
  for _, data in ipairs(cfg.data_list) do
    if data.PotencyName then
      local actived = breakSkillUnlock and breakSkillUnlock[data.Level] or false
      local skill = {
        preSkill = preSkill,
        skillId = data.Skill,
        slot = targetSlot,
        isBreakthroughSkill = true,
        name = LT.Text(data.PotencyName),
        desc = LT.Text(data.PotencyDesc),
        story = data.Story and LT.Text(data.Story) or "",
        skillPara = data.EffectPara and data.EffectPara[1],
        lock = true,
        unlockBreakthroughLevel = data.Level,
        icon = data.PotencyIcon,
        actived = actived,
        requiredMtrls = data.RequiredMaterials
      }
      preSkill = skill
      table.insert(extraSkillList, skill)
      targetSlot = targetSlot + 1
    end
  end
  return extraSkillList
end

function AwakerDataUtils.GetSuperUltiSkillInfo(awakerTid)
  for _, data in pairs(DT.AwakerPotency) do
    if data.AwakerID == awakerTid and data.EffectType1 == AwakerPotencyEffectType.UtlSkill_Promote and data.PotencyName then
      return {
        name = LT.Text(data.PotencyName),
        desc = LT.Text(data.PotencyDesc)
      }
    end
  end
end

function AwakerDataUtils.GetAwakerBreakThroughConfig(tid)
  if not tid then
    return
  end
  return DT.AwakerBreakThrough[tid]
end

function AwakerDataUtils.GetMaxBreakthroughLevel(awakerTid)
  local config = AwakerDataUtils.GetAwakerBreakThroughConfig(awakerTid)
  if not config then
    return 0
  end
  local finalIndex = #config.data_list
  local cfg = config.data_list[finalIndex]
  return cfg and cfg.Level or 0
end

function AwakerDataUtils.GetSpecialSkillWorldDesc(tid)
  local config = TalentDataUtils.GetSpecialSkillConfig(tid)
  if not config then
    return ""
  end
  do return LT.Text end
  return LT.Text, config.ExtraDesc
end

function AwakerDataUtils._AddBreakthroughSkillInfo(awaker)
  local extraSkillList = AwakerDataUtils.CreateBreakthroughSkillInfoList(awaker)
  if not extraSkillList then
    return
  end
  table.append(awaker.skills, extraSkillList)
end

function AwakerDataUtils.SetBreakthroughRewardReceived(tid, star)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  if awaker then
    awaker.breakthroughRewardReceiveState[star] = true
  end
end

function AwakerDataUtils.SetupBreakthroughPreviewData(tid, star)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  if awaker then
    local cfg = DT.AwakerBreakThrough[awaker.tid]
    if not cfg then
      Logger.Error("[突破] 找不到唤醒体\"%s\"的突破配置！", awaker.tid)
      return
    end
    local idx = star + 1
    local currStarCfg = cfg.data_list[idx]
    if not currStarCfg then
      Logger.Error("[突破] 找不到唤醒体\"%s\"的\"%s\"级突破配置！", awaker.tid, star)
      return
    end
    local prevStarCfg = cfg.data_list[idx - 1]
    local mtrlCostToCurrStar, goldCostToCurrStar = AwakerDataUtils._GetBreakthroughCost(prevStarCfg)
    awaker.breakthroughStarPreview = star
    awaker.breakthroughMtrlCostPreview = mtrlCostToCurrStar
    awaker.breakthroughGoldCostPreview = goldCostToCurrStar
    awaker.breakthroughRewardPreview = AwakerDataUtils._GetBreakthroughReward(currStarCfg)
    awaker.breakthroughRewardReceiveStatePreview = AwakerDataUtils.GetBreakthroughRewardReceiveState(awaker, star)
  end
end

function AwakerDataUtils._GetBreakthroughAttrAdd(cfg)
  if not cfg or not cfg.Attr then
    return {}
  end
  local attrAdd = {}
  for id, add in pairs(cfg.Attr) do
    table.insert(attrAdd, {id = id, add = add})
  end
  table.sort(attrAdd, function(a, b)
    return a.id < b.id
  end)
  return attrAdd
end

function AwakerDataUtils._GetBreakthroughCost(cfg)
  if not cfg or not cfg.RequireentItem then
    return {}, 0
  end
  local mtrlCost = {}
  local goldCost = 0
  for id, count in pairs(cfg.RequireentItem) do
    if id == CommonDefine.CurrencyType.JuniorMoney then
      goldCost = count
    else
      table.insert(mtrlCost, {id = id, count = count})
    end
  end
  table.sort(mtrlCost, function(a, b)
    return a.id < b.id
  end)
  return mtrlCost, goldCost
end

function AwakerDataUtils._GetBreakthroughReward(cfg)
  if not cfg or not cfg.Reward then
    return {}
  end
  local reward = {}
  for id, count in pairs(cfg.Reward) do
    table.insert(reward, {id = id, count = count})
  end
  table.sort(reward, function(a, b)
    return a.id < b.id
  end)
  return reward
end

function AwakerDataUtils.GetBreakthroughRewardReceiveState(awaker, star)
  if awaker.breakthroughRewardReceiveState[star] then
    return CommonDefine.AwakerBreakThrough.RewardReceived
  end
  if star <= awaker.currBreakthroughStar then
    return CommonDefine.AwakerBreakThrough.RewardAvailable
  else
    return CommonDefine.AwakerBreakThrough.RewardUnavailable
  end
end

function AwakerDataUtils.GetOwnedAwakerMap()
  local ret = {}
  if not DataCenter.awakerData.awakerMap then
    AwakerDataUtils.InitAwakerMap()
  end
  for tid, awakerData in pairs(DataCenter.awakerData.awakerMap) do
    if AwakerDataUtils.HasOwnedAwaker(tid) then
      ret[tid] = awakerData
    end
  end
  return ret
end

function AwakerDataUtils.IsMocking()
  return table.next(DataCenter.awakerData.mockAwakerMap) ~= nil
end

function AwakerDataUtils.GetOwnedAwakerList()
  local ret = {}
  if not DataCenter.awakerData.awakerMap then
    AwakerDataUtils.InitAwakerMap()
  end
  for tid, awakerData in pairs(DataCenter.awakerData.awakerMap) do
    if AwakerDataUtils.HasOwnedAwaker(tid) then
      table.insert(ret, awakerData)
    end
  end
  return ret
end

function AwakerDataUtils.HasOwnedAwaker(tid)
  local awakerData = AwakerDataUtils.GetAwakerData(tid)
  if not awakerData then
    return false
  end
  return awakerData.state == CommonDefine.AwakerState.Owned
end

function AwakerDataUtils.IsUnlockedOriginType(tid)
  local isOriginType = AwakerDataUtils.IsOriginType(tid)
  if isOriginType then
    do return AwakerDataUtils.HasOwnedAwaker end
    return AwakerDataUtils.HasOwnedAwaker, tid, nil
  elseif AwakerDataUtils.HasOriginType(tid) then
    local originId = AwakerDataUtils.GetChangerForm(tid)
    do return AwakerDataUtils.HasOwnedAwaker end
    return AwakerDataUtils.HasOwnedAwaker, originId
  else
    return false
  end
end

function AwakerDataUtils.IsBaseType(tid)
  local awakerCfg = DT.AwakerConfig[tid]
  return awakerCfg.AwakerType == CommonDefine.AwakerType.BaseType
end

function AwakerDataUtils.IsOriginType(tid)
  local awakerCfg = DT.AwakerConfig[tid]
  if not awakerCfg then
    return false
  end
  return awakerCfg.AwakerType == CommonDefine.AwakerType.OriginType
end

function AwakerDataUtils.HasOriginType(tid)
  if AwakerDataUtils.IsOriginType(tid) then
    return true
  else
    local changeForm = AwakerDataUtils.GetChangerForm(tid)
    if changeForm and 0 ~= changeForm then
      if AwakerDataUtils.HasOwnedAwaker(changeForm) then
        return true
      end
      local awakerCfg = DT.AwakerConfig[changeForm] or {}
      if not awakerCfg.OpenDate or TimeUtils.GetServerTime() >= awakerCfg.OpenDate then
        return true
      end
    end
    return false
  end
end

function AwakerDataUtils.IsAwakerShow(tid)
  local awakerData = AwakerDataUtils.GetAwakerData(tid)
  if awakerData then
    return 0 == awakerData.show
  end
  return false
end

function AwakerDataUtils.GetChangerForm(tid)
  local awakerCfg = DT.AwakerConfig[tid]
  if awakerCfg then
    return awakerCfg.ChangerForm
  else
    return 0
  end
end

function AwakerDataUtils.JumpToSingleAwakerPanel(page, tid, jumpCallback)
  local awakerMap = AwakerDataUtils.GetAwakerDataMap()
  
  local function panelOpenFunc()
    local awakerBasePanelData = {}
    awakerBasePanelData.jumpPage = page or CommonDefine.AwakerPage.Detail
    awakerBasePanelData.specialAwakerList = {
      awakerMap[tid]
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end
  
  FuncJumpManager.JumpToFuncPanel(jumpCallback, panelOpenFunc)
end

function AwakerDataUtils.SetCurShowAwakerIndex(index)
  if not index then
    return
  end
  if type(index) ~= "number" then
    Logger.Info("error: param needs number, got ", type(index))
    return
  end
  if not DataCenter.awakerData.showAwakerList or index > #DataCenter.awakerData.showAwakerList then
    Logger.Info("error param: index out of bounds. index=%d, listSize=%d", index, #DataCenter.awakerData.showAwakerList)
    return
  end
  DataCenter.awakerData.curShowAwakerIndex = index
end

function AwakerDataUtils.GetCurShowAwakerIndex()
  return DataCenter.awakerData.curShowAwakerIndex
end

function AwakerDataUtils.GetShowAwaker(index)
  if not index then
    return
  end
  local size = #DataCenter.awakerData.showAwakerList
  if index > size then
    Logger.Info("Error: index is out of bounds. index=%d, listSize=%d", index, size)
    return
  end
  return DataCenter.awakerData.showAwakerList[index]
end

function AwakerDataUtils.UpdateAwakerAttrs(data)
  if not data then
    return
  end
  for tid, attrs in pairs(data) do
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if awaker then
      for k, v in pairs(attrs) do
        awaker.attrs[k] = v
      end
      if attrs.fighting and attrs.fighting > 0 then
        awaker.fighting = attrs.fighting
      end
      AwakerDataUtils.UpdateClientAttrs(awaker, AwakerDataUtils.GetAwakerShowAttrs(awaker.attrs))
      RedPointDataUtils.UpdateAwakerRed(awaker)
    end
  end
end

function AwakerDataUtils.RevertAwakerAttrExitWorld(data)
  if not data then
    return
  end
  for tid, attrs in pairs(data) do
    local awaker = AwakerDataUtils.GetAwakerData(tid)
    if awaker then
      awaker.attrs = attrs
      AwakerDataUtils.UpdateClientAttrs(awaker, AwakerDataUtils.GetAwakerShowAttrs(awaker.attrs))
      RedPointDataUtils.UpdateAwakerRed(awaker)
    end
  end
end

function AwakerDataUtils.UpdateClientAttrs(awaker, newAttrs)
  awaker.clientAttrs = newAttrs
end

function AwakerDataUtils.GetAwakerData(tid, isJumpMockData)
  if not tid then
    return {}
  end
  if isJumpMockData then
    return DataCenter.awakerData.awakerMap[tid]
  end
  if table.next(DataCenter.awakerData.mockAwakerMap) then
    return DataCenter.awakerData.mockAwakerMap[tid]
  end
  return DataCenter.awakerData.awakerMap[tid]
end

function AwakerDataUtils.GetAwakerDataByUid(uid)
  local awakerMap = DataCenter.awakerData.awakerMap or {}
  if table.next(DataCenter.awakerData.mockAwakerMap) then
    awakerMap = DataCenter.awakerData.mockAwakerMap
  end
  for _, awaker in pairs(awakerMap) do
    if awaker.uid == uid then
      return awaker
    end
  end
end

function AwakerDataUtils.GetAwakerCollectStateByTid(tid)
  local awakerData = AwakerDataUtils.GetAwakerData(tid)
  if not awakerData then
    return 0
  end
  return awakerData.isCollect
end

function AwakerDataUtils.GetAwakerTrainValue(tid)
  local awakerData = AwakerDataUtils.GetAwakerData(tid)
  if not awakerData then
    return 0
  end
  local level = awakerData.level
  local skillTrainValue = AwakerDataUtils.GetSkillTrainValue(awakerData.skills)
  local weaponTrainValue = AwakerDataUtils.GetWeaponTrainValue(awakerData.weapon)
  local trainValue = {
    level = level,
    skillTrainValue = skillTrainValue,
    weaponTrainValue = weaponTrainValue
  }
  return trainValue
end

function AwakerDataUtils.GetSkillTrainValue(skills)
  local skillLevel = 0
  for _, skill in ipairs(skills or {}) do
    skillLevel = skillLevel + (skill.level or 0)
  end
  local trainRates = DT.GetOriginalConstant("CombatGrowParams")
  local trainIndex = CommonDefine.TrainIndex.Level
  return skillLevel * (trainRates[trainIndex] or 1)
end

function AwakerDataUtils.GetWeaponTrainValue(uid)
  local trainValue = 0
  local weaponData = uid and ItemDataUtils.GetItemByUid(uid)
  if weaponData then
    local trainRates = DT.GetOriginalConstant("CombatGrowParams")
    local tid = weaponData.tid
    local itemCfg = DT.Item[tid]
    local qualityTrain = CommonDefine.QualityTrainValue[itemCfg.Quality]
    local qualiyIndex = CommonDefine.TrainIndex.WeaponQuality
    qualityTrain = qualityTrain * (trainRates[qualiyIndex] or 1)
    local levelIndex = CommonDefine.TrainIndex.WeaponLevel
    local levelTrain = weaponData.level * (trainRates[levelIndex] or 1)
    local enhanceLevelIndex = CommonDefine.TrainIndex.WeaponEnhanceLevel
    local enhanceLevelTrain = weaponData.enhanceLevel * (trainRates[enhanceLevelIndex] or 1)
    local breakLevelIndex = CommonDefine.TrainIndex.WeaponBreakLevel
    local breakLevelTrain = weaponData.breakLevel * (trainRates[breakLevelIndex] or 1)
    trainValue = qualityTrain + levelTrain + enhanceLevelTrain + breakLevelTrain
  end
  return trainValue
end

function AwakerDataUtils.GetAwakerTrinketTrainVallue(awakerData, extraItemDataMap)
  local trainValue = 0
  local trinketUids = awakerData.trinkets or {}
  local trainRates = DT.GetOriginalConstant("CombatGrowParams")
  for _, uid in pairs(trinketUids) do
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if awakerData.isAssist then
      itemData = extraItemDataMap and extraItemDataMap[uid]
    end
    if not itemData then
    else
      local itemCfg = ItemDataUtils.GetItemConfig(itemData.tid)
      local quality = itemCfg and itemCfg.Quality
      local qualityTrain = CommonDefine.QualityTrainValue[quality] or 0
      local qualityIndex = CommonDefine.TrainIndex.TrinketQuality
      qualityTrain = qualityTrain * (trainRates[qualityIndex] or 1)
      local levelIndex = CommonDefine.TrainIndex.TrinketLevel
      local levelTrain = itemData.level * (trainRates[levelIndex] or 1)
      local attrNumIndex = CommonDefine.TrainIndex.TrinketAttrNum
      local trinketsAttrs = itemData.attrs or {}
      local valIndex = 0
      for _, v in pairs(trinketsAttrs) do
        valIndex = valIndex + v.valIndex
        if 1 ~= v.index then
          valIndex = valIndex + 1
        end
      end
      local attrTrain = math.ceil(valIndex / 2) * (trainRates[attrNumIndex] or 1)
      trainValue = trainValue + qualityTrain + levelTrain + attrTrain
    end
  end
  local suitEffectCount = AwakerTrinketDataUtils.GetSuitEffectCount(awakerData, extraItemDataMap)
  local index = CommonDefine.TrainIndex.TrinketSuitEffectCount
  trainValue = trainValue + suitEffectCount * (trainRates[index] or 1)
  return trainValue
end

function AwakerDataUtils.GetAwakerSkillIds(tid, model)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  local ids = {}
  if awaker then
    for slot, v in pairs(awaker.skills) do
      ids[slot] = v.tid
    end
  end
  return ids
end

function AwakerDataUtils.UpdateSkill(tid, slot, data)
  local skill = AwakerDataUtils.GetSkillDataBySlot(tid, slot)
  if skill then
    if data.upNum then
      skill.upNum = data.upNum
    end
    if data.level then
      skill.level = skill.level + data.level
    end
  end
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  RedPointDataUtils.UpdateAwakerRed(awaker)
end

function AwakerDataUtils.UpdateFighting(tid, fighting)
  if not fighting or fighting <= 0 then
  end
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  if awaker then
    awaker.fighting = fighting
  end
end

function AwakerDataUtils.GetSkillDataBySlot(tid, slot)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  if awaker then
    return awaker.skills[slot]
  else
    return nil
  end
end

function AwakerDataUtils.GetDbgSkillIdBySlot(tid, slot)
  local skillData = AwakerDataUtils.GetSkillDataBySlot(tid, slot)
  if skillData then
    return skillData.tid
  end
end

function AwakerDataUtils.GetSkillSlotBySkillId(tid, skillId)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  if awaker then
    for slot, v in ipairs(awaker.skills or {}) do
      if v and v.tid == skillId then
        return slot
      end
    end
  else
    return -1
  end
end

function AwakerDataUtils.ReadStory(awakerTid, storyList)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker or not awaker.stories then
    return
  end
  local sendData = {}
  for _, v in pairs(storyList) do
    if awaker.stories[v] == CommonDefine.AwakerStoryVoiceState.Unlock then
      awaker.stories[v] = CommonDefine.AwakerStoryVoiceState.Read
      table.insert(sendData, v)
    end
  end
  if #sendData > 0 then
    ProtoManager.Instance:ReqServer("GameRequest", "OnReadStory", nil, nil, awakerTid, storyList)
  end
end

function AwakerDataUtils.ReadVoice(awakerTid, voiceList)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker or not awaker.voices then
    return
  end
  local sendData = {}
  for _, v in pairs(voiceList) do
    if awaker.voices[v] == CommonDefine.AwakerStoryVoiceState.Unlock then
      awaker.voices[v] = CommonDefine.AwakerStoryVoiceState.Read
      table.insert(sendData, v)
    end
  end
  if #sendData > 0 then
    ProtoManager.Instance:ReqServer("GameRequest", "OnHearVoice", nil, nil, awakerTid, sendData)
  end
end

function AwakerDataUtils.GetAwakerVoiceSound(voiceId)
  local voiceConfig = DT.Voice[voiceId]
  local awakerTid = voiceConfig.AwakerID
  local unlockSkinItem = AwakerDataUtils.GetVoiceUnlockSkinItem(voiceConfig)
  local resNum = AwakerSkinUtils.GetSkinResNum(unlockSkinItem, awakerTid)
  local soundEventName = string.format(CommonDefine.AwakerVoiceFormat.Play_VOC_Awaker, resNum, voiceConfig.AwakerVoiceResAffix)
  return soundEventName
end

function AwakerDataUtils.GetVoiceUnlockSkinItem(voiceCfg)
  local HaveSpecificItem = CommonDefine.TaskUnlockCondType.HaveSpecificItem
  local isUnlockByItem = voiceCfg.ConditionType == HaveSpecificItem or voiceCfg.ConditionType_1 == HaveSpecificItem
  local unlockItemTid = voiceCfg.ConditionType == HaveSpecificItem and (voiceCfg.ConditionPara or {})[2] or voiceCfg.ConditionType_1 == HaveSpecificItem and (voiceCfg.ConditionPara_1 or {})[2] or nil
  if isUnlockByItem and unlockItemTid and ItemDataUtils.GetItemType(unlockItemTid) == cd.ItemType.SkinItem then
    return unlockItemTid
  end
  return nil
end

function AwakerDataUtils.GetDBGCardLevel(cardTid)
  local config = DT.Skill[cardTid]
  if not config then
    return 1
  end
  local awakerTid = config.AwakerID
  if not awakerTid then
    return 1
  end
  local awaker = CopyAwakerDataUtils.GetBattleAwakerData(awakerTid)
  awaker = awaker or AwakerDataUtils.GetAwakerData(awakerTid)
  if nil == awaker or not awaker.skills then
    return 1
  end
  for _, v in ipairs(awaker.skills) do
    if v.tid == cardTid then
      return v.level
    end
  end
  return 1
end

function AwakerDataUtils.ShowSuccessEffect(binder, parent, showText, callback)
  local effectItem
  
  local function OnAnimEnd()
    if effectItem and effectItem.binder then
      effectItem.binder:teardown()
    end
    if callback then
      callback()
    end
  end
  
  local itemData = {showText = showText, callback = OnAnimEnd}
  effectItem = binder:BindNewComponent(parent, AwakerFloatTextItem, AwakerFloatTextItemResource, itemData)
end

function AwakerDataUtils.GetPotencyConfig(tid)
  local config = DT.AwakerPotency[tid]
  if not config then
    Logger.Error("找不到启灵配置 => ", tid)
    return
  end
  return config
end

function AwakerDataUtils.InitAwakerPotencyMap()
  AwakerDataUtils.AwakerPotencyMap = {}
  local tableInsert = table.insert
  local awakerPotencyTempMap = {}
  for tid, config in pairs(DT.AwakerPotency) do
    if nil == config then
    else
      local potencyTempData = awakerPotencyTempMap[config.AwakerID]
      if not potencyTempData then
        potencyTempData = {
          potencyNum = 0,
          attrPotencyStartIndex = 0,
          sequenceMap = {},
          firstPotencyTid = nil
        }
        awakerPotencyTempMap[config.AwakerID] = potencyTempData
      end
      potencyTempData.potencyNum = potencyTempData.potencyNum + 1
      local sequenceInfo = potencyTempData.sequenceMap[tid]
      if not sequenceInfo then
        sequenceInfo = {}
        potencyTempData.sequenceMap[tid] = sequenceInfo
      end
      sequenceInfo.prev = config.FrontPotency or -1
      if config.FrontPotency then
        local otherSequence = potencyTempData.sequenceMap[config.FrontPotency]
        if not otherSequence then
          otherSequence = {}
          potencyTempData.sequenceMap[config.FrontPotency] = otherSequence
        end
        otherSequence.next = tid
      else
        potencyTempData.firstPotencyTid = tid
      end
    end
  end
  for awakerTid, potencyTempData in pairs(awakerPotencyTempMap) do
    if not potencyTempData then
    else
      local list = {}
      local listCount = potencyTempData.potencyNum
      for index = 1, listCount do
        local tid
        if 1 == index then
          if nil == potencyTempData.firstPotencyTid then
            Logger.Warn("唤醒体 %s 缺少初始启灵点配置", tostring(awakerTid))
            goto lbl_144
          end
          tid = potencyTempData.firstPotencyTid
        elseif index > 1 then
          local prevTid = list[index - 1].tid
          if not potencyTempData.sequenceMap or nil == table.next(potencyTempData.sequenceMap) then
            Logger.Warn("唤醒体 %s 缺少启灵顺序索引表数据", tostring(awakerTid))
            goto lbl_144
          end
          tid = potencyTempData.sequenceMap[prevTid].next
        end
        if not tid then
          Logger.Warn("唤醒体 %s 获取第%s个启灵点配置id异常", tostring(awakerTid), index)
        else
          tableInsert(list, {tid = tid, index = index})
        end
      end
      AwakerDataUtils.AwakerPotencyMap[awakerTid] = list
    end
    ::lbl_144::
  end
end

function AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  if not awakerTid then
    return {}
  end
  if not AwakerDataUtils.AwakerPotencyMap then
    AwakerDataUtils.InitAwakerPotencyMap()
  end
  return AwakerDataUtils.AwakerPotencyMap[awakerTid] or {}
end

function AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, potency)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    return 0
  end
  if awakerData.potencyLevel then
    return awakerData.potencyLevel
  end
  if not potency then
    return 0
  end
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  local potencyIndex = 0
  for _, potencyData in ipairs(potencyList) do
    if potencyData.tid == potency then
      potencyIndex = potencyData.index
      break
    end
  end
  return potencyIndex
end

function AwakerDataUtils.GetAwakerPotencyLevel(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData or not awakerData.potencyLevel then
    return 0
  end
  return awakerData.potencyLevel
end

function AwakerDataUtils.GetAwakerAttrPotencyStartIndex(awakerTid)
  if not awakerTid then
    return 0
  end
  local tmp = AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  local startAttrPotencyData
  for _, potencyData in ipairs(tmp) do
    local potencyConfig = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
    if potencyConfig and potencyConfig.PotencyType == PotencyType.Attr_Promote then
      startAttrPotencyData = potencyData
      break
    end
  end
  return startAttrPotencyData and startAttrPotencyData.index or 0
end

function AwakerDataUtils.GetAwakerPassivePotencyActiveNum(awakerTid)
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return 0
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData.potency then
    return 0
  end
  local currActivePotencyIndex = AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, awakerData.potency)
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  local activeNum = 0
  for _, potencyData in ipairs(potencyList) do
    if potencyData and currActivePotencyIndex >= potencyData.index then
      local config = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
      if config and config.PotencyType == PotencyType.PassiveSkill then
        activeNum = activeNum + 1
      end
    end
  end
  return activeNum
end

function AwakerDataUtils.GetAwakerPassivePotencyMaxNum(awakerTid)
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  local maxNum = 0
  for _, potencyData in ipairs(potencyList) do
    local config = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
    if config and config.PotencyType == PotencyType.PassiveSkill then
      maxNum = maxNum + 1
    end
  end
  return maxNum
end

function AwakerDataUtils.GetAwakerAttrPotencyActiveNum(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local attrPotencyStartIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(awakerTid)
  if awakerData.potencyLevel then
    return awakerData.potencyLevel - attrPotencyStartIndex + 1
  end
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return 0
  end
  if not awakerData.potency then
    return 0
  end
  local currActivePotencyIndex = AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, awakerData.potency)
  if not currActivePotencyIndex then
    return 0
  end
  local attrPotencyActiveNum = currActivePotencyIndex - attrPotencyStartIndex + 1
  if attrPotencyActiveNum < 0 then
    attrPotencyActiveNum = 0
  end
  return attrPotencyActiveNum
end

function AwakerDataUtils.GetAwakerAttrPotencyMaxNum(awakerTid)
  local attrPotencyNum = 0
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  if potencyList then
    for _, potencyData in ipairs(potencyList) do
      if potencyData then
        local config = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
        if config and config.PotencyType == PotencyType.Attr_Promote then
          attrPotencyNum = attrPotencyNum + 1
        end
      end
    end
  end
  return attrPotencyNum
end

function AwakerDataUtils.GetPotencyTypeName(potencyTid)
  local config = AwakerDataUtils.GetPotencyConfig(potencyTid)
  if not config then
    return
  end
  local potencyType = config.PotencyType
  if not potencyType then
    return
  end
  local commonIdConfig = DT.CommonID[potencyType]
  return commonIdConfig and commonIdConfig.Desc and LT.Text(commonIdConfig.Desc)
end

function AwakerDataUtils.GetPotencyAddAttrs(awakerTid, targetPotencyTid)
  local attrs = {}
  if not (targetPotencyTid and 0 ~= targetPotencyTid and awakerTid) or 0 == awakerTid then
    return attrs
  end
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  local startIndex = AwakerDataUtils.GetAwakerAttrPotencyStartIndex(awakerTid)
  local endIndex
  for idx, potencyData in ipairs(potencyList) do
    if not potencyData then
    else
      local config = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
      if config.EffectType ~= AwakerPotencyEffectType.Attr_Promote then
      elseif potencyData.tid == targetPotencyTid then
        endIndex = idx
      end
    end
  end
  if not startIndex or not endIndex then
    return attrs
  end
  if endIndex > #potencyList then
    endIndex = #potencyList
  end
  if startIndex > #potencyList then
    startIndex = #potencyList
  end
  local tableInsert = table.insert
  local attrsMap = {}
  for i = startIndex, endIndex do
    local potencyData = potencyList[i]
    if not potencyData then
    else
      local config = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
      if not config then
      else
        for j = 1, #config.Effect, 2 do
          if j >= #config.Effect then
            break
          end
          local attrTid = config.Effect[j]
          local addVal = config.Effect[j + 1]
          if attrTid and addVal then
            local attrIndex = attrsMap[attrTid]
            local attrConfig = DT.ActorAttrType[attrTid]
            if not attrIndex then
              tableInsert(attrs, {
                tid = attrTid,
                type = attrConfig.Name,
                count = addVal,
                name = LT.Text(attrConfig.Text),
                isPercent = attrConfig.Percentage
              })
              attrsMap[attrTid] = #attrs
            else
              attrs[attrIndex].count = attrs[attrIndex].count + addVal
            end
          end
        end
      end
    end
  end
  return attrs
end

function AwakerDataUtils.GetPotencyDesc(awakerTid, potency, mode, skillModel)
  if not potency then
    return
  end
  local config = DT.AwakerPotency[potency]
  if config.EffectType == AwakerPotencyEffectType.Attr_Promote and (not config.EffectType1 or not table.contains({
    AwakerPotencyEffectType.UtlSkill_Promote,
    AwakerPotencyEffectType.LevelLimit_Promote
  }, config.EffectType1)) then
    return ""
  end
  local awakerData
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    awakerData = {tid = awakerTid, level = 1}
  else
    awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  end
  local desc = SkillUtils.GetAwakerPotencyDesc(awakerData, potency, skillModel)
  return desc
end

function AwakerDataUtils.GetAwakerStar(tid)
  local awakerData = AwakerDataUtils.GetAwakerData(tid)
  if not awakerData then
    return 0
  end
  do return math.floor end
  return math.floor, awakerData.potency / 3
end

function AwakerDataUtils.IsAwakerPotencyMax(tid)
  local awakerData = AwakerDataUtils.GetAwakerData(tid)
  if not awakerData then
    return false
  end
  if not tid then
    return false
  end
  local currPotencyIndex = AwakerDataUtils.GetAwakerPotencyIndex(tid, awakerData.potency)
  return currPotencyIndex >= AwakerDataUtils.GetMaxPotencyIndex(tid)
end

function AwakerDataUtils.GetMaxPotencyIndex(tid)
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(tid)
  return potencyList and #potencyList or 0
end

function AwakerDataUtils.GetPotencyEffectCfgs(tid, potency, mode)
  if not tid or not potency then
    return
  end
  local config = DT.AwakerPotency[tid]
  if not config then
    Logger.Error("找不到启灵配置 => ", tid)
    return
  end
  local modeStr = ""
  if mode then
    modeStr = mode == CommonDefine.AwakerSkillMode.DBG and "" or "RPG"
  end
  local key = modeStr .. "PotencyEffect" .. potency
  local list = config[key]
  if not list or #list < 2 then
    return
  end
  local isSpecialLv = false
  for _, lv in ipairs(AwakerDataUtils.SpecialPotencyLvs) do
    if lv == potency then
      isSpecialLv = true
      break
    end
  end
  local mathFloor = math.floor
  local tableInsert = table.insert
  local _effectType = AwakerDataUtils.PotencyEffectType.Attr
  local result = {}
  local addNum = isSpecialLv and 3 or 2
  for i = 1, #list, addNum do
    if i + 1 > #list then
      break
    end
    local typeId = list[i]
    local val = list[i + 1]
    local extraVal
    if typeId and val then
      if isSpecialLv then
        _effectType = mathFloor(typeId / 2 + 0.5)
        extraVal = #list >= i + 2 and list[i + 2] or nil
      end
      tableInsert(result, {
        tid = typeId,
        value = val,
        effectType = _effectType,
        extraValue = extraVal
      })
    end
  end
  return result
end

function AwakerDataUtils.GetPotencyCostNum(potencyIndex)
  if not potencyIndex then
    return 0
  end
  local costNumList = DT.GetOriginalConstant("AwakerPotencyUpgradeConsumeNum")
  if potencyIndex > #costNumList then
    Logger.Warn("启灵序列大于启灵消耗数量列表")
    return 0
  end
  return costNumList[potencyIndex]
end

function AwakerDataUtils.HavePotencyCanUpgrade(awaker)
  if not awaker then
    return
  end
  if AwakerDataUtils.IsAwakerPotencyMax(awaker.tid) then
    return
  end
  local costItmTid = DT.AwakerConfig[awaker.tid].AwakerSpecialItem
  local currNum = ItemDataUtils.GetItemNum(costItmTid)
  local potencyIndex = AwakerDataUtils.GetAwakerPotencyIndex(awaker.tid, awaker.potency)
  local costNum = AwakerDataUtils.GetPotencyCostNum(potencyIndex + 1)
  return currNum >= costNum
end

function AwakerDataUtils.GetSortedAttrIds(ShowType)
  local attrNames = {}
  for id, cfg in pairs(DT.ActorAttrType) do
    if cfg[ShowType] then
      table.insert(attrNames, id)
    end
  end
  table.sort(attrNames, function(a, b)
    local cfgA = DT.ActorAttrType[a]
    local cfgB = DT.ActorAttrType[b]
    if cfgA.AttributeSort and cfgB.AttributeSort then
      return cfgA.AttributeSort < cfgB.AttributeSort
    end
    return a < b
  end)
  return attrNames
end

function AwakerDataUtils.GetMaxSkillLv()
  if not AwakerDataUtils.SkillMaxLevel then
    AwakerDataUtils.SkillMaxLevel = DT.GetConstant("AwakerSkillUpperLevel")
  end
  return AwakerDataUtils.SkillMaxLevel
end

local INDEX_STR_MAP = {
  [1] = "First",
  [2] = "Second",
  [3] = "Third",
  [4] = "Fourth"
}

function AwakerDataUtils.GetSkillUpgradeCostItem(tid, skillTid, skillLv)
  local ret = {}
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  if not config then
    return ret
  end
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awaker)
  local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awaker)
  local skillCfg = DT.Skill[skillTid]
  local skillTypes = BattleSkillUtils.GetSkillType(skillCfg, breakSkillLevel, potencyLevel)
  local AwakerSkillType = CommonDefine.AwakerSkillType
  local maxLv = AwakerDataUtils.GetMaxSkillLv()
  if skillLv >= maxLv then
    return ret
  end
  local costNumRatio = 1
  if skillTypes[1] == AwakerSkillType.Ulti_Skill then
    costNumRatio = DT.GetConstant("AwakerExSkillUpgrade_ConsumeTimes")
  end
  local costItemGroup = AwakerSkillUpgradeUtils.GetSkillUpgradeCostItemGroup(tid, skillLv, skillCfg.Slot)
  for _, info in ipairs(costItemGroup) do
    table.insert(ret, {
      tid = info.tid,
      num = info.num * costNumRatio
    })
  end
  return ret
end

function AwakerDataUtils.GetSkillUpgradeCoinCost(tid, skillTid, skillLv)
  local coinTid = DT.GetConstant("GoldItemTid")
  local ret = {tid = coinTid, num = 0}
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  local _, potencyLevel = AwakerDataUtils.GetBreakAndPotencyLevel(awaker)
  local breakSkillLevel = AwakerDataUtils.GetBreakSkillLevel(awaker)
  local skillCfg = DT.Skill[skillTid]
  assert(skillCfg, string.format("skillCfg is nil, skillTid = %d, awakerTid = %d", skillTid, tid))
  local skillTypes = BattleSkillUtils.GetSkillType(skillCfg, breakSkillLevel, potencyLevel)
  local maxLv = AwakerDataUtils.GetMaxSkillLv()
  if skillLv >= maxLv then
    return ret
  end
  local costNumRatio = 1
  assert(skillTypes, string.format("skillTypes is nil, skillCfg.Name = %s", skillCfg.Name))
  if skillTypes[1] == AwakerSkillType.Ulti_Skill then
    costNumRatio = DT.GetConstant("AwakerExSkillUpgrade_ConsumeTimes")
  end
  local costTid, costNum = AwakerSkillUpgradeUtils.GetSkillUpgradeCostCoinGroup(tid, skillLv, skillCfg.Slot)
  costNum = costNum * costNumRatio
  ret.num = costNum
  ret.tid = costTid
  return ret
end

function AwakerDataUtils.GetSkillData(awakerTid, slot)
  if not awakerTid or not slot then
    return
  end
  local data = AwakerDataUtils.GetAwakerData(awakerTid)
  if not data or not data.skills then
    return
  end
  local skill
  for _, skillData in pairs(data.skills) do
    if skillData.slot == slot then
      skill = skillData
      break
    end
  end
  return skill
end

function AwakerDataUtils.GetSkillLevel(skillData)
  return skillData.level
end

function AwakerDataUtils.GetSkillSlotLevel(awakerTid, targetSlot)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not (awaker and targetSlot) or not table.next(AwakerDataUtils.GetMockAwakerMap()) and not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return 1
  end
  local slotData
  for slot, _slotData in ipairs(awaker.skills) do
    if slot and slot == targetSlot then
      slotData = _slotData
      break
    end
  end
  return slotData and slotData.upNum and slotData.upNum + 1 or 1
end

function AwakerDataUtils.IsSlotCanUpgrade(awakerData, targetSlot)
  if not awakerData or not awakerData.skills then
    return false
  end
  if not targetSlot then
    return false
  end
  for slot, slotData in ipairs(awakerData.skills) do
    if slot ~= targetSlot then
    else
      local config = DT.AwakerConfig[awakerData.tid]
      if not config then
      elseif not DT.Skill[slotData.tid] then
      else
        local level = AwakerDataUtils.GetSkillSlotLevel(awakerData.tid, targetSlot)
        local maxSkillLv = AwakerDataUtils.GetMaxSkillLv()
        if level >= maxSkillLv or not AwakerDataUtils.CheckSkillLevelUpUnlockCondition(level) then
          return false
        end
        local breakthroughLevelNeed = AwakerDataUtils.GetSkillLevelUpBreakthroughNeed(level)
        local breakthroughLevel = awakerData.currBreakthroughStar or 0
        if level >= maxSkillLv or breakthroughLevelNeed > breakthroughLevel then
          return false
        end
        local coinCost = AwakerDataUtils.GetSkillUpgradeCoinCost(awakerData.tid, slotData.tid, level)
        if coinCost and ItemDataUtils.GetItemNum(coinCost.tid) < coinCost.num then
          return false
        end
        local costItemEnough = true
        local costItemList = AwakerDataUtils.GetSkillUpgradeCostItem(awakerData.tid, slotData.tid, level)
        for _, data in pairs(costItemList) do
          local needNum = data.num
          local item = ItemDataUtils.GetItemByTid(data.tid)
          local ownedNum = item and item.num or 0
          if needNum > ownedNum then
            return ItemAlchemyUtils.OpenUpgradeViewWithItemList(costItemList, true)
          end
        end
        if #costItemList <= 0 then
          costItemEnough = false
        end
        if costItemEnough then
          return true
        end
      end
    end
  end
  return false
end

function AwakerDataUtils.GetSkillLevelUpBreakthroughNeed(slotLevel)
  if not slotLevel then
    return
  end
  local breakthroughLvNeed = DT.GetOriginalConstant("SkillUpgradeRequiredBreakthroughLevelCondition")
  if slotLevel > #breakthroughLvNeed then
    Logger.Info(string.format("注意 ===> 当前技能槽位等级(%d)大于等级需求配置最大值", slotLevel))
    slotLevel = #breakthroughLvNeed
  end
  local lvNeed = tonumber(breakthroughLvNeed[slotLevel])
  return lvNeed
end

function AwakerDataUtils.CheckSkillLevelUpUnlockCondition(curLevel, showtips)
  local nextLevel = curLevel + 1
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.AwakerSkillLevel, nextLevel)
  if showtips and not unlocked then
    Alert.ShowStr(AwakerDataUtils.GetSkillLevelUplockConditionTips(curLevel))
  end
  return unlocked
end

function AwakerDataUtils.GetSkillLevelUplockConditionTips(curLevel)
  local nextLevel = curLevel + 1
  do return PlayerDataUtils.GetFeatureLogicUnlockTips, CommonDefine.FeatureId.AwakerSkillLevel end
  return PlayerDataUtils.GetFeatureLogicUnlockTips, CommonDefine.FeatureId.AwakerSkillLevel, nextLevel
end

function AwakerDataUtils.GetSchoolSortValue(tid)
  if not tid then
    return 0
  end
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(tid)
  if not awakerConfig then
    return 0
  end
  local schoolConfig = DT.SchoolConfig[awakerConfig.School]
  return schoolConfig and schoolConfig.Order or 0
end

function AwakerDataUtils.GetAwakerSchool(tid)
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(tid)
  if not awakerConfig then
    return 0
  end
  return awakerConfig.School
end

function AwakerDataUtils.GetAwakerSchoolIcon(tid)
  local school = AwakerDataUtils.GetAwakerSchool(tid)
  do return AwakerDataUtils.GetSchoolIcon end
  return AwakerDataUtils.GetSchoolIcon, school
end

function AwakerDataUtils.GetAwakerSortId(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  if not config then
    return 0
  end
  return config.SortID or 0
end

function AwakerDataUtils.GetQualitySort(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  local qualitySort = config and config.Quality and QualitySortValueTable[config.Quality]
  return qualitySort
end

function AwakerDataUtils.GetSortTypeTitle(sortType)
  if not sortType then
    return ""
  end
  local tb = {
    [CommonDefine.AwakerSortType.Level] = "RoleInterface_SortTypeBtn_Level",
    [CommonDefine.AwakerSortType.Quality] = "RoleInterface_SortTypeBtn_Star",
    [CommonDefine.AwakerSortType.Potency] = "RoleInterface_SortTypeBtn_Potency",
    [CommonDefine.AwakerSortType.Hp] = "RoleInterface_SortTypeBtn_Hp",
    [CommonDefine.AwakerSortType.Atk] = "RoleInterface_SortTypeBtn_Atk",
    [CommonDefine.AwakerSortType.Def] = "RoleInterface_SortTypeBtn_Def",
    [CommonDefine.AwakerSortType.Favorability] = "RoleInterface_SortTypeBtn_Favorability"
  }
  return LT.Text(tb[sortType]) or ""
end

function AwakerDataUtils.GetSortTypeTagContent(sortType, awakerData, awakerLevel)
  if not sortType or not awakerData then
    return
  end
  local tb = {
    [CommonDefine.AwakerSortType.Level] = "RoleInterfaceSort_Str_Level",
    [CommonDefine.AwakerSortType.Quality] = "RoleInterfaceSort_Str_Level",
    [CommonDefine.AwakerSortType.Potency] = "RoleInterfaceSort_Str_Level",
    [CommonDefine.AwakerSortType.Hp] = "RoleInterfaceSort_Str_Hp",
    [CommonDefine.AwakerSortType.Atk] = "RoleInterfaceSort_Str_Atk",
    [CommonDefine.AwakerSortType.Def] = "RoleInterfaceSort_Str_Def",
    [CommonDefine.AwakerSortType.Favorability] = "RoleInterfaceSort_Str_Favorability"
  }
  local key = tb[sortType]
  if not key then
    return ""
  end
  if awakerLevel then
    local calcAttrName = {
      "atk",
      "def",
      "physique"
    }
    for _, v in pairs(calcAttrName) do
      local val_1 = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(awakerData.tid, awakerLevel, v, awakerData)
      local val_lv = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(awakerData.tid, awakerData.level, v, awakerData)
      awakerData.attrs[v] = awakerData.attrs[v] + val_1 - val_lv
    end
  end
  local content = ""
  if sortType == CommonDefine.AwakerSortType.Combat then
    content = LT.Textf(key, awakerData.fighting)
  elseif sortType == CommonDefine.AwakerSortType.Level then
    content = LT.Textf(key, awakerLevel and awakerLevel or awakerData.level)
  elseif sortType == CommonDefine.AwakerSortType.Potency then
    content = LT.Textf(key, awakerLevel and awakerLevel or awakerData.level)
  elseif sortType == CommonDefine.AwakerSortType.Quality then
    content = LT.Textf(key, awakerLevel and awakerLevel or awakerData.level)
  elseif sortType == CommonDefine.AwakerSortType.Hp then
    if awakerData.attrs then
      local perVal = 0
      if awakerData.attrs.physique_per then
        perVal = awakerData.attrs.physique and perVal / 100 or 0
      end
      local hpVal = AttrUtils.GetAwakerFinalAttr(awakerData.attrs.physique, perVal)
      content = LT.Textf(key, hpVal)
    end
  elseif sortType == CommonDefine.AwakerSortType.Atk then
    if awakerData.attrs then
      local perVal = awakerData.attrs.atk_per and awakerData.attrs.atk_per / 100 or 0
      local atkVal = AttrUtils.GetAwakerFinalAttr(awakerData.attrs.atk, perVal)
      content = LT.Textf(key, atkVal)
    end
  elseif sortType == CommonDefine.AwakerSortType.Def then
    if awakerData.attrs then
      local perVal = awakerData.attrs.def_per and awakerData.attrs.def_per / 100 or 0
      local defVal = AttrUtils.GetAwakerFinalAttr(awakerData.attrs.def, perVal)
      content = LT.Textf(key, defVal)
    end
  elseif sortType == CommonDefine.AwakerSortType.Favorability then
    content = LT.Textf(key, awakerData.likeLevel and awakerData.likeLevel or 0)
  end
  return content
end

function AwakerDataUtils.Sort(list, order, sortType)
  if not list then
    return
  end
  if #list <= 1 then
    return list
  end
  local func = AwakerDataUtils.awakerSortFuncMap[sortType]
  if not func then
    Logger.Info("找不到排序函数: %s", sortType)
    return list
  end
  local listCollect = {}
  local listNotCollect = {}
  local listNotOwn = {}
  for i = 1, #list do
    if list[i].isCollect then
      tableInsert(listCollect, list[i])
    elseif list[i].state == CommonDefine.AwakerState.Owned then
      tableInsert(listNotCollect, list[i])
    else
      tableInsert(listNotOwn, list[i])
    end
  end
  
  local function sortFunc(a, b)
    if a.state == b.state then
      if a.state == CommonDefine.AwakerState.NotOwn then
        do return AwakerDataUtils.CommonSort, a end
        return AwakerDataUtils.CommonSort, a, b, nil
      end
      do return func, a, b end
      return func, a, b, order
    end
    do return AwakerDataUtils.SortByState, a end
    return AwakerDataUtils.SortByState, a, b, order
  end
  
  if 0 == #listCollect then
    table.sort(list, sortFunc)
    return list
  else
    table.sort(listCollect, sortFunc)
    table.sort(listNotCollect, sortFunc)
    table.sort(listNotOwn, sortFunc)
    for i = 1, #listNotCollect do
      table.insert(listCollect, listNotCollect[i])
    end
    for i = 1, #listNotOwn do
      table.insert(listCollect, listNotOwn[i])
    end
    return listCollect
  end
end

function AwakerDataUtils.Compare(a, b, order)
  a = a or 0
  b = b or 0
  if order == CommonDefine.SortOrder.Ascend then
    return a < b
  end
  return a > b
end

function AwakerDataUtils.SortByState(a, b)
  do return AwakerDataUtils.Compare, a.state, b.state end
  return AwakerDataUtils.Compare, a.state, b.state, CommonDefine.SortOrder.Descend
end

function AwakerDataUtils.SortBySortId(a, b, order)
  local sortValA = DT.AwakerConfig[a.tid].SortID
  local sortValB = DT.AwakerConfig[b.tid].SortID
  do return AwakerDataUtils.Compare, sortValA, sortValB end
  return AwakerDataUtils.Compare, sortValA, sortValB, order
end

function AwakerDataUtils.CommonSort(a, b)
  local defaultOrder = CommonDefine.SortOrder.Descend
  local tidA = math.abs(a.tid)
  local tidB = math.abs(b.tid)
  if a.level == b.level then
    local default = 1
    local qualitySortA = AwakerDataUtils.GetQualitySort(tidA) or default
    local qualitySortB = AwakerDataUtils.GetQualitySort(tidB) or default
    if qualitySortA == qualitySortB then
      local schoolSortA = AwakerDataUtils.GetSchoolSortValue(tidA)
      local schoolSortB = AwakerDataUtils.GetSchoolSortValue(tidB)
      if schoolSortA == schoolSortB then
        local aSortId = AwakerDataUtils.GetAwakerSortId(tidA)
        local bSortId = AwakerDataUtils.GetAwakerSortId(tidB)
        do return AwakerDataUtils.Compare, aSortId, bSortId end
        return AwakerDataUtils.Compare, aSortId, bSortId, CommonDefine.SortOrder.Ascend
      else
        do return AwakerDataUtils.Compare, schoolSortA, schoolSortB end
        return AwakerDataUtils.Compare, schoolSortA, schoolSortB, CommonDefine.SortOrder.Ascend, bSortId, CommonDefine.SortOrder.Ascend
      end
    else
      do return AwakerDataUtils.Compare, qualitySortA, qualitySortB end
      return AwakerDataUtils.Compare, qualitySortA, qualitySortB, defaultOrder, schoolSortB, CommonDefine.SortOrder.Ascend, bSortId, CommonDefine.SortOrder.Ascend
    end
  end
  do return AwakerDataUtils.Compare, a.level, b.level end
  return AwakerDataUtils.Compare, a.level, b.level, defaultOrder, qualitySortA, qualitySortB, defaultOrder, schoolSortB, CommonDefine.SortOrder.Ascend, bSortId, CommonDefine.SortOrder.Ascend
end

function AwakerDataUtils.SortByCombat(a, b, order)
  if a.fighting == b.fighting then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, CommonDefine.SortOrder.Descend
  end
  do return AwakerDataUtils.Compare, a.fighting, b.fighting end
  return AwakerDataUtils.Compare, a.fighting, b.fighting, order
end

function AwakerDataUtils.SortByLevel(a, b, order)
  if a.level == b.level then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order
  end
  do return AwakerDataUtils.Compare, a.level, b.level end
  return AwakerDataUtils.Compare, a.level, b.level, order
end

function AwakerDataUtils.SortByPotencyLv(a, b, order)
  if a.potencyLevel == b.potencyLevel then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order
  end
  do return AwakerDataUtils.Compare, a.potencyLevel, b.potencyLevel end
  return AwakerDataUtils.Compare, a.potencyLevel, b.potencyLevel, order
end

function AwakerDataUtils.SortByQuality(a, b, order)
  local default = order == SortOrder.Descend and 1 or 999
  local qualitySortA = AwakerDataUtils.GetQualitySort(math.abs(a.tid)) or default
  local qualitySortB = AwakerDataUtils.GetQualitySort(math.abs(b.tid)) or default
  if qualitySortA == qualitySortB then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order
  end
  do return AwakerDataUtils.Compare, qualitySortA, qualitySortB end
  return AwakerDataUtils.Compare, qualitySortA, qualitySortB, order
end

function AwakerDataUtils.SortByPotency(a, b, order)
  if a.potency == b.potency then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order, nil, nil
  end
  local potencyIndexA = AwakerDataUtils.GetAwakerPotencyIndex(a.tid, a.potency)
  local potencyIndexB = AwakerDataUtils.GetAwakerPotencyIndex(b.tid, b.potency)
  if potencyIndexA == potencyIndexB then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order
  end
  do return AwakerDataUtils.Compare, potencyIndexA, potencyIndexB end
  return AwakerDataUtils.Compare, potencyIndexA, potencyIndexB, order
end

function AwakerDataUtils.SortByHp(a, b, order)
  local perValA = a.attrs.physique_per and a.attrs.physique_per / 100
  local perValB = b.attrs.physique_per and b.attrs.physique_per / 100
  local hpA = AttrUtils.GetAwakerFinalAttr(a.attrs.physique, perValA)
  local hpB = AttrUtils.GetAwakerFinalAttr(b.attrs.physique, perValB)
  if hpA == hpB then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order
  end
  do return AwakerDataUtils.Compare, hpA, hpB end
  return AwakerDataUtils.Compare, hpA, hpB, order
end

function AwakerDataUtils.SortByAtk(a, b, order)
  local perValA = a.attrs.atk_per and a.attrs.atk_per / 100
  local perValB = b.attrs.atk_per and b.attrs.atk_per / 100
  local atkA = AttrUtils.GetAwakerFinalAttr(a.attrs.atk, perValA)
  local atkB = AttrUtils.GetAwakerFinalAttr(b.attrs.atk, perValB)
  if atkA == atkB then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order
  end
  do return AwakerDataUtils.Compare, atkA, atkB end
  return AwakerDataUtils.Compare, atkA, atkB, order
end

function AwakerDataUtils.SortByDef(a, b, order)
  local perValA = a.attrs.def_per and a.attrs.def_per / 100
  local perValB = b.attrs.def_per and b.attrs.def_per / 100
  local defA = AttrUtils.GetAwakerFinalAttr(a.attrs.def, perValA)
  local defB = AttrUtils.GetAwakerFinalAttr(b.attrs.def, perValB)
  if defA == defB then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order
  end
  do return AwakerDataUtils.Compare, defA, defB end
  return AwakerDataUtils.Compare, defA, defB, order
end

function AwakerDataUtils.SortByFavorability(a, b, order)
  if a.likeLevel == b.likeLevel then
    if a.like == b.like then
      do return AwakerDataUtils.CommonSort, a, b end
      return AwakerDataUtils.CommonSort, a, b, order
    end
    do return AwakerDataUtils.Compare, a.like, b.like end
    return AwakerDataUtils.Compare, a.like, b.like, order
  end
  do return AwakerDataUtils.Compare, a.likeLevel, b.likeLevel end
  return AwakerDataUtils.Compare, a.likeLevel, b.likeLevel, order
end

function AwakerDataUtils.SortByInterest(a, b, order)
  if a.interest == b.interest then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order
  end
  if order == CommonDefine.SortOrder.Ascend then
    return not a.interest
  end
  return a.interest
end

function AwakerDataUtils.SortByPosType(a, b, order)
  local typeA = DT.AwakerConfig[a.tid].Type
  local typeB = DT.AwakerConfig[b.tid].Type
  if typeA == typeB then
    do return AwakerDataUtils.CommonSort, a, b end
    return AwakerDataUtils.CommonSort, a, b, order
  end
  do return AwakerDataUtils.Compare, typeA, typeB end
  return AwakerDataUtils.Compare, typeA, typeB, order
end

function AwakerDataUtils.GetAwakerDiffAttrMap(awakerData)
  if not awakerData or not AwakerDataUtils.HasOwnedAwaker(awakerData.tid) then
    return {}
  end
  local finalValMap = {}
  for _, data in pairs(awakerData.clientAttrs) do
    if not data then
    else
      finalValMap[data.type] = data.count
    end
  end
  local map = {}
  for attrName, attrValue in pairs(finalValMap) do
    local baseValue = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(awakerData.tid, awakerData.level, attrName, awakerData)
    local addValue = math.ceil(attrValue - baseValue)
    if addValue > 0 then
      map[attrName] = {baseValue = baseValue, addValue = addValue}
    end
  end
  return map
end

function AwakerDataUtils.GetAllSuitTids()
  local tableInsert = table.insert
  local tableSort = table.sort
  local tids = {
    AwakerDataUtils.AllSuit
  }
  for tid, _ in pairs(DT.TrinketSuitEffect) do
    tableInsert(tids, tid)
  end
  
  local function sortFunc(a, b)
    return a < b
  end
  
  tableSort(tids, sortFunc)
  return tids
end

function AwakerDataUtils.GetTrinketMainAttrValue(attrTid, level, quality)
  if not AwakerDataUtils.TrinketMainAttrValueCfgMap then
    AwakerDataUtils.InitTrinketMainAttrValueCfgMap()
  end
  if not (attrTid and level) or not quality then
    Logger.Info("[GetTrinketMainAttrValue]Error Parameter: attrTid=%d, level=%d, quality=%s ", attrTid, level, quality)
    return 0
  end
  local key = attrTid .. "_" .. level
  local tid = AwakerDataUtils.TrinketMainAttrValueCfgMap[key]
  if not tid then
    Logger.Info("找不到装备主属性等级配置id: attrTid=%d, level=%d", attrTid, level)
    return 0
  end
  local config = DT.TrinketMainAttrValue[tid]
  if not config then
    Logger.Info("找不到装备主属性等级配置: tid=%d", tid)
    return 0
  end
  local value = config[quality .. "Value"] or 0
  local attrType = DT.ActorAttrType[tid]
  if attrType then
    return (attrType.Equivalency or 0) * value
  end
  return value
end

function AwakerDataUtils.GetSchoolIcon(school)
  if not school then
    Logger.Error("Error : Can't find school => ", school, debug.traceback())
  end
  local schoolConfig = DT.SchoolConfig[school]
  return schoolConfig.Icon
end

function AwakerDataUtils.GetSchoolName(school)
  if not school then
    Logger.Error("Error : Can't find school => ", school, debug.traceback())
  end
  local schoolConfig = DT.SchoolConfig[school]
  do return LT.Text end
  return LT.Text, schoolConfig.Name, debug.traceback()
end

function AwakerDataUtils.GetSchoolSubplotCover(school)
  if not school then
    Logger.Error("Error : Can't find school => ", school, debug.traceback())
  end
  local schoolConfig = DT.SchoolConfig[school]
  return schoolConfig.SubplotCoverImage
end

function AwakerDataUtils.GetSchoolCfgByNameEn(nameEn)
  for _, cfg in pairs(DT.SchoolConfig) do
    if cfg.NameEn == nameEn then
      return cfg
    end
  end
  return nil
end

function AwakerDataUtils.GetSchoolIdByNameEn(nameEn)
  for _, cfg in pairs(DT.SchoolConfig) do
    if cfg.NameEn == nameEn then
      return cfg.ID
    end
  end
  return nil
end

function AwakerDataUtils.GetSchoolConfigTips(schoolId, isPve)
  local school = schoolId
  local schoolCfg = DT.SchoolConfig[school]
  local pveTips = schoolCfg.SchoolBattleTips or schoolCfg.SchoolTips
  if isPve then
    return pveTips
  end
  local pvpTips = schoolCfg.PVPSchoolBattleTips or pveTips
  return pvpTips
end

function AwakerDataUtils.ResolveSchoolCondText(fieldValue, parserEnv)
  if not fieldValue then
    return nil
  end
  if type(fieldValue) == "string" then
    return fieldValue
  end
  if type(fieldValue) == "table" then
    local cmdParser = BattleCmdParserClient(parserEnv or {})
    do return CmdParserUtils.GetCfgByCond, fieldValue end
    return CmdParserUtils.GetCfgByCond, fieldValue, cmdParser
  end
end

function AwakerDataUtils.GetSchoolTipsByField(schoolId, fieldName, schoolArgs, parserEnv)
  local schoolCfg = DT.SchoolConfig[schoolId]
  if not schoolCfg then
    return nil
  end
  local fieldValue = schoolCfg[fieldName]
  local desc = AwakerDataUtils.ResolveSchoolCondText(fieldValue, parserEnv)
  if not desc then
    return nil
  end
  do return AwakerDataUtils.ParseSchoolDescByArgs, desc end
  return AwakerDataUtils.ParseSchoolDescByArgs, desc, schoolArgs
end

function AwakerDataUtils.GetSchoolTips(schoolId, isPve, schoolArgs)
  local schoolTips = AwakerDataUtils.GetSchoolConfigTips(schoolId, isPve)
  local desc = AwakerDataUtils.ResolveSchoolCondText(schoolTips)
  if not desc then
    return nil
  end
  do return AwakerDataUtils.ParseSchoolDescByArgs, desc end
  return AwakerDataUtils.ParseSchoolDescByArgs, desc, schoolArgs
end

function AwakerDataUtils.ParseSchoolDescByArgs(desc, schoolArgs)
  local desc = LT.Text(desc)
  for valueStr in string.gmatch(desc, "%b[]") do
    valueStr = string.match(valueStr, "%[(.+)]")
    local index = tonumber(string.sub(valueStr, 4))
    local v = schoolArgs and schoolArgs[index] or 0
    desc = string.gsub(desc, "%b[]", v, 1)
  end
  return desc
end

function AwakerDataUtils.GetAwakerSchoolCounts(awakerTids)
  local schoolCounts = {}
  for _, awakerTid in pairs(awakerTids) do
    local awakerCfg = DT.AwakerConfig[awakerTid]
    if awakerCfg then
      local schoolId = awakerCfg.School
      schoolCounts[schoolId] = (schoolCounts[schoolId] or 0) + 1
    end
  end
  return schoolCounts
end

function AwakerDataUtils.GetAwakerTeamEffectSchool(awakerTids)
  local rst
  local chaosSchoolNum = 0
  local chaosSchoolId = AwakerDataUtils.GetSchoolIdByNameEn(CommonDefine.SchoolType.Chaos)
  for _, awakerTid in pairs(awakerTids) do
    local awakerCfg = DT.AwakerConfig[awakerTid]
    if not awakerCfg then
    else
      local schoolId = awakerCfg.School
      if DT.SchoolConfig[schoolId].NameEn == CommonDefine.SchoolType.Chaos then
        chaosSchoolNum = chaosSchoolNum + 1
      else
        rst = schoolId
      end
    end
  end
  if chaosSchoolNum == #awakerTids then
    rst = chaosSchoolId
  end
  return rst
end

function AwakerDataUtils.GetAwakerConfig(tid)
  if not tid or 0 == tid then
    return nil
  end
  assert(type(tid) == "number", "Error : AwakerDataUtils.GetAwakerConfigItem param error")
  tid = math.abs(tid)
  local config = DT.AwakerConfig[tid]
  if not config then
    Logger.Error("Error : Can't find cfg => ", tid, debug.traceback())
  end
  return config
end

function AwakerDataUtils.IsAwakerTid(tid)
  return tid and DT.AwakerConfig[tid] ~= nil
end

function AwakerDataUtils.GetAwakerConfigByField(field, tid)
  local cfg = AwakerDataUtils.GetAwakerConfig(tid)
  if not cfg then
    return nil
  end
  return cfg[field]
end

function AwakerDataUtils.GetAwakerName(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  return config and LT.Text(config.Name) or ""
end

function AwakerDataUtils.GetAwakerIntroduction(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  if nil == config then
    return ""
  end
  return config.AwakerIntroduction and LT.Text(config.AwakerIntroduction) or "AwakerIntroduction没有配置"
end

function AwakerDataUtils.GetAwakerTitle(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  return config and LT.Text(config.Title) or ""
end

function AwakerDataUtils.GetAwakerQualityImage(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  if not config then
    return
  end
  do return ItemDataUtils.GetQualityFramePathByQuality end
  return ItemDataUtils.GetQualityFramePathByQuality, config.Quality
end

function AwakerDataUtils.GetAwakerTeamFrame(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  if not config then
    return
  end
  do return ItemDataUtils.GetTeamFramePathByQuality end
  return ItemDataUtils.GetTeamFramePathByQuality, config.Quality
end

function AwakerDataUtils.GetAwakerQualityColor(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  if not config then
    return
  end
  return DT.ItemQuality[config.Quality].ItemQualityColor
end

function AwakerDataUtils.GetAwakerQualityIcon(awakerTid)
  local config = AwakerDataUtils.GetAwakerConfig(awakerTid)
  if not config then
    return
  end
  return CommonDefine.AwakerQualityIcon[config.Quality]
end

function AwakerDataUtils.GetAwakerDefaultBust(awakerTid)
  do return AwakerSkinUtils.GetAwakerDefaultFullHeadImg end
  return AwakerSkinUtils.GetAwakerDefaultFullHeadImg, awakerTid
end

function AwakerDataUtils.GetAwakerBust(awakerTid, skinId, isOthers)
  if skinId then
    if skinId == CommonDefine.DefaultSkinTid then
      do return AwakerDataUtils.GetAwakerDefaultBust end
      return AwakerDataUtils.GetAwakerDefaultBust, awakerTid, nil
    end
    do return AwakerSkinUtils.GetSkinFullHeadImg end
    return AwakerSkinUtils.GetSkinFullHeadImg, skinId, nil
  end
  if not isOthers then
    local dressedSkin = AwakerSkinUtils.GetAwakerDressedSkin(awakerTid)
    if dressedSkin then
      do return AwakerSkinUtils.GetSkinFullHeadImg end
      return AwakerSkinUtils.GetSkinFullHeadImg, dressedSkin
    end
  end
  do return AwakerDataUtils.GetAwakerDefaultBust end
  return AwakerDataUtils.GetAwakerDefaultBust, awakerTid, dressedSkin
end

function AwakerDataUtils.GetChipCount(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  local chipItemTid = config and config.AwakerSpecialItem
  if not chipItemTid then
    return 0
  end
  do return ItemDataUtils.GetItemNum end
  return ItemDataUtils.GetItemNum, chipItemTid
end

function AwakerDataUtils.GetDefaultPortraitNo(tid)
  local config = AwakerDataUtils.GetAwakerConfig(tid)
  return config and config.AwakerResNum
end

function AwakerDataUtils.GetAwakerResNum(tid, isOthers, curSkin)
  if not isOthers then
    local skinTid = AwakerSkinUtils.GetAwakerDressedSkin(tid)
    if skinTid and skinTid ~= CommonDefine.DefaultSkinTid then
      do return AwakerSkinUtils.GetSkinResNum end
      return AwakerSkinUtils.GetSkinResNum, skinTid
    end
  end
  if curSkin and curSkin ~= cd.DefaultSkinTid then
    do return AwakerSkinUtils.GetSkinResNum end
    return AwakerSkinUtils.GetSkinResNum, curSkin, skinTid
  end
  do return AwakerDataUtils.GetDefaultPortraitNo end
  return AwakerDataUtils.GetDefaultPortraitNo, tid, skinTid
end

function AwakerDataUtils.ReplaceMyAwakerSkinRes(resPath, awakerTid)
  local replaceResNo = AwakerDataUtils.GetAwakerResNum(awakerTid)
  do return AwakerDataUtils.ReplaceSkinRes, resPath, awakerTid end
  return AwakerDataUtils.ReplaceSkinRes, resPath, awakerTid, replaceResNo
end

function AwakerDataUtils.ReplaceSkinRes(resPath, awakerTid, replaceResNo)
  if not replaceResNo then
    return resPath
  end
  local defaultResNum = awakerTid and AwakerDataUtils.GetDefaultPortraitNo(awakerTid)
  if defaultResNum ~= replaceResNo then
    do return resPath.gsub, resPath, defaultResNum end
    return resPath.gsub, resPath, defaultResNum, replaceResNo
  end
  return resPath
end

function AwakerDataUtils.ReplaceSkinTidRes(resPath, awakerTid, skinTid)
  if not skinTid or skinTid == cd.DefaultSkinTid then
    return resPath
  end
  local defaultResNum = awakerTid and AwakerDataUtils.GetDefaultPortraitNo(awakerTid)
  local replaceResNo = AwakerSkinUtils.GetSkinResNum(skinTid)
  if defaultResNum ~= replaceResNo then
    do return resPath.gsub, resPath, defaultResNum end
    return resPath.gsub, resPath, defaultResNum, replaceResNo
  end
  return resPath
end

function AwakerDataUtils.GetPortraitByNo(portraitNo)
  local fileName = string.format("Portrait_Middle_Awaker_%s", portraitNo)
  return string.format("Portraits/Middle/%s.png", fileName), fileName
end

function AwakerDataUtils.GetEmojByNo(no, face)
  local fileName = string.format("Portrait_Middle_Awaker_%s_Face_%s", no, face)
  return string.format("Portraits/Middleface/%s.png", fileName), fileName
end

function AwakerDataUtils.GetLittleIcon(tid, isOthers, curSkin)
  local resNum
  if curSkin and curSkin ~= CommonDefine.DefaultSkinTid then
    resNum = AwakerSkinUtils.GetSkinResNum(curSkin, tid)
  else
    resNum = AwakerDataUtils.GetAwakerResNum(tid, isOthers)
  end
  do return string.format, "Portraits/Minihead/Portrait_Minihead_Awaker_%s.png" end
  return string.format, "Portraits/Minihead/Portrait_Minihead_Awaker_%s.png", resNum
end

function AwakerDataUtils.GetFullHeadIcon(tid, isOthers)
  local resNum = AwakerDataUtils.GetAwakerResNum(tid, isOthers)
  do return string.format, "Portraits/Fullhead/Portrait_Fullhead_Awaker_%s.png" end
  return string.format, "Portraits/Fullhead/Portrait_Fullhead_Awaker_%s.png", resNum
end

function AwakerDataUtils.GetCircleHeadIcon(tid)
  if not tid or 0 == tid then
    return ""
  end
  local config = DT.AwakerConfig[tid]
  assert(nil ~= config, "找不到唤醒体配置: " .. tostring(tid))
  do return AwakerDataUtils.ReplaceMyAwakerSkinRes, config.Circularhead end
  return AwakerDataUtils.ReplaceMyAwakerSkinRes, config.Circularhead, tid, tostring(tid), tid
end

function AwakerDataUtils.GetAttrIdByName(name)
  for tid, attrInfo in pairs(DT.ActorAttrType) do
    if attrInfo.Name == name then
      return tid
    end
  end
end

function AwakerDataUtils.GetAttrInfoByName(name)
  for _, attrInfo in pairs(DT.ActorAttrType) do
    if attrInfo.Name == name then
      return attrInfo
    end
  end
end

function AwakerDataUtils.GetAttrCnName(enName)
  for _, attrInfo in pairs(DT.ActorAttrType) do
    if attrInfo.Name == enName then
      return attrInfo.Text
    end
  end
end

function AwakerDataUtils.GetShowAttrIds()
  if DataCenter.awakerData.showAttrIds then
    return DataCenter.awakerData.showAttrIds
  end
  local keyName = "AwakerShow"
  local showAttrIds = {}
  local attrTypeMap = AttrUtils.GetAttrTypeMap()
  for _, typeTid in pairs(attrTypeMap) do
    if DT.ActorAttrType[typeTid][keyName] then
      table.insert(showAttrIds, typeTid)
    end
  end
  table.sort(showAttrIds, function(a, b)
    return DT.ActorAttrType[a].AttributeSort < DT.ActorAttrType[b].AttributeSort
  end)
  DataCenter.awakerData.showAttrIds = showAttrIds
  return showAttrIds
end

function AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(awakerTid, level, attrName, awakerData)
  local talentTid, talentLevel = AwakerDataUtils.GetAwakerAttrTalentTidAndLevel(awakerData)
  do return AwakerDataUtils.GetAwakerBaseAttrValue, awakerTid, level, attrName, talentTid end
  return AwakerDataUtils.GetAwakerBaseAttrValue, awakerTid, level, attrName, talentTid, talentLevel
end

function AwakerDataUtils.GetAwakerBaseAttrValue(awakerTid, level, attrName, talentTid, talentLevel)
  if not (awakerTid and level) or not attrName then
    Logger.Info("[GetAwakerBaseAttrValue] error params: awakerTid, level, attrType", awakerTid, level, attrName)
    return 0
  end
  local awakerCfg = DT.AwakerConfig[awakerTid]
  local baseValue
  if awakerCfg and awakerCfg[attrName] then
    baseValue = math.ceil(awakerCfg[attrName])
  else
    return 0
  end
  local fieldName
  if "atk" == attrName then
    fieldName = "AtkGrowthOfBaseAtk"
  elseif "def" == attrName then
    fieldName = "DefGrowthOfBaseDef"
  elseif "physique" == attrName then
    fieldName = "PhysiqueGrowthOfBasePhysique"
  else
    return baseValue
  end
  local upgradeCfg = AwakerDataUtils.GetUpgradeConfig(level, awakerCfg.Quality)
  if upgradeCfg and upgradeCfg[fieldName] then
    local talentAttrLv = AwakerDataUtils.GetTalentAttrLv(talentTid, talentLevel)
    local formula = upgradeCfg[fieldName]
    local mt = {
      __index = function(_, key)
        if "talent_attr_lv" == key then
          return talentAttrLv
        end
        if _G[key] then
          return _G[key]
        end
        return awakerCfg[key] or 0
      end
    }
    local fenv = {}
    setmetatable(fenv, mt)
    
    local function cmdFunc()
      do return (LoadFuncUtils.GetFunc(formula)) end
      return LoadFuncUtils.GetFunc(formula), fenv
    end
    
    local _, v = xpcall(cmdFunc, function(error)
      local err = string.format("获取唤醒体 %s 等级 %s 属性 %s 失败，公式 %s", awakerCfg.ID, level, awakerCfg, formula)
      Logger.Error(err, error)
    end)
    return v or baseValue
  end
  return baseValue
end

function AwakerDataUtils.GetAwakerShowAttrs(attrs)
  local ret = {}
  if attrs then
    local attrIds = AwakerDataUtils.GetShowAttrIds()
    for _, id in ipairs(attrIds) do
      local cfg = DT.ActorAttrType[id]
      local attrKey = cfg.Name
      local val = attrs[attrKey]
      local _attrDesc = AttrUtils.GetAttrDesc(id)
      table.insert(ret, {
        tid = id,
        type = cfg.Name,
        count = val,
        name = LT.Text(cfg.Text),
        isPercent = cfg.Percentage,
        attrDesc = _attrDesc
      })
    end
  end
  return ret
end

function AwakerDataUtils.Process2ShowAttrs(attrs)
  local ret = {}
  local attrTypeMap = AttrUtils.GetAttrTypeMap()
  for name, val in pairs(attrs) do
    local id = attrTypeMap[name]
    local cfg = DT.ActorAttrType[id]
    local _attrDesc = AttrUtils.GetAttrDesc(id)
    if name == bc.RoleProperty.AccountLvBattleCurve then
      local propertyValue = 0
      local battleDataCenter = bg and bg.battleDataCenter
      local stageData = WorldStageManager.Instance:GetCurStageData()
      if battleDataCenter then
        propertyValue = battleDataCenter and battleDataCenter:GetPlayerRoleProperty(bc.BattleProperty.ModifyGrowthStrength) or 0
      elseif stageData and stageData.role then
        propertyValue = stageData.role.ModifyGrowthStrength or 0
      end
      local adaption = 1 + propertyValue / 100
      local targetAccountLevelCfg = AcountLevelCfgUtils.GetCfg(val)
      local s1 = math.floor(targetAccountLevelCfg.HpMultiplier * 100)
      local s2 = math.floor(targetAccountLevelCfg.StageGrow * adaption)
      local s3 = math.floor(targetAccountLevelCfg.StageGrow * adaption * targetAccountLevelCfg.AccountDamagePower / 100)
      _attrDesc = LT.Textf(_attrDesc, s1, s2, s3)
    end
    table.insert(ret, {
      tid = id,
      type = cfg.Name,
      count = val,
      attrName = name,
      name = LT.Text(cfg.Text),
      isPercent = cfg.Percentage,
      attrDesc = _attrDesc
    })
  end
  table.sort(ret, function(a, b)
    return DT.ActorAttrType[a.tid].AttributeSort < DT.ActorAttrType[b.tid].AttributeSort
  end)
  return ret
end

function AwakerDataUtils.GetSkillIconPrefix()
  return "UIResources/AtlasSource/2_Icon/SkillIcon/"
end

function AwakerDataUtils.GetAwakerListBg()
  return "UIResources/UIBigImages/4_Image/Awaker_CareerBg/"
end

function AwakerDataUtils.GetAwakerTypeIcon(tid)
  local cfg = DT.AwakerConfig[tid]
  do return DT.GetConstant end
  return DT.GetConstant, "Actor_Type_Icon_" .. cfg.Type, cfg.Type
end

function AwakerDataUtils.GetExpItemId()
  return CommonDefine.CurrencyType.AwakerUpgradeExp
end

function AwakerDataUtils.IsGainNewAwakerPanelOpen()
  return UIManager.Instance:GetWindow(Urls.SummonNewItemPanel) ~= nil
end

function AwakerDataUtils.GetAwakerType(tid)
  local config = DT.AwakerConfig[tid]
  if not config then
    return ""
  end
  do return LT.Text end
  return LT.Text, DT.CommonID[config.Type].Desc, config.Type
end

function AwakerDataUtils.GetAwakerTypeDesc(tid)
  local config = DT.AwakerConfig[tid]
  if not config then
    return ""
  end
  do return LT.Text end
  return LT.Text, config.Characteristic
end

function AwakerDataUtils.LoadAllAwakerBank()
  local allAwakerTids = {}
  for k, awaker in pairs(DataCenter.awakerData.awakerMap) do
    if awaker.level > 0 then
      table.insert(allAwakerTids, awaker.ConfigId)
    end
  end
  do return AwakerDataUtils.LoadAwakerBank end
  return AwakerDataUtils.LoadAwakerBank, allAwakerTids, pairs(DataCenter.awakerData.awakerMap)
end

function AwakerDataUtils.LoadAwakerBank(awakerTids)
  local voiceCfg = DT.VoiceConfig
  local bankMap = {}
  for i, v in ipairs(awakerTids) do
    if voiceCfg[v] then
      local bank = "VO_Chr_Outgame"
      if bank and "" ~= bank then
        bankMap[bank] = true
      end
    end
  end
  for bank, _ in pairs(bankMap) do
    AudioManager.Instance:LoadSoundBank(bank)
  end
  return bankMap
end

function AwakerDataUtils.GetBreakAndPotencyLevel(awaker)
  local breakLevel = 0
  local potencyLevel = 0
  if awaker then
    breakLevel = awaker.currBreakthroughStar or 0
    potencyLevel = awaker.potencyLevel or 0
  end
  return breakLevel, potencyLevel
end

function AwakerDataUtils.GetBreakSkillLevel(awaker)
  local breakSkillLevel = 0
  if awaker then
    if not awaker.breakSkillUnlock then
      return awaker.currBreakthroughStar or 0
    end
    for level, unlock in pairs(awaker.breakSkillUnlock) do
      if level > breakSkillLevel and unlock then
        breakSkillLevel = level
      end
    end
  end
  return breakSkillLevel
end

function AwakerDataUtils.CanBreakSkillActive(skill, breakthroughLevel)
  if not (skill and skill.requiredMtrls) or skill.actived then
    return false
  end
  if not skill.unlockBreakthroughLevel or not breakthroughLevel then
    return false
  end
  if breakthroughLevel < skill.unlockBreakthroughLevel then
    return false
  end
  if skill.preSkill and not skill.preSkill.actived then
    return false
  end
  for tid, needNum in pairs(skill.requiredMtrls) do
    if tid and needNum then
      local itemData = ItemDataUtils.GetItemByTid(tid)
      local ownedNum = itemData and itemData.num or 0
      if needNum > ownedNum then
        return false
      end
    end
  end
  return true
end

function AwakerDataUtils.InitSpecialSkillData()
  local effectTypeMap = {}
  local awakerToEffectMap = {}
  local tableInsert = table.insert
  
  local function GetSpecialSkillDataList(cfg)
    local list = {}
    if cfg and cfg.AwakerID then
      for _, awakerTid in pairs(cfg.AwakerID) do
        local data = {
          tid = cfg.ID,
          awaker = awakerTid,
          sort = cfg.BaseSortID
        }
        tableInsert(list, data)
      end
    end
    return list
  end
  
  for _, funcModules in pairs(effectTypeMap) do
    for _, list in pairs(funcModules) do
      table.sort(list, AwakerDataUtils.SpecialSkillBaseSort)
    end
  end
  AwakerDataUtils.specialSkillTypeMap = effectTypeMap
  AwakerDataUtils.awakerToSpecialSkillMap = awakerToEffectMap
end

function AwakerDataUtils.GetAwakerLevelChangeAttrImprove(tid, currLv, nextLv)
  local list = {}
  local attrTable = {
    "atk",
    "def",
    "physique"
  }
  local attrTypeMap = AttrUtils.GetAttrTypeMap()
  for _, attrName in ipairs(attrTable) do
    local awakerData = AwakerDataUtils.GetAwakerData(tid)
    local _oldValue = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(tid, currLv, attrName, awakerData)
    local _newValue = AwakerDataUtils.GetAwakerBaseAttrValueByAwakerData(tid, nextLv, attrName, awakerData)
    local currValue = awakerData.attrs[attrName]
    local nextValue = currValue + (_newValue - _oldValue)
    currValue = math.ceil(currValue)
    nextValue = math.ceil(nextValue)
    local hasImproved = false
    if nextValue - currValue > 0 then
      nextValue = string.format("<AttrGreen:%s>", nextValue)
      hasImproved = true
    end
    local attrTid = attrTypeMap[attrName]
    local cfg = DT.ActorAttrType[attrTid]
    local data = {
      sort = cfg.AttributeSort,
      nameText = LT.Text(cfg.Text),
      iconPath = cfg.Icon,
      oldValue = currValue,
      newValue = nextValue,
      hasImproved = hasImproved
    }
    tableInsert(list, data)
  end
  
  local function sortFunc(a, b)
    return a.sort < b.sort
  end
  
  tableSort(list, sortFunc)
  return list
end

function AwakerDataUtils.CreateSpecialSkill(awakerTid, targetSlot)
  local specialSkillTid = AwakerDataUtils.GetSpeciallSkillIdByAwaker(awakerTid)
  if not specialSkillTid then
    Logger.Info("[特殊技能] 找不到唤醒体 %s 的特殊技能", awakerTid)
    return
  end
  local skill = {
    slot = targetSlot,
    isSpecialSkill = true,
    name = AwakerDataUtils.GetSpecialSkillTitle(specialSkillTid),
    desc = AwakerDataUtils.GetSpecialSkillDesc(specialSkillTid),
    lock = false,
    upNum = 0
  }
  return skill
end

function AwakerDataUtils._AddSpecialSkillInfo(awaker)
  local skill = AwakerDataUtils.CreateSpecialSkill(awaker.tid, #awaker.skills + 1)
  if not skill then
    return
  end
  table.insert(awaker.skills, skill)
end

function AwakerDataUtils.GetSpecialSkillListByType(effectType, funcModule)
  local list = {}
  if not effectType then
    return list
  end
  local map = {}
  local funcModuleData = AwakerDataUtils.specialSkillTypeMap[effectType]
  if funcModule then
    if funcModuleData then
      list = funcModuleData[funcModule] or list
    end
  elseif funcModuleData then
    for _, dataList in pairs(funcModuleData) do
      for _, data in pairs(dataList) do
        if not map[data.tid] then
          table.insert(list, data)
          map[data.tid] = true
        end
      end
    end
  end
  table.sort(list, AwakerDataUtils.SpecialSkillBaseSort)
  return list
end

function AwakerDataUtils.SpecialSkillBaseSort(a, b)
  local IsActive = 1
  local NotActive = 0
  local activeA = AwakerDataUtils.HasOwnedAwaker(a.awaker) and IsActive or NotActive
  local activeB = AwakerDataUtils.HasOwnedAwaker(b.awaker) and IsActive or NotActive
  if activeA == activeB then
    local qualitySortA = AwakerDataUtils.GetQualitySort(a.awaker)
    local qualitySortB = AwakerDataUtils.GetQualitySort(b.awaker)
    if qualitySortA == qualitySortB then
      return a.sort < b.sort
    end
    return qualitySortA > qualitySortB
  end
  return activeA > activeB
end

function AwakerDataUtils.GetAllSpecialSkillList()
  local effectTypeMap = AwakerDataUtils.specialSkillTypeMap
  local list = {}
  local map = {}
  for _, funcModuleDataTable in pairs(effectTypeMap) do
    if not funcModuleDataTable then
    else
      for _, dataList in pairs(funcModuleDataTable) do
        for _, data in pairs(dataList) do
          if not map[data.tid] then
            table.insert(list, data)
            map[data.tid] = true
          end
        end
      end
    end
  end
  table.sort(list, AwakerDataUtils.SpecialSkillBaseSort)
  return list
end

function AwakerDataUtils.GetEffectActiveNum(effectType, funcModule)
  local list
  if not effectType or effectType == CommonDefine.AwakerSpecialSkillType.All then
    list = AwakerDataUtils.GetAllSpecialSkillList()
  else
    list = AwakerDataUtils.GetSpecialSkillListByType(effectType, funcModule)
  end
  local totalNum = #list
  local activeNum = 0
  for i = 1, totalNum do
    local data = list[i]
    if data and TalentDataUtils.IsTalentUnlocked(data.configId, data.awaker) then
      activeNum = activeNum + 1
    end
  end
  return {activeNum = activeNum, totalNum = totalNum}
end

function AwakerDataUtils.GetSpeciallSkillIdByAwaker(awakerTid)
  if not awakerTid then
    return
  end
  return AwakerDataUtils.awakerToSpecialSkillMap[awakerTid]
end

function AwakerDataUtils.GetSpecialSkillOriginDescByAwaker(awakerTid)
  local specialSkillId = AwakerDataUtils.GetSpeciallSkillIdByAwaker(awakerTid)
  if not specialSkillId then
    return
  end
  local config = TalentDataUtils.GetSpecialSkillConfig(specialSkillId)
  local key = string.format("%sTag", config.Type)
  do return LT.Text end
  return LT.Text, key
end

function AwakerDataUtils.GetSpecialSkillTitle(tid)
  local config = TalentDataUtils.GetSpecialSkillConfig(tid)
  if not config then
    return ""
  end
  do return LT.Text end
  return LT.Text, config.Name
end

function AwakerDataUtils.GetSpecialSkillDesc(tid)
  local config = TalentDataUtils.GetSpecialSkillConfig(tid)
  if not config then
    return ""
  end
  do return LT.Text end
  return LT.Text, config.Desc
end

function AwakerDataUtils.GetSpecialSkillAwakerIcon(tid)
  local config = TalentDataUtils.GetSpecialSkillConfig(tid)
  if not config then
    return ""
  end
  local awakerTid = config.AwakerID and config.AwakerID[1]
  do return AwakerDataUtils.GetLittleIcon end
  return AwakerDataUtils.GetLittleIcon, awakerTid
end

function AwakerDataUtils.GetSpecialSkillIcon(tid)
  local config = TalentDataUtils.GetSpecialSkillConfig(tid)
  if not config then
    return ""
  end
  return config.Icon
end

function AwakerDataUtils.GetSpecialSkillOwnerName(tid)
  local config = TalentDataUtils.GetSpecialSkillConfig(tid)
  if not config then
    return ""
  end
  local awakerTid = config.AwakerID and config.AwakerID[1]
  do return AwakerDataUtils.GetAwakerName end
  return AwakerDataUtils.GetAwakerName, awakerTid
end

function AwakerDataUtils.GetSpecialSkillOwnerQualityFrame(tid)
  local config = TalentDataUtils.GetSpecialSkillConfig(tid)
  if not config then
    return ""
  end
  local awakerTid = config.AwakerID and config.AwakerID[1]
  do return AwakerDataUtils.GetAwakerQualityImage end
  return AwakerDataUtils.GetAwakerQualityImage, awakerTid
end

function AwakerDataUtils.OpenAwakerSpecialSkillActivePanel(effectType, funcModule)
  UIManager.Instance:Reopen(Urls.AwakerSpecialSkillActivePanel, effectType, funcModule)
end

function AwakerDataUtils.OpenAwakerSpecialSkillPanel()
  UIManager.Instance:Reopen(Urls.AwakerSpecialSkillPanel)
end

function AwakerDataUtils.UpdateAwakerlikeReward(awakerId, lv, state)
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  if awaker then
    awaker.likeReward = awaker.likeReward or {}
    awaker.likeReward[lv] = state
  end
end

function AwakerDataUtils.GetAwakerLike(awakerTid)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker then
    return 0
  end
  if not AwakerDataUtils.HasOwnedAwaker(awaker.tid) then
    return 0
  end
  return awaker.like or 0
end

function AwakerDataUtils.GetAwakerLikeLevel(awakerTid)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker then
    return 0
  end
  if not AwakerDataUtils.HasOwnedAwaker(awaker.tid) then
    return 0
  end
  return awaker.likeLevel or 0
end

function AwakerDataUtils.GetAwakerLikeExpRequire(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    return 0
  end
  if not AwakerDataUtils.HasOwnedAwaker(awakerTid) then
    return 0
  end
  local likeLevel = awakerData.likeLevel
  local cfg = DT.AwakerFavorability[awakerTid]
  if not cfg then
    return 0
  end
  local datalist = cfg.data_list
  local nexCfg = datalist[likeLevel + 1]
  return nexCfg and nexCfg.AwakerFavorabilityRequire or 0
end

local function formatNumber(number)
  if 0 == number % 1 then
    do return string.format, "%d" end
    return string.format, "%d", number
  else
    do return tostring end
    return tostring, number, number
  end
end

function AwakerDataUtils.GetTeamAwakerAttrs(awakerList, attrName, assistAwaker)
  local sum = 0
  for _, awakerId in pairs(awakerList) do
    local awaker = AwakerDataUtils.GetAwakerData(awakerId)
    if assistAwaker and assistAwaker.tid == awakerId then
      sum = sum + (assistAwaker.attrs[attrName] or 0)
    elseif awaker and awaker.attrs then
      sum = sum + (awaker.attrs[attrName] or 0)
    end
  end
  do return formatNumber end
  return formatNumber, sum, pairs(awakerList)
end

function AwakerDataUtils.GetAwakerAttrByName(awakerData, attrName)
  if not awakerData then
    return 0
  end
  return awakerData.attrs[attrName] or 0
end

function AwakerDataUtils.GetSkillLevelFromAwakerData(awakerData, skillId)
  local rst = 1
  if not awakerData then
    return rst
  end
  for _, skillSlot in pairs(awakerData.slots or {}) do
    if skillSlot.tid == skillId then
      rst = skillSlot.level
      break
    end
  end
  return rst
end

function AwakerDataUtils.GetAwakerTidByPainting(painting)
  if not painting then
    return 0
  end
  for _, awakerConfig in pairs(DT.AwakerConfig) do
    if awakerConfig.Painting and awakerConfig.Painting == painting then
      return awakerConfig.ID
    end
  end
  return 0
end

function AwakerDataUtils.GetAwakerBreakThroughLevelLimit(awakerTid, currBreakthroughStar)
  local cfg = DT.AwakerBreakThrough[math.abs(awakerTid)]
  if not cfg then
    return 0
  end
  local idx = currBreakthroughStar + 1
  local currStarCfg = cfg.data_list[idx] or cfg.data_list[currBreakthroughStar]
  if not currStarCfg then
    return 0
  end
  return currStarCfg.MaxLevel
end

function AwakerDataUtils.GetAwakerPotencyAndIncreaseLevelValue(awaker, activePotencyIndex)
  local limitIncreaseIdx = awaker.levelLimitIncreaseIdx
  local currLevelLimit = 0
  local limitIncCfg = DT.LevelLimitIncrease[awaker.tid] and DT.LevelLimitIncrease[awaker.tid].data_list[limitIncreaseIdx] or nil
  if limitIncCfg then
    currLevelLimit = currLevelLimit + limitIncCfg.LevelLimitIncreaseValue
  end
  currLevelLimit = currLevelLimit + AwakerDataUtils.GetAwakerPotencyLevelValue(awaker, activePotencyIndex)
  return currLevelLimit
end

function AwakerDataUtils.GetAwakerPotencyLevelValue(awaker, activePotencyIndex)
  if not activePotencyIndex then
    if awaker.potencyLevel then
      activePotencyIndex = awaker.potencyLevel
    else
      activePotencyIndex = AwakerDataUtils.GetAwakerPotencyIndex(awaker.tid, awaker.potency)
    end
  end
  do return AwakerDataUtils.GetPotencyExtraLevelLimit, awaker end
  return AwakerDataUtils.GetPotencyExtraLevelLimit, awaker, activePotencyIndex
end

function AwakerDataUtils.GetPotencyUtlSkillStatus(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  for idx, potencyData in ipairs(potencyList) do
    if potencyData then
      local config = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
      if config.EffectType1 and (config.EffectType1 == AwakerPotencyEffectType.UtlSkill_Promote or config.EffectType1 == AwakerPotencyEffectType.ComingSoon) then
        return {
          effectType = config.EffectType1,
          effectValue = config.Effect1 and (config.Effect1[1] or 0) or 0,
          index = potencyData.index,
          potency = potencyData.tid
        }
      end
    end
  end
end

function AwakerDataUtils.GetPotencyUtlSkillTid(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  for idx, potencyData in ipairs(potencyList) do
    if potencyData then
      local config = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
      if config.EffectType1 and (config.EffectType1 == AwakerPotencyEffectType.UtlSkill_Promote or config.EffectType1 == AwakerPotencyEffectType.ComingSoon) then
        return potencyData.tid
      end
    end
  end
end

function AwakerDataUtils.GetPotencyUtlSkillName(awakerTid)
  local potencyTid = AwakerDataUtils.GetPotencyUtlSkillTid(awakerTid)
  return DT.AwakerPotency[potencyTid] and DT.AwakerPotency[potencyTid].PotencyName or LT.Text("SuperUltlSkillName")
end

function AwakerDataUtils.ExistsPotencyExtraAttrs(awakerTid, potencyIndex)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(awakerTid)
  for idx, potencyData in ipairs(potencyList) do
    if potencyData and potencyData.index == potencyIndex then
      local config = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
      if config.EffectType1 and (config.EffectType1 == AwakerPotencyEffectType.UtlSkill_Promote or config.EffectType1 == AwakerPotencyEffectType.ComingSoon or config.EffectType1 == AwakerPotencyEffectType.LevelLimit_Promote) then
        return true
      end
    end
  end
  return false
end

function AwakerDataUtils.IsAwakerArriveLevelM(awaker, activePotencyIndex)
  local currLevelLimit = AwakerDataUtils.GetAwakerBreakThroughLevelLimit(awaker.tid, awaker.currBreakthroughStar or 0)
  currLevelLimit = currLevelLimit + AwakerDataUtils.GetAwakerPotencyAndIncreaseLevelValue(awaker, activePotencyIndex)
  return currLevelLimit
end

function AwakerDataUtils.GetAwakerCurrLevelLimit(awaker, activePotencyIndex)
  local currLevelLimit = AwakerDataUtils.GetAwakerBreakThroughLevelLimit(awaker.tid, awaker.currBreakthroughStar or 0)
  currLevelLimit = currLevelLimit + AwakerDataUtils.GetAwakerPotencyAndIncreaseLevelValue(awaker, activePotencyIndex)
  return currLevelLimit
end

function AwakerDataUtils.GetAwakerNextBreakthroughLevelLimit(awaker)
  local currLevelLimit = AwakerDataUtils.GetAwakerBreakThroughLevelLimit(awaker.tid, (awaker.currBreakthroughStar or 0) + 1)
  currLevelLimit = currLevelLimit + AwakerDataUtils.GetAwakerPotencyAndIncreaseLevelValue(awaker)
  return currLevelLimit
end

function AwakerDataUtils.GetPotencyExtraLevelLimit(awaker, currActivePotencyIndex)
  local potencyList = AwakerDataUtils.GetAwakerPotencyList(awaker.tid)
  local levelLimit = 0
  if not potencyList then
    return 0
  end
  for _, potencyData in ipairs(potencyList) do
    if potencyData and currActivePotencyIndex >= potencyData.index then
      local config = AwakerDataUtils.GetPotencyConfig(potencyData.tid)
      if config and config.EffectType1 == AwakerPotencyEffectType.LevelLimit_Promote then
        levelLimit = levelLimit + (config.Effect1 and (config.Effect1[1] or 0) or 0)
      end
    end
  end
  return levelLimit
end

function AwakerDataUtils.IsAwakerReachLevelLimit(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  if not awaker then
    return false
  end
  local curLevel = awaker.level or 0
  return curLevel >= AwakerDataUtils.GetAwakerCurrLevelLimit(awaker)
end

function AwakerDataUtils.GetAwakerLevelLimitIncreaseIdx(awakerId)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerId)
  if not awakerData then
    return 0
  end
  return awakerData.levelLimitIncreaseIdx
end

function AwakerDataUtils.GetAwakerLevelLimitIncreaseCfg(awakerId)
  local limitIncreaseIdx = AwakerDataUtils.GetAwakerLevelLimitIncreaseIdx(awakerId)
  return DT.LevelLimitIncrease[awakerId] and DT.LevelLimitIncrease[awakerId].data_list[limitIncreaseIdx] or nil
end

function AwakerDataUtils.GetAwakerMaxLevelWithLimitIncrease(awakerId)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerId)
  local potencyLevel = AwakerDataUtils.GetAwakerPotencyLevelValue(awakerData)
  local limitIncCfg = AwakerDataUtils.GetAwakerLevelLimitIncreaseCfg(awakerId)
  local normalMaxLevel = DT.GetConstant("AwakerMaxLv")
  if not limitIncCfg then
    return normalMaxLevel + potencyLevel
  end
  return normalMaxLevel + limitIncCfg.LevelLimitIncreaseValue + potencyLevel
end

function AwakerDataUtils.GetNextLimitCfg(awakerId)
  local targetIdx = 1
  local curIdx = AwakerDataUtils.GetAwakerLevelLimitIncreaseIdx(awakerId)
  if curIdx then
    targetIdx = curIdx + 1
  end
  if DT.LevelLimitIncrease[awakerId] then
    for idx, cfg in ipairs(DT.LevelLimitIncrease[awakerId].data_list) do
      if idx == targetIdx then
        return cfg
      end
    end
  end
  return nil
end

function AwakerDataUtils.GetAwakerLimitIncreaseRequireItem(awakerId)
  local cfg = AwakerDataUtils.GetNextLimitCfg(awakerId)
  if cfg then
    return cfg.RequireItem
  end
  return {}
end

function AwakerDataUtils.GetAwakerNextMaxLevelWithLimitIncrease(awakerId)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerId)
  local potencyLevel = AwakerDataUtils.GetAwakerPotencyLevelValue(awakerData)
  local cfg = AwakerDataUtils.GetNextLimitCfg(awakerId)
  local normalMaxLevel = DT.GetConstant("AwakerMaxLv")
  if not cfg then
    return normalMaxLevel + potencyLevel
  end
  return normalMaxLevel + cfg.LevelLimitIncreaseValue + potencyLevel
end

function AwakerDataUtils.GetAwakerMaxLimitIncreaseLevel(awakerId)
  local increaseLevel = 0
  if DT.LevelLimitIncrease[awakerId] then
    for _, cfg in pairs(DT.LevelLimitIncrease[awakerId].data_list) do
      increaseLevel = math.max(cfg.LevelLimitIncreaseValue, increaseLevel)
    end
  end
  local normalMaxLevel = DT.GetConstant("AwakerMaxLv")
  local awakerData = AwakerDataUtils.GetAwakerData(awakerId)
  local potencyLevel = AwakerDataUtils.GetAwakerPotencyLevelValue(awakerData)
  return normalMaxLevel + increaseLevel + potencyLevel
end

function AwakerDataUtils.CheckCostItemEnough(awakerId, isOpen, noAutoCompose)
  print("merge CheckCostItemEnough")
  local awakerData = AwakerDataUtils.GetAwakerData(awakerId)
  local awakerLimitLv = AwakerDataUtils.GetAwakerCurrLevelLimit(awakerData)
  if awakerLimitLv > awakerData.level then
    return false
  end
  local costItems = AwakerDataUtils.GetAwakerLimitIncreaseRequireItem(awakerId)
  if 0 == #costItems then
    return false
  end
  for i = 1, #costItems, 2 do
    local tid = costItems[i]
    local num = costItems[i + 1]
    if num > ItemDataUtils.GetItemNum(tid) then
      if noAutoCompose then
        return false
      end
      if not ItemAlchemyUtils.OpenUpgradeViewWithItemFlatList(costItems, not isOpen) then
        return false
      end
    end
  end
  return true
end

function AwakerDataUtils.GetCostItemsWithoutGold(awakerId)
  local costItems = AwakerDataUtils.GetAwakerLimitIncreaseRequireItem(awakerId)
  if 0 == #costItems then
    return nil
  end
  local showCostItems = {}
  for i = 1, #costItems, 2 do
    local tid = costItems[i]
    local num = costItems[i + 1]
    if tid ~= GOLD_TID then
      table.insert(showCostItems, {tid = tid, num = num})
    end
  end
  return showCostItems
end

function AwakerDataUtils.GetGoldCostNum(awakerId)
  local costItems = AwakerDataUtils.GetAwakerLimitIncreaseRequireItem(awakerId)
  if 0 == #costItems then
    return nil
  end
  local showCostItems = {}
  for i = 1, #costItems, 2 do
    local tid = costItems[i]
    local num = costItems[i + 1]
    if tid == GOLD_TID then
      return num
    end
  end
  return showCostItems
end

function AwakerDataUtils.GetAwakerLevel(tid)
  local awakerData = AwakerDataUtils.GetAwakerData(tid)
  if not awakerData then
    return 0
  end
  return awakerData.level
end

function AwakerDataUtils.CheckSSRWeaponForbidden(selectedWeaponUid, unselectedWeaponUid)
  if not selectedWeaponUid or 0 == selectedWeaponUid then
    return false
  end
  if ItemDataUtils.CheckIsMaxLvSSRWeapon(unselectedWeaponUid) or ItemDataUtils.CheckIsMaxLvSSRWeapon(selectedWeaponUid) then
    return false
  end
  local selectedWeaponTid = ItemDataUtils.GetItemDataByField("tid", selectedWeaponUid)
  local unselectedSlotWeapon = ItemDataUtils.GetItemByUid(unselectedWeaponUid)
  if not unselectedSlotWeapon then
    return false
  end
  local unselectedSlotWeaponCfg = DT.Item[unselectedSlotWeapon.tid]
  local weaponCfg = DT.Item[selectedWeaponTid]
  if not unselectedSlotWeaponCfg or not weaponCfg then
    return false
  end
  if unselectedSlotWeaponCfg.Quality == "Orange" and weaponCfg.Quality == "Orange" then
    return true
  end
  return false
end

function AwakerDataUtils.IsMaxLikeLevel(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData or not awakerData.likeLevel then
    return false
  end
  local awakerMaxLikeLevel = AwakerFavorabilityCfgUtils.GetAwakerMaxLikeLevel(awakerTid)
  return awakerMaxLikeLevel <= awakerData.likeLevel
end

function AwakerDataUtils.CheckSameWeaponForbidden(selectedWeaponTid, unselectedWeaponUid)
  if not selectedWeaponTid or 0 == selectedWeaponTid then
    return false
  end
  local unselectedSlotWeapon = ItemDataUtils.GetItemByUid(unselectedWeaponUid)
  if not unselectedSlotWeapon then
    return false
  end
  local unselectedSlotWeaponCfg = DT.Item[unselectedSlotWeapon.tid]
  local weaponCfg = DT.Item[selectedWeaponTid]
  if unselectedSlotWeaponCfg and unselectedSlotWeaponCfg.ID == weaponCfg.ID then
    return true
  end
  return false
end

function AwakerDataUtils.GetAwakerSkillsData(awakerData)
  if not (awakerData and awakerData.skills) or not table.next(awakerData.skills) then
    return nil
  end
  local specialSkill
  local skillList = {}
  for _, skill in pairs(awakerData.skills) do
    if skill.slot == CommonDefine.AwakerSkillSlot.Slot_Super then
      specialSkill = skill
    else
      table.insert(skillList, skill)
    end
  end
  return skillList, specialSkill
end

function AwakerDataUtils.GetUltiSkillName(awakerTid, awakerData)
  local awakerConfig = DT.AwakerConfig[awakerTid]
  if not (awakerConfig and awakerConfig.PVPSkillList) or not awakerConfig.PVPSkillList[1] then
    return nil
  end
  local ultiSkillId = awakerConfig.PVPSkillList[1]
  local skillConfig = DT.Skill[ultiSkillId]
  local params = {awaker = awakerData}
  return skillConfig and BattleSkillUtils.GetSkillName(skillConfig, 0, 0, params) or nil
end

function AwakerDataUtils.GetAwakerPVPSkillList(awakerTid)
  do return AwakerDataUtils.GetAwakerConfigByField, "PVPSkillList" end
  return AwakerDataUtils.GetAwakerConfigByField, "PVPSkillList", awakerTid
end

function AwakerDataUtils.GetAwakerPVPSkillListByType(awakerTid, targetType)
  local skillList = AwakerDataUtils.GetAwakerConfigByField("PVPSkillList", awakerTid)
  if not skillList then
    return nil
  end
  for _, skillTid in pairs(skillList) do
    local skillType = SkillDataUtils.GetSkillType(skillTid)
    if skillType and skillType == targetType then
      return skillTid
    end
  end
  return nil
end

function AwakerDataUtils.GetForbidRelicMap()
  local forbidRelicMap = {}
  local now = TimeUtils.GetServerTime()
  for _, awakerCfg in pairs(DT.AwakerConfig) do
    if awakerCfg.OpenDate and now < awakerCfg.OpenDate and awakerCfg.ExclusiveRelic then
      for _, relicTid in pairs(awakerCfg.ExclusiveRelic) do
        forbidRelicMap[relicTid] = true
      end
    end
  end
  return forbidRelicMap
end

function AwakerDataUtils.GetSummonSchoolLogo(schoolEnName, quality)
  local cfg = CommonDefine.SummonSchoolLogo[schoolEnName]
  local schoolLogo = cfg and cfg[quality]
  schoolLogo = schoolLogo or cfg and cfg.Orange
  return schoolLogo
end

function AwakerDataUtils.GetAwakerChipSSROverflowExtraItems(needDoubleReward)
  local rst = {}
  local dataSSR = DT.Constant.AwakerChipSSROverflowExtraItem.Data
  for i = 1, #dataSSR, 2 do
    local tid = dataSSR[i]
    local num = dataSSR[i + 1] or 0
    if needDoubleReward then
      num = num + num
    end
    table.insert(rst, {tid = tid, num = num})
  end
  return rst
end

function AwakerDataUtils.IsAwakerMaxPotency(awakerTid)
  local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awakerData then
    return false
  end
  local awakerCfg = DT.AwakerConfig[awakerTid]
  local curActivePotencyIndex = AwakerDataUtils.GetAwakerPotencyIndex(awakerTid, awakerData.potency)
  local numFragments = ItemDataUtils.GetItemNum(awakerCfg.AwakerSpecialItem)
  local costNumList = DT.GetOriginalConstant("AwakerPotencyUpgradeConsumeNum")
  return curActivePotencyIndex + numFragments >= #costNumList
end

function AwakerDataUtils.RequestAwakersCollectState(tid, state, callback)
  ProtoManager.Instance:ReqServer("GameRequest", "OnCollection", function(data)
    Logger.Info("colaw col========== 更新唤醒体收藏状态成功 ==========\n", table.tostring(data))
    AwakerDataUtils.UpdateAwakerCollectStateData(tid, data.isCollect)
    if callback then
      callback()
    end
  end, function(data)
    Logger.Info("colaw col========== 更新唤醒体收藏状态失败 ==========\n", table.tostring(data))
  end, tid, state)
end

function AwakerDataUtils.GetTalentAttrMap(talentTid, awakerData, level)
  local attrTalentMap
  local talentAttrLv = AwakerDataUtils.GetTalentAttrLv(talentTid, level)
  local awakerTid = awakerData and awakerData.tid or nil
  local awakerLevel = awakerData and awakerData.level or 1
  local curTalentLevel = level
  local lastTalentLevel = 0
  if not awakerTid then
    local config = DT.AwakerTalent[talentTid]
    local talentCfg = config and config.data_list[level]
    if not talentCfg then
      return
    end
    awakerTid = talentCfg.AwakerID
  end
  if talentAttrLv > 0 then
    attrTalentMap = {}
    for attrName, keyName in pairs(cd.AwakerAttrTalentKey) do
      local lastValue = AwakerDataUtils.GetAwakerBaseAttrValue(awakerTid, awakerLevel, attrName, talentTid, lastTalentLevel)
      local curValue = AwakerDataUtils.GetAwakerBaseAttrValue(awakerTid, awakerLevel, attrName, talentTid, curTalentLevel)
      attrTalentMap[keyName] = curValue - lastValue
    end
  end
  return attrTalentMap
end

function AwakerDataUtils.GetTalentAttrLv(talentTid, level)
  if not talentTid or 0 == talentTid then
    return 0
  end
  local config = DT.AwakerTalent[talentTid]
  local talentCfg = config and config.data_list[level]
  if not talentCfg then
    return 0
  end
  for i = 1, 2 do
    local talentTypeKey = "TalentType" .. i
    if "Talent_Attr_Lv" == talentCfg[talentTypeKey] then
      local talentAttrLv = talentCfg["TalentEffect" .. i][1]
      return talentAttrLv or 0
    end
  end
  return 0
end

function AwakerDataUtils.GetAwakerAttrTalentTidAndLevel(awaker)
  if not awaker or not awaker.talents then
    return 0, 0
  end
  for talentTid, talent in pairs(awaker.talents) do
    if TalentDataUtils.IsAttrTalent(talentTid) then
      return talentTid, talent.lv
    end
  end
  return 0, 0
end

function AwakerDataUtils.GetUnbindMaterialNum()
  local cfg = DT.Constant.TrinketUnbindMaterialNum
  if cfg and cfg.Data then
    return cfg.Data[1]
  end
  return 10
end

function AwakerDataUtils.GetBoundTrinkets(awakerTid)
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker or not awaker.boundTrinkets then
    return {}
  end
  return awaker.boundTrinkets
end

function AwakerDataUtils.GetBoundTrinketUid(awakerTid, pos)
  local boundTrinkets = AwakerDataUtils.GetBoundTrinkets(awakerTid)
  return boundTrinkets[pos] or 0
end

local EMPTY_BOUND_TRINKETS = {}

function AwakerDataUtils.GetBoundTrinketsFormAware(awakerTid)
  if not awakerTid or 0 == awakerTid then
    return EMPTY_BOUND_TRINKETS
  end
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  local bound = awaker and awaker.boundTrinkets
  local changerTid = AwakerDataUtils.GetChangerForm(awakerTid)
  local changerBound
  if changerTid and 0 ~= changerTid then
    local changerAwaker = AwakerDataUtils.GetAwakerData(changerTid)
    changerBound = changerAwaker and changerAwaker.boundTrinkets
  end
  if bound and table.next(bound) then
    return bound
  end
  if changerBound and table.next(changerBound) then
    return changerBound
  end
  return bound or EMPTY_BOUND_TRINKETS
end

function AwakerDataUtils.GetBoundTrinketUidFormAware(awakerTid, pos)
  local boundTrinkets = AwakerDataUtils.GetBoundTrinketsFormAware(awakerTid)
  return boundTrinkets[pos] or 0
end

local function _GetBoundTrinketSourceMap()
  if table.next(DataCenter.awakerData.mockAwakerMap) then
    return DataCenter.awakerData.mockAwakerMap
  end
  return DataCenter.awakerData.awakerMap or {}
end

local function _BuildBoundTrinketIndex(sourceMap)
  local index = {}
  for awakerTid, awaker in pairs(sourceMap) do
    if awaker.boundTrinkets then
      for _, boundUid in pairs(awaker.boundTrinkets) do
        if boundUid and 0 ~= boundUid then
          index[boundUid] = awakerTid
        end
      end
    end
  end
  return index
end

local function _EnsureBoundTrinketIndex()
  local sourceMap = _GetBoundTrinketSourceMap()
  if nil == boundTrinketIndex or boundTrinketIndexSource ~= sourceMap then
    boundTrinketIndexSource = sourceMap
    boundTrinketIndex = _BuildBoundTrinketIndex(sourceMap)
  end
end

function AwakerDataUtils._RefreshBoundTrinketIndex(awakerTid)
  if not awakerTid then
    return
  end
  _EnsureBoundTrinketIndex()
  for uid, tid in pairs(boundTrinketIndex) do
    if tid == awakerTid then
      boundTrinketIndex[uid] = nil
    end
  end
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  local boundTrinkets = awaker and awaker.boundTrinkets or nil
  if boundTrinkets then
    for _, uid in pairs(boundTrinkets) do
      if uid and 0 ~= uid then
        boundTrinketIndex[uid] = awakerTid
      end
    end
  end
end

function AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid)
  if not uid or 0 == uid then
    return nil
  end
  _EnsureBoundTrinketIndex()
  return boundTrinketIndex[uid]
end

function AwakerDataUtils.UpdateBoundTrinkets(awakerTid, boundTrinkets)
  if not awakerTid then
    return
  end
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker or not awaker.tid then
    Logger.Info("AwakerDataUtils.UpdateBoundTrinkets: awaker not found, tid=%s", awakerTid)
    return
  end
  awaker.boundTrinkets = boundTrinkets or {}
  AwakerDataUtils._RefreshBoundTrinketIndex(awakerTid)
end

function AwakerDataUtils.GetUnbindMaterialCandidates(awakerTid, pos, excludeUids)
  local result = {}
  if not pos then
    return result
  end
  local excludeMap = {}
  if excludeUids then
    for _, uid in pairs(excludeUids) do
      excludeMap[uid] = true
    end
  end
  local suitId
  local boundUid = AwakerDataUtils.GetBoundTrinketUid(awakerTid, pos)
  if 0 ~= boundUid then
    local boundItem = ItemDataUtils.GetItemByUid(boundUid)
    suitId = boundItem and AwakerTrinketDataUtils.GetSuitIdByItemTid(boundItem.tid) or nil
  end
  local trinketsList = BagExtModel.Instance and BagExtModel.Instance:GetAllTrinketDataList() or {}
  for _, trinket in ipairs(trinketsList) do
    if excludeMap[trinket.uid] then
    elseif suitId and trinket.suitId ~= suitId then
    elseif AwakerDataUtils.IsTrinketBoundByAnyAwaker(trinket.uid) then
    elseif AwakerTrinketExtModel.Instance and AwakerTrinketExtModel.Instance:IsTrinketUsing(trinket.uid) then
    else
      tableInsert(result, trinket.uid)
    end
  end
  return result
end

function AwakerDataUtils.SortUnbindMaterialUids(uids)
  tableSort(uids, function(uidA, uidB)
    local lockedA = ItemDataUtils.GetItemLocked(uidA)
    local lockedB = ItemDataUtils.GetItemLocked(uidB)
    if lockedA ~= lockedB then
      return not lockedA
    end
    local itemA = ItemDataUtils.GetItemByUid(uidA)
    local itemB = ItemDataUtils.GetItemByUid(uidB)
    local qualityA = itemA and ItemDataUtils.GetQualitySortValue(itemA.tid) or 0
    local qualityB = itemB and ItemDataUtils.GetQualitySortValue(itemB.tid) or 0
    if qualityA ~= qualityB then
      return qualityA < qualityB
    end
    return ItemDataUtils.GetTrinketLevelByUid(uidA) < ItemDataUtils.GetTrinketLevelByUid(uidB)
  end)
end

function AwakerDataUtils._GetTrinketAttrIntensityLimit()
  local cfg = DT.Constant.TrinketAutoRefineAttrIntensityGoal
  if cfg and cfg.Data then
    return cfg.Data[1]
  end
  return 8
end

function AwakerDataUtils._HasHighIntensityAttr(itemData)
  if not itemData or not itemData.attrs then
    return false
  end
  local limit = AwakerDataUtils._GetTrinketAttrIntensityLimit()
  for idx, attr in ipairs(itemData.attrs) do
    if idx > 1 and limit <= AwakerTrinketDataUtils.GetTrinketSubAttrLevel(attr) then
      return true
    end
  end
  return false
end

function AwakerDataUtils._IsTrinketDeveloped(itemData)
  if not itemData or not itemData.uid then
    return false
  end
  return ItemDataUtils.GetTrinketLevelByUid(itemData.uid) > 0
end

function AwakerDataUtils._IsAutoSelectForbidden(itemData)
  if not itemData then
    return false
  end
  if AwakerDataUtils._HasHighIntensityAttr(itemData) then
    return true
  end
  if not itemData.uid then
    return false
  end
  return ItemDataUtils.GetTrinketLevelByUid(itemData.uid) >= AUTO_SELECT_FORBID_TRINKET_LEVEL
end

function AwakerDataUtils._IsAutoSelectDeprioritized(itemData)
  do return AwakerDataUtils._IsTrinketDeveloped end
  return AwakerDataUtils._IsTrinketDeveloped, itemData
end

function AwakerDataUtils.AutoSelectUnbindMaterials(awakerTid, pos, count, excludeUids)
  local candidates = AwakerDataUtils.GetUnbindMaterialCandidates(awakerTid, pos, excludeUids)
  AwakerDataUtils.SortUnbindMaterialUids(candidates)
  local needNum = math.min(count or AwakerDataUtils.GetUnbindMaterialNum(), #candidates)
  local selected = {}
  for _, uid in ipairs(candidates) do
    if needNum <= #selected then
      break
    end
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if itemData and not ItemDataUtils.GetItemLocked(uid) and not AwakerDataUtils._IsAutoSelectForbidden(itemData) and not AwakerDataUtils._IsAutoSelectDeprioritized(itemData) then
      tableInsert(selected, uid)
    end
  end
  for _, uid in ipairs(candidates) do
    if needNum <= #selected then
      break
    end
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if itemData and not ItemDataUtils.GetItemLocked(uid) and not AwakerDataUtils._IsAutoSelectForbidden(itemData) and AwakerDataUtils._IsAutoSelectDeprioritized(itemData) then
      tableInsert(selected, uid)
    end
  end
  return selected
end

return AwakerDataUtils
