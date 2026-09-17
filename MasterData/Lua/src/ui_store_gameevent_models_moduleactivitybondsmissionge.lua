local this = class("moduleActivityBondsMissionGE", L_GameEventStore.baseGameEventCls)

function this:initData()
end

function this:populate(protoData)
end

function this:getData()
  return self.data
end

function this:SetRedState(show)
end

function this:getRedState()
  return false
end

return this
