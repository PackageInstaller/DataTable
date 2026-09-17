local this = class("situationData_hero")

function this:ctor()
  self.class = nil
  self.heroConfigId = nil
  self.clothingId = nil
  self.pos = nil
  self.rot = nil
  self.actionId = nil
  self.faceId = nil
  self.actionTime = nil
end

function this:deserialize(data)
  self.heroConfigId = data.heroConfigId
  self.clothingId = data.clothingId
  self.pos = data.pos
  self.rot = data.rot
  self.actionId = data.actionId
  self.faceId = data.faceId
end

return this
