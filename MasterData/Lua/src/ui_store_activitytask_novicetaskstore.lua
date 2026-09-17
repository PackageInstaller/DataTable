local this = class("noviceTaskStore", G_BaseStore)
local TaskStatus = {
  NOT_COMPLET = 0,
  COMPLETE = 1,
  REWARD_RECEIVED = 2
}
this.event = {
  refreshNoviceTask = "refreshNoviceTask",
  refreshNoviceTaskReddot = "refreshNoviceTaskReddot",
  nextTaskGroupUnlocked = "nextTaskGroupUnlocked"
}
this:importPartialClass(require(L_R.store .. "activityTask.noviceTaskState"))
this:importPartialClass(require(L_R.store .. "activityTask.noviceTaskAction"))

function this:checkIfTargetTaskGroupCompleteByGroupId(groupId)
  local progress = self.data.taskGroupId2GroupProgressDic[groupId]
  local maxProgress = self.data.taskGroupId2GroupMaxProgressDic[groupId]
  return progress == maxProgress
end

function this:checkIfAllTaskCompletedAndAllRewardReceived()
  for groupId, taskInfoList in pairs(self.data.taskInfosDic) do
    if groupId <= self.data.maxTaskGroupId or groupId > self.data.maxTaskGroupId and groupId <= self.data.maxTaskDuelGroupId then
      if self:getTaskGroupIfFinishedById(groupId) ~= true then
        return false
      end
      for _, taskInfo in pairs(taskInfoList) do
        if taskInfo.task_status ~= TaskStatus.REWARD_RECEIVED then
          return false
        end
      end
    end
  end
  return true
end

return this
