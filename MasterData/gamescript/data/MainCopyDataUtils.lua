local StageGroupType = CommonDefine.StageGroupType
local MainCopyDataUtils = {}

function MainCopyDataUtils.ResetAll()
  DataCenter.MainCopyData.allPlots = {}
  DataCenter.MainCopyData.cfgTotalStar = {}
  DataCenter.MainCopyData.stageChapter2Groups = {}
end

function MainCopyDataUtils.InitServerPlots(plots, hardPlots, crazyPlots)
  local allPlots = MainCopyDataUtils.InitOtherDataByCfg()
  for _, v in ipairs(plots) do
    local plot = table.deepclone(v)
    allPlots[v.stageGroupID] = plot
  end
  for _, v in ipairs(hardPlots) do
    local plot = table.deepclone(v)
    allPlots[v.stageGroupID] = plot
  end
  if crazyPlots then
    for _, v in ipairs(crazyPlots) do
      local plot = table.deepclone(v)
      allPlots[v.stageGroupID] = plot
    end
  end
  DataCenter.MainCopyData.allPlots = allPlots
  MainCopyDataUtils:InitCfgTotalStar()
end

function MainCopyDataUtils.InitOtherDataByCfg()
  local allPlots = {}
  for groupId, groupInfo in pairs(DT.StageGroup) do
    allPlots[groupId] = {
      stageList = {},
      open = false,
      stageGroupID = groupId,
      totalStar = 0
    }
  end
  for stageID, stageInfo in pairs(DT.Stage) do
    local groupInfo = allPlots[stageInfo.BelongGroup]
    if groupInfo then
      table.insert(groupInfo.stageList, {
        star = 0,
        unlocked = false,
        hiddenAward = 0,
        firstRewardDraw = false,
        stageID = stageID
      })
    end
  end
  for _, groupInfo in pairs(allPlots) do
    table.sort(groupInfo.stageList, function(a, b)
      local aCfg = DT.Stage[a.stageID]
      local bCfg = DT.Stage[b.stageID]
      return aCfg.Sequence < bCfg.Sequence
    end)
  end
  return allPlots
end

function MainCopyDataUtils.InitCfgTotalStar()
  local cfgTotalStar = {}
  for _, stageInfo in pairs(DT.Stage) do
    local groupID = stageInfo.BelongGroup
    cfgTotalStar[groupID] = (cfgTotalStar[groupID] or 0) + 3
  end
  DataCenter.MainCopyData.cfgTotalStar = cfgTotalStar
end

function MainCopyDataUtils.OpenLastChapterPanel()
  local curStageGroupId = WorldStageManager.Instance.lastGroupId
  if DataCenter.MainCopyData.allPlots[curStageGroupId] then
    MainCopyDataUtils.OpenMainCopyChapterPanel(curStageGroupId)
  end
end

function MainCopyDataUtils.OpenMainCopyAchievementTips(stageGroupId)
  UIManager.Instance:Reopen(Urls.CopyStageAchievementView, stageGroupId)
end

function MainCopyDataUtils.OpenMainCopyChapterPanel(stageGroupId, stageData, noShowDetail, model)
  if UIManager.Instance:GetWindow(Urls.CopyStageDetailView) then
    UIManager.Instance:CloseByUrl(Urls.CopyStageDetailView)
  end
  UIManager.Instance:Reopen(Urls.MainCopyChapterPanel, stageGroupId, stageData, noShowDetail, model)
end

function MainCopyDataUtils.UpdateStageData(data)
  for _, stageData in pairs(data) do
    DataCenter.MainCopyData.allPlots[stageData.stageGroupID] = stageData
  end
end

function MainCopyDataUtils.IsStageGroupUnlock(stageGroupID)
  local stageGroupData = DataCenter.MainCopyData.allPlots[stageGroupID]
  local isOpen = stageGroupData and stageGroupData.open
  return isOpen
end

function MainCopyDataUtils.IsStageIdUnlock(stageID)
  local stageCfg = DT.Stage[stageID]
  local stageGroupID = stageCfg.BelongGroup
  local stageGroupData = DataCenter.MainCopyData.allPlots[stageGroupID]
  local stageList = stageGroupData and stageGroupData.stageList
  for _, stageData in ipairs(stageList or {}) do
    if stageData.stageID == stageID then
      if stageCfg.OpenItem then
        return stageData.unlockItem
      end
      return stageData.unlocked
    end
  end
  return false
end

function MainCopyDataUtils.GetStageCfg(stageId)
  return DT.Stage[stageId]
end

function MainCopyDataUtils.GetStageGroupCfg(stageGroupId)
  return DT.StageGroup[stageGroupId]
end

function MainCopyDataUtils.GetStageGroupID(stageId)
  return DT.Stage[stageId] and DT.Stage[stageId].BelongGroup
end

function MainCopyDataUtils.GetStageList(stageGroupId)
  local groupData = DataCenter.MainCopyData.allPlots[stageGroupId]
  if groupData then
    local stageList = {}
    for _, stageData in ipairs(groupData.stageList) do
      if stageData.unlocked then
        table.insert(stageList, stageData)
      end
    end
    return stageList
  end
  return {}
end

function MainCopyDataUtils.GetAchieveState(stageData, achieveId)
  return stageData.achivement[achieveId]
end

function MainCopyDataUtils.GetAchievementProgress(stageGroupId)
  local achievementCurProgress, achievementLimitProgress = 0, 0
  local stageList = MainCopyDataUtils.GetStageList(stageGroupId)
  for _, stageData in pairs(stageList) do
    for _, isFinish in pairs(stageData.achivement or {}) do
      if isFinish >= 1 then
        achievementCurProgress = achievementCurProgress + 1
      end
    end
    local stageCfg = MainCopyDataUtils.GetStageCfg(stageData.stageID)
    local cfgCount = #(stageCfg.LevelAchieve or {})
    achievementLimitProgress = achievementLimitProgress + cfgCount
  end
  return achievementCurProgress, achievementLimitProgress
end

function MainCopyDataUtils.HasGotAllSubplotPrize(stageGroupTid)
  if not stageGroupTid then
    return false
  end
  local groupData = DataCenter.MainCopyData.allPlots[stageGroupTid]
  local stageList = groupData and groupData.stageList
  if not stageList then
    return false
  end
  for _, stageData in ipairs(groupData.stageList) do
    local stageConfig = CopyDataUtils.GetStageConfig(stageData.stageID)
    if not stageConfig then
      return false
    end
    if not stageData.firstRewardDraw then
      return false
    end
    if stageConfig.Map and stageData.star < 3 then
      return false
    end
    if stageConfig.HideRewards and stageData.hiddenAward and 1 ~= stageData.hiddenAward then
      return false
    end
    if stageData.achivement then
      for _, finishValue in pairs(stageData.achivement) do
        if finishValue ~= CommonDefine.MainCopyAchieveState.IsGot then
          return false
        end
      end
    end
  end
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if stageGroupConfig and stageGroupConfig.StageGroupDrop and groupData.starGainInfo then
    for i = 1, #stageGroupConfig.StageGroupDrop, 2 do
      local star = stageGroupConfig.StageGroupDrop[i]
      if star and not groupData.starGainInfo[star] then
        return false
      end
    end
  end
  return true
end

function MainCopyDataUtils.GetLatestCopyID(hardMode)
  local lastCopyID = 0
  local curTime = math.floor(TimeUtils.GetServerTime())
  local NormalMode = CommonDefine.Difficulty.Normal
  local HardMode = CommonDefine.Difficulty.Hard
  local SuperMode = CommonDefine.Difficulty.Super
  local lastBaseSortID = 0
  local stageChapterName = cd.StageChapterName.StageChapterMorimens
  local _, isFirstChatperFinish = PlayerDataUtils.IsFeatureUnlock(cd.FeatureId.FirstChapterFinish, 0)
  local isFirstAvgFinish = ClientDataUtils.GetData(cd.ClientDataMainKey.AVG_Feature, cd.FeatureId.FirstChapterFinish)
  if isFirstChatperFinish and isFirstAvgFinish then
    stageChapterName = cd.StageChapterName.StageChapterStarsCameRight
  end
  for stageGroupID, info in pairs(DataCenter.MainCopyData.allPlots) do
    local stageGroupCfg = DT.StageGroup[stageGroupID]
    if info.open and stageGroupCfg and stageGroupCfg.StageChapterText == stageChapterName then
      local canShow = stageGroupCfg and (not stageGroupCfg.StageDisplayDate or curTime >= stageGroupCfg.StageDisplayDate)
      local preBaseSortID = lastBaseSortID
      if canShow then
        if hardMode == NormalMode and stageGroupCfg.Type == StageGroupType.MainCopy then
          lastBaseSortID = math.max(lastBaseSortID, stageGroupCfg.BaseSortID)
        elseif hardMode == HardMode and stageGroupCfg.Type == StageGroupType.MainCopyHard then
          lastBaseSortID = math.max(lastBaseSortID, stageGroupCfg.BaseSortID)
        elseif hardMode == SuperMode and stageGroupCfg.Type == StageGroupType.MainCopyCrazy then
          lastBaseSortID = math.max(lastBaseSortID, stageGroupCfg.BaseSortID)
        end
        if lastBaseSortID ~= preBaseSortID then
          lastCopyID = stageGroupID
        end
      end
    end
  end
  return lastCopyID
end

function MainCopyDataUtils.GetLatestStoryLineId(stageGroupID)
  if not stageGroupID or 0 == stageGroupID then
    return 0
  end
  local stageGroupData = DataCenter.MainCopyData.allPlots[stageGroupID]
  local stageList = stageGroupData and stageGroupData.stageList or {}
  local stageCount = #stageList
  for i = stageCount, 1, -1 do
    local stageInfo = stageList[i]
    if stageInfo.unlocked and not stageInfo.firstRewardDraw then
      return stageInfo.stageID
    end
  end
  return stageList[stageCount] and stageList[stageCount].stageID or 0
end

function MainCopyDataUtils.GetLatestPassedStoryLineId()
  local mainCopyGroupList = CopyDataUtils.GetStageGroupIdList(StageGroupType.MainCopy)
  table.sort(mainCopyGroupList, function(a, b)
    local groupCfgA = CopyDataUtils.GetStageGroupConfig(a)
    local groupCfgB = CopyDataUtils.GetStageGroupConfig(b)
    return groupCfgA.BaseSortID > groupCfgB.BaseSortID
  end)
  for _, stageGroupId in ipairs(mainCopyGroupList) do
    local stageGroupInfo = DataCenter.MainCopyData.allPlots[stageGroupId] or {}
    local stageList = stageGroupInfo.stageList or {}
    for i = #stageList, 1, -1 do
      local stageData = stageList[i]
      if stageData and stageData.firstRewardDraw then
        return stageData.stageID
      end
    end
  end
end

function MainCopyDataUtils.IsLastStageOfGroup(stageId)
  local stageCfg = MainCopyDataUtils.GetStageCfg(stageId)
  local stageGroupID = stageCfg.BelongGroup
  if not stageGroupID then
    return false
  end
  local stageGroupData = DataCenter.MainCopyData.allPlots[stageGroupID]
  local stageList = stageGroupData and stageGroupData.stageList or {}
  if 0 == #stageList then
    return false
  end
  return stageList[#stageList].stageID == stageId
end

function MainCopyDataUtils.GetStageData(stageId)
  local stageCfg = DT.Stage[stageId]
  if not stageCfg then
    return
  end
  local stageGroupID = stageCfg.BelongGroup
  local plot = DataCenter.MainCopyData.allPlots[stageGroupID] or {}
  for _, stageData in ipairs(plot.stageList or {}) do
    if stageData.stageID == stageId then
      return stageData
    end
  end
end

function MainCopyDataUtils.GetDymicDifficultyId(stageId)
  local stageData = MainCopyDataUtils.GetStageData(stageId)
  if stageData and stageData.difficultyId and 0 ~= stageData.difficultyId then
    return stageData.difficultyId
  end
end

function MainCopyDataUtils.GetStageLevel(stageId)
  local boxId = MainCopyDataUtils.GetDymicDifficultyId(stageId) or stageId
  local oriCfg = MainCopyDataUtils.GetStageConfig(stageId)
  local cfg = MainCopyDataUtils.GetStageConfig(boxId)
  return cfg.StageLevel or oriCfg.StageLevel
end

function MainCopyDataUtils.IsStageDataFirstFinish(stageId)
  local stageData = MainCopyDataUtils.GetStageData(stageId)
  return stageData and stageData.firstRewardDraw or false
end

function MainCopyDataUtils.IsPlayChapterFinishPlay(stageId)
  local stageGroupId = MainCopyDataUtils.GetStageGroupID(stageId)
  local specialFinalShow = DT.GetOriginalConstant("StageFinalShow")
  if table.contains(specialFinalShow, stageGroupId) then
    if table.contains(specialFinalShow, stageId) then
      return true
    end
    return false
  end
  local isLastStage = MainCopyDataUtils.IsLastStageOfGroup(stageId)
  local stageGroupCfg = MainCopyDataUtils.GetStageGroupCfg(stageGroupId)
  local isStoryCopy = stageGroupCfg and table.contains(CommonDefine.StoryCopy, stageGroupCfg.Type)
  if isStoryCopy and isLastStage then
    return true
  end
end

function MainCopyDataUtils.GetStageGroupCurStar(stageGroupID)
  local stageGroupData = DataCenter.MainCopyData.allPlots[stageGroupID]
  local stageList = stageGroupData and stageGroupData.stageList
  local curStar = 0
  for _, stageInfo in ipairs(stageList or {}) do
    curStar = curStar + stageInfo.star
  end
  return curStar
end

function MainCopyDataUtils.GetHideAwardNodeList(stageId)
  local list = {}
  local stageCfg = DT.Stage[stageId]
  if not stageCfg or not stageCfg.Map then
    return list
  end
  local mapCfg = DT.Map[stageCfg.Map[1]]
  if not mapCfg then
    return list
  end
  local hideAwardNode = CommonDefine.StageHideAwardNodeType
  local mapDataList = mapCfg.data_list
  for _, nodeMap in pairs(mapDataList or {}) do
    for key, nodeList in pairs(nodeMap or {}) do
      if MainCopyDataUtils._IsNodeKey(key) then
        local nodeId = type(nodeList) == "table" and nodeList[1]
        if nodeId then
          local nodeCfg = DT.MapNode[nodeId]
          if not nodeCfg then
            Logger.Error(string.format("关卡[%s]找不到节点信息[%s]", stageCfg.NameNumber, nodeId))
          end
          if nodeCfg.Type == hideAwardNode then
            table.insert(list, nodeCfg)
          end
        end
      end
    end
  end
  return list
end

function MainCopyDataUtils.CheckFirstBattleStage(stageId)
  local rst = false
  local stageCfg = DT.Stage[stageId]
  if not stageCfg or not stageCfg.Map then
    return rst
  end
  local mapCfg = DT.Map[stageCfg.Map[1]]
  if not mapCfg then
    return rst
  end
  local mapDataList = mapCfg.data_list
  for _, nodeMap in pairs(mapDataList or {}) do
    for key, nodeList in pairs(nodeMap or {}) do
      if MainCopyDataUtils._IsNodeKey(key) then
        local nodeId1 = type(nodeList) == "table" and nodeList[1]
        local nodeId2 = type(nodeList) == "table" and nodeList[2]
        if nodeId1 and nodeId2 then
          local nodeCfg1 = DT.MapNode[nodeId1]
          local nodeCfg2 = DT.MapNode[nodeId2]
          if not nodeCfg1 or not nodeCfg2 then
            return rst
          end
          local battleGear = {
            CommonDefine.GearItemType.Boss,
            CommonDefine.GearItemType.EliteMonster,
            CommonDefine.GearItemType.LittleMonster
          }
          if nodeCfg1.Type == CommonDefine.GearItemType.Born and table.contains(battleGear, nodeCfg2.Type) then
            rst = true
          end
        end
      end
    end
  end
  return rst
end

function MainCopyDataUtils.GetMainCopyProgress(stageGroupID)
  if not stageGroupID then
    return 0
  end
  local passedStageCount, totalStageCount = 0, 0
  local stageGroup = DataCenter.MainCopyData.allPlots[stageGroupID]
  if stageGroup then
    local stageList = stageGroup.stageList
    for _, stageData in ipairs(stageList) do
      totalStageCount = totalStageCount + 1
      if stageData.firstRewardDraw then
        passedStageCount = passedStageCount + 1
      end
    end
  end
  local resonanceGroupId = ResonanceDataUtils.GetReonanceGroupIdByStageGroupId(stageGroupID)
  local unlockResonanceNum = ResonanceDataUtils.GetResonanceGroupTotalLevel(resonanceGroupId)
  unlockResonanceNum = 1 == unlockResonanceNum and 0 or unlockResonanceNum
  local totalResonanceNum = ResonanceDataUtils.GetResonanceGroupMaxLevel(resonanceGroupId)
  local curStarNum = MainCopyDataUtils.GetStageGroupCurStar(stageGroupID)
  local totalStarNum = MainCopyDataUtils.GetTotalStar(stageGroupID)
  local totalAchievementNum = 0
  for _, stageCfg in pairs(CopyDataUtils.GetCfgStageList(stageGroupID)) do
    local cfgCount = #(stageCfg.LevelAchieve or {})
    totalAchievementNum = totalAchievementNum + cfgCount
  end
  local curAchievementNum, _ = MainCopyDataUtils.GetAchievementProgress(stageGroupID)
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupID)
  local StageGroupType = StageGroupType
  local weightGroup
  if stageGroupConfig.Type == StageGroupType.MainCopy then
    weightGroup = DT.GetOriginalConstant("StageCompletenessWeight")
  elseif stageGroupConfig.Type == StageGroupType.MainCopyHard or stageGroupConfig.Type == StageGroupType.MainCopyCrazy then
    weightGroup = DT.GetOriginalConstant("HardStageCompletenessWeight")
  else
    Logger.Error("unexpected stageGroup type:", stageGroupID, stageGroupConfig.Type)
  end
  local stagePassW, resonanceW, starW, achievementW = weightGroup[1], weightGroup[2], weightGroup[3], weightGroup[4]
  local rst = (passedStageCount * stagePassW + unlockResonanceNum * resonanceW + curStarNum * starW + curAchievementNum * achievementW) / (totalStageCount * stagePassW + totalResonanceNum * resonanceW + totalStarNum * starW + totalAchievementNum * achievementW)
  return rst
end

function MainCopyDataUtils.GetTotalStar(stageGroupID)
  local stageGroupCfg = DT.StageGroup[stageGroupID]
  local progressReward = stageGroupCfg.StageGroupDrop or {}
  local maxStar = progressReward[#progressReward - 1] or 0
  return maxStar
end

function MainCopyDataUtils.GetStageGroupPercent(groupID)
  local stageGroup = DataCenter.MainCopyData.allPlots[groupID]
  if not stageGroup then
    return 0
  end
  local stageList = stageGroup.stageList
  local passedCount = 0
  for _, stageData in ipairs(stageList) do
    if stageData.firstRewardDraw then
      passedCount = passedCount + 1
    end
  end
  return passedCount / #stageList
end

local mainCopyStageGroupTypes = {
  StageGroupType.MainCopyHard,
  StageGroupType.MainCopy,
  StageGroupType.MainCopyCrazy
}

function MainCopyDataUtils.IsShowMainCopyNew()
  local redReturnGroup = {}
  local curTime = TimeUtils.GetServerTime()
  local allPlots = DataCenter.MainCopyData.allPlots or {}
  for stageGroupId, stageGroupData in pairs(allPlots) do
    local stageGroupCfg = DT.StageGroup[stageGroupId]
    local stageGroupType = stageGroupCfg and stageGroupCfg.Type
    if table.contains(mainCopyStageGroupTypes, stageGroupType) and MainCopyDataUtils.IsStageGroupUnlock(stageGroupId) and (not stageGroupCfg.StageDisplayDate or curTime >= stageGroupCfg.StageDisplayDate) then
      table.insert(redReturnGroup, RedPointDataUtils.IsShowStageGroupRedPoint(stageGroupId))
    end
  end
  do return RedPointDataUtils.PickHighWeightRedData end
  return RedPointDataUtils.PickHighWeightRedData, redReturnGroup, pairs(allPlots)
end

function MainCopyDataUtils.GetStageGroupTidsByStageChatperName(stageChapterName)
  local stageChapter2Groups = DataCenter.MainCopyData.stageChapter2Groups
  if stageChapter2Groups[stageChapterName] then
    return stageChapter2Groups[stageChapterName]
  end
  local redReturnGroup = {}
  local allPlots = DataCenter.MainCopyData.allPlots or {}
  local stageChapterName = stageChapterName or cd.StageChapterName.StageChapterMorimens
  for stageGroupId, stageGroupData in pairs(allPlots) do
    local stageGroupCfg = DT.StageGroup[stageGroupId]
    local stageGroupType = stageGroupCfg and stageGroupCfg.Type
    if stageGroupCfg.StageChapterText and table.contains(mainCopyStageGroupTypes, stageGroupType) then
      stageChapter2Groups[stageGroupCfg.StageChapterText] = stageChapter2Groups[stageGroupCfg.StageChapterText] or {}
      table.insert(stageChapter2Groups[stageGroupCfg.StageChapterText], stageGroupId)
    end
  end
  return stageChapter2Groups[stageChapterName]
end

function MainCopyDataUtils.GetOpeningStageGroupTidsByStageChatperName(stageChapterName)
  local retGroupTids = {}
  local stageGroupTids = MainCopyDataUtils.GetStageGroupTidsByStageChatperName(stageChapterName)
  if not stageGroupTids then
    return retGroupTids
  end
  local curTime = TimeUtils.GetServerTime()
  for _, stageGroupId in pairs(stageGroupTids) do
    local stageGroupCfg = DT.StageGroup[stageGroupId]
    if MainCopyDataUtils.IsStageGroupUnlock(stageGroupId) and (not stageGroupCfg.StageDisplayDate or curTime >= stageGroupCfg.StageDisplayDate) then
      table.insert(retGroupTids, stageGroupId)
    end
  end
  return retGroupTids
end

function MainCopyDataUtils.IsShowMainCopyChapterNew(stageChapterName)
  local redReturnGroup = {}
  local curTime = TimeUtils.GetServerTime()
  local allPlots = DataCenter.MainCopyData.allPlots or {}
  local stageChapterName = stageChapterName or cd.StageChapterName.StageChapterMorimens
  for stageGroupId, stageGroupData in pairs(allPlots) do
    local stageGroupCfg = DT.StageGroup[stageGroupId]
    local stageGroupType = stageGroupCfg and stageGroupCfg.Type
    if table.contains(mainCopyStageGroupTypes, stageGroupType) and MainCopyDataUtils.IsStageGroupUnlock(stageGroupId) and (not stageGroupCfg.StageDisplayDate or curTime >= stageGroupCfg.StageDisplayDate) and stageGroupCfg.StageChapterText == stageChapterName then
      table.insert(redReturnGroup, RedPointDataUtils.IsShowStageGroupRedPoint(stageGroupId))
    end
  end
  do return RedPointDataUtils.PickHighWeightRedData end
  return RedPointDataUtils.PickHighWeightRedData, redReturnGroup, pairs(allPlots)
end

function MainCopyDataUtils.IsShowStageGroupNew(stageGroupID)
  local result
  local groupData = DataCenter.MainCopyData.allPlots[stageGroupID]
  if not groupData then
    return
  end
  local stageList = groupData.stageList
  for _, stageData in ipairs(stageList) do
    if not CopyDataUtils.CheckStageIsUnlocked(stageData.stageID) then
    else
      result = RedPointDataUtils.GetRedPointState(RedPointDataUtils.RedType.NewStageUnlock, {
        stageData.stageID
      })
      if result then
        Logger.Debug("[NewStageUnlock]找到红点", table.tostring({result}))
        return result
      end
    end
  end
end

function MainCopyDataUtils.GetStageConfig(tid)
  if not tid then
    return
  end
  local stageCfg = DT.Stage[tid]
  stageCfg = stageCfg or DT.StageDifficulty[tid] or {}
  return stageCfg
end

function MainCopyDataUtils.GetGroupId2Index()
  if MainCopyDataUtils.groupId2Index then
    return MainCopyDataUtils.groupId2Index
  end
  local groupList = {}
  local prologueGroupId = DT.GetConstant("PrologueStageGroup")
  for groupId, groupInfo in pairs(DT.StageGroup) do
    if groupInfo.Type == CommonDefine.StageGroupType.MainCopy and groupId ~= prologueGroupId then
      table.insert(groupList, groupId)
    end
  end
  table.sort(groupList, function(a, b)
    local aCfg = DT.StageGroup[a]
    local bCfg = DT.StageGroup[b]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  local groupId2Index = {}
  for index, groupId in ipairs(groupList) do
    groupId2Index[groupId] = index
    local groupInfo = DT.StageGroup[groupId]
    if groupInfo.HardMode then
      for _, v in ipairs(groupInfo.HardMode) do
        groupId2Index[v] = index
      end
    end
  end
  MainCopyDataUtils.groupId2Index = groupId2Index
  return groupId2Index
end

function MainCopyDataUtils.GetRelicGroups(stageTid)
  local boxId = MainCopyDataUtils.GetDymicDifficultyId(stageTid)
  local oriCfg = MainCopyDataUtils.GetStageConfig(stageTid)
  local config = MainCopyDataUtils.GetStageConfig(boxId)
  if not oriCfg and not config then
    return {}
  end
  if config and not config.RelicGroupDrop and oriCfg and not oriCfg.RelicGroupDrop then
    return {}
  end
  local newDrop = config and config.RelicGroupDrop or nil
  local oriDrop = oriCfg and oriCfg.RelicGroupDrop or nil
  return newDrop or oriDrop
end

function MainCopyDataUtils.GetEnchantGroups(stageTid)
  local boxId = MainCopyDataUtils.GetDymicDifficultyId(stageTid)
  local oriCfg = MainCopyDataUtils.GetStageConfig(stageTid)
  local config = MainCopyDataUtils.GetStageConfig(boxId)
  if (not oriCfg or not oriCfg.EnchantGroupDrop) and (not config or not config.EnchantGroupDrop) then
    return {}
  end
  local newDrop = config and config.EnchantGroupDrop or nil
  local oriDrop = oriCfg and oriCfg.EnchantGroupDrop or nil
  return newDrop or oriDrop or {}
end

function MainCopyDataUtils._IsNodeKey(key)
  do return string.contains, key end
  return string.contains, key, "Xaxis"
end

return MainCopyDataUtils
