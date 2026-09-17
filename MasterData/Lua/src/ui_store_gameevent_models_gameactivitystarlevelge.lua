local this = class("gameActivityStarLevelGE", L_GameEventStore.baseGameEventCls)

function this:initData()
end

function this:populate()
end

function this:isActivityCompleted()
  local reward_state_list = L_GameEventStore:getGameEventData(self.id):getRewardStateList()
  local res = true
  if reward_state_list then
    for _, reward in pairs(reward_state_list) do
      if reward.reward_state ~= L_Const.ActivityRewardState.ARS_REWARDED then
        res = false
        break
      end
    end
  end
  return res
end

function this:getRedState()
  local activity_id = self.id
  local reward_list = L_GameEventStore:getGameEventData(activity_id):getRewardStateList()
  local res = false
  for _, iter in ipairs(reward_list) do
    if iter.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      res = true
      break
    end
  end
  return res
end

function this:getData()
  return self.data
end

return this
