local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    fishHandbooks = {},
    fishEventHandbooks = {},
    fishPointList = {},
    rodId = nil,
    baitId = nil,
    fishFinish = require(L_R.store .. "fishing.data.fishFinish").new()
  }
end

function this:getFishHandbooks()
  return self.data.fishHandbooks
end

function this:getFishEventHandbooks()
  return self.data.fishEventHandbooks
end

function this:getFishPointList()
  return self.data.fishPointList
end

function this:getCurRodId()
  return self.data.rodId
end

function this:getCurBaitId()
  return self.data.baitId
end

function this:getFishFinish()
  return self.data.fishFinish
end

function this:getFishHandbook(fishId, isCreate)
  local fishList = self:getFishHandbooks()
  local entity = fishList[fishId]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "fishing.data.fishHandbook").new()
    fishList[fishId] = entity
    entity.item_id = fishId
  end
  return entity
end

function this:getFishEventHandbook(eventId, isCreate)
  local events = self:getFishEventHandbooks()
  local entity = events[eventId]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "fishing.data.fishEventHandbook").new()
    events[eventId] = entity
    entity.item_id = eventId
  end
  return entity
end

function this:getFishPoint(fishPointId, isCreate)
  local fishPointList = self:getFishPointList()
  local entity = fishPointList[fishPointId]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "fishing.data.fishPoint").new()
    fishPointList[fishPointId] = entity
    entity.pond_id = fishPointId
  end
  return entity
end

return this
