local QualitySortValueTable = CommonDefine.QualitySortValueTable
local TalentDataUtils = {}

function TalentDataUtils.GetALLTalents()
  do return TalentDataUtils.GetTalentsByParams, nil, nil end
  return TalentDataUtils.GetTalentsByParams, nil, nil, nil
end

function TalentDataUtils.GetTalentsByParams(skillEffectType, funcModule, awakerId)
  local tTalentDatas = {}
  TalentDataUtils.SortTalentDatas(tTalentDatas)
  return tTalentDatas
end

function TalentDataUtils.ShowAwaker(awakerId)
  local awakerData = DataCenter.awakerData.awakerMap[awakerId]
  local own = awakerData and awakerData.state == CommonDefine.AwakerState.Owned or false
  local config = DT.AwakerConfig[awakerId]
  local curTime = math.floor(TimeUtils.GetServerTime())
  local canShow = config.AwakeDisplayDate and curTime >= config.AwakeDisplayDate
  canShow = nil == canShow and true or canShow
  return own or canShow
end

function TalentDataUtils.GetModuleMatch(talentCfgId, funcModule)
  local moduleMatch = nil == funcModule
  return moduleMatch
end

function TalentDataUtils.CalcSortWeight(tTalentDatas)
  local tWeights = {}
  for _, talentData in ipairs(tTalentDatas) do
    local configId = talentData.configId
    local CanUnlock1 = TalentDataUtils.IsTalentCanUnlock(configId) and 1 or 0
    local IsUnlocked2 = TalentDataUtils.IsTalentUnlocked(configId) and 1 or 0
    local OwnedAwaker3 = TalentDataUtils.OwnAwakerByTalentCfgId(configId) and 1 or 0
    local QualitySort4 = TalentDataUtils.GetAwakerQualitySortByTalentCfgId(configId)
    local weight = CanUnlock1 * 1000 + IsUnlocked2 * 100 + OwnedAwaker3 * 10 + QualitySort4
    tWeights[configId] = weight
  end
  return tWeights
end

function TalentDataUtils.SortTalentDatas(list)
  local tWeights = TalentDataUtils.CalcSortWeight(list)
  table.sort(list, function(a, b)
    local aWeight = tWeights[a.configId]
    local bWeight = tWeights[b.configId]
    if aWeight ~= bWeight then
      return aWeight > bWeight
    else
      return a.configId < b.configId
    end
  end)
end

function TalentDataUtils.GetSpecialSkillTitle(tid)
  local config = TalentDataUtils.GetSpecialSkillConfig(tid)
  do return LT.Text end
  return LT.Text, config.Name
end

function TalentDataUtils.GetSpecialSkillDesc(tid)
  local config = TalentDataUtils.GetSpecialSkillConfig(tid)
  do return LT.Text end
  return LT.Text, config.Desc
end

function TalentDataUtils.GetSpecialSkillOwnerName(tid)
  local talentConfig = TalentDataUtils.GetSpecialSkillConfig(tid)
  local awakerConfigId = talentConfig.AwakerID and talentConfig.AwakerID[1]
  local awakerConfig = DT.AwakerConfig[awakerConfigId]
  return awakerConfig and LT.Text(awakerConfig.Name) or ""
end

function TalentDataUtils.GetSpecialSkillAwakerIcon(tid)
  local talentConfig = TalentDataUtils.GetSpecialSkillConfig(tid)
  local awakerConfigId = talentConfig.AwakerID and talentConfig.AwakerID[1]
  if awakerConfigId then
    do return AwakerDataUtils.GetLittleIcon end
    return AwakerDataUtils.GetLittleIcon, awakerConfigId
  end
end

function TalentDataUtils.GetSpecialSkillOwnerQualityFrame(tid)
  local talentConfig = TalentDataUtils.GetSpecialSkillConfig(tid)
  local awakerConfigId = talentConfig.AwakerID and talentConfig.AwakerID[1]
  local awakerConfig = DT.AwakerConfig[awakerConfigId]
  do return ItemDataUtils.GetQualityFramePathByQuality end
  return ItemDataUtils.GetQualityFramePathByQuality, awakerConfig.Quality
end

function TalentDataUtils.UpdateTalentDatas(data)
  local talentDataMap = DataCenter.awakerData.TalentDataMap
  for _, item in ipairs(data) do
    local talentCfgId = item.tid
    local talentData = talentDataMap[talentCfgId] or {}
    talentData.talentCfgId = item.tid
    talentData.awakerId = item.origin
    talentData.isUnlocked = 1 == item.level
    talentDataMap[talentCfgId] = talentData
  end
end

function TalentDataUtils.UpdateSingleTalentData(talentCfgId, awakerCfgId)
  local talentDataMap = DataCenter.awakerData.TalentDataMap
  local talentData = talentDataMap[talentCfgId] or {}
  talentData.talentCfgId = talentCfgId
  talentData.awakerId = awakerCfgId
  talentData.isUnlocked = true
  talentDataMap[talentCfgId] = talentData
end

function TalentDataUtils.IsTalentUnlocked(configId)
  return not TalentDataUtils.IsTalentlocked(configId)
end

function TalentDataUtils.IsTalentlocked(configId)
  local talentDataMap = DataCenter.awakerData.TalentDataMap
  local talentData = talentDataMap[configId]
  if talentData then
    return not talentData.isUnlocked
  else
    return true
  end
end

function TalentDataUtils.GetActiveNum()
  local activeNum = 0
  local talentDataMap = DataCenter.awakerData.TalentDataMap
  for talentCfgId, talentData in pairs(talentDataMap) do
    if talentData.isUnlocked then
      activeNum = activeNum + 1
    end
  end
  return activeNum
end

function TalentDataUtils.Enough2UnlockTalent()
  local cfgList = DT.GetOriginalConstant("SpecialSkill_Unlock_ConsumeGoldCoins")
  local itemId = cfgList[1]
  local need = cfgList[2]
  local ownNum = ItemDataUtils.GetItemNum(itemId)
  return need <= ownNum
end

function TalentDataUtils.IsTalentCanUnlock(talentCfgId)
  local hasAwaker = TalentDataUtils.OwnAwakerByTalentCfgId(talentCfgId)
  local locked = TalentDataUtils.IsTalentlocked(talentCfgId)
  local enough = TalentDataUtils.Enough2UnlockTalent()
  return hasAwaker and locked and enough
end

function TalentDataUtils.OwnAwakerByTalentCfgId(talentCfgId)
  local talentCfg = TalentDataUtils.GetSpecialSkillConfig(talentCfgId)
  local awakerId = talentCfg.AwakerID[1]
  local awakerData = DataCenter.awakerData.awakerMap[awakerId]
  local hasAwaker = awakerData and awakerData.state == CommonDefine.AwakerState.Owned or false
  return hasAwaker
end

function TalentDataUtils.TalentResearchItemShowRed()
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.SpecialSkillList, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlock then
    return false
  end
  do return end
  return TalentDataUtils.HasCanUnlockTalent
end

function TalentDataUtils.HasCanUnlockTalent()
  do return TalentDataUtils.HasCanUnlockTalentBySchool end
  return TalentDataUtils.HasCanUnlockTalentBySchool, 0
end

function TalentDataUtils.HasCanUnlockTalentBySchool(schoolId)
  return false
end

function TalentDataUtils.GetResouceReduceResult(originValue, effectType, funcModule)
  local effectDataList = TalentDataUtils.GetTalentsByParams(effectType, funcModule, nil)
  local effectTids = {}
  if effectDataList then
    for _, effectData in pairs(effectDataList) do
      if effectData and effectData.configId and TalentDataUtils.IsTalentUnlocked(effectData.configId) then
        table.insert(effectTids, effectData.configId)
      end
    end
    if #effectTids > 0 then
      do return TalentDataUtils.ResouceReduceCalc, originValue end
      return TalentDataUtils.ResouceReduceCalc, originValue, effectTids, pairs(effectDataList)
    end
  end
  return originValue
end

function TalentDataUtils.ResouceReduceCalc(originValue, tids)
  if not tids or not originValue then
    return
  end
  local ratio = 0
  for _, tid in pairs(tids) do
    local config = TalentDataUtils.GetSpecialSkillConfig(tid)
    if config and config.Ratio then
      ratio = ratio + config.Ratio
    end
  end
  ratio = ratio / 10000
  local result = math.floor(originValue * (1 - ratio))
  return result
end

function TalentDataUtils.GetSpecialSkillConfig(tid)
  if not tid then
    Logger.Error("[SpecialSkill] error param: tid is nil")
    return
  end
end

function TalentDataUtils.GetAwakerQualitySortByTalentCfgId(talentCfgId)
  local talentCfg = TalentDataUtils.GetSpecialSkillConfig(talentCfgId)
  local awakerId = talentCfg.AwakerID[1]
  local awakerCfg = DT.AwakerConfig[awakerId]
  local qualitySort = awakerCfg and awakerCfg.Quality and QualitySortValueTable[awakerCfg.Quality]
  return qualitySort
end

function TalentDataUtils.IsSpecialSkill_HasOrCan_Active(effectType, funcModule)
  local effectList = TalentDataUtils.GetTalentsByParams(effectType, funcModule)
  if not effectList then
    return false
  end
  for _, data in pairs(effectList) do
    if TalentDataUtils.IsTalentCanUnlock(data.configId) or TalentDataUtils.IsTalentUnlocked(data.configId) then
      return true
    end
  end
  return false
end

function TalentDataUtils.IsSpecialSkill_Can_Active(effectType, funcModule)
  local effectList = TalentDataUtils.GetTalentsByParams(effectType, funcModule)
  if not effectList then
    return false
  end
  for _, data in pairs(effectList) do
    if TalentDataUtils.IsTalentCanUnlock(data.configId) then
      return true
    end
  end
  return false
end

function TalentDataUtils.CalReduceCoin_WhenLvUp(coinCost)
  local effectType = CommonDefine.AwakerSpecialSkillType.ResNeedReduce
  local funcModule = "AwakerLevelUp"
  local resuceExp = TalentDataUtils.GetResouceReduceResult(coinCost, effectType, funcModule)
  if resuceExp then
    do return math.floor end
    return math.floor, resuceExp, funcModule
  end
  return coinCost
end

function TalentDataUtils.GetDisplayTalentLvDesc(talents)
  local talentLvs = TalentDataUtils.GetDisplayTalentLvList(talents)
  do return table.concat, talentLvs end
  return table.concat, talentLvs, "/"
end

function TalentDataUtils.GetDisplayTalentLvList(talents)
  local talentLvs = {}
  for i = 1, #CommonDefine.AwakerTalentOrderedType do
    talentLvs[i] = 0
  end
  if talents then
    for k, v in pairs(talents) do
      local talentCfg = DT.AwakerTalent[k]
      local talentName = talentCfg and talentCfg.data_list[1].TalentName or ""
      for i = 1, #CommonDefine.AwakerTalentOrderedType do
        local talentType = CommonDefine.AwakerTalentOrderedType[i]
        if string.contains(talentName, cd.AwakerTalentName[talentType]) then
          talentLvs[i] = v.lv or 0
          break
        end
      end
    end
  end
  return talentLvs
end

function TalentDataUtils.GetDisplayTalentLv(talents)
  do return table.unpack, TalentDataUtils.GetDisplayTalentLvList(talents) end
  return table.unpack, TalentDataUtils.GetDisplayTalentLvList(talents)
end

function TalentDataUtils.IsAttrTalent(talentTid)
  local talentCfg = DT.AwakerTalent[talentTid]
  if not talentCfg then
    return false
  end
  local attrTalentName = cd.AwakerTalentName[cd.AwakerTalentType.AttrTalent]
  local talentName = talentCfg.data_list and talentCfg.data_list[1].TalentName or nil
  if not talentName then
    return false
  end
  do return string.contains, talentName end
  return string.contains, talentName, attrTalentName
end

return TalentDataUtils
