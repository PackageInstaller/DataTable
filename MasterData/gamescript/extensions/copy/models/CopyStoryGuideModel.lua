local CopyStoryGuideModel, Super = NewClass("CopyStoryGuideModel", CopyStagesModel)
local chapterType = StoryDefine.MainCopyPanelChapter

function CopyStoryGuideModel:OnInit()
  Super.OnInit(self)
  self.storyData = {}
  self.storyList = {}
  self.pendingReturnStageGroupTid = nil
  self.inited = false
  self.sequenceMap = {}
end

function CopyStoryGuideModel:IsMainCopyType(stageGroupType)
  return stageGroupType == cd.StageGroupType.Prologue or stageGroupType == cd.StageGroupType.MainCopy
end

function CopyStoryGuideModel:IsStoryGuideFinished(stageGroupTid, stageGroupType)
  if not stageGroupTid then
    return false
  end
  if stageGroupType == cd.StageGroupType.Prologue then
    return true
  else
    if not MainCopyDataUtils.IsStageGroupUnlock(stageGroupTid) then
      return false
    end
    local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(stageGroupTid)
    local needItem = CopyDataUtils.IsStageGroupNeedUnlockItem(stageGroupTid)
    local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(stageGroupTid)
    if not isFeatureLocked and (not needItem or hasUseUnlockItem) then
      do return self.IsStageGroupCleared, self end
      return self.IsStageGroupCleared, self, stageGroupTid
    end
  end
  return false
end

function CopyStoryGuideModel:IsStageGroupCleared(stageGroupTid)
  local groupData = DataCenter.MainCopyData.allPlots[stageGroupTid]
  local stageList = groupData and groupData.stageList
  if not stageList or 0 == #stageList then
    return false
  end
  for _, stageData in ipairs(stageList) do
    if not stageData or not stageData.firstRewardDraw then
      return false
    end
  end
  return true
end

function CopyStoryGuideModel:RefreshAllStates()
  for _, chapterData in pairs(self.storyData) do
    for _, storyGroupData in pairs(chapterData) do
      for _, sinStoryData in pairs(storyGroupData) do
        local isFinish = self:IsStoryGuideFinished(sinStoryData.stageGroupTid, sinStoryData.type)
        sinStoryData.state = isFinish and StoryDefine.StoryState.Finished or StoryDefine.StoryState.Default
      end
    end
  end
end

function CopyStoryGuideModel:RefreshStates(stageChapterText, sequence)
  local storyGroupData = self.storyData[stageChapterText] and self.storyData[stageChapterText][sequence + 1] or {}
  for _, sinStoryData in pairs(storyGroupData) do
    local stageGroupTid = sinStoryData.stageGroupTid
    local newState = StoryDefine.StoryState.Default
    if sinStoryData.type == cd.StageGroupType.Prologue then
      newState = StoryDefine.StoryState.Finished
    elseif sinStoryData.type == cd.StageGroupType.MainCopy then
      local isFinish = self:IsStoryGuideFinished(stageGroupTid, sinStoryData.type)
      if isFinish then
        newState = StoryDefine.StoryState.Finished
      else
        local isUnlock = MainCopyDataUtils.IsStageGroupUnlock(stageGroupTid)
        newState = isUnlock and StoryDefine.StoryState.Unlocked or StoryDefine.StoryState.Locked
      end
    else
      local isFeatureLocked = CopyDataUtils.IsStageGroupFeatureLocked(stageGroupTid)
      local needItem = CopyDataUtils.IsStageGroupNeedUnlockItem(stageGroupTid)
      local hasUseUnlockItem = CopyDataUtils.IsStageGroupUseUnlockItem(stageGroupTid)
      local freeOpen = ActivityManager.Instance:HasOpeningSubplotActivity(stageGroupTid)
      local allPrizesGot = self:IsStoryGuideFinished(stageGroupTid, sinStoryData.type)
      if isFeatureLocked then
        newState = StoryDefine.StoryState.Locked
      elseif allPrizesGot then
        newState = StoryDefine.StoryState.Finished
      elseif needItem and not hasUseUnlockItem and freeOpen then
        newState = StoryDefine.StoryState.FreeNow
      elseif needItem and not hasUseUnlockItem and not freeOpen then
        newState = StoryDefine.StoryState.CanUnlock
      else
        newState = StoryDefine.StoryState.Unlocked
      end
    end
    sinStoryData.state = newState
  end
end

function CopyStoryGuideModel:GetStoryGroupData(stageChapterText, sequence)
  return self.storyData[stageChapterText] and self.storyData[stageChapterText][sequence + 1] or {}
end

function CopyStoryGuideModel:SetPendingReturnStageGroupTid(stageGroupTid)
  self.pendingReturnStageGroupTid = stageGroupTid
end

function CopyStoryGuideModel:GetPendingReturnStageGroupTid()
  return self.pendingReturnStageGroupTid
end

function CopyStoryGuideModel:ClearPendingReturnStageGroupTid()
  self.pendingReturnStageGroupTid = nil
end

function CopyStoryGuideModel:GetStoryLocationByStageGroupTid(stageGroupTid)
  if not stageGroupTid then
    return
  end
  for stageChapterText, chapterData in pairs(self.storyData) do
    for sequencePlusOne, storyGroupData in pairs(chapterData) do
      for storyIndex, sinStoryData in ipairs(storyGroupData) do
        if sinStoryData.stageGroupTid == stageGroupTid then
          return stageChapterText, sequencePlusOne - 1, storyIndex
        end
      end
    end
  end
end

function CopyStoryGuideModel:GetIndexByChapter(stageChapterText, sequence)
  for index, sinStory in ipairs(self.storyList) do
    if sinStory.stageChapterText == stageChapterText and sinStory.sequence == sequence then
      return index
    end
  end
  return 0
end

function CopyStoryGuideModel:GetMainCopyStoryIndex(stageChapterText, sequence)
  local chapterOffset = stageChapterText == StoryDefine.MainCopyPanelChapter.StarsCameRight and 9 or 0
  return chapterOffset + sequence
end

function CopyStoryGuideModel:GetChapterProgress(stageChapterText, sequence)
  local storyGroupData = self.storyData[stageChapterText][sequence + 1]
  if not storyGroupData then
    return 0, 0
  end
  local finishedStory = 0
  local totalStory = 0
  for _, sinStoryData in pairs(self.storyData[stageChapterText][sequence + 1]) do
    if sinStoryData.state == StoryDefine.StoryState.Finished then
      finishedStory = finishedStory + 1
    end
    totalStory = totalStory + 1
  end
  return finishedStory, totalStory
end

function CopyStoryGuideModel:GetStoryGroup(index)
  if index and self.storyList[index] then
    return self.storyList[index].stageChapterText, self.storyList[index].sequence
  end
  return chapterType.Morimens, 0
end

function CopyStoryGuideModel:ParseCfgStoryData()
  if self.inited then
    return
  end
  self.inited = true
  self.storyData = {
    [chapterType.Morimens] = {},
    [chapterType.StarsCameRight] = {}
  }
  self.sequenceMap = {}
  
  local function InsertFunc(stageGroupCfg, sequence, stageChapterText)
    stageChapterText = stageChapterText or stageGroupCfg.StageChapterText
    if self.storyData[stageChapterText] then
      if not self.storyData[stageChapterText][sequence + 1] then
        self.storyData[stageChapterText][sequence + 1] = {}
      end
      table.insert(self.storyData[stageChapterText][sequence + 1], {
        stageGroupTid = stageGroupCfg.ID,
        type = stageGroupCfg.Type,
        state = StoryDefine.StoryState.Default
      })
    end
  end
  
  local GetSequence
  
  function GetSequence(stageGroupCfg)
    local preSequence = self.sequenceMap[stageGroupCfg.ID]
    if preSequence then
      return preSequence[1], preSequence[2]
    end
    if stageGroupCfg.BestExperienceCondition then
      local stageChapterText = chapterType.Morimens
      local stageGroupSequence = 0
      for _, bestStage in ipairs(stageGroupCfg.BestExperienceCondition) do
        local bestStageBelongGroup = DT.Stage[bestStage] and DT.Stage[bestStage].BelongGroup
        if bestStageBelongGroup and DT.StageGroup[bestStageBelongGroup] then
          if self:IsMainCopyType(DT.StageGroup[bestStageBelongGroup].Type) then
            local tmpStageChapterText, tmpStageGroupSequence = DT.StageGroup[bestStageBelongGroup].StageChapterText, DT.StageGroup[bestStageBelongGroup].Sequence
            if table.indexof(StoryDefine.MainCopyPanelChapterList, tmpStageChapterText) > table.indexof(StoryDefine.MainCopyPanelChapterList, stageChapterText) or tmpStageChapterText == stageChapterText and stageGroupSequence < tmpStageGroupSequence then
              stageChapterText, stageGroupSequence = tmpStageChapterText, tmpStageGroupSequence
            end
          else
            local tmpStageChapterText, tmpStageGroupSequence = GetSequence(DT.StageGroup[bestStageBelongGroup])
            if table.indexof(StoryDefine.MainCopyPanelChapterList, tmpStageChapterText) > table.indexof(StoryDefine.MainCopyPanelChapterList, stageChapterText) or tmpStageChapterText == stageChapterText and stageGroupSequence < tmpStageGroupSequence then
              stageChapterText, stageGroupSequence = tmpStageChapterText, tmpStageGroupSequence
            end
          end
        end
      end
      local retChapterText, retGroupSequence = stageChapterText, stageGroupSequence
      self.sequenceMap[stageGroupCfg.ID] = {retChapterText, retGroupSequence}
      return retChapterText, retGroupSequence
    end
    local featureTid = PlayerDataUtils.GetFeatureTidByKey(stageGroupCfg.ID)
    if not featureTid then
      local retChapterText, retGroupSequence = chapterType.Morimens, 0
      self.sequenceMap[stageGroupCfg.ID] = {retChapterText, retGroupSequence}
      return retChapterText, retGroupSequence
    end
    local unlockStage = DT.FeatureUnlock[featureTid] and DT.FeatureUnlock[featureTid].UnlockCondition[2]
    if not unlockStage then
      local retChapterText, retGroupSequence = chapterType.Morimens, 0
      self.sequenceMap[stageGroupCfg.ID] = {retChapterText, retGroupSequence}
      return retChapterText, retGroupSequence
    end
    local unlockStageBelongGroup = DT.Stage[unlockStage] and DT.Stage[unlockStage].BelongGroup
    if unlockStageBelongGroup and DT.StageGroup[unlockStageBelongGroup] then
      if self:IsMainCopyType(DT.StageGroup[unlockStageBelongGroup].Type) then
        local retChapterText, retGroupSequence = DT.StageGroup[unlockStageBelongGroup].StageChapterText, DT.StageGroup[unlockStageBelongGroup].Sequence
        self.sequenceMap[stageGroupCfg.ID] = {retChapterText, retGroupSequence}
        return retChapterText, retGroupSequence
      else
        local retChapterText, retGroupSequence = GetSequence(DT.StageGroup[unlockStageBelongGroup])
        self.sequenceMap[stageGroupCfg.ID] = {retChapterText, retGroupSequence}
        return retChapterText, retGroupSequence
      end
    end
    local retChapterText, retGroupSequence = chapterType.Morimens, 0
    self.sequenceMap[stageGroupCfg.ID] = {retChapterText, retGroupSequence}
    return retChapterText, retGroupSequence
  end
  
  for _, cfg in pairs(DT.StageGroup) do
    if not cfg or cfg.StageDisplayDate and cfg.StageDisplayDate > TimeUtils.GetServerTime() then
    elseif self:IsMainCopyType(cfg.Type) then
      InsertFunc(cfg, cfg.Sequence)
    elseif StoryDefine.StoryTypeRes[cfg.Type] then
      local stageChapterText, stageGroupSequence = GetSequence(cfg)
      InsertFunc(cfg, stageGroupSequence, stageChapterText)
    end
  end
  for _, stageChapterText in ipairs(StoryDefine.MainCopyPanelChapterList) do
    local chapterStoryData = self.storyData[stageChapterText]
    table.insert(self.storyList, {stageChapterText = stageChapterText, sequence = -1})
    local chapterStoryLen = table.length(chapterStoryData)
    for i = 1, chapterStoryLen do
      local groupStoryData, sequence
      if stageChapterText == chapterType.Morimens then
        sequence = i - 1
      else
        sequence = i
      end
      groupStoryData = chapterStoryData[sequence + 1]
      table.insert(self.storyList, {stageChapterText = stageChapterText, sequence = sequence})
      table.sort(groupStoryData, function(a, b)
        local aSortId = DT.StageGroup[a.stageGroupTid].BaseSortID
        local bSortId = DT.StageGroup[b.stageGroupTid].BaseSortID
        return aSortId < bSortId
      end)
    end
  end
end

return CopyStoryGuideModel
