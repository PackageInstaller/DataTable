_class("HomeTaskGroup", Object)
HomeTaskGroup = HomeTaskGroup

function HomeTaskGroup:Constructor(groupID, groupCfg, taskmanager, serverData)
  self._groupID = groupID
  self._taskItems = {}
  self._taskmanager = taskmanager
  self._runningTaskIndex = 0
  self._runningTaskId = nil
  self._runningTask = nil
  self._groupCfg = groupCfg
  self._groupData = serverData
  self._homelandTaskManagerHelper = self._taskmanager:GetHomelandTaskManagerHelper()
  self:CreateTaskItems()
end

function HomeTaskGroup:SortTaskItems()
end

function HomeTaskGroup:CreateTaskItems()
  local list = self._homelandTaskManagerHelper:GetSortedTaskItems(self._groupID)
  if not list then
    Log.fatal("HomeTaskGroup:CreateTaskItems  groupID :" .. self._groupID .. "is nil")
    return
  end
  for index, value in pairs(list) do
    local cfg = self._homelandTaskManagerHelper:GetTaskItemCfg(value.ID)
    local taskItem = HomeTaskItem:New(value.ID, cfg, self)
    table.insert(self._taskItems, taskItem)
  end
  self:SetServerData(self._groupData)
end

function HomeTaskGroup:SetServerData(serverData)
  if serverData then
    self._groupData = serverData
  end
  for i = 1, #self._groupData do
    for k = 1, #self._taskItems do
      if self._taskItems[k]:GetTaskID() == self._groupData[i]:ID() then
        self._taskItems[k]:SetServerInfo(self._groupData[i])
      end
    end
  end
end

function HomeTaskGroup:Dispose()
  if self._taskItems and #self._taskItems > 0 then
    for i = 1, #self._taskItems do
      self._taskItems[i]:Dispose()
    end
  end
  self._taskItems = nil
  if self._runningTask then
    self._runningTask:Dispose()
  end
  self._runningTask = nil
  self._groupID = nil
  self._groupData = nil
  self._groupCfg = nil
end

function HomeTaskGroup:StartRun()
  if self._taskmanager then
    self._taskmanager:OnTaskGroupStart(self._groupID)
  end
  self:SetRun()
end

function HomeTaskGroup:EndRun()
  if self._taskmanager then
    self._taskmanager:OnTaskGroupEnd(self._groupID)
  end
  if self._runningTask then
    self._runningTask:EndRun()
    self._runningTask = nil
  end
end

function HomeTaskGroup:Update(deltaTimeMS)
  if self._runningTask then
    self._runningTask:Update(deltaTimeMS)
  end
end

function HomeTaskGroup:GetGroupID()
  return self._groupID
end

function HomeTaskGroup:GetGroupAcceptCondition()
  return self._groupCfg.AcceptCondition
end

function HomeTaskGroup:GetGroupType()
  return self._groupCfg.GroupType
end

function HomeTaskGroup:GetGroupPriority()
  return self._groupCfg.Priority
end

function HomeTaskGroup:GetGroupInfo()
  return self._groupCfg.GroupTitle, self._groupCfg.GroupContent
end

function HomeTaskGroup:GetRewardItems()
  return self._groupCfg.Rewardtems
end

function HomeTaskGroup:CheckFinished()
  if not self._taskItems or #self._taskItems == 0 then
    return false
  end
  for i = 1, #self._taskItems do
    if not self._taskItems[i]:GetTaskFinished() then
      return false
    end
  end
  return true
end

function HomeTaskGroup:OnTaskGroupFinished()
  GameGlobal.TaskManager():StartTask(self.OnTaskGroupFinishedCoro, self)
end

function HomeTaskGroup:OnTaskGroupFinishedCoro(TT)
  GameGlobal.UIStateManager():Lock("HomeTaskGroup:OnTaskGroupFinishedCoro")
  local afterRewardEvent = false
  local res, replyEvent = self._taskmanager:GetHomelandModule():HandleHomelandTaskGroupTakeReq(TT, self._groupID)
  if res:GetSucc() then
    Log.info("[HomelandTask]任务组结束 领奖成功 任务id:" .. self._groupID)
    local assetList = replyEvent.rewards
    if 0 < #assetList then
      afterRewardEvent = true
      GameGlobal.UIStateManager():ShowDialog("UIHomeShowAwards", assetList, function()
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeLandTaskGroupSubmitAfterReward, self._groupID)
      end, false, nil)
    end
  else
    Log.fatal("[HomeTaskItem] HomeTaskItem:HandleHomelandFinishTaskReq, res:" .. res:GetResult())
  end
  GameGlobal.UIStateManager():UnLock("HomeTaskGroup:OnTaskGroupFinishedCoro")
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeLandTaskGroupSubmit, self._groupID)
  if not afterRewardEvent then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnHomeLandTaskGroupSubmitAfterReward, self._groupID)
  end
end

function HomeTaskGroup:MoveNextTask()
  local nextIndex = self._runningTaskIndex + 1
  self._runningTaskIndex = nextIndex > #self._taskItems and -1 or nextIndex
  if self._runningTaskIndex < 0 then
    return
  end
  if self._taskItems[nextIndex] then
    self._runningTask = self._taskItems[nextIndex]
    self._runningTaskId = self._taskItems[nextIndex]:GetTaskID()
  end
  return self._runningTask
end

function HomeTaskGroup:CheckCanReceive()
  local time_mod = GameGlobal.GameLogic():GetModule(SvrTimeModule)
  local now = time_mod:GetServerTime() / 1000
  return now > self._groupCfg.StartTime and now < self._groupCfg.EndTime
end

function HomeTaskGroup:GetTaskManager()
  return self._taskmanager
end

function HomeTaskGroup:GetRunningTaskItem()
  return self._runningTask
end

function HomeTaskGroup:SetRun()
  for index, value in ipairs(self._taskItems) do
    if not value:GetTaskFinished() then
      self._runningTask = value
      self._runningTaskIndex = index
      break
    end
  end
  if not self._runningTask then
    return
  end
  self._runningTaskId = self._runningTask:GetTaskID()
  self._runningTask:StartRun()
end

function HomeTaskGroup:GetRuningTaskId()
  return self._runningTaskId
end

function HomeTaskGroup:GetRuningTask()
  return self._runningTask
end

function HomeTaskGroup:CheckFinishAll()
  local finish = true
  for index, value in pairs(self._taskItems) do
    if not value:GetTaskFinished() then
      finish = false
      break
    end
  end
  return finish
end

function HomeTaskGroup:GetTaskItems()
  return self._taskItems
end

function HomeTaskGroup:SetUnlock(islock)
  self._isLock = islock
end

function HomeTaskGroup:GetRunTaskItem()
  if not self._taskItems or #self._taskItems == 0 then
    return
  end
  for i = 1, #self._taskItems do
    if not self._taskItems[i]:GetTaskFinished() then
      return self._taskItems[i]
    end
  end
  return
end
