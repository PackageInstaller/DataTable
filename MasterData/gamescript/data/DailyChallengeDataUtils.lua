local DailyChallengeData = DataCenter.dailyChallengeData
local TaskType = CommonDefine.TaskType
local DailyChallengeDataUtils = {}
DailyChallengeDataUtils.careerLevelType = CareerLevelDefine.CareerLevelType.DailyChallenge

function DailyChallengeDataUtils.ResetAll()
  DailyChallengeData.svrData = nil
  DailyChallengeController.Instance.OnReset()
end

function DailyChallengeDataUtils.ReqOnOpenDailyChallenge(callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnOpenDailyChallenge", function(svrData)
    Logger.Info("GameRequest.OnOpenDailyChallenge svrData:", table.tostring(svrData))
    DailyChallengeDataUtils.SetSvrData(svrData)
    if svrData.seasonId then
      SeasonRotationController.Instance:SetConsciousnessDivingSeasonData({
        seasonId = svrData.seasonId,
        data = svrData
      })
    end
    if callback then
      callback(svrData)
    end
  end, function(errData)
    Logger.Error("GameRequest.OnOpenDailyChallenge failed:", table.tostring(errData))
  end)
end

function DailyChallengeDataUtils.GetSvrData()
  return DailyChallengeData.svrData
end

function DailyChallengeDataUtils.SetSvrData(data)
  DailyChallengeData.svrData = data
end

function DailyChallengeDataUtils.CutClassStateFinish()
  local data = DailyChallengeData.svrData
  return data and 1 == data.cutClassFinish
end

function DailyChallengeDataUtils.GetShowRankId(curRankId)
  local data = DailyChallengeData.svrData
  if not data or not data.seasonId then
    return 0
  end
  curRankId = curRankId or 0
  local seasonId = data.seasonId
  local gameplayType = CommonDefine.SeasonGameplayType.ConsciousnessDiving
  local finish = DailyChallengeDataUtils.CutClassStateFinish()
  local lastRankId = finish and DailyChallengeDataUtils.GetLastRewardRankId() or 0
  local curOrder = SeasonRotationCfgUtils.GetSeasonRankRewardTierStrength(seasonId, gameplayType, curRankId)
  local lastOrder = SeasonRotationCfgUtils.GetSeasonRankRewardTierStrength(seasonId, gameplayType, lastRankId)
  local resultRankId = curRankId
  if lastOrder > 0 then
    if curOrder > 0 then
      resultRankId = curOrder > lastOrder and curRankId or lastRankId
    else
      resultRankId = lastRankId
    end
  end
  return resultRankId or 0
end

function DailyChallengeDataUtils.GetLastRewardRankId()
  local data = DailyChallengeData.svrData
  return data and data.lastRewardRankId or 0
end

function DailyChallengeDataUtils.UpdateAfterCutClass(svrData)
  local data = DailyChallengeData.svrData
  if data then
    data.weekWinNum = svrData.weekWinNum
    data.cutClassFinish = svrData.cutClassFinish
    data.dailyMaxDiffStage = svrData.dailyMaxDiffStage
    data.maxDifficultyStageID = svrData.maxDifficultyStageID
  end
end

function DailyChallengeDataUtils.GetNowSeasonTid()
  do return SeasonRotationModel.Instance.GetSeasonId, SeasonRotationModel.Instance end
  return SeasonRotationModel.Instance.GetSeasonId, SeasonRotationModel.Instance, CommonDefine.SeasonGameplayType.ConsciousnessDiving
end

function DailyChallengeDataUtils.GetDailyAchievementTaskLists()
  if DailyChallengeDataUtils.parentTaskList then
    return DailyChallengeDataUtils.parentTaskList, DailyChallengeDataUtils.taskListMap
  end
  local parentTaskList = {}
  local taskListMap = {}
  for taskId, taskCfg in pairs(DT.Task) do
    if taskCfg.TaskType == TaskType.TaskType_DailyChallengeTask_Main then
      table.insert(parentTaskList, taskId)
    elseif taskCfg.TaskType == TaskType.TaskType_DailyChallengeTask then
      local parentTaskId = taskCfg.BelongTaskGroup
      if not taskListMap[parentTaskId] then
        taskListMap[parentTaskId] = {}
      end
      table.insert(taskListMap[parentTaskId], taskId)
    end
  end
  table.sort(parentTaskList, function(aId, bId)
    local aCfg = DT.Task[aId]
    local bCfg = DT.Task[bId]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  DailyChallengeDataUtils.parentTaskList = parentTaskList
  DailyChallengeDataUtils.taskListMap = taskListMap
  return parentTaskList, taskListMap
end

function DailyChallengeDataUtils.IsHaveAchievementReward(groupId)
  DailyChallengeDataUtils.GetDailyAchievementTaskLists()
  local taskList = DailyChallengeDataUtils.taskListMap
  if not taskList then
    return false
  end
  if groupId then
    for _, taskId in ipairs(taskList[groupId]) do
      local state = TaskDataUtils.GetTaskData(taskId).state
      if state == CommonDefine.TaskState.Receive then
        return true
      end
    end
  else
    for _, childList in pairs(taskList) do
      for _, taskId in ipairs(childList) do
        local state = TaskDataUtils.GetTaskData(taskId).state
        if state == CommonDefine.TaskState.Receive then
          return true
        end
      end
    end
  end
  return false
end

function DailyChallengeDataUtils.GetAchievementRewardProgress()
  DailyChallengeDataUtils.GetDailyAchievementTaskLists()
  local taskList = DailyChallengeDataUtils.taskListMap
  local count = 0
  local total = 0
  if not taskList then
    return count, total
  end
  for _, childList in pairs(taskList) do
    for _, taskId in ipairs(childList) do
      local state = TaskDataUtils.GetTaskData(taskId).state
      if state == CommonDefine.TaskState.Done then
        count = count + 1
      end
      total = total + 1
    end
  end
  return count, total
end

function DailyChallengeDataUtils.GetDailyChallengeExpReward(stageId)
  if not (stageId and DT.Stage[stageId]) or not DT.Stage[stageId].NormalReward then
    return 0
  end
  for i = 1, #DT.Stage[stageId].NormalReward, 2 do
    if DT.Stage[stageId].NormalReward[i] == DT.GetConstant("DailyChallengeExperienceRewardItem") then
      return DT.Stage[stageId].NormalReward[i + 1] or 0
    end
  end
  return 0
end

function DailyChallengeDataUtils.GetStageAwardBonus(stageId)
  if not stageId or not DT.Stage[stageId] then
    return 0
  end
  local orinRewardCount = DailyChallengeDataUtils.GetDailyChallengeExpReward(stageId)
  local playerLevel = DataCenter.playerData.DRole.level
  local recommendLevel = DT.Stage[stageId].StageLevel or 0
  local bonusList = DT.Constant.DailyChallengedExpRewardCoefficientLevel and DT.Constant.DailyChallengedExpRewardCoefficientLevel.Data or {}
  local bonusCount = 0
  for i = 1, #bonusList, 2 do
    if playerLevel < recommendLevel + bonusList[i] then
      bonusCount = (bonusList[i + 1] or 1) * orinRewardCount
      break
    end
  end
  return bonusCount
end

local SchoolSortFeq = {
  1,
  3,
  4,
  2
}

function DailyChallengeDataUtils.GetStrongAwakers()
  local recAwakerList = DailyChallengeController.Instance:GetInfo().recAwakerList
  local illuTid
  local ret = {}
  if not recAwakerList then
    illuTid = DailyChallengeController.Instance:GetInfo().illuTid or 0
    local cfg = DT.IllusorischerConfig[illuTid]
    if cfg then
      table.insert(ret, cfg.RotationAwaker1)
      table.insert(ret, cfg.RotationAwaker2)
      table.insert(ret, cfg.RotationAwaker3)
      table.insert(ret, cfg.RotationAwaker4)
      table.insert(ret, cfg.RotationAwaker5)
      table.insert(ret, cfg.RotationAwaker6)
      table.insert(ret, cfg.RotationAwaker7)
      table.insert(ret, cfg.RotationAwaker8)
    end
  else
    for tid, _ in pairs(recAwakerList) do
      table.insert(ret, tid)
    end
  end
  recAwakerList = ret
  table.sort(recAwakerList, function(a, b)
    local aCfg = DT.AwakerConfig[a]
    local bCfg = DT.AwakerConfig[b]
    local aSch = SchoolSortFeq[aCfg.School]
    local bSch = SchoolSortFeq[bCfg.School]
    if aSch ~= bSch then
      return aSch < bSch
    end
    local aSpecial = DailyChallengeDataUtils.IsSpecialAwaker(a)
    local bSpecial = DailyChallengeDataUtils.IsSpecialAwaker(b)
    if aSpecial and not bSpecial then
      return true
    elseif not aSpecial and bSpecial then
      return false
    end
    return DT.AwakerConfig[a].BaseSortID < DT.AwakerConfig[b].BaseSortID
  end)
  return recAwakerList
end

function DailyChallengeDataUtils.IsSpecialAwaker(awakerTid)
  if not DailyChallengeDataUtils.specialAwakerMap then
    local ret = {}
    local specialAwakerList = DT.Constant.WeeklyRecSpecialRoleList.Data
    for _, tid in pairs(specialAwakerList or {}) do
      ret[tid] = true
    end
    DailyChallengeDataUtils.specialAwakerMap = ret
  end
  return DailyChallengeDataUtils.specialAwakerMap[awakerTid]
end

return DailyChallengeDataUtils
