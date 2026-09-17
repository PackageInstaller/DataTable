local this = class("situationData_stamp")

function this:ctor()
  self.class = nil
  self.configId = nil
  self.pos = nil
  self.index = nil
  self.scale = nil
end

function this:deserialize(data)
  self.configId = data.configId
  self.pos = data.pos
  self.index = data.index
  self.scale = data.scale
end

return this
