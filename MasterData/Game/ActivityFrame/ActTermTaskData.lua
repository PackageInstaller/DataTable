local ActTermTaskData = class("ActTermTaskData")

function ActTermTaskData:BindTeramTaskCommitFunc(func)
  self._commitFunc = func
end

function ActTermTaskData:BindTeramTaskUnlockFunc(func)
  self._unlockFunc = func
end

function ActTermTaskData:ReqCommitTermOnceTask(taskId, callback)
  local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
  if taskData == nil or not taskData:CheckComplete() then
    return
  end
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  taskCtrl:SendCommitQuestReward(taskData, true, function()
    if self._commitFunc ~= nil then
      self._commitFunc()
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function ActTermTaskData:ReqCommitTermAllTask(term, callback)
  local taskIds
  if term == nil then
    taskIds = {}
    for i = 1, self:GetTermTaskStageCount() do
      if self:GetTermOpenTime(i) <= PlayerDataCenter.timestamp then
        table.insertto(taskIds, self:GetTermTaskIds(i))
      end
    end
  elseif self:GetTermOpenTime(term) <= PlayerDataCenter.timestamp then
    taskIds = self:GetTermTaskIds(term)
  end
  
  local function checkPreTask(taskId)
    local taskCfg = ConfigData.task[taskId]
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskCfg == nil or taskData == nil then
      error("cant find taskCfg or taskData!")
      return nil
    end
    if taskCfg ~= nil and taskCfg.show_pre > 0 then
      local preTaskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskCfg.show_pre, true)
      return preTaskData.isPicked and checkPreTask(taskCfg.show_pre)
    end
    return true
  end
  
  if taskIds == nil then
    return
  end
  local taskIdDic = {}
  for _, taskId in ipairs(taskIds) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
    if taskData ~= nil and taskData:CheckComplete() and checkPreTask(taskId) then
      taskIdDic[taskId] = true
    end
  end
  if table.count(taskIdDic) == 0 then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.Task)
  network:CS_QUEST_OneKeyPick(taskIdDic, function()
    if self._commitFunc ~= nil then
      self._commitFunc()
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function ActTermTaskData:RegisterActTermRefresh()
  local frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameData = frameCtrl:GetActivityFrameData(self._frameId)
  if frameData == nil or not frameData:IsInRuningState() then
    return
  end
  local startTerm = self._lockNearTerm or 1
  local nextTime = 0
  for i = startTerm, self:GetTermTaskStageCount() do
    if self:GetTermOpenTime(i) > PlayerDataCenter.timestamp then
      nextTime = self:GetTermOpenTime(i)
      self._lockNearTerm = i
      break
    end
  end
  if nextTime > frameData:GetActivityEndTime() or nextTime < PlayerDataCenter.timestamp then
    return
  end
  if self.__ExpireDealCallback == nil then
    self.__ExpireDealCallback = BindCallback(self, self.__ExpireDeal)
  end
  frameCtrl:AddActivityDataUpdateTimeListen(self._frameId, nextTime, self.__ExpireDealCallback)
end

function ActTermTaskData:__ExpireDeal()
  TimerManager:StartTimer(1, function()
    local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    network:CS_ACTIVITY_TermTask(self._frameId, function()
      if self._unlockFunc ~= nil then
        self._unlockFunc()
      end
      MsgCenter:Broadcast(eMsgEventId.ActivityTermTaskExpired, self._frameId)
    end)
  end, self, true)
end

function ActTermTaskData:IsExistTermCompleteTask()
  for i = 1, self:GetTermTaskStageCount() do
    if self:IsExistTermCompleteTaskInTerm(i) then
      return true
    end
  end
  return false
end

function ActTermTaskData:IsExistTermCompleteTaskInTerm(term)
  local function showPreComplete(taskId)
    local taskCfg = ConfigData.task[taskId]
    
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskCfg == nil or taskData == nil then
      error("cant find taskCfg or taskData!")
      return nil
    end
    if taskCfg ~= nil and taskCfg.show_pre > 0 then
      local preTaskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskCfg.show_pre, true)
      return preTaskData.isPicked and showPreComplete(taskCfg.show_pre)
    end
    return true
  end
  
  if term > self:GetTermTaskStageCount() then
    return
  end
  if self:GetTermOpenTime(term) > PlayerDataCenter.timestamp then
    return
  end
  local taskIds = self:GetTermTaskIds(term)
  for i, taskId in ipairs(taskIds) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
    if taskData ~= nil and taskData:CheckComplete() and showPreComplete(taskId) then
      return true
    end
  end
  return false
end

function ActTermTaskData:InitTermTask(frameId)
  self._frameId = frameId
end

function ActTermTaskData:IsExitInTermTask(taskId)
  return false
end

function ActTermTaskData:GetTermTaskStageCount()
  return 0
end

function ActTermTaskData:GetTermTaskIds(term)
  return nil
end

function ActTermTaskData:GetTermOpenTime(term)
  return 0
end

return ActTermTaskData
