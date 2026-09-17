local this = class("gameActivityHeroTrialsGE", L_GameEventStore.baseGameEventCls)

function this:ctor(eventId, type, data)
  this.super.ctor(self, eventId, type, data)
end

function this:initData()
end

function this:dispose()
end

function this:getRedState()
  local gameEventData = L_GameEventStore:getGameEventData(self.id)
  if not gameEventData:IsConditionComplete() then
    return false
  end
  local dotKey = string.format("IsShowEvent_%d", self.id)
  if tonumber(L_CommonUtil.getLocalValue(dotKey)) == 0 then
    return true
  end
  for i, v in pairs(gameEventData:getRewardStateList()) do
    if v.reward_state == L_Const.ActivityRewardState.ARS_FINISH then
      return true
    end
  end
  return false
end

return this
