local group2resonancesConfigs, resonanceGroup2StageGroupIds
local ResonanceDataUtils = {}

function ResonanceDataUtils.ResetAll()
  DataCenter.resonanceData.resonances = {}
  DataCenter.resonanceData.groupedResonances = {}
  DataCenter.resonanceData.requestingRroupedResonances = {}
end

function ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(stageGroupId)
  do return CopyDataUtils.GetResonanceGroupId end
  return CopyDataUtils.GetResonanceGroupId, stageGroupId
end

function ResonanceDataUtils.GetStageGroupIdsByResonanceGroupId(resonanceGroupId)
  if not resonanceGroupId then
    return
  end
  if not resonanceGroup2StageGroupIds then
    resonanceGroup2StageGroupIds = {}
    for stageGroupId, cfg in pairs(DT.StageGroup) do
      if cfg.BattleBuff and 1 == cfg.BattleBuff[1] then
        local rgId = cfg.BattleBuff[2]
        local list = resonanceGroup2StageGroupIds[rgId]
        if not list then
          list = {}
          resonanceGroup2StageGroupIds[rgId] = list
        end
        table.insert(list, stageGroupId)
      end
    end
  end
  return resonanceGroup2StageGroupIds[resonanceGroupId]
end

function ResonanceDataUtils.GetStageGroupIdByResonanceGroupId(resonanceGroupId)
  local list = ResonanceDataUtils.GetStageGroupIdsByResonanceGroupId(resonanceGroupId)
  return list and list[1]
end

function ResonanceDataUtils.GetResonanceGroupConfig()
  if not group2resonancesConfigs then
    group2resonancesConfigs = {}
    for resonanceId, resonanceInfo in pairs(DT.Resonance) do
      local belongGroup = resonanceInfo.data_list[1].BelongGroup
      local groupChaters = group2resonancesConfigs[belongGroup]
      if not groupChaters then
        groupChaters = {}
        group2resonancesConfigs[belongGroup] = groupChaters
      end
      table.insert(groupChaters, resonanceInfo)
    end
    for k, v in pairs(group2resonancesConfigs) do
      table.sort(v, function(a, b)
        return a.data_list[1].BaseSortID < b.data_list[1].BaseSortID
      end)
    end
  end
  return group2resonancesConfigs
end

function ResonanceDataUtils.GetResonanceConfigByGroupId(resonanceGroupId)
  local resonanceCfgs = ResonanceDataUtils.GetResonanceGroupConfig()
  return resonanceCfgs[resonanceGroupId] or {}
end

function ResonanceDataUtils.ReqAllResonanceData()
  local chapterList = {
    cd.StageChapterName.StageChapterMorimens,
    cd.StageChapterName.StageChapterStarsCameRight
  }
  for _, stageChapterName in ipairs(chapterList) do
    local groupIdList = CopyDataUtils.CalculateChapterIndex(CommonDefine.Difficulty.Normal, stageChapterName)
    for _, groupId in pairs(groupIdList) do
      if MainCopyDataUtils.IsStageGroupUnlock(groupId) and not CopyDataUtils.IsCrazyStageGroup(groupId) then
        local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(groupId)
        ResonanceDataUtils.ReqResonanceData(resonanceGroupId)
      end
    end
  end
end

function ResonanceDataUtils.ReqLargeSubplotGroupResonanceDatas()
  local groupIdList = CopyExtModel.Instance:GetSublplotLargeGroupList()
  for _, groupId in pairs(groupIdList) do
    if SubplotRedUtils.CheckGroupRedValid(groupId) and not CopyDataUtils.IsCrazyStageGroup(groupId) then
      local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(groupId)
      ResonanceDataUtils.ReqResonanceData(resonanceGroupId)
    end
  end
end

function ResonanceDataUtils.ReqResonanceData(resonanceGroupId, callback)
  if not resonanceGroupId then
    if callback then
      callback()
    end
    return
  end
  local isResonanceData = ResonanceDataUtils.IsResonanceGroupDataInited(resonanceGroupId)
  if not isResonanceData then
    EventMgr.Instance.OpenReqMask:Dispatch()
    DataCenter.resonanceData.requestingRroupedResonances[resonanceGroupId] = true
    ProtoManager.Instance:ReqServer("GameRequest", "OnTalentList", function(resonanceData)
      local resourcedCfgs = ResonanceDataUtils.GetResonanceConfigByGroupId(resonanceGroupId)
      ResonanceDataUtils.UpdateResonances(resonanceData)
      ResonanceDataUtils.ActiveFirstResonance(resourcedCfgs[1].ID)
      DataCenter.resonanceData.requestingRroupedResonances[resonanceGroupId] = false
      ResonanceDataUtils.UpdateResonancesGroupData(resonanceGroupId)
      RedPointDataUtils.UpdateMainStageResonance(resonanceGroupId)
      if callback then
        callback()
      end
    end, function()
    end, resonanceGroupId)
  elseif callback then
    callback()
  end
end

function ResonanceDataUtils.ReqUpgradeResonance(tid, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnUpgradeTalent", function(resonanceData)
    ResonanceDataUtils.SetResonanceLevel(tid, resonanceData.lv)
    local resonanceGroupId = ResonanceDataUtils.GetResonanceBelongGroup(tid)
    RedPointDataUtils.UpdateMainStageResonance(resonanceGroupId)
    if callback then
      callback()
    end
    GlobalDispatcher:Dispatch(NotifyId.OnResonanceDataChanged, resonanceGroupId, tid)
  end, function()
  end, tid)
end

function ResonanceDataUtils.ReqResetResonance(resonanceGroupId, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnTalentReset", function()
    ResonanceDataUtils.ResetResonances(resonanceGroupId)
    RedPointDataUtils.UpdateMainStageResonance(resonanceGroupId)
    if callback then
      callback()
    end
    GlobalDispatcher:Dispatch(NotifyId.OnResonanceDataChanged, resonanceGroupId)
  end, function()
  end, resonanceGroupId)
end

function ResonanceDataUtils.OpenResonancePanel(stageGroupId)
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(stageGroupId)
  local isResonanceData = ResonanceDataUtils.IsResonanceGroupDataInited(resonanceGroupId)
  if not isResonanceData then
    ResonanceDataUtils.ReqResonanceData(resonanceGroupId, function()
      UIManager.Instance:Reopen(Urls.ResonanceMainPanel, {resonanceGroupId = resonanceGroupId, stageGroupTid = stageGroupId})
    end)
  else
    UIManager.Instance:Reopen(Urls.ResonanceMainPanel, {resonanceGroupId = resonanceGroupId, stageGroupTid = stageGroupId})
  end
end

function ResonanceDataUtils.GetResonanceName(tid)
  local resonanceConfig = DT.Resonance[tid]
  if not resonanceConfig then
    return ""
  end
  local lv = math.max(1, ResonanceDataUtils.GetResonanceLevel(tid))
  do return LT.Text end
  return LT.Text, resonanceConfig.data_list[lv].Name, ResonanceDataUtils.GetResonanceLevel(tid)
end

function ResonanceDataUtils.GetResonanceDesc(tid)
  local lv = math.max(1, ResonanceDataUtils.GetResonanceLevel(tid))
  local resonanceConfig = DT.Resonance[tid]
  if not resonanceConfig or not resonanceConfig.data_list[lv] then
    return ""
  end
  do return LT.Text end
  return LT.Text, resonanceConfig.data_list[lv].Desc
end

function ResonanceDataUtils.GetResonanceBelongGroup(tid)
  local resonanceConfig = DT.Resonance[tid]
  return resonanceConfig.data_list[1].BelongGroup
end

function ResonanceDataUtils.GetPreResonanceIds(configId)
  local ret = {}
  local resonanceConfig = DT.Resonance[configId]
  if resonanceConfig and resonanceConfig.data_list[1].PreResonance and #resonanceConfig.data_list[1].PreResonance > 0 then
    for _, tid in ipairs(resonanceConfig.data_list[1].PreResonance) do
      table.insert(ret, tid)
    end
  end
  if 0 == #ret then
    local resonance = ResonanceDataUtils.GetResonance(configId)
    if resonance.isDefaultActiveResonace then
      return ret
    end
    local resonanceCfgs = ResonanceDataUtils.GetResonanceGroupConfig()
    local belongGroup = resonanceConfig.data_list[1].BelongGroup
    local groupChaters = resonanceCfgs[belongGroup]
    table.insert(ret, groupChaters[1].ID)
  end
  return ret
end

function ResonanceDataUtils.IsAllPreResonanceActive(tid)
  local cfg = DT.Resonance[tid]
  if not cfg then
    return false
  end
  local data = cfg.data_list[1]
  if data.ConsumeType then
    do return TaskDataUtils.IsTaskDoneByTaskId end
    return TaskDataUtils.IsTaskDoneByTaskId, data.ConsumeType, nil, nil, nil, nil, nil, nil, nil, nil, nil
  end
  if not data.PreResonance or not table.next(data.PreResonance) then
    return true
  end
  local preResonanceGroup = data.PreResonance
  if 1 == #preResonanceGroup then
    do return ResonanceDataUtils.IsResonanceActive end
    return ResonanceDataUtils.IsResonanceActive, preResonanceGroup[1], nil, nil, nil, nil, nil, nil, nil, nil
  end
  local unlockCommon = data.UnlockCommon or CommonDefine.ResonanceUnlockType.Or
  if unlockCommon == CommonDefine.ResonanceUnlockType.Or then
    for _, preTid in ipairs(preResonanceGroup) do
      if ResonanceDataUtils.IsResonanceActive(preTid) then
        return true
      end
    end
    return false
  elseif unlockCommon == CommonDefine.ResonanceUnlockType.And then
    local rst = true
    for _, preTid in ipairs(preResonanceGroup) do
      if not ResonanceDataUtils.IsResonanceActive(preTid) then
        rst = false
      end
    end
    return rst
  end
end

function ResonanceDataUtils.GetResonanceUnlockCommon(tid)
  return DT.Resonance[tid] and DT.Resonance[tid].data_list[1] and DT.Resonance[tid].data_list[1].UnlockCommon or CommonDefine.ResonanceUnlockType.Or
end

function ResonanceDataUtils.GetResonanceUnlockConditionText(unlockCommon)
  return unlockCommon == CommonDefine.ResonanceUnlockType.Or and LT.Text("ResonanceUnlock_Or") or LT.Text("ResonanceUnlock_And")
end

function ResonanceDataUtils.ActiveFirstResonance(tid)
  local belongGroup = ResonanceCfgUtils.GetCfgField("BelongGroup", tid, 1)
  if belongGroup == CommonDefine.ResonanceGroupRailway then
    return
  end
  local resonance = ResonanceDataUtils.GetResonance(tid)
  resonance.isDefaultActiveResonace = true
  resonance.resonanceLevel = 1
end

function ResonanceDataUtils.IsResonanceActive(tid)
  local resonance = ResonanceDataUtils.GetResonance(tid)
  return resonance and resonance.resonanceLevel > 0
end

function ResonanceDataUtils.IsResonanceUnLocked(tid)
  do return ResonanceDataUtils.IsAllPreResonanceActive end
  return ResonanceDataUtils.IsAllPreResonanceActive, tid
end

function ResonanceDataUtils.GetResonance(tid)
  local resonance = DataCenter.resonanceData.resonances[tid]
  if not resonance then
    resonance = {resonanceId = tid, resonanceLevel = 0}
    DataCenter.resonanceData.resonances[tid] = resonance
  end
  return resonance
end

function ResonanceDataUtils.IsResonanceGroupDataInited(resonanceGroupId)
  return resonanceGroupId and DataCenter.resonanceData.groupedResonances[resonanceGroupId] ~= nil
end

function ResonanceDataUtils.UpdateResonances(resonanceData)
  for k, v in pairs(resonanceData.talent) do
    local resonance = ResonanceDataUtils.GetResonance(v.tid)
    resonance.resonanceLevel = v.lv
  end
end

function ResonanceDataUtils.ResetResonances(resonanceGroupId)
  local resonanceConfigs = ResonanceDataUtils.GetResonanceConfigByGroupId(resonanceGroupId)
  for _, v in pairs(resonanceConfigs) do
    ResonanceDataUtils.SetResonanceLevel(v.ID, 0)
  end
end

function ResonanceDataUtils.UpdateResonancesGroupData(resonanceGroupId)
  DataCenter.resonanceData.groupedResonances[resonanceGroupId] = {}
  local resonanceConfigs = ResonanceDataUtils.GetResonanceConfigByGroupId(resonanceGroupId)
  for _, v in pairs(resonanceConfigs or {}) do
    local resonance = ResonanceDataUtils.GetResonance(v.ID)
    table.insert(DataCenter.resonanceData.groupedResonances[resonanceGroupId], resonance)
  end
end

function ResonanceDataUtils.GeteResonancesGroupData(resonanceGroupId)
  return DataCenter.resonanceData.groupedResonances[resonanceGroupId]
end

function ResonanceDataUtils.GetActiveResonanceList(groupId)
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(groupId)
  local resonancesGroupData = ResonanceDataUtils.GeteResonancesGroupData(resonanceGroupId) or {}
  local activeResonanceList = {}
  for i = 1, #resonancesGroupData do
    if ResonanceDataUtils.IsResonanceActive(resonancesGroupData[i].resonanceId) then
      table.insert(activeResonanceList, resonancesGroupData[i])
    end
  end
  return activeResonanceList
end

function ResonanceDataUtils.SetResonanceLevel(tid, level)
  local resonance = ResonanceDataUtils.GetResonance(tid)
  resonance.resonanceLevel = level or 0
end

function ResonanceDataUtils.GetResonanceLevel(tid)
  local resonance = ResonanceDataUtils.GetResonance(tid)
  return resonance and resonance.resonanceLevel or 0
end

function ResonanceDataUtils.GetResonanceMaxLevel(tid)
  local cfg = DT.Resonance[tid]
  if not cfg then
    return 0
  end
  if not cfg.data_list then
    return 0
  end
  return #cfg.data_list
end

function ResonanceDataUtils.IsResonanceArriveMaxLevel(tId)
  local currLv = ResonanceDataUtils.GetResonanceLevel(tId)
  local maxLv = ResonanceDataUtils.GetResonanceMaxLevel(tId)
  return currLv >= maxLv
end

function ResonanceDataUtils.GetResonanceGroupTotalLevel(resonanceGroupId)
  local resonances = ResonanceDataUtils.GeteResonancesGroupData(resonanceGroupId)
  local totalLevel = 0
  if not resonances then
    return totalLevel
  end
  for i = 1, #resonances do
    totalLevel = totalLevel + resonances[i].resonanceLevel
  end
  return totalLevel
end

function ResonanceDataUtils.GetResonanceGroupMaxLevel(resonanceGroupId)
  local resonanceConfigs = ResonanceDataUtils.GetResonanceConfigByGroupId(resonanceGroupId)
  local maxLevel = 0
  for k, v in pairs(resonanceConfigs) do
    maxLevel = maxLevel + ResonanceDataUtils.GetResonanceMaxLevel(v.ID)
  end
  return maxLevel
end

function ResonanceDataUtils.IsExistedUpgradeableResonance(resonanceGroupId)
  local resonanceConfigs = ResonanceDataUtils.GetResonanceConfigByGroupId(resonanceGroupId)
  for k, v in pairs(resonanceConfigs) do
    if ResonanceDataUtils.IsResonanceUpgradeable(v.ID) then
      return true
    end
  end
  return false
end

function ResonanceDataUtils.IsResonanceUpgradeable(tid, noUseExtra)
  if not ResonanceDataUtils.IsResonanceUnLocked(tid) then
    return false
  end
  if ResonanceDataUtils.IsResonanceArriveMaxLevel(tid) then
    return false
  end
  do return ResonanceDataUtils.IsResonanceUpgradeMaterialEnough, tid end
  return ResonanceDataUtils.IsResonanceUpgradeMaterialEnough, tid, noUseExtra
end

function ResonanceDataUtils.IsResonanceShowRed(tid)
  do return ResonanceDataUtils.IsResonanceUpgradeable, tid end
  return ResonanceDataUtils.IsResonanceUpgradeable, tid, true
end

function ResonanceDataUtils.GetResonanceGroupBasicConsumeMaterial(resonanceGroup)
  local cfg = DT.Constant[resonanceGroup]
  local cData = cfg and cfg.Data or {}
  return cData and cData[1] or nil
end

function ResonanceDataUtils.GetResonanceGroupActivityId(resonanceGroup)
  local cfg = DT.Constant[resonanceGroup]
  local cData = cfg and cfg.Data
  return cData and cData[6] or nil
end

function ResonanceDataUtils.GetResonanceGroupAllConsumeMaterials(resonanceGroup, materialsList)
  local itemId = ResonanceDataUtils.GetResonanceGroupBasicConsumeMaterial(resonanceGroup)
  materialsList = materialsList or {}
  table.clear(materialsList)
  table.insert(materialsList, itemId)
  local activityId = ResonanceDataUtils.GetResonanceGroupActivityId(resonanceGroup)
  local isFinishedActivity = ActivityManager.Instance:IsActivityFinishedByTid(activityId)
  if not activityId or 0 == activityId or not isFinishedActivity then
    return materialsList
  end
  local resonancesGroupData = ResonanceDataUtils.GeteResonancesGroupData(resonanceGroup) or {}
  for i = 1, #resonancesGroupData do
    local resonanceCfg = DT.Resonance[resonancesGroupData[i].resonanceId]
    local resonantConversion = resonanceCfg and resonanceCfg.data_list[1].ResonantConversion or nil
    if resonantConversion and resonantConversion[1] and not table.contains(materialsList, resonantConversion[1]) then
      table.insert(materialsList, resonantConversion[1])
    end
  end
  return materialsList
end

function ResonanceDataUtils.GetResonanceLevelCost(tid, curLevel)
  local cfg = DT.Resonance[tid]
  if not cfg then
    return
  end
  if not cfg.data_list then
    return
  end
  local nextCfg = cfg.data_list[curLevel + 1]
  if not nextCfg then
    return
  end
  local itemId = ResonanceDataUtils.GetResonanceGroupBasicConsumeMaterial(nextCfg.BelongGroup)
  local activityId = ResonanceDataUtils.GetResonanceGroupActivityId(nextCfg.BelongGroup)
  local itemNum = nextCfg.Consume or 0
  local ownedNum = ItemDataUtils.GetItemNum(itemId)
  local extraItemId, extraItemNum, extraItemOwned
  if itemNum > ownedNum and activityId and 0 ~= activityId and ActivityManager.Instance:IsActivityFinishedByTid(activityId) then
    local resonantConversion = nextCfg.ResonantConversion or nil
    if resonantConversion then
      extraItemId = resonantConversion[1]
      extraItemNum = resonantConversion[2] * (itemNum - ownedNum)
      extraItemOwned = ItemDataUtils.GetItemNum(extraItemId)
    end
  end
  return {
    itemId = itemId,
    itemNum = itemNum,
    ownedNum = ownedNum,
    extraItemId = extraItemId,
    extraItemNum = extraItemNum,
    extraItemOwned = extraItemOwned
  }
end

function ResonanceDataUtils.IsResonanceUpgradeMaterialEnough(tid, noUseExtraItem)
  local currLv = ResonanceDataUtils.GetResonanceLevel(tid)
  local itemsConfig = ResonanceDataUtils.GetResonanceLevelCost(tid, currLv)
  local itemId, consumeNum = itemsConfig.itemId, itemsConfig.itemNum
  local itemNum = ItemDataUtils.GetItemNum(itemId)
  if consumeNum <= itemNum then
    return true
  end
  local isUseExtra = not noUseExtraItem
  if isUseExtra and itemsConfig.extraItemId then
    return itemsConfig.extraItemOwned >= itemsConfig.extraItemNum
  end
  return false
end

function ResonanceDataUtils.GetResonanceResetCost(resonanceGroup)
  local cfg = DT.Constant[resonanceGroup]
  local cData = cfg and cfg.Data or {}
  return cData[2], cData[3]
end

function ResonanceDataUtils.GetUpgradeGroupToMaxCost(resonanceGroup)
  local group2ResourcesMap = ResonanceDataUtils.GetResonanceGroupConfig()
  local resonances = group2ResourcesMap[resonanceGroup]
  if not resonances then
    return
  end
  local needItemTid = ResonanceDataUtils.GetResonanceGroupBasicConsumeMaterial(resonanceGroup)
  local totalNeedNum = 0
  for _, resonanceCfg in pairs(resonances) do
    local resonanceTid = resonanceCfg.ID
    local currLv = ResonanceDataUtils.GetResonanceLevel(resonanceTid)
    local maxLv = ResonanceDataUtils.GetResonanceMaxLevel(resonanceTid)
    local isReachMax = currLv >= maxLv
    if isReachMax then
    else
      for level = currLv, maxLv - 1 do
        local costInfo = ResonanceDataUtils.GetResonanceLevelCost(resonanceTid, level)
        if costInfo and costInfo.itemNum then
          totalNeedNum = totalNeedNum + costInfo.itemNum
        end
      end
    end
  end
  return needItemTid, totalNeedNum
end

function ResonanceDataUtils.IsMapNodeTypeRelateToResonance(mapNodeType)
  local groupIndex = 1
  while true do
    local mt = CommonDefine.GearItemType["StageGroup_" .. groupIndex .. "_Talent"]
    if not mt then
      return false
    end
    if mt == mapNodeType then
      return true
    end
    groupIndex = groupIndex + 1
  end
end

return ResonanceDataUtils
