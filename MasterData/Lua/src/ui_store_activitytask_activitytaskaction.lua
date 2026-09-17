local this = {}

local function buildClientSortRwdList(activityRewardList)
  local clientSortRwdList = {}
  for _, rewardItem in ipairs(activityRewardList) do
    if rewardItem.canReward == 1 and rewardItem.isFinish == false and not table.isEmpty(rewardItem.reward) then
      for _, reward in ipairs(rewardItem.reward) do
        table.insert(clientSortRwdList, reward)
      end
    end
  end
  return clientSortRwdList
end

function this:req_getActivityTaskReward(reward_type, callback)
  local data = {u32 = reward_type}
  L_Net:sendMessage(MsgGenCode.CSProtoGetActiveValueReward, data, function(rspData, errorCode)
    local rspRewards = rspData.rewards
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if not table.isEmpty(rspRewards) then
        local rewards = require("ui.manager.reward.rewardData").new()
        rewards.rewardShowType = L_Const.rewardShowType.full
        local clientSortRwdList = buildClientSortRwdList(self:getActivityRewardListByIndex(reward_type))
        local data = L_DataUtil.parseRewardConfig(rspRewards, true, true, clientSortRwdList)
        rewards:constructList(data)
        L_RewardManager:ShowReward(rewards)
      end
      if callback then
        callback()
      end
    end
  end)
end

function this:req_getActivityItemReward(ids, callback)
  local data = {u32s = ids}
  L_Net:sendMessage(MsgGenCode.CSProtoGetActiveReward, data, function(rspData, errorCode)
    local rewards = rspData.rewards
    if not table.isEmpty(rewards) then
    end
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:rsp_syncActivityTaskInfo(data)
  if data == nil then
    return
  end
  for i, v in pairs(data) do
    local entity = self:getActivityTaskItem(v.task_id, true)
    entity.count = v.task_value
    if v.task_status then
      entity.finishState = v.task_status
    else
      self:getServerDataActivityTask(entity)
    end
  end
  self:call(self.event.refreshActivityTask)
  self:call(self.event.refreshActivityReddot)
end

function this:rsp_syncFinishedActivityTaskInfo(data)
  if data == nil then
    return
  end
  for i, v in pairs(data) do
    local entity = self:getActivityTaskItem(v.task_id, true)
    entity.count = v.task_value
    entity.finishState = v.task_status
    entity.maxStage = 1
    entity.curStage = 1
  end
  self:call(self.event.refreshActivityTask)
  self:call(self.event.refreshActivityReddot)
end

function this:rsp_syncTodayActivityInfo(data, type)
  self.data.todayActivityValue = data
  if data == 0 then
    for i, v in pairs(self.data.csvAllActivityRewardList) do
      local entity = self.data.activityRewardList[v.id]
      if entity ~= nil and v.taskType == type then
        self.data.activityRewardList[v.id] = entity
        entity.id = v.id
        entity.canReward = 0
        entity.requireActivity = v.requireActivity
        entity.isFinish = false
        entity.taskType = v.taskType
        entity.reward = v.reward
      end
    end
  end
  self:call(self.event.refreshActivityReward)
  self:call(self.event.refreshActivityReddot)
end

function this:rsp_syncWeekActivityInfo(data, type)
  self.data.weekActivityValue = data
  if data == 0 then
    for i, v in pairs(self.data.csvAllActivityRewardList) do
      local entity = self.data.activityRewardList[v.id]
      if entity ~= nil and v.taskType == type then
        self.data.activityRewardList[v.id] = entity
        entity.id = v.id
        entity.canReward = 0
        entity.requireActivity = v.requireActivity
        entity.isFinish = false
        entity.taskType = v.taskType
        entity.reward = v.reward
      end
    end
  end
  self:call(self.event.refreshActivityReward)
  self:call(self.event.refreshActivityReddot)
end

function this:rsp_syncActivityRewardListInfo(data)
  if data == nil then
    return
  end
  for i, v in pairs(data) do
    local entity = self:getActivityRewardItem(v)
    entity.isFinish = true
  end
  self:call(self.event.refreshActivityReward)
  self:call(self.event.refreshActivityReddot)
end

return this
