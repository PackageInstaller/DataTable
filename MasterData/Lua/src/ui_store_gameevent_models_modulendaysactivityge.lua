local this = class("moduleNDaysActivityGE", L_GameEventStore.baseGameEventCls)

function this:initData()
end

function this:populate(protoData)
  local data
end

function this:getData()
  return self.data
end

function this:SetRedState(show)
end

function this:getRedState()
  return C_NDaysActivityStore.GetInstance():HasRewardAnyDay()
end

function this:isActivityCompleted()
  local result = C_NDaysActivityStore.GetInstance():HasAllComplete()
  return result
end

function this:isActivityCompletedNeedEnd()
  return self:isActivityCompleted()
end

return this
