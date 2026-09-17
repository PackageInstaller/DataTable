local this = class("situationData_obj")

function this:ctor()
  self.class = nil
  self.configId = nil
  self.pos = nil
  self.rot = nil
end

function this:deserialize(data)
  self.configId = data.configId
  self.pos = data.pos
  self.rot = data.rot
end

return this
