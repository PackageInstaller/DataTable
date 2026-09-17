local this = class("gameActivityTravelLogGE", L_GameEventStore.baseGameEventCls)

function this:initData()
end

function this:populate(protoData)
end

function this:getData()
  return self.data
end

function this:SetRedState(show)
end

function this:isActivityCompleted()
  return AzurWorld.JourneyMgr:AllRewardComplete()
end

function this:getRedState()
  return false
end

return this
