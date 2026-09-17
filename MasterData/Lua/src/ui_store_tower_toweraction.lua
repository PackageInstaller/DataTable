local this = {}

function this:req_towerScoreReward(rewardId, callback)
  local data = {u32 = rewardId}
  L_Net:sendMessage(MsgGenCode.CSProtoTowerScoreReward, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local rewards = rspData.rewards
      if not table.isEmpty(rewards) then
        L_RewardManager:showPage(rewards, rspData.src)
      end
      table.insert(self.data.scoreRewardRecord, rewardId)
      if callback then
        callback(rspData)
      end
      self:call(self.event.refreshTowerScoreReward)
    end
  end)
end

function this:rsp_towerSync(rspMsg)
  self.data.towerId = rspMsg.tower_id
  self.data.towerTime = rspMsg.tower_time
  self.data.firstRewardRecord = rspMsg.first_reward_record or {}
  self:call(self.event.refreshTowerData)
end

function this:rsp_towerScoreSync(rspMsg)
  self.data.score = rspMsg.cur_score
  self.data.scoreTime = rspMsg.score_time
  self.data.scoreRewardRecord = rspMsg.score_reward_record or {}
  self:call(self.event.refreshTowerScore)
end

return this
