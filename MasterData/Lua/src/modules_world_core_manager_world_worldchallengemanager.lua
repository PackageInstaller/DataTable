local this = class("worldChallengeManager", G_EventManagerBase)
local CHALLENGEPOINTPATH = "UI/Pages/Main/challengePointItem.prefab"
this.event = {
  generateChallengePoint = "generateChallengePoint",
  disposeChallengePoint = "disposeChallengePoint"
}

function this:ctor()
  this.super.ctor(self)
  self.challengeEntityList = {}
end

function this:generateChallengePoint(data)
  self:sendEvent(this.event.generateChallengePoint, data)
  if self.challengeEntityList ~= nil and self.challengeEntityList[data.entity.data.entityId] == nil then
    self.challengeEntityList[data.entity.data.entityId] = data
  end
end

function this:disposeChallengePoint(data)
  self:sendEvent(this.event.disposeChallengePoint, data)
  if self.challengeEntityList ~= nil and self.challengeEntityList[data.entity.data.entityId] ~= nil then
    self.challengeEntityList[data.entity.data.entityId] = nil
  end
end

function this:getChallengePointList()
  return self.challengeEntityList or {}
end

function this:dispose(callback)
  self.challengeEntityList = nil
  self.challengeEntityList = {}
end

return this
