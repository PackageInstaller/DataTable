local this = {}
local _dungeonEntrustTpl = L_GameTpl:getDungeonEntrustTpl()

function this:req_enterEntrustLevel(levelId, callback)
  local data = {entrust_id = levelId}
  L_Net:sendMessage(MsgGenCode.CSProtoEnterEntrust, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

function this:req_getEntrustReward(rewardIdList, callback)
  local data = {reward_id_list = rewardIdList}
  L_Net:sendMessage(MsgGenCode.CSProtoEntrustStarReward, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if not table.isEmpty(rspData.rewards) then
      local rewards = require("ui.manager.reward.rewardData").new()
      rewards.rewardShowType = L_Const.rewardShowType.full
      local data = L_DataUtil.parseRewardConfig(rspData.rewards, true, true)
      rewards:constructList(data)
      L_RewardManager:ShowReward(rewards)
    end
    if callback then
      callback()
    end
  end)
end

function this:req_CSProtoTeachStart(taskId, callback)
  local data = {u32 = taskId}
  L_Net:sendMessage(MsgGenCode.CSProtoTeachStart, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

function this:rsp_entrustInfo(data, errorCode)
  if data and data.data then
    for _, v in ipairs(data.data) do
      if not self.data.entrustInfo[v.entrust_id] then
        self.data.entrustInfo[v.entrust_id] = {star = 0, finish_time = 86400}
      end
      self.data.entrustInfo[v.entrust_id].entrust_star = v.entrust_star
      self.data.entrustInfo[v.entrust_id].success_time = v.success_time
    end
  end
  if data and data.infos then
    for _, v in ipairs(data.infos) do
      local entrust = _dungeonEntrustTpl:getTplByDungeonId(v.ins_id)
      if entrust then
        if not self.data.entrustInfo[entrust.id] then
          self.data.entrustInfo[entrust.id] = {entrust_star = 0, success_time = 1}
        end
        self.data.entrustInfo[entrust.id].star = v.ins_star
        self.data.entrustInfo[entrust.id].finish_time = v.success_time
      else
        print("委托数据同步：未获取到的配置数据" .. v.ins_id)
      end
    end
  end
  self:call(self.event.entrustInfoRefresh)
end

function this:rsp_entrustReward(data, errorCode)
  if not data or not data.data then
    return
  end
  for _, v in ipairs(data.data) do
    self.data.entrustReward[v.reward_id] = {}
    self.data.entrustReward[v.reward_id].reward_id = v.reward_id
    self.data.entrustReward[v.reward_id].reward_time = v.reward_time
  end
  self:call(self.event.entrustRewardRefresh)
end

function this:rsp_entrustKiboInfo(data, errorCode)
  if data and data.data then
    for _, v in ipairs(data.data) do
      if not self.data.entrustKiboInfo[v.kibo_dule_id] then
        self.data.entrustKiboInfo[v.kibo_dule_id] = {star = 0, finish_time = 86400}
      end
      self.data.entrustKiboInfo[v.kibo_dule_id].kibo_dule_id = v.kibo_dule_id
      self.data.entrustKiboInfo[v.kibo_dule_id].entrust_star = v.entrust_star
      self.data.entrustKiboInfo[v.kibo_dule_id].success_time = v.success_time
    end
  end
  if data and data.records then
    for _, v in ipairs(data.records) do
      if not self.data.entrustKiboInfo[v.id] then
        self.data.entrustKiboInfo[v.id] = {entrust_star = 0, success_time = 1}
      end
      self.data.entrustKiboInfo[v.id].kibo_dule_id = v.id
      self.data.entrustKiboInfo[v.id].star = v.star
      self.data.entrustKiboInfo[v.id].finish_time = v.success_time
    end
  end
  self:refershKiboData()
  self:call(self.event.entrustKiboInfoRefresh)
  if data and data.records then
    for _, v in ipairs(data.records) do
      local trainTaskTpl = L_GameTpl:getTrainTaskTpl()
      local trainTaskId = trainTaskTpl:getTaskIdByDungeonId(v.id)
      if trainTaskId and 0 < v.success_time then
        self.data.trainTaskRecord[trainTaskId] = true
      end
    end
  end
end

function this:rsp_syncTrainTaskCompletedData(data, errorCode)
  data = data or {}
  for i, v in pairs(data) do
    for _, v2 in ipairs(v) do
      self.data.trainTaskRecord[v2] = true
    end
  end
end

function this:req_enterMultiCoopLevel(levelId, callback)
  local data = {entrust_id = levelId}
  L_Net:sendMessage(MsgGenCode.CSProtoMultiCampaignCreate, data, function(rspData, errorCode)
    if 0 < errorCode then
      return
    end
    if callback then
      callback()
    end
  end)
end

function this:rsp_multiCoopInfo(data, errorCode)
  if not data or not data.data then
    return
  end
  for _, v in ipairs(data.data) do
    self.data.multiCoopInfo[v.entrust_id] = {}
    self.data.multiCoopInfo[v.entrust_id].entrust_rank = v.entrust_rank
    self.data.multiCoopInfo[v.entrust_id].entrust_score = v.entrust_score
    self.data.multiCoopInfo[v.entrust_id].success_time = v.success_time
  end
  self:call(self.event.entrustMultiCoopInfoRefresh)
end

function this:rsp_multiCoopReward(data, errorCode)
  if not data or not data.data then
    return
  end
  for _, v in ipairs(data.data) do
    self.data.multiCoopReward[v.reward_id] = {}
    self.data.multiCoopReward[v.reward_id].reward_id = v.reward_id
    self.data.multiCoopReward[v.reward_id].reward_time = v.reward_time
  end
  self:call(self.event.entrustMultiCoopRewardRefresh)
end

return this
