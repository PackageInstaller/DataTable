_class("HomeStoryTask", Object)
HomeStoryTask = HomeStoryTask

function HomeStoryTask:Constructor(storyTaskID, Cfg, storytaskmanager, serverData)
  self._storyTaskID = storyTaskID
  self._taskGroups = {}
  self._storytaskmanager = storytaskmanager
  self._taskmanager = storytaskmanager:GetTaskManager()
  self._runningTaskGroup = nil
  self._storyTaskCfg = Cfg
  self._serverData = serverData
  self._homelandTaskManagerHelper = self._taskmanager:GetHomelandTaskManagerHelper()
  self:CreateStoryTaskGroups()
end

function HomeStoryTask:CreateStoryTaskGroups()
  if not self._serverData then
    Log.fatal("HomeStoryTask:CreateTaskItems  groupID :" .. self._storyTaskID .. "is nil")
    return
  end
  for index, value in pairs(self._storyTaskCfg.StoryTaskGroupTb) do
    local cfg = self._homelandTaskManagerHelper:GetTaskGroupCfg(value)
    if self._serverData[value] then
      local groupItem = HomeTaskGroup:New(value, cfg, self._taskmanager, self._serverData[value])
      table.insert(self._taskGroups, groupItem)
    end
  end
  self:SetServerData(self._serverData)
end

function HomeStoryTask:SetServerData(serverData)
  if serverData then
    self._serverData = serverData
  end
  self:AddNewGroups(serverData)
  for key, value in pairs(self._serverData) do
    for k = 1, #self._taskGroups do
      if self._taskGroups[k]:GetGroupID() == key then
        self._taskGroups[k]:SetServerData(value)
      end
    end
  end
end

function HomeStoryTask:AddNewGroups(serverData)
  if not serverData then
    return
  end
  for index, value in pairs(self._storyTaskCfg.StoryTaskGroupTb) do
    local cfg = self._homelandTaskManagerHelper:GetTaskGroupCfg(value)
    if self._serverData[value] and not self:CheckHaveGroup(value) then
      local groupItem = HomeTaskGroup:New(value, cfg, self._taskmanager, serverData[value])
      table.insert(self._taskGroups, groupItem)
    end
  end
end

function HomeStoryTask:CheckHaveGroup(GroupId)
  if not self._taskGroups then
    return
  end
  for index, value in pairs(self._taskGroups) do
    if value:GetGroupID() == GroupId then
      return true
    end
  end
  return false
end

function HomeStoryTask:Dispose()
  if #self._taskGroups > 0 then
    for i = 1, #self._taskGroups do
      self._taskGroups[i]:Dispose()
    end
  end
  self._taskGroups = nil
  if self._runningTaskGroup then
    self._runningTaskGroup:Dispose()
  end
  self._runningTaskGroup = nil
  self._storyTaskID = nil
  self._serverData = nil
  self._storyTaskCfg = nil
end

function HomeStoryTask:StartRun()
  if self._storytaskmanager then
    self._storytaskmanager:OnStoryTaskStart(self._storyTaskID)
  end
  self:SetRun()
end

function HomeStoryTask:EndRun()
  if self._storytaskmanager then
    self._storytaskmanager:OnStoryTaskEnd(self._storyTaskID)
  end
  if self._runningTaskGroup then
    self._runningTaskGroup:EndRun()
  end
  self._runningTaskGroup = nil
end

function HomeStoryTask:Update(deltaTimeMS)
  if self._runningTaskGroup then
    self._runningTaskGroup:Update(deltaTimeMS)
  end
end

function HomeStoryTask:GetStoryTaskID()
  return self._storyTaskID
end

function HomeStoryTask:GetStoryTaskCfg()
  return self._storyTaskCfg
end

function HomeStoryTask:GetRewardItems()
  return self._storyTaskCfg.Rewards
end

function HomeStoryTask:CheckFinished()
  if not self._taskGroups or #self._taskGroups == 0 then
    return false
  end
  for i = 1, #self._taskGroups do
    if not self._taskGroups[i]:CheckFinished() then
      return false
    end
  end
  return true
end

function HomeStoryTask:GetFinishedCount()
  local count = 0
  for i = 1, #self._taskGroups do
    if self._taskGroups[i]:CheckFinished() then
      count = count + 1
    end
  end
  return count
end

function HomeStoryTask:OnStoryTaskFinished()
  GameGlobal.TaskManager():StartTask(self.OnStoryTaskFinishedCore, self)
end

function HomeStoryTask:OnStoryTaskFinishedCore(TT)
end

function HomeStoryTask:MoveNextTaskGroup()
  local nextIndex = self._runningTaskGroupIndex + 1
  self._runningTaskGroupIndex = nextIndex > #self._taskGroups and -1 or nextIndex
  if self._runningTaskGroupIndex < 0 then
    return
  end
  if not self._taskGroups[nextIndex] then
    Log.fatal("当前剧情任务 结束")
    return
  end
  if self._taskGroups[nextIndex] then
    self._runningTaskGroup = self._taskGroups[nextIndex]
  end
  self._runningTaskGroupId = self._runningTaskGroup:GetGroupID()
  return self._runningTaskGroup
end

function HomeStoryTask:CheckOpen()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local now = time_mod:GetServerTime() / 1000
  return now > self._storyTaskCfg.UnlockTime
end

function HomeStoryTask:GetTaskManager()
  return self._taskmanager
end

function HomeStoryTask:GetRunningTaskGroup()
  return self._runningTaskGroup
end

function HomeStoryTask:SetRun()
  for index, value in ipairs(self._taskGroups) do
    if not value:CheckFinished() then
      self._runningTaskGroup = value
      self._runningTaskGroupIndex = index
      break
    end
  end
  if not self._runningTaskGroup then
    return
  end
  self._runningTaskGroup:StartRun()
  self._runningTaskGroupId = self._runningTaskGroup:GetGroupID()
end

function HomeStoryTask:GetRuningTaskGroupId()
  return self._runningTaskGroupId
end

function HomeStoryTask:GetRuningTaskGroup()
  return self._runningTaskGroup
end

function HomeStoryTask:CheckFinishAll()
  local finish = true
  for index, value in pairs(self._taskGroups) do
    if not value:CheckFinished() then
      finish = false
      break
    end
  end
  return finish
end

function HomeStoryTask:GetTaskGroups()
  return self._taskGroups
end

function HomeStoryTask:SetLock(islock)
  self._isLock = islock
end
