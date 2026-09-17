local this = class("situationData_pet")

function this:ctor()
  self.class = nil
  self.petGuid = nil
  self.petConfigId = nil
  self.specialParam = nil
  self.flashParam = nil
  self.pos = nil
  self.rot = nil
  self.actionId = nil
  self.faceId = nil
  self.actionTime = nil
  self.skinId = nil
  self.starColorId = nil
end

function this:deserialize(data)
  self.petGuid = data.petGuid
  self.petConfigId = data.petConfigId
  self.specialParam = data.specialParam
  self.flashParam = data.flashParam
  self.pos = data.pos
  self.rot = data.rot
  self.actionId = data.actionId
  self.faceId = data.faceId
  self.skinId = data.skinId
  self.starColorId = data.starColorId
end

return this
