local this = {}
local TaskStatus = {
  NOT_COMPLET = 0,
  COMPLETE = 1,
  REWARD_RECEIVED = 2
}
local TaskType = {guide = 1, duel = 2}

function this:req_noviceTaskFinish(cellNoviceTaskItem, callback)
  local taskId = cellNoviceTaskItem:getTaskId()
  local data = {u32 = taskId}
  L_Net:sendMessage(MsgGenCode.CSProtoNoviceTaskFinish, data, callback)
end

function this:req_noviceTaskFinishGroup(groupId, callback)
  local data = {u32 = groupId}
  L_Net:sendMessage(MsgGenCode.CSProtoNoviceTaskFinishGroup, data, callback)
end

function this:rsp_syncNoviceTaskInfo(data)
  self.data.taskInfosDic = self.data.taskInfosDic or {}
  if data.groups == nil then
    return
  end
  printf("10761_新手任务信息同步", data)
  for _, group in pairs(data.groups) do
    local groupId = group.group_id
    local taskInfos = group.tasks
    if taskInfos then
      table.sort(taskInfos, function(a, b)
        if a.task_status == b.task_status then
          return a.task_id < b.task_id
        else
          local TaskState2Order = {
            [TaskStatus.COMPLETE] = 0,
            [TaskStatus.NOT_COMPLET] = 1,
            [TaskStatus.REWARD_RECEIVED] = 2
          }
          return TaskState2Order[a.task_status] < TaskState2Order[b.task_status]
        end
      end)
      self.data.taskInfosDic[groupId] = taskInfos
      local ifFinished = group.finished or false
      self.data.taskGroupId2GroupFinishedDic[groupId] = ifFinished
      local progress = 0
      local maxProgress = 0
      for _, taskInfo in pairs(taskInfos) do
        maxProgress = maxProgress + 1
        if taskInfo.task_status == TaskStatus.REWARD_RECEIVED then
          progress = progress + 1
        end
      end
      self.data.taskGroupId2GroupProgressDic[groupId] = progress
      self.data.taskGroupId2GroupMaxProgressDic[groupId] = maxProgress
      if self:getTaskGroup(groupId) == TaskType.duel then
        if groupId > self.data.maxTaskDuelGroupId then
          self.data.maxTaskDuelGroupId = self:getMaxTaskGroup(TaskType.duel)
        end
      elseif groupId > self.data.maxTaskGroupId then
        self.data.maxTaskGroupId = self:getMaxTaskGroup(TaskType.guide)
      end
    end
  end
  printf("新手任务信息，排序后结果", self.data.taskInfosDic)
  self:call(self.event.refreshNoviceTask)
  self:call(self.event.refreshNoviceTaskReddot)
end

return this
