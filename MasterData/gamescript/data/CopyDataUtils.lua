local StageGroupType = CommonDefine.StageGroupType
local FeatureId = CommonDefine.FeatureId
local TaskState = CommonDefine.TaskState
local CopyDataUtils = {}

function CopyDataUtils.ResetAll()
  DataCenter.copyData.data = {}
  DataCenter.copyData.stageInfo = {}
  CopyDataUtils.Set_needShowBattleSettleTips(false)
end

function CopyDataUtils.ResetStageGroupData(stageGroupId)
  DataCenter.copyData.data[stageGroupId] = nil
  DataCenter.copyData.stageInfo[stageGroupId] = nil
end

CopyDataUtils.StageGroupTypeMapFeatureId = {
  [CommonDefine.StageGroupType.MaterialCopy] = CommonDefine.FeatureId.ResCopy,
  [CommonDefine.StageGroupType.TrinketCopy] = CommonDefine.FeatureId.TrinketCopy
}
local StageGroupType2FeatureIdMap = {
  [StageGroupType.SmallSubplotNormal] = FeatureId.SmallSubplot,
  [StageGroupType.SmallSubplotHard] = FeatureId.SmallSubplotHard,
  [StageGroupType.SmallSubplotCrazy] = FeatureId.SmallSubplotCrazy,
  [StageGroupType.LargeSubplotNormal] = FeatureId.LargeSubplot,
  [StageGroupType.LargeSubplotHard] = FeatureId.LargeSubplotHard,
  [StageGroupType.LargeSubplotCrazy] = FeatureId.LargeSubplotCrazy,
  [StageGroupType.SpecialSubplotNormal] = FeatureId.SpecialSubplot,
  [StageGroupType.LinkageActivityNormal] = FeatureId.SpecialSubplot,
  [StageGroupType.LinkageActivityHard] = FeatureId.SpecialSubplot,
  [StageGroupType.LinkageActivityCrazy] = FeatureId.SpecialSubplot,
  [StageGroupType.SpecialSubplotHard] = FeatureId.SpecialSubplot,
  [StageGroupType.SpecialSubplotCrazy] = FeatureId.SpecialSubplot
}
CopyDataUtils.StageGroupType2FeatureIdMap = StageGroupType2FeatureIdMap
CopyDataUtils.StageGroupId2FeatureUnlockTid = nil
local StageGroupType2SubplotGroupCopyPage = {
  [CommonDefine.StageGroupType.Vindicate] = CommonDefine.MainCopyPanelPage.Vindicate,
  [CommonDefine.StageGroupType.SmallSubplotNormal] = CommonDefine.MainCopyPanelPage.SmallSubplot,
  [CommonDefine.StageGroupType.SmallSubplotHard] = CommonDefine.MainCopyPanelPage.SmallSubplot,
  [CommonDefine.StageGroupType.SmallSubplotCrazy] = CommonDefine.MainCopyPanelPage.SmallSubplot,
  [CommonDefine.StageGroupType.LargeSubplotNormal] = CommonDefine.MainCopyPanelPage.LargeSubplot,
  [CommonDefine.StageGroupType.LargeSubplotHard] = CommonDefine.MainCopyPanelPage.LargeSubplot,
  [CommonDefine.StageGroupType.LargeSubplotCrazy] = CommonDefine.MainCopyPanelPage.LargeSubplot,
  [CommonDefine.StageGroupType.SpecialSubplotNormal] = CommonDefine.MainCopyPanelPage.SpecialSubplot,
  [CommonDefine.StageGroupType.SpecialSubplotHard] = CommonDefine.MainCopyPanelPage.SpecialSubplot,
  [CommonDefine.StageGroupType.SpecialSubplotCrazy] = CommonDefine.MainCopyPanelPage.SpecialSubplot,
  [CommonDefine.StageGroupType.LinkageActivityNormal] = CommonDefine.MainCopyPanelPage.LinkageActivity,
  [CommonDefine.StageGroupType.LinkageActivityHard] = CommonDefine.MainCopyPanelPage.LinkageActivity,
  [CommonDefine.StageGroupType.LinkageActivityCrazy] = CommonDefine.MainCopyPanelPage.LinkageActivity
}
CopyDataUtils.StageGroupType2SubplotGroupCopyPage = StageGroupType2SubplotGroupCopyPage

function CopyDataUtils.ReqCopyData(featureId, stageGroupId, callback, isRefreshData)
  local curData = DataCenter.copyData.data[stageGroupId]
  if not isRefreshData and curData then
    if callback then
      callback()
    end
    return
  end
  ProtoManager.Instance:ReqServer("StageRequest", "GetStageInfo", function(data)
    Logger.Info("GetStageInfo Sucessful data ", table.tostring(data))
    for _, groupInfo in ipairs(data or {}) do
      local list = groupInfo and groupInfo.stageList
      Logger.Info("GetStageInfo stageListLen", groupInfo and groupInfo.stageGroupID or 0, list and #list or 0)
    end
    CopyDataUtils.UpdateCopyData(data)
    if callback then
      callback()
    end
  end, function()
  end, featureId or "", stageGroupId or 0)
end

function CopyDataUtils.HasStageGroupStageList(stageGroupId)
  if not stageGroupId or 0 == stageGroupId then
    return false
  end
  local stageList = CopyDataUtils.GetStageList(stageGroupId)
  return nil ~= stageList and #stageList > 0
end

function CopyDataUtils.CollectGuideNoteNeedRequestStageGroupIds(stageGroupIdList)
  local needRequestList = {}
  local added = {}
  if not stageGroupIdList then
    return needRequestList
  end
  for _, stageGroupId in ipairs(stageGroupIdList) do
    if not stageGroupId or 0 == stageGroupId or added[stageGroupId] then
    elseif CopyDataUtils.HasStageGroupStageList(stageGroupId) then
    elseif CopyDataUtils.IsCrazyStageGroup(stageGroupId) then
    elseif CopyDataUtils.IsStageGroupFeatureLocked(stageGroupId) then
    else
      added[stageGroupId] = true
      table.insert(needRequestList, stageGroupId)
    end
  end
  return needRequestList
end

function CopyDataUtils.ShouldSkipCrazyStageRequest(stageGroupId)
  if not CopyDataUtils.IsCrazyStageGroup(stageGroupId) then
    return false
  end
  local difficult2TidMap = CopyDataUtils.GetSubplotDifficult2IdMap(stageGroupId)
  if difficult2TidMap then
    local hardModeIndex = CommonDefine.StageGroupHardModeIndex.Hard
    if difficult2TidMap[hardModeIndex] == stageGroupId then
      return false
    end
  end
  return true
end

function CopyDataUtils.TryAddNeedRequestStageGroupId(needRequestList, added, stageGroupId)
  if not (stageGroupId and 0 ~= stageGroupId and needRequestList) or not added then
    return
  end
  if added[stageGroupId] then
    return
  end
  if CopyDataUtils.ShouldSkipCrazyStageRequest(stageGroupId) then
    return
  end
  if CopyDataUtils.IsStageGroupFeatureLocked(stageGroupId) then
    return
  end
  if CopySubplotGroupModel.Instance:IsHaveServerStageData(stageGroupId) then
    return
  end
  added[stageGroupId] = true
  table.insert(needRequestList, stageGroupId)
end

function CopyDataUtils.CollectNeedRequestStageGroupIds(stageGroupIdList)
  local needRequestList = {}
  local added = {}
  if not stageGroupIdList then
    return needRequestList
  end
  for _, stageGroupId in ipairs(stageGroupIdList) do
    CopyDataUtils.TryAddNeedRequestStageGroupId(needRequestList, added, stageGroupId)
    local difficult2TidMap = CopyDataUtils.GetSubplotDifficult2IdMap(stageGroupId)
    if difficult2TidMap then
      for _, relatedId in pairs(difficult2TidMap) do
        CopyDataUtils.TryAddNeedRequestStageGroupId(needRequestList, added, relatedId)
      end
    end
  end
  return needRequestList
end

function CopyDataUtils.IsStageGroupRelatedDifficulty(stageGroupId, relatedStageGroupId)
  if not stageGroupId or not relatedStageGroupId then
    return false
  end
  if stageGroupId == relatedStageGroupId then
    return true
  end
  local difficult2TidMap = CopyDataUtils.GetSubplotDifficult2IdMap(stageGroupId)
  if not difficult2TidMap then
    return false
  end
  for _, groupId in pairs(difficult2TidMap) do
    if groupId == relatedStageGroupId then
      return true
    end
  end
  return false
end

function CopyDataUtils.ReqCopyDataList(stageGroupIdList, callback)
  if not stageGroupIdList or 0 == #stageGroupIdList then
    if callback then
      callback()
    end
    return
  end
  ProtoManager.Instance:ReqServer("StageRequest", "GetStageInfoList", function(data)
    local groupList = data or {}
    Logger.Info("GetStageInfoList successful, count=", #groupList)
    CopyDataUtils.UpdateCopyData(groupList)
    if callback then
      callback()
    end
  end, function()
    if callback then
      callback()
    end
  end, stageGroupIdList)
end

function CopyDataUtils.PrepareActivityChallengeStageData(stageGroupId, openFunc, featureId)
  featureId = featureId or ""
  local stageList = CopyDataUtils.GetStageList(stageGroupId)
  if stageList and #stageList > 0 then
    openFunc()
    CopyDataUtils.ReqCopyData(featureId, stageGroupId, nil, true)
    return
  end
  CopyDataUtils.ReqCopyData(featureId, stageGroupId, openFunc, true)
end

function CopyDataUtils.PrepareFeatureCopyStageData(featureId, openFunc)
  if openFunc then
    openFunc()
  end
  if not featureId or "" == featureId then
    return
  end
  CopyDataUtils.ReqCopyData(featureId, nil, nil, true)
end

function CopyDataUtils.IsFeatureCopyDataCached(featureId)
  if not featureId or "" == featureId then
    return false
  end
  local cfgList = CopyDataUtils.GetCfgCopyList(featureId)
  if 0 == #cfgList then
    return false
  end
  for _, cfg in ipairs(cfgList) do
    if cfg and cfg.ID and not CopyDataUtils.IsStageGroupFeatureLocked(cfg.ID) and not CopySubplotGroupModel.Instance:IsHaveServerStageData(cfg.ID) then
      return false
    end
  end
  return true
end

function CopyDataUtils.ReqFeatureCopyDataIfNeeded(featureId, callback)
  if not featureId or "" == featureId then
    if callback then
      callback()
    end
    return
  end
  if CopyDataUtils.IsFeatureCopyDataCached(featureId) then
    if callback then
      callback()
    end
    return
  end
  CopyDataUtils.ReqCopyData(featureId, nil, callback)
end

function CopyDataUtils.RefreshFeatureCopyData(featureId, callback)
  if not featureId or "" == featureId then
    if callback then
      callback()
    end
    return
  end
  CopyDataUtils.ReqCopyData(featureId, nil, callback, true)
end

function CopyDataUtils.GetCfgCopyList(featureId)
  assert(type(featureId) == "string", "CopyDataUtils.GetCfgCopyList param error, must be number")
  local result = {}
  local cfg = DT.FeatureUnlock
  for _, v in pairs(cfg) do
    if v.Feature == featureId and v.Key then
      table.insert(result, DT.StageGroup[v.Key])
    end
  end
  table.sort(result, function(a, b)
    return a.ID < b.ID
  end)
  return result
end

function CopyDataUtils.GetFeatureUnlockCfgByStageGroupId(stageGroupId)
  if not stageGroupId or 0 == stageGroupId then
    return nil
  end
  if not CopyDataUtils.StageGroupId2FeatureUnlockTid then
    CopyDataUtils.StageGroupId2FeatureUnlockTid = {}
    for featureUnlockTid, cfg in pairs(DT.FeatureUnlock) do
      local key = cfg and cfg.Key or nil
      if key and 0 ~= key then
        CopyDataUtils.StageGroupId2FeatureUnlockTid[key] = featureUnlockTid
      end
    end
  end
  local featureUnlockTid = CopyDataUtils.StageGroupId2FeatureUnlockTid[stageGroupId]
  if not featureUnlockTid then
    return nil
  end
  return DT.FeatureUnlock[featureUnlockTid]
end

function CopyDataUtils.GetStageGroupUnlockTip(stageGroupId)
  local cfg = CopyDataUtils.GetFeatureUnlockCfgByStageGroupId(stageGroupId)
  if not cfg or not cfg.LockTip then
    return nil
  end
  do return LT.Text end
  return LT.Text, cfg.LockTip
end

function CopyDataUtils.GetStageUnlockTip(stageId)
  local stageCfg = DT.Stage[stageId or 0]
  if not stageCfg or not stageCfg.BelongGroup then
    return nil
  end
  do return CopyDataUtils.GetStageGroupUnlockTip end
  return CopyDataUtils.GetStageGroupUnlockTip, stageCfg.BelongGroup
end

function CopyDataUtils.IsPrologue(stageOrGroupId)
  local cfgPrologueStageGroup = DT.GetConstant("PrologueStageGroup")
  if stageOrGroupId == cfgPrologueStageGroup then
    return true
  end
  local stageCfg = DT.Stage[stageOrGroupId]
  if stageCfg and stageCfg.BelongGroup == cfgPrologueStageGroup then
    return true
  end
end

function CopyDataUtils.IsHaveStarCondition(stageId)
  local cfg = CopyDataUtils.GetStageCfg(stageId)
  return cfg and cfg.PerfectCondition
end

function CopyDataUtils.GetStageGroupData(stageGroupId)
  return stageGroupId and DataCenter.copyData.stageInfo[stageGroupId]
end

function CopyDataUtils.IsForceAssistStageGroup(stageGroupId)
  local stageGroupData = CopyDataUtils.GetStageGroupData(stageGroupId)
  return stageGroupData and stageGroupData.ForceAssist
end

function CopyDataUtils.GetAjustLevelList(stageGroupId)
  local stageGroupCfg = stageGroupId and CopyDataUtils.GetStageGroupConfig(stageGroupId)
  if not stageGroupCfg or not stageGroupCfg.LevelAdjustment then
    return {}
  end
  local cfgAdjustNeedActivityOpen = stageGroupCfg.AdjustNeedActivityOpen
  if cfgAdjustNeedActivityOpen then
    for _, activityTid in pairs(cfgAdjustNeedActivityOpen) do
      if not ActivityManager.Instance:IsActivityOpenedByTid(activityTid) then
        return {}
      end
    end
  end
  return stageGroupCfg.LevelAdjustment
end

function CopyDataUtils.GetStageGroupIdList(stageGroupType, isFilterDisplayDate)
  local cfgList = CopyDataUtils.GetStageGroupCfgList(stageGroupType, isFilterDisplayDate)
  local idList = {}
  for _, v in ipairs(cfgList) do
    table.insert(idList, v.ID)
  end
  return idList
end

function CopyDataUtils.GetStageGroupCfgList(stageGroupType, isFilterDisplayDate)
  local result = {}
  local typeList = type(stageGroupType) == "table" and stageGroupType or {stageGroupType}
  for _, stageInfo in pairs(DT.StageGroup) do
    if table.contains(typeList, stageInfo.Type) then
      if not isFilterDisplayDate then
        table.insert(result, stageInfo)
      elseif not stageInfo.StageDisplayDate or TimeUtils.GetServerTime() >= stageInfo.StageDisplayDate then
        table.insert(result, stageInfo)
      end
    end
  end
  table.sort(result, function(a, b)
    return (a.Sequence or a.BaseSortID) < (b.Sequence or b.BaseSortID)
  end)
  return result
end

function CopyDataUtils.GetWeekCopyCfgList()
  do return CopyDataUtils.GetStageGroupCfgList end
  return CopyDataUtils.GetStageGroupCfgList, {
    CommonDefine.StageGroupType.WeeklyCopy,
    CommonDefine.StageGroupType.WeeklyCopy2
  }, CommonDefine.StageGroupType.WeeklyCopy, CommonDefine.StageGroupType.WeeklyCopy2
end

function CopyDataUtils.UpdateCopyData(data)
  MainCopyDataUtils.UpdateStageData(data)
  local copyData = DataCenter.copyData
  for _, v in pairs(data) do
    copyData.data[v.stageGroupID] = v.stageList
    copyData.stageInfo[v.stageGroupID] = v
    GlobalDispatcher:Dispatch(NotifyId.OnStageDataChanged, v.stageGroupID)
  end
end

function CopyDataUtils.GetStageInitRelic(stageId)
  local rst = {}
  if not stageId then
    Logger.Debug("Error stageId:", stageId)
    return rst
  end
  local stageCfg = DT.Stage[stageId]
  if stageCfg and stageCfg.InitRelic then
    rst = stageCfg.InitRelic
  end
  return rst
end

function CopyDataUtils.GetStageData(stageGroupId, stageId)
  if not stageGroupId then
    local stageCfg = CopyDataUtils.GetStageCfg(stageId)
    stageGroupId = stageCfg and stageCfg.BelongGroup
  end
  local stageList = CopyDataUtils.GetStageList(stageGroupId)
  if not stageList then
    return nil
  end
  for _, stageData in pairs(stageList) do
    if stageData.stageID == stageId then
      return stageData
    end
  end
  return nil
end

function CopyDataUtils.GetStageGroupId(stageId)
  local stageCfg = DT.Stage[stageId]
  return stageCfg and stageCfg.BelongGroup
end

function CopyDataUtils.GetStageInfo(copyID)
  local copyData = DataCenter.copyData
  return copyData.stageInfo[copyID]
end

function CopyDataUtils.GetStageList(copyID)
  local copyData = DataCenter.copyData
  return copyData.data[copyID]
end

function CopyDataUtils.GetStageRewardPreviewSortWeight(item)
  local weight = 9999
  local gap = 100
  local awardType = item.awardType or item.type
  local isGot = item.isGot
  if awardType == CommonDefine.ItemAwardType.First3Star and not isGot then
    return weight - (item.index or 0)
  end
  weight = weight - gap
  if awardType == CommonDefine.ItemAwardType.First and not isGot then
    return weight - (item.index or 0)
  end
  weight = weight - gap
  if awardType == CommonDefine.ItemAwardType.FirstMult and not isGot then
    return weight - (item.index or 0)
  end
  weight = weight - gap
  if awardType == CommonDefine.ItemAwardType.Normal then
    return weight - (item.index or 0)
  end
  if awardType == CommonDefine.ItemAwardType.First3Star then
    return weight - (item.index or 0)
  end
  weight = weight - gap
  if awardType == CommonDefine.ItemAwardType.First then
    return weight - (item.index or 0)
  end
  return weight
end

function CopyDataUtils.GetStageRewardPreviewList(stageId, opts)
  opts = opts or {}
  local cfg = DT.Stage[stageId]
  if not cfg then
    return {}
  end
  local stageData = CopyDataUtils.GetStageData(cfg.BelongGroup, stageId) or {}
  local curStar = stageData.star or 0
  local firstRewardDraw = stageData.firstRewardDraw == true
  local firstPassGotMode = opts.firstPassGotMode or "first_draw"
  local firstIsGot = "star" == firstPassGotMode and curStar > 0 or firstRewardDraw
  local rewards = {}
  for tid, num, index in table.iteraDouble(cfg.FirstTimeReward or {}) do
    table.insert(rewards, {
      tid = tid,
      num = num,
      type = CommonDefine.ItemAwardType.First,
      isGot = firstIsGot,
      index = index
    })
  end
  for tid, num, index in table.iteraDouble(cfg.PerfectReward or {}) do
    table.insert(rewards, {
      tid = tid,
      num = num,
      type = CommonDefine.ItemAwardType.First3Star,
      isGot = curStar >= 3,
      index = index
    })
  end
  for tid, num, index in table.iteraDouble(cfg.NormalReward or {}) do
    table.insert(rewards, {
      tid = tid,
      num = num,
      type = CommonDefine.ItemAwardType.Normal,
      index = index
    })
  end
  if opts.includeTaskNormalReward and cfg.TaskCondition and TaskDataUtils.CheckTaskListIsAllDone(cfg.TaskCondition) then
    for tid, num, index in table.iteraDouble(cfg.TaskNormalReward or {}) do
      table.insert(rewards, {
        tid = tid,
        num = num,
        type = CommonDefine.ItemAwardType.Normal,
        index = index
      })
    end
  end
  rewards = ItemDataUtils.KickoutAwakerFavorItem(rewards)
  table.sort(rewards, function(a, b)
    local weightA = CopyDataUtils.GetStageRewardPreviewSortWeight(a)
    local weightB = CopyDataUtils.GetStageRewardPreviewSortWeight(b)
    if weightA == weightB then
      local itemA = DT.Item[a.tid]
      local itemB = DT.Item[b.tid]
      return itemA.BaseSortID < itemB.BaseSortID
    end
    return weightA > weightB
  end)
  return rewards
end

function CopyDataUtils.GetCfgStageList(copyID)
  local result = {}
  for _, v in pairs(DT.Stage) do
    if v.BelongGroup == copyID then
      table.insert(result, v)
    end
  end
  table.sort(result, function(a, b)
    return a.Sequence < b.Sequence
  end)
  return result
end

function CopyDataUtils.GetUnlockedStageList(copyID)
  local list = CopyDataUtils.GetStageList(copyID)
  if list then
    local result = {}
    for _, v in ipairs(list) do
      if v.unlock == true then
        table.insert(result, v)
      end
    end
    return result
  else
    Logger.Info("GetUnlockedStageList is nil copyId is" .. copyID)
  end
end

function CopyDataUtils.IsInOpenTime(copyID)
  local cfgData = DT.StageGroup[copyID]
  if nil == cfgData then
    return false
  end
  if nil == cfgData.OpenTime then
    return true
  end
  local week = TimeUtils.GetWeekDay(math.floor(TimeUtils.GetServerTime() - 18000))
  if 0 == week then
    week = 7
  end
  for _, v in ipairs(cfgData.OpenTime) do
    if v == week then
      return true
    end
  end
  return false
end

function CopyDataUtils.CheckStageIsInOpenTime(stageId)
  local cfgData = DT.Stage[stageId]
  if nil == cfgData then
    return false
  end
  if nil == cfgData.OpenTime then
    return true
  end
  local curTime = TimeUtils.GetServerTime()
  return curTime >= cfgData.OpenTime
end

function CopyDataUtils.CheckStageIsConditionOk(stageId, isShowTips)
  local stageCfg = DT.Stage[stageId] or {}
  local lockReason
  local orUnlockTaskTid = stageCfg.OrUnlockCondition and stageCfg.OrUnlockCondition[1]
  if orUnlockTaskTid and TaskDataUtils.IsTaskDoneByTaskId(orUnlockTaskTid) then
    return true
  end
  local unlockTaskTid = stageCfg.UnlockCondition and stageCfg.UnlockCondition[1]
  local isTaskOk = not unlockTaskTid
  if unlockTaskTid then
    if TaskDataUtils.IsTaskDoneByTaskId(unlockTaskTid) then
      isTaskOk = true
    else
      lockReason = TaskDataUtils.GetTaskDesc(unlockTaskTid)
    end
  end
  return isTaskOk, lockReason
end

function CopyDataUtils.CheckStageIsUnlocked(stageId)
  local isInOpenTime = CopyDataUtils.CheckStageIsInOpenTime(stageId)
  if not isInOpenTime then
    local leftTimeText = TimeUtils.UnlockedCountDownFormat(CopyDataUtils.GetStageOpenCountDown(stageId))
    return false, leftTimeText
  end
  local isTaskOk, lockReason = CopyDataUtils.CheckStageIsConditionOk(stageId)
  if not isTaskOk then
    return false, lockReason
  end
  return true
end

function CopyDataUtils.GetStageOpenCountDown(stageId)
  local cfgData = DT.Stage[stageId]
  if nil == cfgData then
    return 0
  end
  if nil == cfgData.OpenTime then
    return 0
  end
  do return math.max, 0 end
  return math.max, 0, cfgData.OpenTime - TimeUtils.GetServerTime(), (TimeUtils.GetServerTime())
end

function CopyDataUtils.GetStageGroupIndex(stageGroupId)
  local group2Index = MainCopyDataUtils.GetGroupId2Index()
  return group2Index[stageGroupId]
end

function CopyDataUtils.GetStageGroupIndexName(stageGroupId)
  if not CopyDataUtils.IsNewStageChapter(stageGroupId) then
    local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupId)
    if stageGroupCfg and stageGroupCfg.Sequence then
      do return CopyDataUtils.GetMainCopyName end
      return CopyDataUtils.GetMainCopyName, stageGroupCfg.Sequence, nil
    end
    do return CopyDataUtils.GetMainCopyName, CopyDataUtils.GetStageGroupIndex(stageGroupId) end
    return CopyDataUtils.GetMainCopyName, CopyDataUtils.GetStageGroupIndex(stageGroupId)
  else
    local cfg = CopyDataUtils.GetStageGroupConfig(stageGroupId)
    do return LT.Textf, "MainLines_Chapterx" end
    return LT.Textf, "MainLines_Chapterx", cfg.Sequence
  end
end

function CopyDataUtils.GetMainCopyName(index)
  if 9 == index then
    do return LT.Text end
    return LT.Text, "MainLines_Chapter9", nil
  end
  do return LT.Textf, "MainLines_Chapterx" end
  return LT.Textf, "MainLines_Chapterx", index
end

function CopyDataUtils.GetStageGroupFeature(groupTid)
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(groupTid)
  if not stageGroupCfg then
    return
  end
  local featureId = StageGroupType2FeatureIdMap[stageGroupCfg.Type]
  if featureId then
    return featureId
  end
  return CopyDataUtils.StageGroupTypeMapFeatureId[stageGroupCfg.Type]
end

function CopyDataUtils.IsStageGroupFeatureLocked(groupTid)
  local feature = CopyDataUtils.GetStageGroupFeature(groupTid)
  if not feature then
    return false
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(feature, groupTid)
  return not unlocked
end

function CopyDataUtils.IsStageGroupNeedUnlockItem(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  return stageGroupCfg and stageGroupCfg.UnlockItem and table.next(stageGroupCfg.UnlockItem) ~= nil
end

function CopyDataUtils.CheckSubplotIsLockState(stageGroupId)
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(stageGroupId)
  if isFeatureLocked then
    return true
  end
  if not CopyDataUtils.IsStageGroupNeedUnlockItem(stageGroupId) then
    return false
  end
  if CopyDataUtils.IsStageGroupFeatureLocked(stageGroupId) then
    return true
  end
  local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(stageGroupId)
  return not hasUseUnlockItem
end

function CopyDataUtils.CheckStageGroupIsFeatrueLock(stageGroupId)
  local isUnlockFreeStageGroupTid = table.contains(DT.GetOriginalConstant("StageGroupUnlockFeature"), stageGroupId)
  if isUnlockFreeStageGroupTid and ActivityManager.Instance:HasOpeningSubplotActivity(stageGroupId) then
    return false
  end
  local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(stageGroupId)
  if isFeatureLocked then
    local feature = CopyDataUtils.GetStageGroupFeature(stageGroupId)
    if feature then
      PlayerDataUtils.AlertLockedTips(feature, stageGroupId)
    end
  end
  return isFeatureLocked
end

function CopyDataUtils.OnClickSubPlotEntry(stageGroupId, activityTid, ignoreTip)
  if CopyDataUtils.CheckStageGroupIsFeatrueLock(stageGroupId) then
    return
  end
  if not CopySubplotGroupModel.Instance:IsHaveServerStageData(stageGroupId) then
    CopyDataUtils.ReqCopyData(nil, stageGroupId, function()
      CopyDataUtils.OnOpenSubPlotGroupPanel(stageGroupId, activityTid, ignoreTip)
    end)
  else
    CopyDataUtils.OnOpenSubPlotGroupPanel(stageGroupId, activityTid, ignoreTip)
  end
end

function CopyDataUtils.OnOpenSubPlotGroupPanel(stageGroupId, activityTid, ignoreTip)
  if CopyDataUtils.CheckSubplotIsLockState(stageGroupId) then
    local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(stageGroupId)
    if hasOpenningSubplotActivity then
      if ignoreTip then
        CopyDataUtils.ReqUnlockStageGroup(stageGroupId, true)
        CopyDataUtils.OpenSubPlotGroupPanel(stageGroupId, activityTid)
      else
        Alert.Show(20138, nil, function()
          CopyDataUtils.ReqUnlockStageGroup(stageGroupId)
        end)
      end
      return
    end
    local itemName, itemNum = CopyDataUtils.GetStageGroupFirstUnlockItemInfo(stageGroupId)
    local stageGroupName = CopyDataUtils.GetStageGroupName(stageGroupId)
    local tipsText = LT.Textf(DT.TipsType[20139].Desc, itemName, stageGroupName, itemNum)
    Alert.Show(20139, nil, function()
      if not CopyDataUtils.IsStageGroupUnlockItemEnough(stageGroupId) then
        local itemNameCostStr = CopyDataUtils.GetStageGroupUnlockItemCostStr(stageGroupId, false)
        local _tipsText = LT.Textf(DT.TipsType[10646].Desc, itemNameCostStr)
        Alert.Show(10646, nil, nil, nil, _tipsText)
        return
      end
      CopyDataUtils.ReqUnlockStageGroup(stageGroupId)
    end, nil, tipsText)
    return
  end
  CopyDataUtils.OpenSubPlotGroupPanel(stageGroupId, activityTid)
end

function CopyDataUtils.IsStageGroupUseUnlockItem(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  local stageGroupData = DataCenter.MainCopyData.allPlots[stageGroupTid]
  return stageGroupData and stageGroupData.unlockItem and stageGroupData.unlockItem ~= false
end

function CopyDataUtils.CanOpenSubPlotGroupPanel(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  if CopyDataUtils.IsStageGroupFeatureLocked(stageGroupTid) then
    return false
  end
  if not CopyDataUtils.IsStageGroupNeedUnlockItem(stageGroupTid) then
    return true
  end
  do return CopyDataUtils.IsStageGroupUseUnlockItem end
  return CopyDataUtils.IsStageGroupUseUnlockItem, stageGroupTid
end

function CopyDataUtils.IsStageGroupUnlockItemEnough(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not (stageGroupCfg and stageGroupCfg.UnlockItem) or table.next(stageGroupCfg.UnlockItem) == nil then
    return true
  end
  local isEnough = true
  for i = 1, #stageGroupCfg.UnlockItem, 2 do
    local tid = stageGroupCfg.UnlockItem[i]
    local num = stageGroupCfg.UnlockItem[i + 1]
    if tid and num then
      local ownNum = ItemDataUtils.GetItemNum(tid) or 0
      if num > ownNum then
        isEnough = false
        break
      end
    end
  end
  return isEnough
end

function CopyDataUtils.GetStageGroupFirstUnlockItemInfo(stageGroupTid)
  local cfgUnlockItem = StageGroupCfgUtils.GetCfgField("UnlockItem", stageGroupTid)
  if not cfgUnlockItem then
    return
  end
  local itemTid = cfgUnlockItem[1]
  local itemNum = cfgUnlockItem[2]
  local itemName = ItemDataUtils.GetItemName(itemTid)
  return itemName, itemNum
end

function CopyDataUtils.GetStageGroupUnlockItemCostStr(stageGroupTid, withNumStr)
  local resultText = ""
  if not stageGroupTid then
    return resultText
  end
  if nil == withNumStr then
    withNumStr = true
  end
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not (stageGroupCfg and stageGroupCfg.UnlockItem) or nil == table.next(stageGroupCfg.UnlockItem) then
    return resultText
  end
  local itemCostStrList = {}
  for i = 1, #stageGroupCfg.UnlockItem, 2 do
    local tid = stageGroupCfg.UnlockItem[i]
    local num = stageGroupCfg.UnlockItem[i + 1] or 0
    if tid and num then
      local itemName = ItemDataUtils.GetItemName(tid)
      local text = itemName
      if withNumStr then
        text = ItemNumUtils.GetStr(itemName, num)
      end
      table.insert(itemCostStrList, text)
    end
  end
  if #itemCostStrList > 0 then
    resultText = table.concat(itemCostStrList, ",")
  end
  return resultText
end

function CopyDataUtils.GetStageGroupName(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  return stageGroupCfg and stageGroupCfg.Name and LT.Text(stageGroupCfg.Name)
end

function CopyDataUtils.ReqUnlockStageGroup(stageGroupTid, ignoreTips, successCb)
  local hasOpenningSubplotActivity = ActivityManager.Instance:HasOpeningSubplotActivity(stageGroupTid)
  if not hasOpenningSubplotActivity then
    local isItemEnough = CopyDataUtils.IsStageGroupUnlockItemEnough(stageGroupTid)
    if not isItemEnough then
      return
    end
  end
  
  local function OnSuccessTips()
    if not ignoreTips then
      Alert.Show(10755)
    end
  end
  
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("StageRequest", "UnlockStageGroupByItem", function()
    if successCb then
      successCb(OnSuccessTips)
    else
      OnSuccessTips()
    end
    GlobalDispatcher:Dispatch(NotifyId.OnCopySubplotGroupUnlocked, stageGroupTid)
  end, function()
  end, stageGroupTid)
end

function CopyDataUtils.IsMainCopy(stageGroupId)
  local featureId = CommonDefine.FeatureId.MainCopy
  local featureData = PlayerDataUtils.GetFeatureUnlockData(featureId, stageGroupId)
  return nil ~= featureData
end

function CopyDataUtils.IsMainCopyHard(stageGroupId)
  local featureId = CommonDefine.FeatureId.MainCopyHard
  local featureData = PlayerDataUtils.GetFeatureUnlockData(featureId, stageGroupId)
  return nil ~= featureData
end

function CopyDataUtils.HasBattleNode(stageId)
  local stageCfg = DT.Stage[stageId]
  if stageCfg.Map then
    return true
  else
    return false
  end
end

function CopyDataUtils.IsActiveResonance(stageGroupId)
  local resonanceGroup = CopyDataUtils.GetResonanceGroupId(stageGroupId)
  return resonanceGroup and #resonanceGroup > 0
end

function CopyDataUtils.GetResonanceGroupId(stageGroupId)
  if not stageGroupId then
    return
  end
  local config = DT.StageGroup[stageGroupId]
  if not config then
    Logger.Info("[CopyDataUtils.GetResonanceGroupId] Error: config not found, tid:", tostring(stageGroupId))
    return
  end
  if not config.BattleBuff or 1 ~= config.BattleBuff[1] then
    return
  end
  return config.BattleBuff[2]
end

function CopyDataUtils.IsDoubleFight(stageId)
  local stageCfg = DT.Stage[stageId]
  if not stageCfg then
    return false
  end
  local SecondMode = stageCfg.SecondMode
  return SecondMode and 0 ~= SecondMode
end

function CopyDataUtils.OpenSweepPanel(stageId, activityTid, limitTimes)
  UIManager.Instance:Reopen(Urls.DungeonSweepPanel, stageId, activityTid, limitTimes)
end

function CopyDataUtils.OpenCopyAchievePanelConstKey(constKey, selectedTaskId, title)
  local parentTaskList = DT.GetOriginalConstant(constKey)
  if parentTaskList then
    CopyDataUtils.OpenCopyAchievePanel(parentTaskList, selectedTaskId, title)
  end
end

function CopyDataUtils.OpenCopyAchievePanel(parentTaskList, selectedTaskId, title)
  local allTaskMap = {}
  local parentTaskMap = table.reverseKV(parentTaskList)
  print("-------------------OpenCopyAchievePanel parentTaskMap", table.tostring(parentTaskMap))
  for taskTid, taskCfg in pairs(DT.Task) do
    if taskCfg.BelongTaskGroup and parentTaskMap[taskCfg.BelongTaskGroup] then
      local taskData = TaskDataUtils.GetTaskData(taskTid)
      print("-------------------OpenCopyAchievePanelConstKey", taskTid, taskCfg.CnID, taskCfg.BelongTaskGroup, taskData or "nil")
      if taskData then
        allTaskMap[taskTid] = taskData
      end
    end
  end
  local extraParams = {selectedTaskId = selectedTaskId, title = title}
  UIManager.Instance:Reopen(Urls.ActivityAchievementPanel, nil, parentTaskList, allTaskMap, extraParams)
end

function CopyDataUtils.IsCanSweepInCfg(stageId, stageGroupId)
  local stageCfg = DT.Stage[stageId]
  if not stageCfg then
    return false
  end
  local sweepVal = stageCfg.StageSweep
  return sweepVal and 0 ~= sweepVal
end

function CopyDataUtils.IsSweepTypeOK(stageId, activityTid)
  local stageCfg = DT.Stage[stageId or 0]
  if not stageCfg then
    return false, nil, "No Stage " .. (stageId or "nil")
  end
  local sweepVal = stageCfg.StageSweep
  if not sweepVal or 0 == sweepVal then
    return false, nil, "Not Config To Sweep " .. stageId
  end
  local belongStageGroup = stageCfg.BelongGroup
  local stageData = CopyDataUtils.GetStageData(belongStageGroup, stageId)
  if not stageData then
    Logger.Warn("CopyDataUtils.IsSweepTypeOK no stageData, stageId:", stageId, "belongStageGroup:", belongStageGroup)
    return false, nil, "No StageData " .. stageId
  end
  if sweepVal == CommonDefine.SweepCondition.ThreeStar and stageData.star < 3 then
    return false, sweepVal, LT.Text("SweepTipsNotThreeStarTxt")
  end
  if sweepVal == CommonDefine.SweepCondition.StageFinish then
    local isStageFinished = stageData.firstRewardDraw or (stageData.star or 0) > 0
    if not isStageFinished then
      return false, sweepVal, LT.Text("SweepTipsUnopenTxt")
    end
  end
  if sweepVal == CommonDefine.SweepCondition.SingleDay then
    local lastPassTime = stageData.lastPassTime or 0
    local nextDayFreshTime = TimeUtils.GetNextClockTime(TimeUtils.GetServerTime(), 9)
    local curDayFreshTime = nextDayFreshTime - 86400
    if lastPassTime < curDayFreshTime then
      local tipsId = 10632
      local tipsData = DT.TipsType[tipsId] or {}
      return false, sweepVal, LT.Text(tipsData.Desc)
    end
  end
  if sweepVal == CommonDefine.SweepCondition.ReceiveAllAchievement and (not stageData.firstRewardDraw or not CopyDataUtils.IsReceiveAllAchievement(activityTid)) then
    return false, sweepVal, LT.Text("SweepTipsAllTasksNotClearTxt")
  end
  return true
end

function CopyDataUtils.IsReceiveAllAchievement(activityTid)
  local parentTaskList = ActivityDataUtils.GetTaskList(activityTid)
  local activityData = ActivityManager.Instance.model:GetActivityDataClient(activityTid)
  local totalCount = 0
  local finishCount = 0
  if activityData and activityData.taskList then
    local taskList = activityData.taskList
    local state
    for _, taskData in pairs(taskList) do
      if not table.contains(parentTaskList, taskData.tid) then
        totalCount = totalCount + 1
        state = taskData.state
        if state == TaskState.Receive or state == TaskState.Done then
          finishCount = finishCount + 1
        end
      end
    end
  end
  return totalCount <= finishCount
end

function CopyDataUtils.IsCanSweepInCondition(stageId, activityTid)
  local stageCfg = DT.Stage[stageId or 0]
  if not stageCfg then
    return false, nil, "No Stage " .. (stageId or "nil")
  end
  local isOk, reason, tip = CopyDataUtils.IsSweepTypeOK(stageId, activityTid)
  if nil ~= isOk then
    return isOk, reason, tip
  end
  if not CopyDataUtils.CheckLevelReach(stageId) then
    return false, CommonDefine.SweepCondition.PlayerLevel, LT.Text("SchoolTowerChallengeNotReachLevelTips")
  end
  if PlayerDataUtils.GetEnergy() < (stageCfg.Cost or 0) then
    local energyTip = LT.Textf("Shop_Buy_Lack_Money", LT.Text(DT.Item[DT.GetConstant("EnergyItemTid")].Name))
    return false, CommonDefine.SweepCondition.NotEnoughEnergy, energyTip
  end
  return true
end

function CopyDataUtils.ReqStageSweep(stageId, count, teamId, rewardPanelCloseCb, failCb)
  EventMgr.Instance.OpenReqMask:Dispatch()
  local stageConfig = CopyDataUtils.GetStageConfig(stageId)
  local stageGroupTid = stageConfig.BelongGroup
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  ProtoManager.Instance:ReqServer("StageRequest", "Sweep", function(data)
    local items = {}
    local _itemAwardTypeDesc
    if stageGroupConfig.BonusTips then
      _itemAwardTypeDesc = BonusCardModel.Instance:GetBonusRewardTagText(stageGroupTid)
    end
    for _, prize in ipairs(data.basePrize) do
      if prize then
        table.insert(items, {
          tid = prize.tid,
          changedNum = prize.num,
          uid = prize.uid,
          reason = prize.reason,
          awardType = prize.awardType,
          extraDesc = prize.awardType == CommonDefine.ItemAwardType.BonusCard and _itemAwardTypeDesc or nil,
          extraDescBgType = prize.awardType == CommonDefine.ItemAwardType.BonusCard and CommonDefine.CommonIconExtraDescBgType.Blue or nil
        })
      end
    end
    items = CopyDataUtils.SortCopyRewards(items, stageId)
    ItemDataUtils.ShowRewardPanel(LT.Text("ClearCopy_Str_Title"), "", items, rewardPanelCloseCb, nil, nil)
  end, function(data, errcode)
    if failCb then
      failCb()
    end
    if errcode and errcode.code then
      if errcode.code == 10055 then
        ErrorMsg.ShowErrCodeTips(errcode, data, nil, function()
          RpcMgr.Instance:Disconnect()
          SceneMgr.Instance:EnterLogin()
        end)
      else
        ErrorMsg.ShowErrCodeTips(errcode)
      end
    end
  end, stageId, count, teamId)
end

function CopyDataUtils.SortCopyRewards(rewards, stageId)
  local stageCfg = DT.Stage[stageId]
  local tid2index = {}
  for tid, _, index in table.iteraDouble(stageCfg.FirstTimeReward or {}) do
    tid2index[tid] = index
  end
  for tid, _, index in table.iteraDouble(stageCfg.NormalReward or {}) do
    tid2index[tid] = index
  end
  for tid, _, index in table.iteraDouble(stageCfg.PerfectReward or {}) do
    tid2index[tid] = index
  end
  
  local function GetItemSortWeight(item)
    local index = tid2index[item.tid]
    local weight = 9999
    local gap = 100
    local type = item.awardType
    if type == CommonDefine.ItemAwardType.First3Star then
      return weight - (index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.First then
      return weight - (index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.FirstMult then
      return weight - (index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.DoubleOutput then
      return weight - (index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.Normal then
      return weight - (index or 0)
    end
    return weight
  end
  
  for _, item in ipairs(rewards) do
    item._sortWeight = GetItemSortWeight(item)
  end
  local tidGroups = {}
  local tidOrder = {}
  for _, item in ipairs(rewards) do
    local tid = item.tid
    if not tidGroups[tid] then
      tidGroups[tid] = {}
      tidOrder[#tidOrder + 1] = tid
    end
    table.insert(tidGroups[tid], item)
  end
  for _, group in pairs(tidGroups) do
    table.sort(group, function(a, b)
      if a.awardType ~= b.awardType then
        if a.awardType == CommonDefine.ItemAwardType.Normal then
          return true
        end
        if b.awardType == CommonDefine.ItemAwardType.Normal then
          return false
        end
      end
      local itemA = DT.Item[a.tid]
      local itemB = DT.Item[b.tid]
      local qualityA = DT.ItemQuality[itemA.Quality].Sort
      local qualityB = DT.ItemQuality[itemB.Quality].Sort
      if qualityA ~= qualityB then
        return qualityA > qualityB
      end
      return itemA.BaseSortID < itemB.BaseSortID
    end)
  end
  local groupMinWeight = {}
  for tid, group in pairs(tidGroups) do
    local minW = group[1]._sortWeight
    for i = 2, #group do
      if minW > group[i]._sortWeight then
        minW = group[i]._sortWeight
      end
    end
    groupMinWeight[tid] = minW
  end
  table.sort(tidOrder, function(a, b)
    local wA = groupMinWeight[a]
    local wB = groupMinWeight[b]
    if wA ~= wB then
      return wA > wB
    end
    local itemA = DT.Item[a]
    local itemB = DT.Item[b]
    local qualityA = DT.ItemQuality[itemA.Quality].Sort
    local qualityB = DT.ItemQuality[itemB.Quality].Sort
    if qualityA ~= qualityB then
      return qualityA > qualityB
    end
    return itemA.BaseSortID < itemB.BaseSortID
  end)
  local out = {}
  for _, tid in ipairs(tidOrder) do
    for _, item in ipairs(tidGroups[tid]) do
      table.insert(out, item)
    end
  end
  for index, item in ipairs(out) do
    item._sortWeight = nil
    item.sortIndex = index
  end
  return out
end

function CopyDataUtils._IsNodeKey(key)
  do return string.contains, key end
  return string.contains, key, "Xaxis"
end

function CopyDataUtils.GetMapNodeList(mapId)
  local mapCfg = DT.Map[mapId] or {}
  local nodeList = {}
  local data_list = mapCfg.data_list or {}
  for _, rowData in ipairs(data_list) do
    for key, rowNodeList in pairs(rowData) do
      if CopyDataUtils._IsNodeKey(key) then
        for _, nodeId in ipairs(rowNodeList) do
          table.insert(nodeList, nodeId)
        end
      end
    end
  end
  return nodeList
end

function CopyDataUtils.GetStageNodeList(stageId)
  local stageCfg = DT.Stage[stageId]
  stageCfg = stageCfg or DT.StageDifficulty[stageId] or {}
  if stageCfg.MapType == cd.StageMapType.OneLine or stageCfg.MapType == cd.StageMapType.Railway then
    return stageCfg.Map
  end
  local mapId = stageCfg.Map and stageCfg.Map[1] or -1
  do return CopyDataUtils.GetMapNodeList end
  return CopyDataUtils.GetMapNodeList, mapId
end

function CopyDataUtils.GetOneLineStageBattleNodes(stageId)
  local nodeList = CopyDataUtils.GetStageNodeList(stageId)
  local battleNodes = {}
  for _, nodeId in ipairs(nodeList) do
    local nodeCfg = DT.MapNode[nodeId]
    local nodeEffectId = nodeCfg and nodeCfg.Effect and nodeCfg.Effect[1] or -1
    local battleCfg = DT.BattleConfig[nodeEffectId]
    if battleCfg then
      table.insert(battleNodes, nodeEffectId)
    end
  end
  return battleNodes
end

function CopyDataUtils.IsOneBattleStage(stageId)
  if not stageId then
    return false
  end
  local stageCfg = DT.Stage[stageId] or DT.StageDifficulty[stageId] or {}
  local mapId = stageCfg.Map and stageCfg.Map[1] or -1
  local mapCfg = DT.Map[mapId] or {}
  local data_list = mapCfg.data_list or {}
  local typeTable = "table"
  local bornNodeId = DT.GetConstant("MapNodeBorn")
  for _, rowData in ipairs(data_list) do
    for key, rowNodeList in pairs(rowData) do
      if type(rowNodeList) == typeTable and #rowNodeList >= 2 and rowNodeList[1] == bornNodeId then
        for i = 2, #rowNodeList do
          local secondNode = DT.MapNode[rowNodeList[i]] or {}
          local nodeType = DT.MapNodeType[secondNode.NodeType or 0] or {}
          if nodeType.TypeEffect == cd.GearItemType.Boss then
            return true
          end
        end
        return
      end
    end
  end
end

function CopyDataUtils.GetAwakerRequirementMap(stageId)
  local limits, icon = CopyDataUtils.GetAwakerRequirement(stageId)
  local limitMap = {}
  for _, limit in ipairs(limits) do
    local schoolId, count = limit[1], limit[2]
    limitMap[schoolId] = count
  end
  return limitMap, icon
end

function CopyDataUtils.GetAwakerRequirement(stageId)
  local stageCfg = DT.Stage[stageId]
  local awakerRequirement = stageCfg and stageCfg.AwakerRequirement or {}
  local icon
  local limits = {}
  for schoolId, count in table.iteraDouble(awakerRequirement) do
    table.insert(limits, {
      schoolId,
      count or 1
    })
  end
  if 1 == #limits then
    icon = CopyDataUtils.GetSchoolIconLittle(awakerRequirement[1])
  elseif 2 == #limits then
    local school1, school2 = awakerRequirement[1], awakerRequirement[3]
    if school1 ~= school2 then
      icon = CopyDataUtils.GetSchoolIconLittle(school1, school2)
    else
      icon = CopyDataUtils.GetSchoolIconLittle(school1)
    end
  end
  local schoolWeight = {
    [cd.SchoolId.Choas] = 1,
    [cd.SchoolId.Ocean] = 2,
    [cd.SchoolId.Blood] = 3,
    [cd.SchoolId.Dimension] = 4
  }
  table.sort(limits, function(a, b)
    local school1, school2 = a[1], b[1]
    return schoolWeight[school1] < schoolWeight[school2]
  end)
  return limits, icon
end

function CopyDataUtils.GetSchoolIcon(school1, school2)
  if school1 and not school2 then
    local schoolCfg = DT.SchoolConfig[school1]
    return schoolCfg and schoolCfg.Icon
  elseif school1 and school2 then
    return cd.SchoolIconMix[school1 * school2]
  end
end

function CopyDataUtils.GetSchoolIconLittle(school1, school2)
  if school1 and not school2 then
    return cd.SchoolIconLittle[school1]
  elseif school1 and school2 then
    return cd.SchoolIconMixLittle[school1 * school2]
  end
end

function CopyDataUtils.GetStageMonsterBossTidList(stageTid)
  local nodeList = CopyDataUtils.GetStageNodeList(stageTid)
  local gearBossType = CommonDefine.GearItemType.Boss
  local monsterList = {}
  for _, nodeId in ipairs(nodeList) do
    local nodeCfg = DT.MapNode[nodeId]
    if nodeCfg and nodeCfg.Type == gearBossType then
      local battleCfg = nodeCfg.Effect[1] and DT.BattleConfig[nodeCfg.Effect[1]]
      if battleCfg then
        for index = 1, 5 do
          local monsterId = battleCfg["Monster" .. index]
          if monsterId and monsterId > 0 then
            table.insert(monsterList, monsterId)
          end
        end
      end
    end
  end
  return monsterList
end

local BattleTid2CoinRewardNumMap = {}

function CopyDataUtils.GetCoinRewardNum(battleTid)
  if BattleTid2CoinRewardNumMap[battleTid] then
    return BattleTid2CoinRewardNumMap[battleTid]
  end
  for _, config in pairs(DT.MapNode) do
    if config.Effect and config.Effect[1] == battleTid then
      BattleTid2CoinRewardNumMap[battleTid] = config.Effect[2]
      return config.Effect[2]
    end
  end
  return 0
end

function CopyDataUtils.GetBattleTidByMapNodeTid(mapNodeTid)
  local nodeCfg = DT.MapNode[mapNodeTid]
  if CommonDefine.GearBattleType[nodeCfg.Type] then
    return nodeCfg.Effect[1]
  end
  return nil
end

local monsterFields = {
  "Monster1",
  "Monster2",
  "Monster3",
  "Monster4",
  "Monster5"
}
local monsterAffixFields = {
  "MonsterAffix1",
  "MonsterAffix2",
  "MonsterAffix3",
  "MonsterAffix4",
  "MonsterAffix5"
}

function CopyDataUtils.GetStageMonsterWithAffixList(stageId, isSort)
  local nodeList = CopyDataUtils.GetStageNodeList(stageId)
  local monsterMap = {}
  local monsterDuplicates = {}
  for _, nodeId in ipairs(nodeList) do
    local nodeCfg = DT.MapNode[nodeId]
    local nodeEffectId = nodeCfg and nodeCfg.Effect and nodeCfg.Effect[1] or -1
    local battleCfg = DT.BattleConfig[nodeEffectId]
    if battleCfg then
      for index, monsterKey in ipairs(monsterFields) do
        local monsterId = battleCfg[monsterKey]
        local monsterUniqueKey = monsterId and CopyDataUtils.GetMonsterUniqueKey(monsterId)
        if monsterUniqueKey and not monsterDuplicates[monsterUniqueKey] then
          monsterDuplicates[monsterUniqueKey] = true
          monsterMap[monsterId] = monsterMap[monsterId] or {}
          local monsterAffixIds = table.clone(battleCfg[monsterAffixFields[index]] or {})
          table.sort(monsterAffixIds)
          if not CopyDataUtils.IsContainsAffix(monsterMap[monsterId], monsterAffixIds) then
            table.insert(monsterMap[monsterId], monsterAffixIds)
          end
        end
      end
    end
  end
  local monsterList = {}
  for monsterId, _ in pairs(monsterMap) do
    table.insert(monsterList, monsterId)
  end
  if isSort then
    monsterList = CopyDataUtils.SortMonsterList(monsterList)
  end
  local monsterWithAffixList = {}
  for _, monsterId in ipairs(monsterList) do
    for _, affixIds in ipairs(monsterMap[monsterId] or {}) do
      local monsterWithAffix = monsterId .. "_" .. table.concat(affixIds, "_")
      table.insert(monsterWithAffixList, monsterWithAffix)
    end
  end
  return monsterWithAffixList
end

function CopyDataUtils.GetMonsterUniqueKey(monsterId)
  local cfg = DT.MonsterConfig[monsterId]
  local name = LT.Text(cfg.MonsterName)
  local desc = LT.Text(cfg.Desc)
  local icon = cfg.MiniIcon
  do return string.format, "%s-%s-%s", name, desc end
  return string.format, "%s-%s-%s", name, desc, icon
end

function CopyDataUtils.IsContainsAffix(affixIdsList, affixIds)
  if not affixIds then
    return false
  end
  for _, _affixIds in ipairs(affixIdsList) do
    if #affixIds == #_affixIds then
      local isSame = true
      for index, affixId in ipairs(affixIds) do
        if affixId ~= _affixIds[index] then
          isSame = false
          break
        end
      end
      if isSame then
        return true
      end
    end
  end
  return false
end

function CopyDataUtils.SplitMonsterWithAffix(monsterWithAffix)
  if type(monsterWithAffix) ~= "string" then
    return monsterWithAffix
  end
  local monsterId, affixIds = string.match(monsterWithAffix, "(%d+)_(.*)")
  if not monsterId then
    return
  end
  local affixStrList = string.split(affixIds, "_")
  local affixIds = {}
  for _, affixStr in ipairs(affixStrList) do
    if tonumber(affixStr) then
      table.insert(affixIds, tonumber(affixStr))
    end
  end
  return tonumber(monsterId), affixIds
end

function CopyDataUtils.SortMonsterList(monsterTids)
  local sortList = {}
  for _, monsterTid in ipairs(monsterTids) do
    local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterTid)
    if not monsterCfg then
      Logger.Error("怪物表里面找不到 monsterTid == %s", monsterTid)
    else
      if monsterCfg.MonsterClass == CommonDefine.MonsterClass.Boss then
        table.insert(sortList, {monsterTid = monsterTid, sort = 3})
      end
      if monsterCfg.MonsterClass == CommonDefine.MonsterClass.Elite then
        table.insert(sortList, {monsterTid = monsterTid, sort = 2})
      end
      if monsterCfg.MonsterClass == CommonDefine.MonsterClass.Common then
        table.insert(sortList, {monsterTid = monsterTid, sort = 1})
      end
    end
  end
  table.sort(sortList, function(a, b)
    return a.sort > b.sort
  end)
  local tidList = {}
  for _, info in ipairs(sortList) do
    table.insert(tidList, info.monsterTid)
  end
  return tidList
end

function CopyDataUtils.GetMonsterDataModel(stageId, monsterId)
  local stageCfg = DT.Stage[stageId]
  local stageMonsterEffectCfg = DT.Stage[stageId]
  local stageMonsterEffectId = stageCfg.StageMonsterData
  local difficultyId = MainCopyDataUtils.GetDymicDifficultyId(stageId)
  if difficultyId then
    local difficultyCfg = DT.StageDifficulty[difficultyId]
    if difficultyCfg and difficultyCfg.StageMonsterData then
      stageMonsterEffectId = difficultyCfg.StageMonsterData
    end
  end
  if stageMonsterEffectId then
    stageMonsterEffectCfg = DT.StageMonsterData[stageMonsterEffectId]
  end
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterId)
  if not monsterCfg then
    return nil
  end
  local monsterTag = monsterCfg.BattleTag
  local dataModelList = stageMonsterEffectCfg.data_list or {}
  for _, dataModel in ipairs(dataModelList) do
    if dataModel.BattleTag == monsterTag then
      return dataModel
    end
  end
end

function CopyDataUtils.GetMonsterAttrData(stageId, monsterId)
  local monsterModel = CopyDataUtils.GetMonsterDataModel(stageId, monsterId)
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterId)
  if not monsterModel or not monsterCfg then
    return
  end
  local attrData = {}
  attrData.max_hp = monsterModel.StandardHp * monsterCfg.MonsterProportion * monsterCfg.MonsterHpPercent - monsterModel.StandardTurn * 0.5 * monsterModel.StandardDef * monsterCfg.MonsterDefPercent
  attrData.atk = monsterModel.StandardAtk * monsterCfg.MonsterProportion * monsterCfg.MonsterAtkPercent
  attrData.def = monsterModel.StandardDef * monsterCfg.MonsterDefPercent
  attrData.level = CopyDataUtils.GetMonsterLevel(stageId, monsterId)
  return attrData
end

function CopyDataUtils.GetMonsterConfig(tid)
  if not tid then
    return
  end
  local monsterTid = CopyDataUtils.SplitMonsterWithAffix(tid)
  return DT.MonsterConfig[monsterTid]
end

function CopyDataUtils.GetMonsterTagList(tid)
  local monsterCfg = CopyDataUtils.GetMonsterConfig(tid)
  return monsterCfg and monsterCfg.MonsterTag or {}
end

function CopyDataUtils.GetTagConfig(tagTid)
  return DT.TagConfig[tagTid]
end

function CopyDataUtils.GetMonsterLevel(stageId, monsterId)
  local monsterDataModel = CopyDataUtils.GetMonsterDataModel(stageId, monsterId)
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterId)
  if not monsterDataModel or not monsterCfg then
    return 0
  end
  do return math.floor end
  return math.floor, monsterDataModel.StandardLv
end

function CopyDataUtils.GetMonsterName(monsterId, stageId)
  local monsterTid, affixIds = CopyDataUtils.SplitMonsterWithAffix(monsterId)
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterTid)
  if not monsterCfg then
    return
  end
  local affixStr = ""
  local affixConnectStr = LT.Text("AffixConnect")
  for _, affixId in ipairs(affixIds or {}) do
    local stateCfg = DT.State[affixId]
    if stateCfg and stateCfg.Name then
      affixStr = affixStr .. LT.Text(stateCfg.Name) .. affixConnectStr
    end
  end
  local monsterName = LT.Text(monsterCfg.MonsterName)
  if not stageId then
    return affixStr .. monsterName
  end
  local monsterLevel = CopyDataUtils.GetMonsterLevel(stageId, monsterId)
  return affixStr .. monsterName .. " Lv." .. monsterLevel
end

function CopyDataUtils.GetMonsterDesc(monsterId)
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterId)
  if not monsterCfg then
    return
  end
  do return LT.Text end
  return LT.Text, monsterCfg.Desc
end

function CopyDataUtils.GetIsLocked(stageId, stageDataList)
  for _, stageData in pairs(stageDataList) do
    if stageData.stageID == stageId then
      return stageData and not stageData.unlock
    end
  end
end

function CopyDataUtils.CheckLevelReach(stageId)
  local playerLv = DataCenter.playerData.DRole.level
  local stageCfg = DT.Stage[stageId]
  local limitLv = stageCfg.PlayerLevel or 0
  local lvMatch = limitLv and playerLv >= limitLv
  return lvMatch
end

function CopyDataUtils.CheckCanChallenge(stageId, stageGroupId)
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(DT.StageGroup[stageGroupId].Type)
  if showLevelLimit then
    if not CopyDataUtils.CheckLevelReach(self.stageId) then
      local stageCfg = self:GetStageCfg(self.stageId)
      local limitLv = stageCfg.PlayerLevel
      return false
    end
  elseif self:GetIsLocked(stageId) then
    return false
  end
  return true
end

function CopyDataUtils.HasMonsterTypeName(monsterId)
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterId)
  if not monsterCfg or monsterCfg.MonsterClass == CommonDefine.MonsterClass.Common then
    return false
  end
  return true
end

function CopyDataUtils.GetStageUnlockedByUnlockCondition(stageId, activityTid)
  local unlockCondition = CopyDataUtils.GetStageCfgByField("UnlockCondition", stageId)
  if not unlockCondition then
    return true
  end
  local taskId = unlockCondition[1]
  if not taskId or not DT.Task[taskId] then
    return true
  end
  local taskData = TaskDataUtils.GetTaskData(taskId)
  if not taskData or not taskData.state then
    return true
  end
  return taskData.state >= CommonDefine.CommonState.GainPrize
end

function CopyDataUtils.GetMonsterTypeName(monsterId)
  local monsterCfg = CopyDataUtils.GetMonsterConfig(monsterId)
  if not monsterCfg then
    return
  end
  if not CopyDataUtils.HasMonsterTypeName(monsterId) then
    return false
  end
  local imageKey = string.format("LevelDetailBattle_%s_Tips", monsterCfg.MonsterClass)
  do return LT.Text end
  return LT.Text, imageKey
end

function CopyDataUtils.GetMonsterStateComputeList(stageId, monsterId)
  if not monsterId or 0 == monsterId then
    return {}
  end
  local monsterModel = CopyDataUtils.GetMonsterDataModel(stageId, monsterId)
  if not monsterModel then
    return {}
  end
  local monsterAttr = CopyDataUtils.GetMonsterAttrData(stageId, monsterId) or {}
  local outStateComputeList = {}
  if monsterModel.StageStatus then
    local layerList = string.split(tostring(monsterModel.StageStateLayers or ""), ",")
    local stateParamsList = string.split(tostring(monsterModel.StageStateParams or ""), ",")
    for index, stateId in ipairs(monsterModel.StageStatus) do
      local layer = tonumber(layerList[index]) or 1
      local monsterData = {attrs = monsterAttr}
      local compute = OuterStateCompute(stateId, monsterData, layer, stateParamsList)
      table.insert(outStateComputeList, compute)
    end
  end
  return outStateComputeList
end

CopyDataUtils.needShowBattleSettleTips = false

function CopyDataUtils.Set_needShowBattleSettleTips(boolVal)
  CopyDataUtils.needShowBattleSettleTips = boolVal
end

function CopyDataUtils.Get_needShowBattleSettleTips()
  return CopyDataUtils.needShowBattleSettleTips
end

function CopyDataUtils.HandleGearBattleResult(data, sceneType, callBack)
  if not data then
    if callBack then
      callBack()
    end
    return
  end
  if CopyDataUtils.Get_needShowBattleSettleTips() then
    UIManager.Instance:InsertUIQueue(sceneType, true, Urls.WorldStageBattleSettleTip, {}, 1, data.money or 0, nil, {
      soundEventName = "Play_NTC_Figth_Win_S"
    })
    CopyDataUtils.Set_needShowBattleSettleTips(false)
  end
  local price_type = data.prize and data.prize[1] and data.prize[1].type
  if "enchant" == price_type then
    UIManager.Instance:InsertUIQueue(sceneType, true, Urls.WorldStageBattleRewardPanel, true, {
      gainNum = 1,
      type = "enchant",
      items = data.prize[1].items,
      giveUpEnchantArg = data.giveUpEnchantArg
    })
    if callBack then
      UIManager.Instance:RegisterPanelClose(Urls.WorldStageBattleRewardPanel, callBack)
    end
  elseif "relic" == price_type then
    local userData = {
      maxCount = 1,
      mustSelect = true,
      relics = data.prize[1].items,
      titleStr = LT.Textf("Relic_Select", 1)
    }
    UIManager.Instance:InsertCopyUIShowQueue(Urls.WorldStageRelicThreeSelectPanel, userData)
    if callBack then
      UIManager.Instance:RegisterPanelClose(Urls.WorldStageRelicSelectPanel, callBack)
    end
  elseif callBack then
    callBack()
  end
end

function CopyDataUtils.IsNewStageChapter(stageId)
  local stageChapter = CopyDataUtils.GetStageChapter(stageId)
  if stageChapter and stageChapter ~= cd.StageChapterName.StageChapterMorimens then
    return true
  end
end

function CopyDataUtils.IsFirstRewardDraw(stageId)
  local stageData = MainCopyDataUtils.GetStageData(stageId)
  return stageData and stageData.firstRewardDraw
end

function CopyDataUtils.GetStageChapter(stageId)
  local stageGroupCfg = CopyDataUtils.GetStageGroupCfgByStage(stageId)
  return stageGroupCfg and stageGroupCfg.StageChapterText
end

function CopyDataUtils.GetStageChapterTextAndIdx(stageId)
  local chapterText = CopyDataUtils.GetStageChapter(stageId)
  if not chapterText then
    return
  end
  local list = DT.GetOriginalConstant(chapterText)
  if list then
    return list[1], list[2], list[3]
  end
end

function CopyDataUtils.GetStageChapterIcon(stageId)
  local _, index = CopyDataUtils.GetStageChapterTextAndIdx(stageId)
  return CommonRes.StageChapterIcon[index]
end

function CopyDataUtils.GetStageChapterIconByName(stageChapterName)
  local list = DT.GetOriginalConstant(stageChapterName)
  if list and list[2] then
    return CommonRes.StageChapterIcon[list[2]]
  end
end

function CopyDataUtils.GetStageChapterState(stageId)
  local stageGroupCfg = CopyDataUtils.GetStageGroupCfgByStage(stageId)
  return stageGroupCfg and stageGroupCfg.StageChapterState or {}
end

function CopyDataUtils.GetStageNameNumber(stageId)
  local stageCfg = CopyDataUtils.GetStageCfg(stageId)
  local chapterText = CopyDataUtils.GetStageChapterTextAndIdx(stageId)
  if stageCfg and stageCfg.NameNumber and chapterText then
    do return string.format, "%s<space=0.2em>%s", LT.Text(chapterText), LT.Text(stageCfg.NameNumber) end
    return string.format, "%s<space=0.2em>%s", LT.Text(chapterText), LT.Text(stageCfg.NameNumber)
  end
end

function CopyDataUtils.GetStageGroupDailyWinCount(stageGroupId)
  local winCount, limitCount = 0, 0
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupId)
  if not stageGroupCfg then
    return winCount, limitCount
  end
  local stageGroupType = stageGroupCfg.Type
  local statsKey = cd.PlayerStatsType.PersonalStageGroupTypeWinCount .. "_" .. stageGroupType
  winCount = PlayerDataUtils.GetDailyStatsData(statsKey) or 0
  local cfgList = DT.GetOriginalConstant("StageGroupTypeDailyWinCountLimit", {})
  for groupType, count in table.iteraDouble(cfgList) do
    if groupType == stageGroupType then
      limitCount = count
      break
    end
  end
  return winCount, limitCount
end

function CopyDataUtils.CalculateChapterIndex(difficulty, stageChapterName)
  local curTime = math.floor(TimeUtils.GetServerTime())
  local groupList = {}
  local COPY_TYPE = CommonDefine.StageGroupType.MainCopy
  local prologueGroupId = DT.GetConstant("PrologueStageGroup")
  stageChapterName = stageChapterName or cd.StageChapterName.StageChapterMorimens
  for groupId, groupCfg in pairs(DT.StageGroup) do
    if groupCfg.Type == COPY_TYPE and groupId ~= prologueGroupId and groupCfg.StageChapterText == stageChapterName then
      local canShow = groupCfg.StageDisplayDate and curTime >= groupCfg.StageDisplayDate
      canShow = nil == canShow and true or canShow
      if canShow then
        if difficulty == CommonDefine.Difficulty.Normal then
          table.insert(groupList, groupId)
        elseif groupCfg.HardMode and groupCfg.HardMode[difficulty] then
          table.insert(groupList, groupCfg.HardMode[difficulty])
        end
      end
    end
  end
  table.sort(groupList, function(a, b)
    local aCfg = DT.StageGroup[a]
    local bCfg = DT.StageGroup[b]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  return groupList
end

function CopyDataUtils.ResetWeekStageCopyData(data)
  DataCenter.copyData.weekStage[data.groupTid] = data
  local newStar = 0
  for _, stageData in pairs(data.stage) do
    newStar = stageData.star + newStar
  end
  DataCenter.copyData.weekCopy.stageList[data.groupTid].star = newStar
end

function CopyDataUtils.UpdateWeekBossData(WeekBossData)
  if not WeekBossData then
    return
  end
  local copyData = DataCenter.copyData
  copyData.weekBoss.weekBossRefreshTime = WeekBossData.refreshTime
  copyData.weekBoss.leftRewardCnt = WeekBossData.num
  for stageGroupID, v in pairs(WeekBossData.data) do
    copyData.data[stageGroupID] = CopyDataUtils.FixWeekBossStageList(v.stageList)
  end
  EventMgr.Instance.OnSyncWeekBossData:Dispatch()
end

function CopyDataUtils.FixWeekBossStageList(stageList)
  local t = {}
  for _, v in pairs(stageList) do
    table.insert(t, v)
  end
  table.sort(t, function(a, b)
    local aStageCfg = DT.Stage[a.stageID]
    local bStageCfg = DT.Stage[b.stageID]
    return aStageCfg.BaseSortID < bStageCfg.BaseSortID
  end)
  return t
end

function CopyDataUtils.GetStageCfg(tid)
  if not tid then
    return
  end
  return DT.Stage[tid]
end

function CopyDataUtils.GetIconPathIdx(stageGroupId)
  local stageGroupCfg = CopyDataUtils.GetStageGroupCfgByStage(stageGroupId)
  local pathIdx = stageGroupCfg.Sequence
  if CopyDataUtils.IsNewStageChapter(stageGroupId) then
    pathIdx = pathIdx + 9
  end
  if pathIdx < 10 then
    pathIdx = "0" .. pathIdx
  end
  return pathIdx
end

function CopyDataUtils.GetStageGroupCfgByStage(stageId)
  local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageId)
  if stageGroupCfg then
    return stageGroupCfg
  end
  local stageCfg = CopyDataUtils.GetStageCfg(stageId)
  if not stageCfg or not stageCfg.BelongGroup then
    return
  end
  do return CopyDataUtils.GetStageGroupConfig end
  return CopyDataUtils.GetStageGroupConfig, stageCfg.BelongGroup
end

function CopyDataUtils.IsWorldBossStage(stageId)
  local stageCfg = CopyDataUtils.GetStageCfg(stageId)
  return stageCfg and stageCfg.StageHighDifficulty == CommonDefine.StageDiffType.Boss
end

function CopyDataUtils.GetStageCfgByField(field, tid)
  local stageCfg = CopyDataUtils.GetStageCfg(tid)
  if not stageCfg then
    return
  end
  return stageCfg[field]
end

function CopyDataUtils.GetWeekBossRewardCnt()
  return DataCenter.copyData.weekBoss.leftRewardCnt
end

function CopyDataUtils.GetWeekBossRefreshTime()
  return DataCenter.copyData.weekBoss.weekBossRefreshTime
end

function CopyDataUtils.GetStageReplenishCost(stageId)
  local stageCfg = DT.Stage[stageId]
  local stageGroup = stageCfg.BelongGroup
  local groupCfg = DT.StageGroup[stageGroup]
  if groupCfg.Type == CommonDefine.StageGroupType.WeekBoss then
    local cnt = CopyDataUtils.GetWeekBossRewardCnt()
    if cnt <= 0 then
      return 0
    end
  end
  return stageCfg.Cost or 0
end

function CopyDataUtils.GetStageConfig(tid)
  if not tid then
    return
  end
  return DT.Stage[tid]
end

function CopyDataUtils.GetStageGroupConfig(tid)
  if not tid then
    return
  end
  return DT.StageGroup[tid]
end

function CopyDataUtils.GetStageName(tid)
  local stageCfg = CopyDataUtils.GetStageConfig(tid)
  if not stageCfg then
    return ""
  end
  do return LT.Text end
  return LT.Text, stageCfg.Name
end

function CopyDataUtils.GetSubplotList(isLarge)
  if nil == isLarge then
    isLarge = false
  end
  local now = TimeUtils.GetServerTime()
  local groupList = {}
  for groupTid, config in pairs(DT.StageGroup) do
    local isSubplot, isLargeSubplot, isSmallSubplot = CopyDataUtils.IsSubplotGroup(groupTid, isLarge)
    if isSubplot and isLarge == isLargeSubplot and isSmallSubplot == not isLarge and (not config.StageDisplayDate or now >= config.StageDisplayDate) then
      table.insert(groupList, groupTid)
    end
  end
  table.sort(groupList, function(aTid, bTid)
    local isLockedA = CopyDataUtils.IsStageGroupFeatureLocked(aTid) and 1 or 0
    local isLockedB = CopyDataUtils.IsStageGroupFeatureLocked(bTid) and 1 or 0
    if isLockedA == isLockedB then
      local configA = CopyDataUtils.GetStageGroupConfig(aTid)
      local configB = CopyDataUtils.GetStageGroupConfig(bTid)
      return configA.Sequence < configB.Sequence
    end
    return isLockedA < isLockedB
  end)
  return groupList
end

function CopyDataUtils.IsSubplotGroup(groupTid)
  local StageGroupType = CommonDefine.StageGroupType
  local config = CopyDataUtils.GetStageGroupConfig(groupTid)
  if not config then
    return false
  end
  local curType = config.Type
  local SmallSubplotType = {
    [StageGroupType.SmallSubplotNormal] = true,
    [StageGroupType.SmallSubplotHard] = true,
    [StageGroupType.SmallSubplotCrazy] = true
  }
  local LargeSubplotType = {
    [StageGroupType.LargeSubplotNormal] = true,
    [StageGroupType.LargeSubplotHard] = true,
    [StageGroupType.LargeSubplotCrazy] = true
  }
  local SpecialSubplotType = {
    [StageGroupType.SpecialSubplotNormal] = true,
    [StageGroupType.SpecialSubplotHard] = true
  }
  local isLargeSubplot = LargeSubplotType[curType] or false
  local isSmallSubplot = SmallSubplotType[curType] or false
  local isSpecialSubplotType = SpecialSubplotType[curType] or false
  local isSubplot = isLargeSubplot or isSmallSubplot or isSpecialSubplotType
  return isSubplot, isLargeSubplot, isSmallSubplot
end

function CopyDataUtils.IsValidSubplotStageGroupForRedDot(stageGroupTid)
  if type(stageGroupTid) ~= "number" then
    return false
  end
  local config = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not config then
    return false
  end
  if CopyDataUtils.IsSubplotGroup(stageGroupTid) then
    return true
  end
  if CopyDataUtils.GetSubplotDifficult2IdMap(stageGroupTid) then
    return true
  end
  if config.Type == CommonDefine.StageGroupType.Vindicate then
    return true
  end
  return false
end

function CopyDataUtils.IsNormalSubplotGroup(stageGroupTid)
  local StageGroupType = CommonDefine.StageGroupType
  local config = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not config then
    return false
  end
  local groupType = config.Type
  return groupType == StageGroupType.LargeSubplotNormal or groupType == StageGroupType.SmallSubplotNormal
end

function CopyDataUtils.IsHardSubplotGroup(stageGroupTid)
  local StageGroupType = CommonDefine.StageGroupType
  local config = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not config then
    return false
  end
  local groupType = config.Type
  return groupType == StageGroupType.LargeSubplotHard or groupType == StageGroupType.SmallSubplotHard
end

function CopyDataUtils.IsCrazySubplotGroup(stageGroupTid)
  local StageGroupType = CommonDefine.StageGroupType
  local config = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not config then
    return false
  end
  local groupType = config.Type
  return groupType == StageGroupType.LargeSubplotCrazy or groupType == StageGroupType.SmallSubplotCrazy
end

local crazyStageGroupTypes = {
  [CommonDefine.StageGroupType.MainCopyCrazy] = true,
  [CommonDefine.StageGroupType.LargeSubplotCrazy] = true,
  [CommonDefine.StageGroupType.SmallSubplotCrazy] = true,
  [CommonDefine.StageGroupType.SpecialSubplotCrazy] = true,
  [CommonDefine.StageGroupType.LinkageActivityCrazy] = true
}

function CopyDataUtils.IsCrazyStageGroup(stageGroupId)
  local config = CopyDataUtils.GetStageGroupConfig(stageGroupId)
  if not config then
    return false
  end
  return crazyStageGroupTypes[config.Type] == true
end

local plotNormalStageGroupTypes = {
  StageGroupType.SmallSubplotNormal,
  StageGroupType.LargeSubplotNormal,
  StageGroupType.SpecialSubplotNormal,
  StageGroupType.LinkageActivityNormal
}

function CopyDataUtils.InitSubplotDifficult2IdMap()
  local difficult2IdMap = {}
  local StageGroupType = CommonDefine.StageGroupType
  local HardModeIndex = CommonDefine.StageGroupHardModeIndex
  for groupTid, config in pairs(DT.StageGroup) do
    local groupType = config.Type
    local isSubplotNormal = table.contains(plotNormalStageGroupTypes, groupType)
    if not isSubplotNormal then
    else
      local index2TidMap = {
        [HardModeIndex.Normal] = groupTid
      }
      difficult2IdMap[groupTid] = index2TidMap
      if not config.HardMode then
      else
        local hardGroupTid = config.HardMode[HardModeIndex.Hard]
        if hardGroupTid then
          index2TidMap[HardModeIndex.Hard] = hardGroupTid
          difficult2IdMap[hardGroupTid] = index2TidMap
        end
        local crazyGroupTid = config.HardMode[HardModeIndex.Crazy]
        if crazyGroupTid then
          index2TidMap[HardModeIndex.Crazy] = crazyGroupTid
          difficult2IdMap[crazyGroupTid] = index2TidMap
        end
      end
    end
  end
  CopyDataUtils.SubplotGroupDifficultIdMap = difficult2IdMap
end

function CopyDataUtils.GetSubplotDifficult2IdMap(groupTid)
  if not groupTid then
    return
  end
  if not CopyDataUtils.SubplotGroupDifficultIdMap then
    CopyDataUtils.InitSubplotDifficult2IdMap()
  end
  return CopyDataUtils.SubplotGroupDifficultIdMap[groupTid]
end

function CopyDataUtils.GetOtherDifficultGroupByHardIndex(groupTid, hardModeIndex)
  if not groupTid or not hardModeIndex then
    return
  end
  if not CopyDataUtils.SubplotGroupDifficultIdMap then
    CopyDataUtils.InitSubplotDifficult2IdMap()
  end
  local difficult2IdMap = CopyDataUtils.SubplotGroupDifficultIdMap
  if difficult2IdMap then
    local index2TidMap = difficult2IdMap[groupTid] or {}
    return index2TidMap[hardModeIndex]
  end
end

function CopyDataUtils.GetShowRewardItemGroup(progressDrops, star, getData, groupTid)
  local rst = {}
  for i = 1, #progressDrops, 2 do
    local needStar = progressDrops[i]
    local dropId = progressDrops[i + 1]
    local dropCfg = DT.Drop[dropId]
    local rewards = {}
    for _, info in ipairs(dropCfg.data_list) do
      table.insert(rewards, {
        tid = info.DropItem,
        num = info.DropNum
      })
    end
    table.insert(rst, {
      needStar = needStar,
      rewards = rewards,
      star = star,
      isAttach = star >= needStar,
      isGet = getData and getData[needStar] or false,
      groupTid = groupTid
    })
  end
  return rst
end

function CopyDataUtils.GetShowRewardItemGroupByStarItemReward(starRewardDatas, star, getData, groupTid)
  local rst = {}
  for _, data in ipairs(starRewardDatas) do
    local rewards = {}
    if data.rewards then
      for i = 1, #data.rewards, 2 do
        local tid = data.rewards[i]
        local num = data.rewards[i + 1]
        if tid and num then
          table.insert(rewards, {tid = tid, num = num})
        end
      end
      local progressInfoData = {
        needStar = data.star,
        rewards = rewards,
        star = star,
        isAttach = star >= data.star,
        isGet = data.isGet or getData[data.star] or false,
        groupTid = groupTid,
        awardTitle = data.awardTitle,
        hideStar = data.hideStar,
        reqGetAwardFunc = data.reqGetAwardFunc
      }
      if progressInfoData.reqGetAwardFunc then
        setmetatable(progressInfoData, ReactiveFlags.SKIP)
      end
      table.insert(rst, progressInfoData)
    end
  end
  return rst
end

function CopyDataUtils.GetStageGroupType(stageGroupTid)
  if not stageGroupTid then
    return
  end
  local config = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  return config and config.Type
end

function CopyDataUtils.GetGroupBestExperienceCondTipsId(stageGroupId)
  local stageGroupCfg = DT.StageGroup[stageGroupId]
  if not stageGroupCfg.BestExperienceCondition and not stageGroupCfg.PromptNumber then
    return nil
  end
  local needShowTips = false
  for _, stageId in pairs(stageGroupCfg.BestExperienceCondition or {}) do
    local stageCfg = DT.Stage[stageId]
    local tmpStageGroupId = stageCfg.BelongGroup
    local stageData = CopyDataUtils.GetAllTypeStageData(tmpStageGroupId, stageId)
    if not stageData or not stageData.firstRewardDraw then
      needShowTips = true
      break
    end
  end
  return needShowTips and stageGroupCfg.PromptNumber or nil
end

function CopyDataUtils.GetMaxPassedStageIndex(stageDataList)
  local maxPassedIndex = 0
  for i = 1, #stageDataList do
    local stageData = stageDataList[i]
    if stageData and stageData.firstRewardDraw and i > maxPassedIndex then
      maxPassedIndex = i
    end
  end
  return maxPassedIndex
end

function CopyDataUtils.GetLastUnlockStageIndex(stageDataList)
  local index = 0
  for i = 1, #stageDataList do
    if CopyDataUtils.GetStageVisible(stageDataList[i]) then
      break
    end
    index = index + 1
  end
  return 0 == index and 1 or index
end

function CopyDataUtils.GetStageVisible(stageData)
  local stageId = stageData.stageID
  local stageCfg = DT.Stage[stageId]
  local stageGroupId = stageCfg.BelongGroup
  local stageGroupType = DT.StageGroup[stageGroupId].Type
  local playerLv = DataCenter.playerData.DRole.level
  local showLevelLimit = DungeonUtils.IsShowStageLevelLimit(stageGroupType)
  if showLevelLimit then
    local limitLv = stageCfg and stageCfg.PlayerLevel or stageCfg.StageLevel or 0
    return playerLv < limitLv
  else
    return not stageData.unlocked
  end
end

function CopyDataUtils.GetAllTypeStageData(stageGroupId, stageId)
  local rst = MainCopyDataUtils.GetStageData(stageId)
  rst = rst or MainCopyDataUtils.GetStageData(stageId)
  rst = rst or CopyDataUtils.GetStageData(stageGroupId, stageId)
  rst = rst or SchoolTowerDataUtils.GetTowerStageData(stageId)
  return rst
end

function CopyDataUtils.OpenSubPlotGroupPanel(stageGroupId, fromActivityTid, extraParam)
  CopySubplotGroupModel.Instance:SetStageGroupID(stageGroupId)
  
  local function openSubplotPanel()
    UIManager.Instance:Reopen(Urls.SubplotGroupView, stageGroupId, fromActivityTid, extraParam)
  end
  
  local tipsId = CopyDataUtils.GetGroupBestExperienceCondTipsId(stageGroupId)
  if not tipsId then
    openSubplotPanel()
    return
  end
  local isCloseBestPrompt = ClientDataUtils.GetClientSubData(cd.ClientSubKey.CloseBestPromptToday)
  if 1 == isCloseBestPrompt then
    openSubplotPanel()
    return
  end
  local viewData = {
    tipsTypeTid = tipsId,
    stageTidList = StageGroupCfgUtils.GetCfgField("BestExperienceCondition", stageGroupId),
    confirmFunc = openSubplotPanel
  }
  TimerManager.Instance:CreateTimer(0.1, 0, nil, function()
    UIManager.Instance:Reopen(Urls.BestExpeirenceMsgView, viewData)
  end)
end

function CopyDataUtils.GetStageGroupCoverImage(tid)
  local config = CopyDataUtils.GetStageGroupConfig(tid)
  if not config then
    return
  end
  return config.CoverImage
end

function CopyDataUtils.GetStageGroupName(tid)
  local config = CopyDataUtils.GetStageGroupConfig(tid)
  if not config then
    return
  end
  return config.Name and LT.Text(config.Name)
end

function CopyDataUtils.HasDisplayTime(tid)
  local config = CopyDataUtils.GetStageGroupConfig(tid)
  return config and config.StageDisplayDate and config.StageDisplayDate > 0
end

function CopyDataUtils.IsInDisplayTime(groupTid)
  local config = CopyDataUtils.GetStageGroupConfig(groupTid)
  local now = TimeUtils.GetServerTime()
  if config and config.StageGroupCloseDate and now > config.StageGroupCloseDate then
    return
  end
  if config and config.StageDisplayDate then
    return config.StageDisplayDate < TimeUtils.GetServerTime()
  end
  return true
end

function CopyDataUtils.GetAwakerByStageId(stageId)
  local config = CopyDataUtils.GetStageConfig(stageId)
  if not config then
    return
  end
  local awakerName
  if type(config.TrialAwaker) == "number" then
    awakerName = AwakerDataUtils.GetAwakerName(config.TrialAwaker)
    return config.TrialAwaker, AwakerDataUtils.GetAwakerSchool(config.TrialAwaker), awakerName
  end
  if type(config.TrialAwaker) == "string" then
    local list = string.split(config.TrialAwaker, ";")
    local tid, schoolTid = tonumber(list[1]), tonumber(list[2])
    awakerName = AwakerDataUtils.GetAwakerName(tid)
    if schoolTid then
      awakerName = string.format("%s·%s", awakerName, AwakerDataUtils.GetSchoolName(schoolTid))
    end
    return tid, schoolTid, awakerName
  end
  return
end

function CopyDataUtils.GetDefaultStageTid(stageDataList)
  local targetIdx = CopyDataUtils.GetLastUnlockStageIndex(stageDataList) or 1
  if stageDataList and stageDataList[targetIdx] and stageDataList[targetIdx].stageID then
    return stageDataList[targetIdx].stageID
  end
  return 0
end

return CopyDataUtils
