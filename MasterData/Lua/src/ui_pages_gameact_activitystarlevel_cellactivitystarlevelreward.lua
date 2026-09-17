local this = class("cellActivityStarLevelReward", G_UIModuleBase)

function this.bind()
  return {
    txt_level = "",
    txt_receive_level = "",
    txt_finish_level = "",
    cellIcon_reward = {
      moduleName = "modulePages/cellIconBag"
    },
    go_reward = false,
    go_process = false,
    go_receive = false,
    go_finish = false
  }
end

function this.methods()
  return {
    onClick_Reward = function(self)
      local tmp_list = {}
      table.insert(tmp_list, self.bind.reward_id)
      L_GameEventStore:req_CsProtoActivityReward(self.bind.reward_group_id, self.bind.canRewardIdList, function(data)
        local rewards = require("ui.manager.reward.rewardData").new()
        rewards.rewardShowType = L_Const.rewardShowType.full
        local data = L_DataUtil.parseRewardConfig(data.rewards, true, true)
        rewards:constructList(data)
        L_RewardManager:ShowReward(rewards)
        L_EntrustStore:call(L_EntrustStore.event.entrustRewardRefresh)
        self.bind.refreshPageFunc()
      end)
    end
  }
end

function this:open()
  local gameEventRewardTpl = L_GameTpl:getGameEventsRewardTpl()
  local tpl = gameEventRewardTpl:getTplById(self.bind.reward_id)
  local reward_list = gameEventRewardTpl:getRewardShow(tpl)
  local level = gameEventRewardTpl:getPara(tpl)
  self.bind.txt_level = tostring(level)
  self.bind.txt_receive_level = tostring(level)
  self.bind.txt_finish_level = tostring(level)
  if self.bind.reward_state == L_Const.ActivityRewardState.ARS_REWARDED then
    for _, reward in ipairs(reward_list) do
      reward.isReceived = true
    end
  end
  self.bind.cellIcon_reward:clear()
  self.bind.cellIcon_reward:insert_array(reward_list)
  self:refreshBg(self.bind.reward_state)
  self.bind.go_reward = self.bind.reward_state == L_Const.ActivityRewardState.ARS_FINISH
end

function this:close()
  self.isInit = false
end

function this:refresh()
  local gameEventRewardTpl = L_GameTpl:getGameEventsRewardTpl()
  local tpl = gameEventRewardTpl:getTplById(self.bind.reward_id)
  local reward_list = gameEventRewardTpl:getRewardShow(tpl)
  if self.bind.reward_state == L_Const.ActivityRewardState.ARS_REWARDED then
    for _, reward in ipairs(reward_list) do
      reward.isReceived = true
    end
  end
  self:refreshBg(self.bind.reward_state)
  self.bind.go_reward = self.bind.reward_state == L_Const.ActivityRewardState.ARS_FINISH
  for i = 1, #reward_list do
    self.bind.cellIcon_reward:change(i, reward_list[i])
  end
end

function this:refreshBg(state)
  if state == L_Const.ActivityRewardState.ARS_NONE then
    self.bind.go_process = true
    self.bind.go_receive = false
    self.bind.go_finish = false
  elseif state == L_Const.ActivityRewardState.ARS_REWARDED then
    self.bind.go_process = false
    self.bind.go_receive = false
    self.bind.go_finish = true
  elseif state == L_Const.ActivityRewardState.ARS_FINISH then
    self.bind.go_process = false
    self.bind.go_receive = true
    self.bind.go_finish = false
  end
end

return this
