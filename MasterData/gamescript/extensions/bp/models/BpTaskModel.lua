local TaskServerIndex = CommonDefine.TaskServerIndex
local BpTaskModel = NewClass("BpTaskModel", BaseModel)

function BpTaskModel:OnInit()
  self.curSelectTab = 0
  self.taskTabList = {
    [1] = TaskServerIndex.Period
  }
  self.curTaskList = {}
end

function BpTaskModel:OnReset()
end

function BpTaskModel:SetCurTaskList(taskSvrIdx)
  local tmpList = TaskDataUtils.GetTaskDataListBySvrIdx(taskSvrIdx)
  tmpList = TaskDataUtils.SortTasksData(tmpList)
  if taskSvrIdx == CommonDefine.TaskServerIndex.Daily then
    tmpList = TaskDataUtils.RemoveJumpLockTasks(tmpList)
  end
  self.curTaskList = tmpList
end

function BpTaskModel:SetCurSelectTab(taskSvrIdx)
  self:SetCurTaskList(taskSvrIdx)
  if self.curSelectTab ~= taskSvrIdx then
    self.curSelectTab = taskSvrIdx
    self:LocalNotify(NotifyId.OnBpTaskViewTabChanged, taskSvrIdx)
  end
end

function BpTaskModel:CheckContainActiveTask(taskSvrIdx)
  local taskList = TaskDataUtils.GetTaskDataListBySvrIdx(taskSvrIdx)
  for _, taskData in pairs(taskList) do
    if TaskDataUtils.GetTaskIsActive(taskData.uid) then
      return true
    end
  end
  return false
end

function BpTaskModel:GetTaskState(taskUid)
  local rst = CommonDefine.TaskState.Doing
  local taskData = TaskDataUtils.GetTaskData(taskUid)
  if taskData and taskData.state then
    rst = taskData.state
  end
  return rst
end

function BpTaskModel:GetCurTaskList()
  return self.curTaskList or {}
end

function BpTaskModel:_IsGuideNoteActivityFullByTaskCfg(taskCfg)
  if not (GuideNoteModel and GuideNoteModel.Instance) or not taskCfg then
    return false
  end
  local taskSvrIndex = CommonDefine.TaskType2ServerIndex[taskCfg.TaskType]
  local rewardLevelType, tierRewardConstKey
  if taskSvrIndex == TaskServerIndex.Daily then
    rewardLevelType = GuideNoteDefine.LevelType.Daily
    tierRewardConstKey = "GuideNoteDailyActivityTierRewards"
  elseif taskSvrIndex == TaskServerIndex.Weekly then
    rewardLevelType = GuideNoteDefine.LevelType.Weekly
    tierRewardConstKey = "GuideNoteWeeklyActivityTierRewards"
  else
    return false
  end
  local maxNeed = 0
  local raw = DT.GetOriginalConstant(tierRewardConstKey, {}) or {}
  for i = 1, #raw, 2 do
    local need = tonumber(raw[i]) or 0
    if maxNeed < need then
      maxNeed = need
    end
  end
  return maxNeed > 0 and maxNeed <= GuideNoteModel.Instance:GetActivityExp(rewardLevelType)
end

function BpTaskModel:GetTaskProgress(taskUid)
  local taskCfg = TaskDataUtils.GetTaskConfigByUid(taskUid)
  if not taskCfg then
    return ""
  end
  local taskData = TaskDataUtils.GetTaskData(taskUid)
  local count = taskData and taskData.count or 0
  local taskProgressLimit = TaskDataUtils.GetTaskProgressLimit(taskCfg.ID)
  local limitNum = tonumber(taskProgressLimit) or 0
  if count < limitNum and taskCfg.TaskType ~= CommonDefine.TaskType.TaskType_Period and self:_IsGuideNoteActivityFullByTaskCfg(taskCfg) then
    return "ActivityFull"
  end
  do return string.format, "%s/%s", count end
  return string.format, "%s/%s", count, taskProgressLimit
end

function BpTaskModel:GetTaskCountDown(taskUid)
  local taskData = TaskDataUtils.GetTaskData(taskUid)
  local endTs = taskData.endTs
  if not endTs or endTs <= TimeUtils.GetServerTime() then
    return ""
  end
  local countDown = endTs - TimeUtils.GetServerTime()
  local d, h, m = TimeUtils.ConvertTime(countDown)
  if countDown >= TimeUtils.OneDaySeconds then
    do return LT.Textf, "BattlePassLeftTimeMore", d end
    return LT.Textf, "BattlePassLeftTimeMore", d, h
  end
  do return LT.Textf, "BattlePassLeftTimeLess", h end
  return LT.Textf, "BattlePassLeftTimeLess", h, m
end

local function GetWeeklyTaskCountDown()
  local countDown = TimeCfgUtils.GetNextMonday()
  local d, h, m = TimeUtils.ConvertTime(countDown)
  if countDown >= 86400 then
    do return LT.Textf, "BattlePassLeftTimeMore", d end
    return LT.Textf, "BattlePassLeftTimeMore", d, h
  end
  do return LT.Textf, "BattlePassLeftTimeLess", h end
  return LT.Textf, "BattlePassLeftTimeLess", h, m
end

local function GetPeriodTaskCountDown()
  do return end
  return BattlePassDataUtils.GetEndCountDown, nil
end

local taskSeverIdx2CountDownFuncMap = {
  [TaskServerIndex.Weekly] = GetWeeklyTaskCountDown,
  [TaskServerIndex.Period] = GetPeriodTaskCountDown
}

function BpTaskModel:GetTaskGroupCountDown(svrIdx)
  local coundDownFunc = taskSeverIdx2CountDownFuncMap[svrIdx]
  if coundDownFunc then
    do return end
    return coundDownFunc
  end
  return ""
end

return BpTaskModel
