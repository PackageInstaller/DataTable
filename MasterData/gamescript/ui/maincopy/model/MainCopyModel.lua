local diff = CommonDefine.Difficulty

local function createMainCopyModelState(stageGroupId)
  local state = {}
  state.hardMode = CommonDefine.Difficulty.Normal
  state.stageGroupId = stageGroupId
  
  function state.groupIdMap()
    local groupIdMap = {}
    local COPY_TYPE = CommonDefine.StageGroupType.MainCopy
    for groupId, groupInfo in pairs(DT.StageGroup) do
      if groupInfo.Type == COPY_TYPE and groupInfo.HardMode then
        local normalId = groupId
        local hardId = groupInfo.HardMode[diff.Hard] or normalId
        local superId = groupInfo.HardMode[diff.Super] or normalId
        local temp = {}
        temp[diff.Normal] = groupId
        temp[diff.Hard] = hardId
        temp[diff.Super] = superId
        groupIdMap[normalId] = temp
        groupIdMap[hardId] = temp
        groupIdMap[superId] = temp
      end
    end
    return groupIdMap
  end
  
  function state.groupId2Index()
    do return end
    return MainCopyDataUtils.GetGroupId2Index, nil
  end
  
  function state.groupIdList()
    local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(state.stageGroupId)
    local chapterName = stageGroupCfg and stageGroupCfg.StageChapterText
    do return CopyDataUtils.CalculateChapterIndex, state.hardMode end
    return CopyDataUtils.CalculateChapterIndex, state.hardMode, chapterName
  end
  
  function state.notOpenActivityMap()
    do return ActivityManager.Instance.GetNotOpenSubplotActivities end
    return ActivityManager.Instance.GetNotOpenSubplotActivities, ActivityManager.Instance
  end
  
  function state.subplotGroupList()
    local groupList = CopyDataUtils.GetSubplotList(false)
    local list = {}
    for _, groupTid in ipairs(groupList) do
      local isNormal = CopyDataUtils.IsNormalSubplotGroup(groupTid)
      if isNormal and not state.notOpenActivityMap[groupTid] then
        table.insert(list, groupTid)
      end
    end
    return list
  end
  
  function state.sublplotLargeGroupList()
    local groupList = CopyDataUtils.GetSubplotList(true)
    local list = {}
    for _, groupTid in ipairs(groupList) do
      local isNormal = CopyDataUtils.IsNormalSubplotGroup(groupTid)
      if isNormal and not state.notOpenActivityMap[groupTid] then
        table.insert(list, groupTid)
      end
    end
    return list
  end
  
  state.curSelectStageId = 0
  return state
end

local function createMainCopyModelViews(data)
  local views = {}
  
  function views:GetStageGroupList()
    return data.groupIdList
  end
  
  function views:GetStageList(stageGroupId)
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
  
  function views:GetPanelStageList(stageGroupId)
    local stageList = self:GetStageList(stageGroupId)
    local panelStageList = {}
    local totalIndex = #stageList
    for index, stageData in ipairs(stageList) do
      table.insert(panelStageList, {
        stageData = stageData,
        index = index,
        totalIndex = totalIndex
      })
    end
    if 1 == #panelStageList then
      table.insert(panelStageList, 1, {})
    end
    table.insert(panelStageList, {})
    return panelStageList
  end
  
  function views:GetPreStageGroup(stageGroupId)
    for i, groupId in ipairs(data.groupIdList) do
      if groupId == stageGroupId then
        return data.groupIdList[i - 1]
      end
    end
  end
  
  function views:GetNextStageGroup(stageGroupId)
    for i, groupId in ipairs(data.groupIdList) do
      if groupId == stageGroupId then
        local nextGroupId = data.groupIdList[i + 1]
        if nextGroupId then
          local featureId = self:GetFeatureId()
          local _, isUnlocked = PlayerDataUtils.IsFeatureUnlock(featureId, nextGroupId)
          if not isUnlocked then
            return
          end
          return nextGroupId
        end
        return
      end
    end
  end
  
  function views:GetFeatureId()
    local featureId = CommonDefine.FeatureId.MainCopy
    if self.hardMode == CommonDefine.Difficulty.Hard then
      featureId = CommonDefine.FeatureId.MainCopyHard
    elseif self.hardMode == CommonDefine.Difficulty.Super then
      featureId = CommonDefine.FeatureId.MainCopyCrazy
    end
    return featureId
  end
  
  function views:GetStageGroupIndex(stageGroupId)
    return data.groupId2Index[stageGroupId]
  end
  
  function views:GetStageGroupName(stageGroupId)
    local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupId)
    do return LT.Text end
    return LT.Text, stageGroupCfg.Name
  end
  
  function views:GetStageGroupBgImage(stageGroupId)
    local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupId)
    return stageGroupCfg and stageGroupCfg.Backgrand
  end
  
  function views:GetStageGroupCoverImage(stageGroupId)
    local stageGroupCfg = CopyDataUtils.GetStageGroupConfig(stageGroupId)
    return stageGroupCfg and stageGroupCfg.CoverImage
  end
  
  function views:GetStageGroupChapter(stageGroupId)
    if not CopyDataUtils.IsNewStageChapter(stageGroupId) then
      do return CopyDataUtils.GetMainCopyName, self:GetStageGroupIndex(stageGroupId) end
      return CopyDataUtils.GetMainCopyName, self:GetStageGroupIndex(stageGroupId)
    else
      local cfg = CopyDataUtils.GetStageGroupConfig(stageGroupId)
      do return LT.Textf, "MainLines_Chapterx" end
      return LT.Textf, "MainLines_Chapterx", cfg.Sequence
    end
  end
  
  function views:GetStageNumber(stageId)
    local stageCfg = DT.Stage[stageId]
    return stageCfg.NameNumber
  end
  
  function views:GetStageName(stageId)
    local stageCfg = DT.Stage[stageId]
    return stageCfg.Name
  end
  
  function views:GetStageDesc(stageId)
    local stageCfg = DT.Stage[stageId]
    return stageCfg.Desc
  end
  
  function views:GetSortedMonsterTids(stageId)
    do return CopyDataUtils.GetStageMonsterWithAffixList, stageId end
    return CopyDataUtils.GetStageMonsterWithAffixList, stageId, true
  end
  
  function views:GetStageCfg(stageId)
    return DT.Stage[stageId]
  end
  
  function views:IsHaveMap(stageId)
    local stageCfg = DT.Stage[stageId]
    return stageCfg.Map
  end
  
  function views:GetCfgStarCount(stageId)
    local stageCfg = DT.Stage[stageId]
    return #(stageCfg.PerfectCondition or {})
  end
  
  function views:GetStarCount(stageData)
    return stageData.star
  end
  
  function views:GetCfgAchieveCount(stageId)
    local stageCfg = DT.Stage[stageId] or {}
    return #(stageCfg.LevelAchieve or {})
  end
  
  function views:GetAchieveCount(stageData)
    local count = 0
    for _, isFinish in pairs(stageData.achivement or {}) do
      if isFinish >= 1 then
        count = count + 1
      end
    end
    return count
  end
  
  function views:IsFinishAchive(stageData, achiveId)
    return (stageData.achivement[achiveId] or 0) >= 1
  end
  
  function views:GetAchieveState(stageData, achieveId)
    return stageData.achivement[achieveId]
  end
  
  function views:GetMaxAchieveCount(stageId)
    local cfg = DT.Stage[stageId]
    local levelAchieve = cfg.LevelAchieve or {}
    return #levelAchieve
  end
  
  function views:GetStageRewardList(stageId, curStar)
    local cfg = DT.Stage[stageId]
    local stageData = MainCopyDataUtils.GetStageData(stageId)
    local rewards = {}
    for tid, num, index in table.iteraDouble(cfg.FirstTimeReward or {}) do
      table.insert(rewards, {
        tid = tid,
        num = num,
        type = CommonDefine.ItemAwardType.First,
        isGot = stageData.firstRewardDraw,
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
        isFirst = not stageData.firstRewardDraw,
        multipleNum = cfg.FirstTimeNormalRewardMultiple,
        index = index
      })
    end
    rewards = ItemDataUtils.KickoutAwakerFavorItem(rewards)
    table.sort(rewards, function(a, b)
      local sortWeightA = views:GetItemSortWeight(a)
      local sortWeightB = views:GetItemSortWeight(b)
      if sortWeightA == sortWeightB then
        local itemA = DT.Item[a.tid]
        local itemB = DT.Item[b.tid]
        return itemA.BaseSortID < itemB.BaseSortID
      end
      return sortWeightA > sortWeightB
    end)
    return rewards
  end
  
  function views:GetItemSortWeight(item)
    local weight = 9999
    local gap = 100
    local type = item.awardType
    if type == CommonDefine.ItemAwardType.First3Star then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.First then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.FirstMult then
      return weight - (item.index or 0)
    end
    weight = weight - gap
    if type == CommonDefine.ItemAwardType.Normal then
      return weight - (item.index or 0)
    end
    return weight
  end
  
  return views
end

local function createMainCopyModelActions(data)
  local actions = {}
  
  function actions:SetHardMode(newHardMode)
    if newHardMode == data.hardMode then
      return
    end
    local temp = data.groupIdMap[data.stageGroupId]
    local newStageGroupId = temp[newHardMode] or data.stageGroupId
    data.stageGroupId = newStageGroupId
    data.hardMode = newHardMode
  end
  
  function actions.SetCurSelectStageId(stageId)
    if not stageId then
      Logger.Error("Error stageId ", stageId)
    end
    data.curSelectStageId = stageId
  end
  
  function actions:SetStageGroupID(groupID)
    data.stageGroupId = groupID
  end
  
  return actions
end

local function onSetup(_, _)
end

local MainCopyModel = Vue.model("MainCopyModel", createMainCopyModelState):views(createMainCopyModelViews):actions(createMainCopyModelActions):setup(onSetup)
return MainCopyModel
