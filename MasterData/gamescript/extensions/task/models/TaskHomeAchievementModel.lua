local TaskHomeAchievementModel = NewClass("TaskHomeAchievementModel", BaseModel)
local ExcelBoolType = CommonDefine.ExcelBoolType
local TaskState = CommonDefine.TaskState
local AchievementSubTaskType = CommonDefine.AchievementSubTaskType
local AchievementTrophyType = CommonDefine.AchievementTrophyType
local taskTabGroup = DT.GetOriginalConstant("AchieveTabSort")
local taskShowStateGroup = {
  TaskState.Receive,
  TaskState.Done
}

function TaskHomeAchievementModel:OnInit()
  self:OnReset()
end

function TaskHomeAchievementModel:OnReset()
  self.curTaskType = taskTabGroup and taskTabGroup[1] or AchievementSubTaskType.Exploration
end

function TaskHomeAchievementModel:GetToggleTypeGroup()
  return taskTabGroup
end

function TaskHomeAchievementModel:GetCurTaskType()
  return self.curTaskType
end

function TaskHomeAchievementModel:SetCurTaskType(curTaskType)
  self.curTaskType = curTaskType
end

function TaskHomeAchievementModel:GetCurTaskList()
  self:_InitAchievementTaskMap()
  local rst = table.clone(self.achievementTaskMap[self.curTaskType] or {})
  for i = #rst, 1, -1 do
    local taskData = rst[i]
    if not (self:_CheckTaskShow(taskData.tid) or table.contains(taskShowStateGroup, taskData.state)) or not TaskDataUtils.GetTaskData(taskData.uid) then
      table.remove(rst, i)
    end
  end
  do return TaskDataUtils.SortTasksData end
  return TaskDataUtils.SortTasksData, rst, -1, nil, rst[i], table.remove, rst, i
end

function TaskHomeAchievementModel:_CheckTaskShow(taskTid)
  local taskCfg = DT.Task[taskTid]
  if not taskCfg.AchieveDisplayCondition then
    return true
  end
  if 0 == ExcelBoolType[taskCfg.AchieveDisplayCondition] then
    return false
  end
  local preTaskTid = tonumber(taskCfg.AchieveDisplayCondition) or 0
  if 0 == preTaskTid then
    return true
  end
  local taskData = TaskDataUtils.GetTaskData(preTaskTid)
  if not taskData then
    return false
  end
  return taskData.state == TaskState.Done
end

function TaskHomeAchievementModel:GetTaskRedDotStatusByType(curTaskType)
  self:_InitAchievementTaskMap()
  for _, taskData in pairs(self.achievementTaskMap[curTaskType] or {}) do
    if taskData.state == TaskState.Receive then
      return RedPointDataUtils.RedAttrType.Red
    end
  end
  return false
end

function TaskHomeAchievementModel:GetTrophyNums()
  local rst = {
    [AchievementTrophyType.Gold] = 0,
    [AchievementTrophyType.Silver] = 0,
    [AchievementTrophyType.Bronze] = 0
  }
  local allAchievementTaskList = TaskDataUtils.GetTaskDataListBySvrIdx(CommonDefine.TaskServerIndex.Achivement)
  for _, taskData in pairs(allAchievementTaskList) do
    local taskCfg = DT.Task[taskData.tid]
    if not taskCfg.AchieveQuality then
    elseif taskData.state == TaskState.Done then
      rst[taskCfg.AchieveQuality] = rst[taskCfg.AchieveQuality] + 1
    end
  end
  return rst
end

function TaskHomeAchievementModel:_InitAchievementTaskMap()
  if self.achievementTaskMap then
    return
  end
  self:RebuildAchievementTaskMap()
end

function TaskHomeAchievementModel:_RefreshAchievementTaskMap(newTaskInfo)
  self:_InitAchievementTaskMap()
  local taskCfg = DT.Task[newTaskInfo.tid]
  if not taskCfg.AchieveType then
    return
  end
  
  local function updateTaskList(list)
    for idx, taskData in pairs(list or {}) do
      if taskData.uid == newTaskInfo.uid then
        list[idx] = newTaskInfo
      end
    end
  end
  
  updateTaskList(self.achievementTaskMap[taskCfg.AchieveType])
  updateTaskList(self.achievementTaskMap[AchievementSubTaskType.All])
end

function TaskHomeAchievementModel:RebuildAchievementTaskMap()
  self.achievementTaskMap = {
    [AchievementSubTaskType.All] = {},
    [AchievementSubTaskType.Growth] = {},
    [AchievementSubTaskType.Exploration] = {},
    [AchievementSubTaskType.Battle] = {},
    [AchievementSubTaskType.Other] = {}
  }
  local allAchievementTaskList = TaskDataUtils.GetTaskDataListBySvrIdx(CommonDefine.TaskServerIndex.Achivement)
  for _, taskData in pairs(allAchievementTaskList) do
    local taskCfg = DT.Task[taskData.tid]
    if not taskCfg.AchieveType then
    elseif self.achievementTaskMap[taskCfg.AchieveType] then
      table.insert(self.achievementTaskMap[taskCfg.AchieveType], taskData)
      table.insert(self.achievementTaskMap[AchievementSubTaskType.All], taskData)
    end
  end
end

return TaskHomeAchievementModel
