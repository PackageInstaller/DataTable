local CopyStageDetailModel, Super = NewClass("CopyStageDetailModel", BaseModel)

function CopyStageDetailModel:OnInit()
  self:OnReset()
end

function CopyStageDetailModel:OnReset()
  self.stageGroupId = 0
  self.stageGroupList = nil
  self.stageGroupData = nil
  self.stageIndex = 0
  self.withoutOpenItem = false
  self.stageAchieveList = nil
end

function CopyStageDetailModel:SetStageGroupId(stageId)
  if not stageId then
    return
  end
  local stageCfg = self:GetStageCfg(stageId)
  if not stageCfg then
    return
  end
  self.stageGroupId = stageCfg.BelongGroup
end

function CopyStageDetailModel:SetGroupId(stageGroupId)
  self.stageGroupId = stageGroupId
end

function CopyStageDetailModel:GetStageGroupId()
  return self.stageGroupId
end

function CopyStageDetailModel:GetGroupData()
  return MainCopyData.allPlots[self.stageGroupId]
end

function CopyStageDetailModel:GetStageGroupList()
  return self.stageGroupList
end

function CopyStageDetailModel:SetStageGroupData()
  local groupData = self:GetGroupData()
  if groupData then
    self.stageGroupList = {}
    self.stageGroupData = {}
    for _, stageData in ipairs(groupData.stageList) do
      table.insert(self.stageGroupList, stageData)
      self.stageGroupData[stageData.stageID] = stageData
    end
  end
end

function CopyStageDetailModel:GetStageData(stageId)
  if not self.stageGroupData then
    return
  end
  return self.stageGroupData[stageId]
end

function CopyStageDetailModel:GetStageDataByIndex(stageIndex)
  if not self.stageGroupList then
    return
  end
  return self.stageGroupList[stageIndex]
end

function CopyStageDetailModel:GetStageCfg(stageId)
  if not stageId then
    return
  end
  local stageCfg = DT.Stage[stageId]
  stageCfg = stageCfg or DT.StageDifficulty[stageId]
  return stageCfg
end

function CopyStageDetailModel:GetOriStageCfg(stageId)
  if not stageId then
    return
  end
  return DT.Stage[stageId]
end

function CopyStageDetailModel:GetStageIndex(stageId)
  for index, stageData in ipairs(self.stageGroupList) do
    if stageData.stageID == stageId then
      return index
    end
  end
end

function CopyStageDetailModel:GetCommandLevel(stageId)
  local difficultyId = MainCopyDataUtils.GetDymicDifficultyId(stageId) or stageId
  local oriCfg = self:GetStageCfg(stageId)
  local cfg = self:GetStageCfg(difficultyId)
  return cfg.StageLevel or oriCfg.StageLevel
end

function CopyStageDetailModel:GetCommandSchool(stageId)
  if not stageId then
    return {}
  end
  local stageCfg = self:GetStageCfg(stageId)
  if not stageCfg then
    return {}
  end
  return stageCfg.RecClass or {}
end

function CopyStageDetailModel:GetStarLevel(stageId)
  local stageData = self:GetStageData(stageId)
  if not stageData then
    return 0
  end
  return stageData.star
end

function CopyStageDetailModel:IsShowStar(stageId)
  local cfg = DT.Stage[stageId]
  local isNormalStage = not self.isStoryReviewMode and self:IsHaveMap(stageId)
  return cfg.PerfectCondition ~= nil and self:IsNormalStage(stageId)
end

function CopyStageDetailModel:IsDifficulty(stageId)
  local cfg = DT.Stage[stageId]
  return cfg and cfg.StageDifficulty ~= nil
end

function CopyStageDetailModel:IsHighDiffculty(stageId)
  local cfg = DT.Stage[stageId]
  return cfg and 1 == cfg.StageHighDifficulty
end

function CopyStageDetailModel:IsSubplotInActivity(stageGroupId)
  do return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance end
  return ActivityManager.Instance.HasOpeningSubplotActivity, ActivityManager.Instance, stageGroupId
end

function CopyStageDetailModel:IsEnergyEnough(stageId)
  if not stageId then
    return false
  end
  local stageCfg = self:GetStageCfg(stageId)
  if not stageCfg then
    return false
  end
  local costCount = stageCfg.Cost or 0
  return costCount <= PlayerDataUtils.GetEnergy()
end

function CopyStageDetailModel:SetWithoutOpenItem(isOpen)
  self.withoutOpenItem = isOpen
end

function CopyStageDetailModel:GetWithoutOpenItem()
  return self.withoutOpenItem
end

function CopyStageDetailModel:GetMonsterList(stageId)
  local difficultyId = MainCopyDataUtils.GetDymicDifficultyId(stageId)
  local diffCfg = DT.StageDifficulty[difficultyId] or {}
  if diffCfg.Map == nil then
    difficultyId = stageId
  end
  return CopyDataUtils.GetStageMonsterWithAffixList(difficultyId, true) or {}
end

function CopyStageDetailModel:IsHaveMonster(stageId)
  if not stageId then
    return false
  end
  local isStoryReviewMode = StoryReviewModel.Instance:IsReviewingStory()
  local isHaveMap = self:IsHaveMap(stageId)
  if not isStoryReviewMode and isHaveMap then
    return #self:GetMonsterList(stageId) > 0
  end
end

function CopyStageDetailModel:IsHaveMap(stageId)
  local stageCfg = self:GetStageCfg(stageId)
  return stageCfg.Map
end

function CopyStageDetailModel:IsNormalStage(stageId)
  local isStoryReviewMode = StoryReviewModel.Instance:IsReviewingStory()
  return not isStoryReviewMode and self:IsHaveMap(stageId)
end

function CopyStageDetailModel:IsStoryStage(stageId)
  if not stageId then
    return false
  end
  local isStoryReviewMode = StoryReviewModel.Instance:IsReviewingStory()
  local isHaveMap = self:IsHaveMap(stageId)
  return not isHaveMap or isStoryReviewMode
end

function CopyStageDetailModel:IsMeltDisaster(stageId)
  local isStoryReviewMode = StoryReviewModel.Instance:IsReviewingStory()
  if isStoryReviewMode then
    return false
  end
  do return StageInitialStateModel.Instance.ExistsInitialState, StageInitialStateModel.Instance end
  return StageInitialStateModel.Instance.ExistsInitialState, StageInitialStateModel.Instance, stageId
end

function CopyStageDetailModel:IsCanChanllenge(stageId)
  local stageCfg = self:GetStageCfg(stageId)
  if not stageCfg then
    return false
  end
  if not self:IsEnergyEnough(stageId) then
    return false
  end
  return true
end

function CopyStageDetailModel:GetOpenItem(stageId)
  if not stageId then
    return 0, 0
  end
  local stageCfg = self:GetStageCfg(stageId)
  if not stageCfg or not stageCfg.OpenItem then
    return 0, 0
  end
  local itemTid = 0
  local itemNum = 0
  for tid, num in pairs(stageCfg.OpenItem) do
    if num and num > 0 then
      itemTid = tid
      itemNum = num
      break
    end
  end
  return itemTid, itemNum
end

function CopyStageDetailModel:GetStageAchieveData()
  local groupData = self:GetGroupData()
  self.stageAchieveList = {}
  if groupData then
    for _, stageData in ipairs(groupData.stageList) do
      if stageData.unlocked then
        local stageCfg = DT.Stage[stageData.stageID]
        if stageCfg.LevelAchieve then
          table.insert(self.stageAchieveList, stageData)
        end
      end
    end
  end
  return self.stageAchieveList
end

return CopyStageDetailModel
