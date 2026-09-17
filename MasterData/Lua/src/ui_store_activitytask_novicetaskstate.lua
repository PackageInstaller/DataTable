local this = {}
local noviceTaskTpl = L_GameTpl:getNoviceTaskTpl()
local noviceTaskGroupTpl = L_GameTpl:getNoviceTaskGroupTpl()
local TaskStatus = {
  NOT_COMPLET = 0,
  COMPLETE = 1,
  REWARD_RECEIVED = 2
}

function this:init()
  this.super.init(self)
  self.data = {
    taskInfosDic = {},
    taskTplDataDic = noviceTaskTpl:getTaskTplDataDic(),
    taskGroupId2GroupFinishedDic = {},
    taskGroupId2GroupProgressDic = {},
    taskGroupId2GroupMaxProgressDic = {},
    maxTaskGroupId = 0,
    maxTaskDuelGroupId = 0
  }
end

function this:state()
  return {}
end

function this:getTaskInfosDic()
  return self.data.taskInfosDic
end

function this:getTaskTplDataDic()
  return self.data.taskTplDataDic
end

function this:getMaxTaskGroupId(type)
  return type == 1 and self.data.maxTaskGroupId or self.data.maxTaskDuelGroupId
end

function this:getTaskGroupIfFinishedById(groupId)
  return self.data.taskGroupId2GroupFinishedDic[groupId]
end

function this:getTaskGroupProgressById(groupId)
  return self.data.taskGroupId2GroupProgressDic[groupId]
end

function this:getTaskGroupMaxProgressById(groupId)
  return self.data.taskGroupId2GroupMaxProgressDic[groupId]
end

function this:getTaskGroup(groupId)
  return noviceTaskGroupTpl:getTaskGroupType(groupId)
end

function this:getMaxTaskGroup(type)
  return noviceTaskGroupTpl:getMaxTaskGroup(type)
end

function this:getCanReceiveRewardNumber()
  local canReceiveRewardNumber = 0
  canReceiveRewardNumber = self:getNoviceTaskRewardNumber(1) + self:getNoviceTaskRewardNumber(201)
  return canReceiveRewardNumber
end

function this:getNoviceTaskRewardNumber(type)
  if type == 201 and not C_IntegrateMgr.SystemUnlockModule:getSystemIsOpen(L_SystemConst.enum.noviceDuelTask) then
    return 0
  end
  local canReceiveRewardNumber = 0
  local maxUnlockTaskGroup = self:getMaxUnlockedTaskGroupId(type)
  
  local function taskFunc(id)
    if type <= self.data.maxTaskGroupId then
      return id <= maxUnlockTaskGroup
    else
      return id > self.data.maxTaskGroupId and id <= maxUnlockTaskGroup
    end
  end
  
  for groupId, taskInfoList in pairs(self.data.taskInfosDic) do
    if taskFunc(groupId) then
      canReceiveRewardNumber = canReceiveRewardNumber + self:getTaskFinishNumber(groupId, taskInfoList)
    end
  end
  return canReceiveRewardNumber
end

function this:getTaskFinishNumber(groupId, taskInfoList)
  local tempNumber = 0
  if self:getTaskGroupProgressById(groupId) == self:getTaskGroupMaxProgressById(groupId) and self:getTaskGroupIfFinishedById(groupId) ~= true then
    tempNumber = tempNumber + 1
  end
  for _, taskInfo in pairs(taskInfoList) do
    if taskInfo.task_status == TaskStatus.COMPLETE then
      tempNumber = tempNumber + 1
    end
  end
  return tempNumber
end

function this:getMaxUnlockedTaskGroupId(taskType)
  local maxTaskId = self:getMaxTaskGroupId(taskType)
  local maxUnlockeTaskGroupId = taskType
  for groupId, ifFinished in pairs(self.data.taskGroupId2GroupFinishedDic) do
    if ifFinished and maxTaskId >= groupId + 1 and maxUnlockeTaskGroupId < groupId + 1 then
      if taskType ~= 1 then
        local unLock = L_ConditionManager:isComplete(noviceTaskGroupTpl:getTaskGroupUnLockCondition(groupId + 1))
        if unLock then
          maxUnlockeTaskGroupId = groupId + 1
        end
      else
        maxUnlockeTaskGroupId = groupId + 1
      end
    end
  end
  return maxUnlockeTaskGroupId
end

return this
