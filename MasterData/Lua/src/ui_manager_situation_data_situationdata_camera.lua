local this = class("situationData_camera")

function this:ctor()
  self.class = nil
  self.pos = nil
  self.targetPos = nil
end

function this:deserialize(data)
  self.pos = data.pos
  self.targetPos = data.targetPos
end

return this
