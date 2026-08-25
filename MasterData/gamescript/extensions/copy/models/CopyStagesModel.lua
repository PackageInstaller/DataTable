local CopyStagesModel = NewClass("CopyStagesModel", BaseModel)
local StageGroupType = CommonDefine.StageGroupType

function CopyStagesModel:OnReset()
  self.stageGroupId = 0
  self.curStageTid = 0
  self.jumpActivityTid = nil
end

function CopyStagesModel:OnInit()
  self:OnReset()
  self:RegisterNotify(NotifyId.OnStageDataChanged, self.OnStageDataChanged, self, NotifyPriority.High)
end

function CopyStagesModel:SetStageGroupID(stageGroupId)
  if self.stageGroupId == stageGroupId then
    return
  end
  self.stageGroupId = stageGroupId
  if not self:IsHaveServerStageData(stageGroupId) then
    CopyDataUtils.ReqCopyData(nil, stageGroupId)
  end
end

function CopyStagesModel:GetStageGroupID()
  return self.stageGroupId
end

function CopyStagesModel:IsHaveServerStageData(stageGroupId)
  if DataCenter.copyData.stageInfo[stageGroupId] then
    return true
  end
end

function CopyStagesModel:GetGroupData(stageGroupId)
  return DataCenter.MainCopyData.allPlots[stageGroupId or self.stageGroupId]
end

function CopyStagesModel:GetStageList()
  local curGroupData = self:GetGroupData(self.stageGroupId)
  local temp = {}
  if curGroupData and curGroupData.stageList then
    for _, stageData in ipairs(curGroupData.stageList) do
      if stageData and stageData.unlocked then
        table.insert(temp, stageData.stageID)
      end
    end
  end
  return temp
end

function CopyStagesModel:CheckIsPureAvgStageGroup(stageGroupId)
  local curGroupData = self:GetGroupData(stageGroupId)
  if not curGroupData or not curGroupData.stageList then
    return false
  end
  for _, stageData in ipairs(curGroupData.stageList) do
    local stageId = stageData.stageID
    if not CopySubplotGroupModel.Instance:IsStoryStage(stageId) then
      return false
    end
  end
  return true
end

function CopyStagesModel:SetStageID(stageId)
  if self.curStageTid == stageId then
    return
  end
  self.curStageTid = stageId
end

function CopyStagesModel:GetStageID()
  return self.curStageTid
end

function CopyStagesModel:ResetStageData()
  self.stagesDataMap = nil
end

function CopyStagesModel:OnStageDataChanged(stageGroupId)
  self.stagesDataMap = nil
end

function CopyStagesModel:GetStageData(stageTid)
  self.stagesDataMap = self.stagesDataMap or {}
  if self.stagesDataMap[stageTid] then
    return self.stagesDataMap[stageTid]
  end
  local curGroupData = self:GetGroupData(self.stageGroupId)
  if curGroupData and curGroupData.stageList then
    for _, stageData in ipairs(curGroupData.stageList) do
      if stageData and stageData.stageID == stageTid then
        self.stagesDataMap[stageTid] = stageData
        return stageData
      end
    end
  end
end

function CopyStagesModel:GetStageOpenTime(stageTid)
  local stageData = self:GetStageData(stageTid)
  return stageData and stageData.openTime or 0
end

function CopyStagesModel:GetStageUnlockLeftTime(stageTid)
  local openTime = self:GetStageOpenTime(stageTid)
  local now = TimeUtils.GetServerTime()
  if openTime <= now then
    return 0
  end
  return openTime - now
end

function CopyStagesModel:IsStageFirstRewarded(stageTid)
  local stageData = self:GetStageData(stageTid)
  return stageData and stageData.firstRewardDraw
end

function CopyStagesModel:IsStageUnlock(stageTid)
  if not stageTid then
    return
  end
  local stageData = self:GetStageData(stageTid)
  local config = CopyDataUtils.GetStageConfig(stageTid)
  if not stageData or not config then
    return
  end
  if stageData.star > 0 or stageData.firstRewardDraw then
    return true
  end
  local belongGroup = config.BelongGroup
  if not MainCopyDataUtils.IsStageGroupUnlock(belongGroup) then
    return false
  end
  if not self:IsStageInOpenTime(stageTid) then
    return false
  end
  if self:IsStageNeedUnlockItem(stageTid) then
    local isUsedUnlockItem = self:IsStageUsedUnlockItem(stageTid)
    return isUsedUnlockItem
  end
  if not self:IsStageConditionOk(stageTid) then
    return false
  end
  if stageData.unlocked ~= nil then
    return stageData.unlocked
  end
  return true
end

function CopyStagesModel:IsStageInOpenTime(stageTid)
  local openTime = self:GetStageOpenTime(stageTid)
  if openTime then
    local now = TimeUtils.GetServerTime()
    if openTime > now then
      return false
    end
  end
  return true
end

function CopyStagesModel:IsStageNeedUnlockItem(stageTid)
  local config = CopyDataUtils.GetStageConfig(stageTid)
  return config and config.OpenItem ~= nil
end

function CopyStagesModel:IsStageUsedUnlockItem(stageTid)
  local stageData = self:GetStageData(stageTid)
  return stageData and stageData.unlockItem
end

function CopyStagesModel:IsStageConditionOk(stageTid, isShowTips)
  local isTaskOk, _ = CopyDataUtils.CheckStageIsConditionOk(stageTid, isShowTips)
  if not isTaskOk then
    if isShowTips then
      local taskTid = self:GetStageTaskCondition(stageTid)
      if taskTid then
        local taskDesc = TaskDataUtils.GetTaskDesc(taskTid)
        local tipStr = LT.Textf("TextEventNotFinished", taskDesc)
        Alert.ShowStr(tipStr)
      end
    end
    return false
  end
  return true
end

function CopyStagesModel:GetStageTaskCondition(stageTid)
  local stageCfg = CopyDataUtils.GetStageConfig(stageTid)
  return stageCfg and stageCfg.UnlockCondition and stageCfg.UnlockCondition[1]
end

function CopyStagesModel:GetStageConditionParams(stageTid, taskCondParaIndex)
  local stageCfg = CopyDataUtils.GetStageConfig(stageTid)
  local unlockCondition = stageCfg.UnlockCondition
  if unlockCondition then
    local params = {}
    local paraIndex = taskCondParaIndex or 1
    for _, taskTid in ipairs(unlockCondition) do
      local taskCfg = DT.Task[taskTid] or {}
      if taskCfg.CompleteCondPara and taskCfg.CompleteCondPara[paraIndex] then
        table.insert(params, taskCfg.CompleteCondPara[paraIndex])
      end
    end
    do return table.unpack end
    return table.unpack, params, ipairs(unlockCondition)
  end
end

function CopyStagesModel:GetUnlockInfo(stageOrStageGroup)
  local stageGroupCfg = DT.StageGroup[stageOrStageGroup]
  local stageCfg = DT.Stage[stageOrStageGroup]
  local stageGroupId = stageGroupCfg and stageGroupCfg.ID or stageCfg.BelongGroup
  stageGroupCfg = DT.StageGroup[stageGroupId]
  local stageGroupType = stageGroupCfg.Type
  local isInActivityDiscount = false
  local unlockItemTid, unlockItemNum = table.unpack(stageGroupCfg and stageGroupCfg.UnlockItem or {})
  if stageCfg then
    for itemTid, itemNum in pairs(stageCfg.OpenItem or {}) do
      unlockItemTid, unlockItemNum = itemTid, itemNum
    end
  end
  local originItemNum = unlockItemNum
  if stageGroupType >= StageGroupType.LargeSubplotNormal and stageGroupType <= StageGroupType.SmallSubplotCrazy then
    isInActivityDiscount = ActivityManager.Instance:HasOpeningSubplotActivity(stageGroupId)
    return isInActivityDiscount, unlockItemTid, isInActivityDiscount and 0 or unlockItemNum, originItemNum
  end
  if stageGroupCfg.Type == StageGroupType.Vindicate then
    local actType = ActivityDefine.ActivityType.ConfessionEventDiscountActivity
    local activityData, activityCfg = ActivityManager.Instance:GetOpeningActivityByType(actType)
    if activityData then
      return true, unlockItemTid, activityCfg.ActivityPara1[2], originItemNum
    else
      return false, unlockItemTid, unlockItemNum, originItemNum
    end
  end
  return isInActivityDiscount, unlockItemTid, unlockItemNum, originItemNum
end

function CopyStagesModel:GetStageName(stageTid)
  if not stageTid then
    return ""
  end
  if not self:IsStageUnlock(stageTid) then
    do return LT.Text end
    return LT.Text, "LockedSubplotStageName", stageTid, nil
  end
  local config = CopyDataUtils.GetStageConfig(stageTid)
  local stageName = config and LT.Text(config.Name)
  do return StrUtils.ReplaceAvgContent end
  return StrUtils.ReplaceAvgContent, stageName
end

function CopyStagesModel:IsStageHavedAchievement(stageTid)
  local config = CopyDataUtils.GetStageConfig(stageTid)
  if not config or not config.LevelAchieve then
    return false
  end
  return #config.LevelAchieve > 0
end

function CopyStagesModel:GetAchivementProgress(stageTid)
  local stageData = self:GetStageData(stageTid)
  if not stageData then
    return ""
  end
  if not self:IsStageHavedAchievement(stageTid) then
    return ""
  end
  local stageCfg = CopyDataUtils.GetStageConfig(stageTid)
  local maxAchieveCount = #stageCfg.LevelAchieve
  local progress = 0
  for _, finishValue in pairs(stageData.achivement) do
    if 1 == finishValue then
      progress = progress + 1
    end
  end
  do return string.format, "%s/%s", progress end
  return string.format, "%s/%s", progress, maxAchieveCount, nil, nil, nil
end

function CopyStagesModel:IsStoryStage(stageTid)
  local stageCfg = CopyDataUtils.GetStageConfig(stageTid)
  return stageCfg and not stageCfg.Map
end

function CopyStagesModel:GetStageFirstReward(stageTid)
  local stageCfg = CopyDataUtils.GetStageConfig(stageTid)
  local FirstTimeReward = stageCfg and stageCfg.FirstTimeReward or {}
  local isGot = self:IsStageFirstRewarded(stageTid)
  local rewardList = {}
  for itemTid, itemCount in table.iteraDouble(FirstTimeReward) do
    table.insert(rewardList, {
      itemTid = itemTid,
      itemCount = itemCount,
      isGot = isGot
    })
  end
  return rewardList
end

return CopyStagesModel
