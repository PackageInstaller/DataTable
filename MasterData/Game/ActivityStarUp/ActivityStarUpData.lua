local ActivityStarUpData = class("ActivityStarUpData")
local ActivityStarUpEnum = require("Game.ActivityStarUp.ActivityStarUpEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local cs_playerData = CS.PlayerDataCenter.Instance
local TaskData = require("Game.Task.Data.TaskData")
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function ActivityStarUpData:InitStarUp(rookieStarCfg, msgData)
  self.id = msgData.actId
  self.cfg = rookieStarCfg[msgData.subId]
  self.startTime = self.cfg.pre_para1[1]
  self:CollectTaskIds()
  self.curStageId = 1
  self:RefreshStage()
end

function ActivityStarUpData:GetActivityFrameId()
  return ConfigData.activity.actTypeMapping[ActivityFrameEnum.eActivityType.StarUp][self.id]
end

function ActivityStarUpData:CollectTaskIds()
  self.taskDic = {}
  self.taskDic[1] = {}
  local mainTaskId = self.cfg.phase[1].task
  self.taskDic[1].mainTaskId = mainTaskId
  self.taskDic[1].childTaskIds = {}
  for i, v in ipairs(self.cfg.init_tasks) do
    if v ~= mainTaskId then
      self.taskDic[1].childTaskIds[v] = true
    end
  end
  for i = 2, #self.cfg.phase do
    self.taskDic[i] = {}
    local mainTaskId = self.cfg.phase[i].task
    self.taskDic[i].mainTaskId = mainTaskId
    self.taskDic[i].childTaskIds = {}
    local lastMainTaskId = self.cfg.phase[i - 1].task
    local taskCfg = ConfigData.task[lastMainTaskId]
    if taskCfg == nil then
      if isGameDev then
        error(" taskCfg is nil ,id:" .. tostring(lastMainTaskId) .. " phase:" .. tostring(i))
      end
      break
    end
    for k, v in ipairs(taskCfg.next_task) do
      if v ~= mainTaskId then
        self.taskDic[i].childTaskIds[v] = true
      end
    end
  end
end

function ActivityStarUpData:RefreshStage()
  if self.curStageId == nil then
    return
  end
  local dayCount = (cs_playerData.timestamp - self.startTime) / 86400
  for i = self.curStageId + 1, #self.cfg.phase do
    local phase = self.cfg.phase[i]
    if phase.type == ActivityStarUpEnum.eActivityStageOpen.LastEnd then
      local lastPhase = self.cfg.phase[phase.para]
      local lastMainTask = PlayerDataCenter.allTaskData.taskDatas[lastPhase.task]
      if lastMainTask == nil or lastMainTask.state == TaskEnum.eTaskState.Picked then
        self.curStageId = i
      else
        break
      end
    elseif dayCount >= phase.para then
      self.curStageId = i
    end
  end
  if self.curStageId == #self.cfg.phase then
    local mainTask = PlayerDataCenter.allTaskData.taskDatas[self.cfg.phase[self.curStageId].task]
    if mainTask == nil or mainTask.state == TaskEnum.eTaskState.Picked then
      self.curStageId = nil
    end
  end
  self:UpdateStarUpRedddot()
  if self.curStageId == nil then
    local activityCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
    activityCtrl:HideActivityByExtraLogic(ActivityFrameEnum.eActivityType.StarUp, self.id)
  end
end

function ActivityStarUpData:IsFinish()
  return self.curStageId == nil
end

function ActivityStarUpData:UpdateStarUpRedddot()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actInfo = activityFrameCtrl:GetActivityFrameDataByTypeAndId(ActivityFrameEnum.eActivityType.StarUp, self.id)
  if actInfo == nil or not actInfo:IsActivityOpen() then
    return
  end
  local reddotNode = actInfo:GetActivityReddotNode()
  if reddotNode == nil then
    return
  end
  if self.curStageId == nil then
    reddotNode:SetRedDotCount(0)
    return
  end
  local isHasComplete = false
  local mainTask, tasks = self:GetTasks(self.curStageId, false, true)
  if mainTask ~= nil and mainTask:CheckComplete() then
    isHasComplete = true
  end
  if not isHasComplete then
    for i, v in ipairs(tasks) do
      if v:CheckComplete() then
        isHasComplete = true
        break
      end
    end
  end
  reddotNode:SetRedDotCount(isHasComplete and 1 or 0)
  return
end

function ActivityStarUpData:ContainsTask(taskId, isAllStage)
  isAllStage = isAllStage or false
  local max = (isAllStage or self.curStageId == nil) and #self.cfg.phase or self.curStageId
  for i = 1, max do
    local item = self.taskDic[i]
    if taskId == item.mainTaskId or item.childTaskIds[taskId] ~= nil then
      return true
    end
  end
  return false
end

function ActivityStarUpData:GetTasks(stageId, isJustMainTask, ignoreNullData)
  function CreatePickedTGask(id)
    local stcData = ConfigData.task[id]
    
    if stcData ~= nil then
      local taskData = TaskData.CreatePickedTaskData(stcData)
      return taskData
    end
    return nil
  end
  
  stageId = stageId or self.curStageId
  isJustMainTask = isJustMainTask or false
  ignoreNullData = ignoreNullData or false
  if stageId == nil or stageId > #self.cfg.phase then
    return
  end
  local mainTaskId = self.taskDic[stageId].mainTaskId
  local mainTask = PlayerDataCenter.allTaskData.taskDatas[mainTaskId]
  if mainTask == nil and not ignoreNullData then
    mainTask = CreatePickedTGask(mainTaskId)
  end
  if isJustMainTask then
    return mainTask
  end
  local childTasks = self.taskDic[stageId].childTaskIds
  local tasks = {}
  for k, _ in pairs(childTasks) do
    local task = PlayerDataCenter.allTaskData.taskDatas[k]
    if task == nil and not ignoreNullData then
      task = CreatePickedTGask(k)
    end
    table.insert(tasks, task)
  end
  return mainTask, tasks
end

return ActivityStarUpData
