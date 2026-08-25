local FreeTrialController = NewClass("FreeTrialController", BaseController)

function FreeTrialController:GetSchoolGoupsData()
  local groupList = {}
  local map = FreeTrialModel.Instance:GetSchoolGroupDatas()
  for schoolType, list in pairs(map) do
    if #list > 0 then
      table.insert(groupList, {schoolType = schoolType, list = list})
    end
  end
  table.sort(groupList, function(a, b)
    local aCfg = DT.SchoolConfig[a.schoolType]
    local bCfg = DT.SchoolConfig[b.schoolType]
    local aWeight = CommonDefine.SchoolTypeSortWeight[aCfg.NameEn]
    local bWeight = CommonDefine.SchoolTypeSortWeight[bCfg.NameEn]
    return aWeight > bWeight
  end)
  return groupList
end

function FreeTrialController:GetAwakerByStageId(stageId)
  do return CopyDataUtils.GetAwakerByStageId end
  return CopyDataUtils.GetAwakerByStageId, stageId
end

function FreeTrialController:GetPrizeList(stageId)
  local prizeList = {}
  local config = CopyDataUtils.GetStageConfig(stageId)
  local taskId = config.ResidentTrialRewardTasks
  if not taskId then
    return prizeList
  end
  local oriAwardList = TaskDataUtils.GetTaskCompleteAward(taskId)
  local done = TaskDataUtils.TaskFinshAndGetedAward(taskId)
  for _, oriAward in ipairs(oriAwardList) do
    table.insert(prizeList, {
      itemTid = oriAward.tid,
      itemCount = oriAward.num,
      isGot = done,
      showGetIcon = false
    })
  end
  return prizeList
end

function FreeTrialController:TrialPlay(stageId)
  WorldStageManager.Instance:CheckOpen(stageId, function()
    StageExitPanelManager.Instance:PushWhenDungeonTrialExit(stageId)
  end)
end

function FreeTrialController:ReqGetPrize(stageId)
  local config = CopyDataUtils.GetStageConfig(stageId)
  local taskId = config.ResidentTrialRewardTasks
  local taskData = TaskDataUtils.GetTaskData(taskId)
  TaskDataUtils.TaskComplete(taskData.uid, function(data)
    self:UpdateFreeTrial()
    self:LocalNotify(NotifyId.UpdateTrialAwaker, stageId)
  end)
end

function FreeTrialController:FinshAndGetedAward(stageId)
  local config = CopyDataUtils.GetStageConfig(stageId)
  local taskId = config.ResidentTrialRewardTasks
  local result = TaskDataUtils.TaskFinshAndGetedAward(taskId)
  return result
end

function FreeTrialController:CanGetAward(stageId)
  local config = CopyDataUtils.GetStageConfig(stageId)
  local taskId = config.ResidentTrialRewardTasks
  local result = TaskDataUtils.IsTaskCanReward(taskId)
  return result
end

function FreeTrialController:FinishTrial(stageId)
  local config = CopyDataUtils.GetStageConfig(stageId)
  local taskId = config.ResidentTrialRewardTasks
  local result = TaskDataUtils.IsTaskDoneByTaskId(taskId)
  return result
end

function FreeTrialController:UpdateFreeTrial()
  if not DataCenter.redPointData then
    return
  end
  local RedType = RedPointDataUtils.RedType
  local trialStageRedData = DataCenter.redPointData[RedType.AwakerFreeTrial]
  if not trialStageRedData then
    trialStageRedData = {}
    DataCenter.redPointData[RedType.AwakerFreeTrial] = trialStageRedData
  end
  for _, trailType in pairs(cd.TrialType) do
    FreeTrialModel.Instance:SetTrialType(trailType)
    local stageList = FreeTrialModel.Instance:GetAllTrailStageIdList()
    for _, stageId in pairs(stageList) do
      if self:CanGetAward(stageId) then
        trialStageRedData[stageId] = "red"
      else
        trialStageRedData[stageId] = nil
      end
    end
  end
  FreeTrialModel.Instance:SetTrialType(CommonDefine.TrialType.Normal)
  self:LocalNotify(NotifyId.UpdateTrialAwakerFinishState)
end

function FreeTrialController:TrialStageHasAward(stageId)
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.ResidentTrial, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  do return RedPointDataUtils.TrialStageHasAward end
  return RedPointDataUtils.TrialStageHasAward, stageId
end

function FreeTrialController:HasAwardInStageIdList(stageIdList)
  for _, stageId in pairs(stageIdList) do
    if RedPointDataUtils.TrialStageHasAward(stageId) then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  return false
end

function FreeTrialController:HasFreeTrialAward()
  local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.ResidentTrial, PlayerDataUtils.GetFeatureMainTypeKey())
  if not unlocked then
    return false
  end
  local limitStageIdList = FreeTrialModel.Instance:GetStageIdListByType(cd.TrialType.Limit)
  local hasLimitReward = FreeTrialController.Instance:HasAwardInStageIdList(limitStageIdList)
  local normalStageIdList = FreeTrialModel.Instance:GetStageIdListByType(cd.TrialType.Normal)
  local normalLimitReward = FreeTrialController.Instance:HasAwardInStageIdList(normalStageIdList)
  local starStageIdList = FreeTrialModel.Instance:GetStageIdListByType(cd.TrialType.Star)
  local starLimitReward = FreeTrialController.Instance:HasAwardInStageIdList(starStageIdList)
  if hasLimitReward or normalLimitReward or starLimitReward then
    return RedPointDataUtils.RedAttrType.Red
  end
  return false
end

return FreeTrialController
