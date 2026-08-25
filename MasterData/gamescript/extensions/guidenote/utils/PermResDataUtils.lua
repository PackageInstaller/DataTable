local PermResDataUtils = {}
local FeatureId = CommonDefine.FeatureId
local StageGroupType = CommonDefine.StageGroupType
local MainCopyAchieveState = CommonDefine.MainCopyAchieveState
local TaskDone = CommonDefine.TaskState.Done
local MODULE_CONFIG = {
  [1] = {
    jumpUrl = "CopyMainView",
    featureId = FeatureId.MainCopy,
    featureKey = 0,
    title = LT.Text("MainCopyTitle")
  },
  [2] = {
    jumpUrl = "DungeonsMainView",
    title = LT.Text("MainInterface_Challenge")
  },
  [3] = {
    jumpUrl = "MainPanelPVP",
    featureId = FeatureId.PVP,
    featureKey = 0,
    title = LT.Text("GoodSourcePVP")
  },
  [4] = {
    jumpUrl = "DailyChallengeView",
    featureId = FeatureId.DailyChallenge,
    featureKey = 0,
    title = LT.Text("MainInterface_Btn_DailyChallenge")
  },
  [5] = {
    jumpUrl = "ActivityPermanentsPanel",
    featureId = FeatureId.Activity,
    featureKey = 0,
    title = LT.Text("Resonance_Group_Name_Railway")
  }
}

function PermResDataUtils.GetSortedSummaryList()
  local cfgTable = DT.PermResSummary
  if nil == cfgTable then
    return {}
  end
  local list = {}
  for _, cfg in pairs(cfgTable) do
    list[#list + 1] = cfg
  end
  table.sort(list, function(a, b)
    return (a.BaseSortID or 0) < (b.BaseSortID or 0)
  end)
  return list
end

function PermResDataUtils.GetSummaryConfig(configId)
  local cfgTable = DT.PermResSummary
  if nil == cfgTable then
    return nil
  end
  return cfgTable[configId]
end

function PermResDataUtils.GetModuleTitle(moduleKey)
  local moduleCfg = MODULE_CONFIG[moduleKey]
  if nil == moduleCfg then
    return ""
  end
  return moduleCfg.title
end

function PermResDataUtils.IsModuleUnlocked(moduleKey)
  local moduleCfg = MODULE_CONFIG[moduleKey]
  if nil == moduleCfg then
    return true
  end
  if not moduleCfg.featureId then
    return true
  end
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(moduleCfg.featureId, moduleCfg.featureKey)
  return true == unlocked
end

function PermResDataUtils.GetModuleFeatureeText(moduleKey)
  local moduleCfg = MODULE_CONFIG[moduleKey]
  if nil == moduleCfg then
    return ""
  end
  do return PlayerDataUtils.GetFeatureLogicUnlockTips, moduleCfg.featureId end
  return PlayerDataUtils.GetFeatureLogicUnlockTips, moduleCfg.featureId, moduleCfg.featureKey
end

function PermResDataUtils.JumpToModule(moduleKey)
  local moduleCfg = MODULE_CONFIG[moduleKey]
  if nil == moduleCfg then
    return
  end
  local url = Urls[moduleCfg.jumpUrl]
  if nil == url then
    return
  end
  UIManager.Instance:Reopen(url)
end

function PermResDataUtils.GetJumpUrl(moduleKey)
  local moduleCfg = MODULE_CONFIG[moduleKey]
  if nil == moduleCfg then
    return nil
  end
  return Urls[moduleCfg.jumpUrl]
end

function PermResDataUtils.GetModuleTotalProgress(moduleKey)
  local progressData = PermResDataUtils.GetModuleProgressData(moduleKey)
  local totalCurrent = 0
  local totalMax = 0
  for _, slotData in pairs(progressData) do
    totalCurrent = totalCurrent + (slotData.current or 0)
    totalMax = totalMax + (slotData.total or 0)
  end
  return totalCurrent, totalMax
end

function PermResDataUtils.GetModuleProgressPercent(moduleKey)
  local current, total = PermResDataUtils.GetModuleTotalProgress(moduleKey)
  if total <= 0 then
    return 0
  end
  do return math.floor end
  return math.floor, current / total * 100
end

function PermResDataUtils.ParseDescWithProgress(configId)
  local cfg = PermResDataUtils.GetSummaryConfig(configId)
  if nil == cfg then
    return {}
  end
  local desc = LT.Text(cfg.Desc) or ""
  local progressData = PermResDataUtils.GetModuleProgressData(cfg.Key)
  desc = string.gsub(desc, "{s(%d+)}", function(indexStr)
    local slotIndex = tonumber(indexStr) or 0
    local slotData = progressData[slotIndex]
    if slotData then
      return tostring(slotData.current or 0) .. " / " .. tostring(slotData.total or 0)
    end
    return "0 / 0"
  end)
  local lines = {}
  for line in string.gmatch(desc, "([^#]+)") do
    local trimmed = line:match("^%s*(.-)%s*$")
    if trimmed and "" ~= trimmed then
      lines[#lines + 1] = trimmed
    end
  end
  return lines
end

function PermResDataUtils.ParseDescProgressItems(configId)
  local cfg = PermResDataUtils.GetSummaryConfig(configId)
  if nil == cfg then
    return {}
  end
  local desc = LT.Text(cfg.Desc) or ""
  local progressData = PermResDataUtils.GetModuleProgressData(cfg.Key)
  local items = {}
  for segment in string.gmatch(desc, "([^#]+)") do
    local trimmed = segment:match("^%s*(.-)%s*$")
    if trimmed and "" ~= trimmed then
      local title = trimmed:gsub("&?{s%d+}", ""):match("^%s*(.-)%s*$")
      local slotIndexStr = trimmed:match("{s(%d+)}")
      local slotIndex = tonumber(slotIndexStr) or 0
      local slotData = progressData[slotIndex] or {current = 0, total = 0}
      items[#items + 1] = {
        title = title or "",
        current = slotData.current or 0,
        total = slotData.total or 0
      }
    end
  end
  return items
end

function PermResDataUtils._GetMainCopySlotByGroupCfg(stageGroupCfg)
  if not stageGroupCfg then
    return nil
  end
  local groupType = stageGroupCfg.Type
  if groupType == StageGroupType.MainCopy then
    if stageGroupCfg.StageChapterText == cd.StageChapterName.StageChapterMorimens then
      return 1
    end
    if stageGroupCfg.StageChapterText == cd.StageChapterName.StageChapterStarsCameRight then
      return 3
    end
  elseif groupType == StageGroupType.MainCopyHard then
    if stageGroupCfg.StageChapterText == cd.StageChapterName.StageChapterMorimens then
      return 2
    end
    if stageGroupCfg.StageChapterText == cd.StageChapterName.StageChapterStarsCameRight then
      return 4
    end
  elseif groupType == StageGroupType.LargeSubplotNormal then
    return 5
  elseif groupType == StageGroupType.LargeSubplotHard then
    return 6
  elseif groupType == StageGroupType.SmallSubplotNormal then
    return 7
  elseif groupType == StageGroupType.SmallSubplotHard then
    return 8
  elseif groupType == StageGroupType.SpecialSubplotNormal then
    return 9
  elseif groupType == StageGroupType.SpecialSubplotCrazy then
    return 10
  elseif groupType == StageGroupType.LinkageActivityNormal then
    return 11
  elseif groupType == StageGroupType.LinkageActivityHard then
    return 12
  elseif groupType == StageGroupType.Vindicate then
    return 13
  end
  return nil
end

function PermResDataUtils._IsMainLineStage(groupType)
  return groupType == StageGroupType.MainCopy or groupType == StageGroupType.MainCopyHard or groupType == StageGroupType.MainCopyCrazy
end

function PermResDataUtils._MergeRewardList(itemCountMap, rewardInfoList)
  for _, info in ipairs(rewardInfoList or {}) do
    local tid = info.tid or info.itemTid
    local num = info.num or info.count or 0
    if tid and tid > 0 and num > 0 then
      itemCountMap[tid] = (itemCountMap[tid] or 0) + num
    end
  end
end

function PermResDataUtils._MergeCareerLevelNotReceived(itemCountMap, careerLevelType)
  if CareerLevelModel and CareerLevelModel.Instance then
    local list = CareerLevelModel.Instance:GetNotReceiveRewardInfoList(careerLevelType)
    PermResDataUtils._MergeRewardList(itemCountMap, list)
  end
end

function PermResDataUtils._MergeNotDoneTaskRewardsByTaskList(itemCountMap, taskList)
  for _, taskData in ipairs(taskList or {}) do
    local taskTid = taskData and taskData.tid or 0
    local taskCfg = taskTid > 0 and DT.Task[taskTid] or nil
    local isDone = taskData and taskData.state == TaskDone or false
    if taskCfg and not isDone then
      for tid, num in table.iteraDouble(taskCfg.CompleteAward or {}) do
        if tid and num and tid > 0 and num > 0 then
          itemCountMap[tid] = (itemCountMap[tid] or 0) + num
        end
      end
    end
  end
end

function PermResDataUtils._GetConstKeyTaskDoneProgress(constKey)
  local parentTaskList = DT.GetOriginalConstant(constKey)
  if not parentTaskList then
    return 0, 0
  end
  local parentTaskMap = table.reverseKV(parentTaskList)
  local current, total = 0, 0
  for taskTid, taskCfg in pairs(DT.Task or {}) do
    if taskCfg.BelongTaskGroup and parentTaskMap[taskCfg.BelongTaskGroup] then
      total = total + 1
      local taskData = TaskDataUtils.GetTaskData(taskTid)
      if taskData and taskData.state == TaskDone then
        current = current + 1
      end
    end
  end
  return current, total
end

function PermResDataUtils._GetCareerLevelRewardGotProgress(careerLevelType)
  local cfgList = CareerLevelCfgUtils.GetcfgListByType(careerLevelType) or {}
  local current = 0
  local total = #cfgList
  local careerLevelModel = CareerLevelModel and CareerLevelModel.Instance or nil
  for _, cfg in ipairs(cfgList) do
    if careerLevelModel and careerLevelModel.IsCareerLevelGoted and careerLevelModel:IsCareerLevelGoted(careerLevelType, cfg.Level) then
      current = current + 1
    end
  end
  return current, total
end

function PermResDataUtils._CollectMainCopyStageBasicRewards(itemCountMap, stageCfg, stageData, includePerfectReward)
  local firstTimeReward = stageCfg and stageCfg.FirstTimeReward or nil
  if not stageData.firstRewardDraw then
    for tid, num in table.iteraDouble(firstTimeReward or {}) do
      if tid and num and tid > 0 and num > 0 then
        itemCountMap[tid] = (itemCountMap[tid] or 0) + num
      end
    end
  end
  local perfectReward = stageCfg and stageCfg.PerfectReward or nil
  if includePerfectReward and (stageData.star or 0) < 3 then
    for tid, num in table.iteraDouble(perfectReward or {}) do
      if tid and num and tid > 0 and num > 0 then
        itemCountMap[tid] = (itemCountMap[tid] or 0) + num
      end
    end
  end
end

function PermResDataUtils._CollectMainCopyStageExtraRewards(itemCountMap, stageCfg, stageData)
  if nil == stageCfg or nil == stageData then
    return
  end
  for _, taskId in ipairs(stageCfg.LevelAchieve or {}) do
    local isTaskGot = stageData.achivement and stageData.achivement[taskId] == MainCopyAchieveState.IsGot
    if not isTaskGot then
      local taskCfg = DT.Task[taskId]
      for tid, num in table.iteraDouble(taskCfg and taskCfg.CompleteAward or {}) do
        if tid and num and tid > 0 and num > 0 then
          itemCountMap[tid] = (itemCountMap[tid] or 0) + num
        end
      end
    end
  end
  local hideAwardNodeList = MainCopyDataUtils.GetHideAwardNodeList(stageData.stageID)
  if #hideAwardNodeList > 0 and 1 ~= stageData.hiddenAward then
    for tid, num in pairs(stageCfg.HideRewards or {}) do
      if tid and num and tid > 0 and num > 0 then
        itemCountMap[tid] = (itemCountMap[tid] or 0) + num
      end
    end
  end
end

function PermResDataUtils._CollectMainCopyGroupStarRewards(itemCountMap, groupID, stageGroupCfg, groupData)
  if nil == stageGroupCfg then
    return
  end
  local dropList = stageGroupCfg.StageGroupDrop or {}
  local starGainInfo = groupData and groupData.starGainInfo or {}
  for i = 1, #dropList, 2 do
    local needStar = dropList[i]
    local dropId = dropList[i + 1]
    if needStar and dropId and not starGainInfo[needStar] then
      local dropCfg = DT.Drop[dropId]
      for _, info in ipairs(dropCfg and dropCfg.data_list or {}) do
        local tid = info.DropItem
        local num = info.DropNum
        if tid and num and tid > 0 and num > 0 then
          itemCountMap[tid] = (itemCountMap[tid] or 0) + num
        end
      end
    end
  end
end

function PermResDataUtils._CollectMainCopyRemainingRewards(itemCountMap)
  for groupID, stageGroupCfg in pairs(DT.StageGroup or {}) do
    if CopyDataUtils.IsInDisplayTime(groupID) then
      local slotIndex = PermResDataUtils._GetMainCopySlotByGroupCfg(stageGroupCfg)
      if slotIndex then
        local isMainLineStage = PermResDataUtils._IsMainLineStage(stageGroupCfg.Type)
        local includePerfectReward = stageGroupCfg.Type ~= StageGroupType.Vindicate
        for _, stageCfg in ipairs(CopyDataUtils.GetCfgStageList(groupID) or {}) do
          if CopyDataUtils.CheckStageIsInOpenTime(stageCfg.ID) then
            local stageData = MainCopyDataUtils.GetStageData(stageCfg.ID) or {
              stageID = stageCfg.ID,
              firstRewardDraw = false,
              star = 0,
              hiddenAward = 0
            }
            PermResDataUtils._CollectMainCopyStageBasicRewards(itemCountMap, stageCfg, stageData, includePerfectReward)
            if isMainLineStage then
              PermResDataUtils._CollectMainCopyStageExtraRewards(itemCountMap, stageCfg, stageData)
            end
          end
        end
        if isMainLineStage then
          local groupData = DataCenter.MainCopyData.allPlots and DataCenter.MainCopyData.allPlots[groupID] or nil
          PermResDataUtils._CollectMainCopyGroupStarRewards(itemCountMap, groupID, stageGroupCfg, groupData)
        end
      end
    end
  end
end

function PermResDataUtils._MergeNotDoneTaskRewardsByConstKey(itemCountMap, constKey, debugTag)
  local parentTaskList = DT.GetOriginalConstant(constKey)
  if not parentTaskList then
    return
  end
  local parentTaskMap = table.reverseKV(parentTaskList)
  local pendingTaskCount = 0
  local debugRewardMap = {}
  local taskData, isDone
  for taskTid, taskCfg in pairs(DT.Task) do
    if taskCfg.BelongTaskGroup and parentTaskMap[taskCfg.BelongTaskGroup] then
      taskData = TaskDataUtils.GetTaskData(taskTid)
      isDone = taskData and taskData.state == TaskDone or false
      if not isDone then
        pendingTaskCount = pendingTaskCount + 1
        for tid, num in table.iteraDouble(taskCfg.CompleteAward or {}) do
          if tid and num and tid > 0 and num > 0 then
            itemCountMap[tid] = (itemCountMap[tid] or 0) + num
            if debugTag then
              debugRewardMap[tid] = (debugRewardMap[tid] or 0) + num
            end
          end
        end
      end
    end
  end
  if debugTag then
    local rewardParts = {}
    for tid, num in pairs(debugRewardMap) do
      rewardParts[#rewardParts + 1] = string.format("{itemTid=%s,count=%s}", tostring(tid), tostring(num))
    end
    table.sort(rewardParts)
    print(string.format("[PermResDebug][%sRemaining] constKey=%s pendingTaskCount=%s rewardCount=%s rewards=%s", tostring(debugTag), tostring(constKey), tostring(pendingTaskCount), tostring(#rewardParts), table.concat(rewardParts, ", ")))
  end
end

function PermResDataUtils._AccumulateDungeonsMaterialRewards(itemTid2Count)
  PermResDataUtils._MergeNotDoneTaskRewardsByConstKey(itemTid2Count, "DailyMaterialPerfectRewardTaskGroup")
end

function PermResDataUtils._AccumulateDungeonsTrinketRewards(itemTid2Count)
  PermResDataUtils._MergeNotDoneTaskRewardsByConstKey(itemTid2Count, "TrinketCopyPerfectRewardTaskGroup")
end

function PermResDataUtils._AccumulateDungeonsAbyssRewards(itemTid2Count)
  local abyssModel = AbyssExtModel and AbyssExtModel.Instance or nil
  if abyssModel and abyssModel.GetProgressRewardDatas then
    local progressRewardDatas = abyssModel:GetProgressRewardDatas()
    for _, rewardData in ipairs(progressRewardDatas or {}) do
      local isAttach = rewardData and rewardData.isAttach or false
      local isGet = rewardData and rewardData.isGet or false
      if isAttach and not isGet then
        PermResDataUtils._MergeRewardList(itemTid2Count, rewardData.rewards)
      end
    end
  end
end

function PermResDataUtils._AccumulateDungeonsTowerRewards(itemTid2Count)
  local towerDataList = SchoolTowerDataUtils.GetTowerDataByStageGroupType(StageGroupType.DisposableSchoolTower)
  for _, towerData in ipairs(towerDataList or {}) do
    local stageGroupId = towerData.stageGroupId
    local stageGroupCfg = DT.StageGroup[stageGroupId]
    for _, stageData in pairs(towerData.stageList or {}) do
      if not stageData.firstRewardDraw then
        local stageCfg = DT.Stage[stageData.stageID]
        for tid, num in table.iteraDouble(stageCfg and stageCfg.FirstTimeReward or {}) do
          if tid and num and tid > 0 and num > 0 then
            itemTid2Count[tid] = (itemTid2Count[tid] or 0) + num
          end
        end
      end
    end
    local dropList = stageGroupCfg and stageGroupCfg.StageGroupDrop or {}
    local towerModel = SchoolTowerModel and SchoolTowerModel.Instance or nil
    local awardProgress = towerModel and towerModel.GetStageGroupAwardProgressDict and towerModel:GetStageGroupAwardProgressDict(stageGroupId)
    local hasAwardProgressData = nil ~= awardProgress
    for j = 1, #dropList, 2 do
      local needStar = dropList[j]
      local dropId = dropList[j + 1]
      if hasAwardProgressData and needStar and dropId and not awardProgress[needStar] then
        local dropCfg = DT.Drop and DT.Drop[dropId]
        for _, info in ipairs(dropCfg and dropCfg.data_list or {}) do
          local tid = info.DropItem
          local num = info.DropNum
          if tid and num and tid > 0 and num > 0 then
            itemTid2Count[tid] = (itemTid2Count[tid] or 0) + num
          end
        end
      end
    end
  end
end

function PermResDataUtils._AccumulateDungeonsWeekBossRewards(itemTid2Count)
  PermResDataUtils._MergeNotDoneTaskRewardsByConstKey(itemTid2Count, "WeekBossChallengePerfectRewardTaskGroup")
end

function PermResDataUtils._AccumulatePvpRecordRewards(itemTid2Count)
  local pvpTaskType = CommonDefine.TaskType.TaskType_PVPRewardTask
  local pvpTaskList = TaskDataUtils.GetTaskListByType(pvpTaskType, true)
  PermResDataUtils._MergeNotDoneTaskRewardsByTaskList(itemTid2Count, pvpTaskList)
end

function PermResDataUtils._AccumulateDailyChallengeAchievementRewards(itemTid2Count)
  local _, taskListMap = DailyChallengeDataUtils.GetDailyAchievementTaskLists()
  for _, childList in pairs(taskListMap or {}) do
    local taskDataList = {}
    for _, taskId in ipairs(childList or {}) do
      local taskData = TaskDataUtils.GetTaskData(taskId)
      if taskData then
        taskDataList[#taskDataList + 1] = taskData
      end
    end
    PermResDataUtils._MergeNotDoneTaskRewardsByTaskList(itemTid2Count, taskDataList)
  end
end

function PermResDataUtils._AccumulateRemainingRewardsForModule(moduleKey, itemTid2Count)
  if 1 == moduleKey then
    PermResDataUtils._CollectMainCopyRemainingRewards(itemTid2Count)
  elseif 2 == moduleKey then
    PermResDataUtils._AccumulateDungeonsMaterialRewards(itemTid2Count)
    PermResDataUtils._AccumulateDungeonsTrinketRewards(itemTid2Count)
    PermResDataUtils._AccumulateDungeonsAbyssRewards(itemTid2Count)
    PermResDataUtils._AccumulateDungeonsTowerRewards(itemTid2Count)
    PermResDataUtils._AccumulateDungeonsWeekBossRewards(itemTid2Count)
  elseif 3 == moduleKey then
    PermResDataUtils._AccumulatePvpRecordRewards(itemTid2Count)
    PermResDataUtils._MergeCareerLevelNotReceived(itemTid2Count, CareerLevelDefine.CareerLevelType.PvpPreBuilt)
    PermResDataUtils._MergeCareerLevelNotReceived(itemTid2Count, CareerLevelDefine.CareerLevelType.PvpDraft)
  elseif 4 == moduleKey then
    PermResDataUtils._AccumulateDailyChallengeAchievementRewards(itemTid2Count)
    PermResDataUtils._MergeCareerLevelNotReceived(itemTid2Count, CareerLevelDefine.CareerLevelType.DailyChallenge)
  elseif 5 == moduleKey and RailWayModel and RailWayModel.Instance and RailWayModel.Instance.GetNotReceiveRewardInfoList then
    local railWayRewards = RailWayModel.Instance:GetNotReceiveRewardInfoList()
    PermResDataUtils._MergeRewardList(itemTid2Count, railWayRewards)
  end
end

function PermResDataUtils._CompareRemainingRewardEntries(a, b)
  local cfgA = ItemDataUtils.GetItemConfig(a.itemTid)
  local cfgB = ItemDataUtils.GetItemConfig(b.itemTid)
  if nil == cfgA and nil == cfgB then
    return a.itemTid < b.itemTid
  end
  if nil == cfgA then
    return false
  end
  if nil == cfgB then
    return true
  end
  local qualitySortA = ItemCfgUtils.GetItemQualitySort(a.itemTid) or 0
  local qualitySortB = ItemCfgUtils.GetItemQualitySort(b.itemTid) or 0
  if qualitySortA ~= qualitySortB then
    return qualitySortA > qualitySortB
  end
  local typeA = cfgA.Type or 0
  local typeB = cfgB.Type or 0
  if typeA ~= typeB then
    return typeA < typeB
  end
  local sortIdA = cfgA.BaseSortID or 0
  local sortIdB = cfgB.BaseSortID or 0
  if sortIdA ~= sortIdB then
    return sortIdA < sortIdB
  end
  return a.itemTid < b.itemTid
end

function PermResDataUtils._RemainingRewardMapToSortedList(itemTid2Count)
  local resultList = {}
  local ItemType = CommonDefine.ItemType
  local ItemSubType = CommonDefine.ItemSubType
  local excludeTypeMap = {
    [ItemType.KeeperSkill] = true,
    [ItemType.AwakerItem] = true
  }
  local excludeSubTypeMap = {
    [ItemSubType.ResonanceParticle] = true
  }
  for tid, count in pairs(itemTid2Count) do
    local itemType = ItemDataUtils.GetItemType(tid)
    local itemSubType = ItemDataUtils.GetItemSubType(tid)
    local isExcludeType = excludeTypeMap[itemType] or excludeSubTypeMap[itemSubType]
    if not isExcludeType then
      resultList[#resultList + 1] = {itemTid = tid, count = count}
    end
  end
  table.sort(resultList, PermResDataUtils._CompareRemainingRewardEntries)
  return resultList
end

function PermResDataUtils.GetRemainingRewards(moduleKey)
  local itemTid2Count = {}
  PermResDataUtils._AccumulateRemainingRewardsForModule(moduleKey, itemTid2Count)
  do return PermResDataUtils._RemainingRewardMapToSortedList end
  return PermResDataUtils._RemainingRewardMapToSortedList, itemTid2Count, itemTid2Count
end

local SPECIAL_CURRENCY_TID = CommonDefine.CurrencyType.SeniorMoney or 0

function PermResDataUtils.GetRemainingSpecialCurrency(moduleKey)
  if SPECIAL_CURRENCY_TID <= 0 then
    return 0
  end
  local rewards = PermResDataUtils.GetRemainingRewards(moduleKey)
  local totalCount = 0
  for _, reward in ipairs(rewards) do
    if reward.itemTid == SPECIAL_CURRENCY_TID then
      totalCount = totalCount + (reward.count or 0)
    end
  end
  return totalCount
end

function PermResDataUtils.IsModuleFullyCollected(moduleKey)
  local current, total = PermResDataUtils.GetModuleTotalProgress(moduleKey)
  return total > 0 and total <= current
end

function PermResDataUtils._CalcStageGroupStarDropProgress(stageGroupID)
  local cur, total = 0, 0
  local stageGroupCfg = DT.StageGroup[stageGroupID]
  if not stageGroupCfg or not stageGroupCfg.StageGroupDrop then
    return cur, total
  end
  local dropList = stageGroupCfg.StageGroupDrop
  local groupData = DataCenter.MainCopyData.allPlots[stageGroupID]
  local starGainInfo = groupData and groupData.starGainInfo
  for i = 1, #dropList, 2 do
    local needStar = dropList[i]
    local dropId = dropList[i + 1]
    if needStar and dropId then
      total = total + 1
      if starGainInfo and starGainInfo[needStar] then
        cur = cur + 1
      end
    end
  end
  return cur, total
end

function PermResDataUtils._CalcMainCopyStageGroupProgress(stageGroupID, includeLineExtra, includePerfectReward)
  local cur, total = 0, 0
  local cfgStages = CopyDataUtils.GetCfgStageList(stageGroupID) or {}
  for _, stageCfg in ipairs(cfgStages) do
    if not CopyDataUtils.CheckStageIsInOpenTime(stageCfg.ID) then
    else
      total = total + 1
      local sd = MainCopyDataUtils.GetStageData(stageCfg.ID)
      if sd and sd.firstRewardDraw then
        cur = cur + 1
      end
      if includePerfectReward and stageCfg.PerfectReward then
        total = total + 1
        if sd and (sd.star or 0) >= 3 then
          cur = cur + 1
        end
      end
      if includeLineExtra then
        total = total + #(stageCfg.LevelAchieve or {})
        if sd and sd.achivement then
          for _, achieveState in pairs(sd.achivement) do
            if achieveState == MainCopyAchieveState.IsGot then
              cur = cur + 1
            end
          end
        end
        local hideNodeList = MainCopyDataUtils.GetHideAwardNodeList(stageCfg.ID)
        local hideNodeCount = #hideNodeList
        if hideNodeCount > 0 then
          total = total + hideNodeCount
          if sd and 1 == sd.hiddenAward then
            cur = cur + hideNodeCount
          end
        end
      end
    end
  end
  local starDropCur, starDropTotal = PermResDataUtils._CalcStageGroupStarDropProgress(stageGroupID)
  cur = cur + starDropCur
  total = total + starDropTotal
  return cur, total
end

function PermResDataUtils._GetCopyProgressData()
  local result = {}
  for slotIndex = 1, 13 do
    result[slotIndex] = {current = 0, total = 0}
  end
  for groupID, groupCfg in pairs(DT.StageGroup or {}) do
    if CopyDataUtils.IsInDisplayTime(groupID) then
      local slotIndex = PermResDataUtils._GetMainCopySlotByGroupCfg(groupCfg)
      if slotIndex then
        local includeLineExtra = PermResDataUtils._IsMainLineStage(groupCfg.Type)
        local includePerfectReward = groupCfg.Type ~= StageGroupType.Vindicate
        local gCur, gTotal = PermResDataUtils._CalcMainCopyStageGroupProgress(groupID, includeLineExtra, includePerfectReward)
        result[slotIndex].current = result[slotIndex].current + gCur
        result[slotIndex].total = result[slotIndex].total + gTotal
      end
    end
  end
  return result
end

function PermResDataUtils._GetDungeonsProgressData()
  local result = {}
  for slotIndex = 1, 8 do
    result[slotIndex] = {current = 0, total = 0}
  end
  local materialCur, materialTotal = PermResDataUtils._GetConstKeyTaskDoneProgress("DailyMaterialPerfectRewardTaskGroup")
  result[1] = {current = materialCur, total = materialTotal}
  local trinketCur, trinketTotal = PermResDataUtils._GetConstKeyTaskDoneProgress("TrinketCopyPerfectRewardTaskGroup")
  result[2] = {current = trinketCur, total = trinketTotal}
  local towerDataList = SchoolTowerDataUtils.GetTowerDataByStageGroupType(StageGroupType.DisposableSchoolTower)
  table.sort(towerDataList, function(a, b)
    local cfgA = DT.StageGroup[a.stageGroupId]
    local cfgB = DT.StageGroup[b.stageGroupId]
    return (cfgA and cfgA.Sequence or 0) < (cfgB and cfgB.Sequence or 0)
  end)
  for i, towerData in ipairs(towerDataList) do
    local slotIndex = i + 2
    if slotIndex > 6 then
      break
    end
    local stageGroupId = towerData.stageGroupId
    local stageGroupCfg = DT.StageGroup[stageGroupId]
    for _, stageData in pairs(towerData.stageList or {}) do
      local stageCfg = DT.Stage[stageData.stageID]
      if stageCfg and stageCfg.FirstTimeReward then
        result[slotIndex].total = result[slotIndex].total + 1
        if stageData.firstRewardDraw then
          result[slotIndex].current = result[slotIndex].current + 1
        end
      end
    end
    local dropList = stageGroupCfg and stageGroupCfg.StageGroupDrop or {}
    local towerModel = SchoolTowerModel and SchoolTowerModel.Instance or nil
    local awardProgress = towerModel and towerModel.GetStageGroupAwardProgressDict and towerModel:GetStageGroupAwardProgressDict(stageGroupId)
    for j = 1, #dropList, 2 do
      local needStar = dropList[j]
      local dropId = dropList[j + 1]
      if needStar and dropId then
        result[slotIndex].total = result[slotIndex].total + 1
        if awardProgress and awardProgress[needStar] then
          result[slotIndex].current = result[slotIndex].current + 1
        end
      end
    end
  end
  local weekBossCur, weekBossTotal = PermResDataUtils._GetConstKeyTaskDoneProgress("WeekBossChallengePerfectRewardTaskGroup")
  result[7] = {current = weekBossCur, total = weekBossTotal}
  return result
end

function PermResDataUtils._GetPvpProgressData()
  local result = {}
  for slotIndex = 1, 3 do
    result[slotIndex] = {current = 0, total = 0}
  end
  local totalCount = 0
  local receivedCount = 0
  local pvpTaskType = CommonDefine.TaskType.TaskType_PVPRewardTask
  if pvpTaskType then
    local pvpTaskList = TaskDataUtils.GetTaskListByType(pvpTaskType, true)
    for _, taskData in ipairs(pvpTaskList or {}) do
      totalCount = totalCount + 1
      if taskData.state == TaskDone then
        receivedCount = receivedCount + 1
      end
    end
  end
  result[1] = {current = receivedCount, total = totalCount}
  local preBuiltCur, preBuiltTotal = PermResDataUtils._GetCareerLevelRewardGotProgress(CareerLevelDefine.CareerLevelType.PvpPreBuilt)
  result[2] = {current = preBuiltCur, total = preBuiltTotal}
  local draftCur, draftTotal = PermResDataUtils._GetCareerLevelRewardGotProgress(CareerLevelDefine.CareerLevelType.PvpDraft)
  result[3] = {current = draftCur, total = draftTotal}
  return result
end

function PermResDataUtils._GetDivingProgressData()
  local result = {}
  for slotIndex = 1, 2 do
    result[slotIndex] = {current = 0, total = 0}
  end
  local _, taskListMap = DailyChallengeDataUtils.GetDailyAchievementTaskLists()
  local divingCur, divingTotal = 0, 0
  for _, childList in pairs(taskListMap or {}) do
    for _, taskId in ipairs(childList) do
      divingTotal = divingTotal + 1
      local taskData = TaskDataUtils.GetTaskData(taskId)
      if taskData and taskData.state == TaskDone then
        divingCur = divingCur + 1
      end
    end
  end
  result[1] = {current = divingCur, total = divingTotal}
  local levelCur, levelTotal = PermResDataUtils._GetCareerLevelRewardGotProgress(CareerLevelDefine.CareerLevelType.DailyChallenge)
  result[2] = {current = levelCur, total = levelTotal}
  return result
end

function PermResDataUtils._GetRailWayProgressData()
  local result = {}
  for slotIndex = 1, 2 do
    result[slotIndex] = {current = 0, total = 0}
  end
  local taskList = TaskDataUtils.GetTaskListByType(CommonDefine.TaskType.TaskType_RailWay, true)
  local totalCount = 0
  local receivedCount = 0
  for _, taskData in ipairs(taskList or {}) do
    totalCount = totalCount + 1
    if taskData.state == TaskDone then
      receivedCount = receivedCount + 1
    end
  end
  result[1] = {current = receivedCount, total = totalCount}
  local levelCur, levelTotal = PermResDataUtils._GetCareerLevelRewardGotProgress(CareerLevelDefine.CareerLevelType.RailWay)
  result[2] = {current = levelCur, total = levelTotal}
  return result
end

local MODULE_PROGRESS_GETTERS = {
  [1] = PermResDataUtils._GetCopyProgressData,
  [2] = PermResDataUtils._GetDungeonsProgressData,
  [3] = PermResDataUtils._GetPvpProgressData,
  [4] = PermResDataUtils._GetDivingProgressData,
  [5] = PermResDataUtils._GetRailWayProgressData
}

function PermResDataUtils.GetModuleProgressData(moduleKey)
  local fn = MODULE_PROGRESS_GETTERS[moduleKey]
  if fn then
    do return end
    return fn
  end
  return {}
end

return PermResDataUtils
