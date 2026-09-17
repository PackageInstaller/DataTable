local this = class("moduleActivityPartyGE", L_GameEventStore.baseGameEventCls)

function this:initData()
  self.data.score = 0
  self.data.scoreLimit = 0
  self.data.showRed = false
end

function this:populate(protoData)
  local data
  if protoData then
    data = protoData.popper_party or protoData.popperParty
  end
  if data then
    self.data.score = tonumber(data.score) or self.data.score
    self.data.scoreLimit = tonumber(data.score_limit) or tonumber(data.scoreLimit) or self.data.scoreLimit
  end
  
  function self.data.SetRedState(show)
    self.data.showRed = show
  end
end

function this:getData()
  return self.data
end

function this:SetRedState(show)
  self.data.showRed = show
end

function this:getRedState()
  return self.data.showRed
end

return this
