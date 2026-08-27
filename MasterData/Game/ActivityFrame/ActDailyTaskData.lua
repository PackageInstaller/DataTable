local ActDailyTaskData = class("ActDailyTaskData")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function ActDailyTaskData:InitActDailyTask(frameId)
  self._cfg = ConfigData.activity_general_daily_task[frameId]
  self._taskIds = {}
  self._timepassCtr = ControllerManager:GetController(ControllerTypeId.TimePass, true)
end

function ActDailyTaskData:BindActDailyTaskCommitFunc(func)
  self._commitFunc = func
end

function ActDailyTaskData:BindActDailyTaskChangeFunc(func)
  self._changeFunc = func
end

function ActDailyTaskData:BindActDailyTaskExpireFunc(func)
  self._expireFunc = func
end

function ActDailyTaskData:SetActDailyTaskIds(taskIds)
  self._taskIds = taskIds or {}
end

function ActDailyTaskData:SetActDailyExpireTime(time)
  self._expireTime = time
end

function ActDailyTaskData:RegisterActDailyRefresh()
  local frameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local frameData = frameCtrl:GetActivityFrameData(self._cfg.id)
  if frameData == nil or not frameData:IsInRuningState() then
    return
  end
  local nextTime = self:GetActDailyExpireTime()
  if nextTime >= frameData:GetActivityEndTime() then
    return
  end
  if self.__ExpireDealCallback == nil then
    self.__ExpireDealCallback = BindCallback(self, self.__ExpireDeal)
  end
  frameCtrl:AddActivityDataUpdateTimeListen(self._cfg.id, nextTime, self.__ExpireDealCallback)
end

function ActDailyTaskData:__ExpireDeal()
  TimerManager:StartTimer(1, function()
    local net = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    net:CS_ACTIVITY_RefreshQuestDaily(self._cfg.id, function(args)
      if (args == nil or args.Count == 0) and isGameDev then
        error("args.Count == 0")
      end
      local msg = args[0]
      if msg.taskIds[1] ~= nil then
        table.insertto(self._taskIds, msg.taskIds)
      end
      self._expireTime = msg.nextFreshTime
      self:RegisterActDailyRefresh()
      if self._expireFunc ~= nil then
        self._expireFunc()
      end
      MsgCenter:Broadcast(eMsgEventId.ActivityDailyTaskExpired, self._cfg.id)
    end)
  end, self, true)
end

function ActDailyTaskData:IsExistDailyCompleteTask()
  for i, taskId in ipairs(self._taskIds) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
    if taskData ~= nil and taskData:CheckComplete() then
      return true
    end
  end
  return false
end

function ActDailyTaskData:IsExitInDailyTask(taskId)
  return table.contain(self._taskIds, taskId)
end

function ActDailyTaskData:ReqActDailyTaskCommit(taskId, callback)
  if not table.contain(self._taskIds, taskId) then
    return
  end
  local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
  if taskData == nil or not taskData:CheckComplete() then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  network:CS_Activity_Quest_Commit(self._cfg.id, taskId, function(args)
    local rewards, nums = taskData:GetTaskCfgRewards()
    local overflowInfo
    local rewardDic = {}
    for index, id in pairs(rewards) do
      rewardDic[id] = nums[index]
    end
    if args ~= nil then
      local addInfo = args[0]
      if addInfo ~= nil then
        overflowInfo = addInfo.task_overflowInfo
        local randomPackage = addInfo.task_randomPackage or table.emptytable
        for parentItemId, data in pairs(randomPackage) do
          rewardDic[parentItemId] = (rewardDic[parentItemId] or 0) - data.itemNum
          if rewardDic[parentItemId] <= 0 then
            rewardDic[parentItemId] = nil
          end
          local resultDic = data.product
          for itemId, num in pairs(resultDic) do
            rewardDic[itemId] = (rewardDic[itemId] or 0) + num
          end
        end
      end
    end
    local CRData = CommonRewardData.CreateCRDataUseDic(rewardDic):SetCRItemCustomTransDic(overflowInfo)
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      window:AddAndTryShowReward(CRData)
    end)
    table.removebyvalue(self._taskIds, taskId)
    if self._commitFunc ~= nil then
      self._commitFunc()
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function ActDailyTaskData:ReqActDailyTaskRef(taskId, callback)
  local times = self:GetActDailyRefTimes()
  if times >= self._cfg.daily_task_refresh_max then
    return
  end
  local index = table.indexof(self._taskIds, taskId)
  if index then
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
    if taskData == nil or taskData:CheckComplete() then
      return
    end
    local network = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
    network:CS_ACTIVITY_RefreshSingleQuestByUser(self._cfg.id, taskId, function(args)
      if args == nil or args.Count == 0 then
        if isGameDev then
          error("args.Count == 0")
        end
        return
      end
      local newTaskId = args[0]
      self._taskIds[index] = newTaskId
      if self._changeFunc ~= nil then
        self._changeFunc()
      end
      if callback ~= nil then
        callback(newTaskId)
      end
    end)
  end
end

function ActDailyTaskData:GetActDailyTaskIds()
  return self._taskIds
end

function ActDailyTaskData:GetActDailyTaskCfg()
  return self._cfg
end

function ActDailyTaskData:GetActDailyExpireTime()
  if (self._expireTime or 0) == 0 then
    return self._cfg.task_time
  end
  return self._expireTime
end

function ActDailyTaskData:GetActDailyRefTimes()
  local elemtData = self._timepassCtr:getCounterElemData(proto_object_CounterModule.CounterModuleActivityQuestUserRefreshTimes, self._cfg.id)
  if elemtData == nil or elemtData.nextExpiredTm < self._expireTime then
    return 0
  end
  return elemtData.times
end

return ActDailyTaskData
