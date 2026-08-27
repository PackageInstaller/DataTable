local TaskData = class("TaskData")
local TaskEnum = require("Game.Task.TaskEnum")

function TaskData.CreateTaskData(data, stcData)
  local taskData = TaskData.New()
  taskData:InitTaskData(data, stcData)
  return taskData
end

function TaskData.CreatePickedTaskData(stcData)
  local taskData = TaskData.New()
  taskData:InitTaskData(nil, stcData)
  taskData.isPicked = true
  taskData.state = TaskEnum.eTaskState.Picked
  taskData.schedule = taskData.taskStepCfg[1].finish_value or 1
  taskData.aim = taskData.taskStepCfg[1].finish_value or 1
  taskData.acceptedTm = 0
  taskData.expiredTm = 0
  taskData.disappearTm = 0
  return taskData
end

function TaskData:ctor()
end

function TaskData:InitTaskData(data, stcData)
  self.id = stcData.id
  self.stcData = stcData
  self.taskStepCfg = ConfigData.taskStep[self.id]
  if data ~= nil then
    self:UpdateTaskData(data)
  end
end

function TaskData:UpdateTaskData(data)
  self.state = data.state
  self.acceptedTm = data.acceptedTm
  self.expiredTm = data.expiredTm
  self.disappearTm = data.disappearTm
  self.stepIdx = data.stepIdx
  self.schedule = data.schedule
  self.aim = data.aim
end

function TaskData:GetStepCfg()
  return self.taskStepCfg[1]
end

function TaskData:CheckComplete()
  if self.stcData.open_condition ~= nil and self.stcData.open_condition > 0 and not FunctionUnlockMgr:ValidateUnlock(self.stcData.open_condition) then
    return false
  end
  if self.state == TaskEnum.eTaskState.Picked or self.schedule == nil or self.aim == nil then
    return false
  end
  return self.schedule >= self.aim
end

function TaskData:IsPickedTaskReward()
  return self.state >= proto_object_QuestState.QuestStateCompleted
end

function TaskData:GetTaskProcess()
  return self.schedule, self.aim
end

function TaskData:GetTaskCfgRewards()
  return self.stcData.rewardIds, self.stcData.rewardNums
end

function TaskData:GetTaskFirstStepIntro()
  return LanguageUtil.GetLocaleText(self.stcData.task_intro)
end

function TaskData:GetTaskName()
  return LanguageUtil.GetLocaleText(self.stcData.name)
end

function TaskData:GetTaskJumpArg()
  local jumpId = self.stcData.jump_id
  return 0 < (jumpId or 0), jumpId, self.stcData.jumpArgs
end

function TaskData:GetQuality()
  if 0 < (self.stcData.quality or 0) then
    return self.stcData.quality
  end
  return eItemQualityType.White
end

function TaskData:IsTaskShowNew()
  return self.stcData.activity_limit_new
end

function TaskData:SetBindActFramId(actFrameId)
  self.__dwBindActFrameId = actFrameId
end

function TaskData:GetBindActFramId()
  return self.__dwBindActFrameId
end

function TaskData:GetTaskOrder()
  return self.stcData.order
end

return TaskData
