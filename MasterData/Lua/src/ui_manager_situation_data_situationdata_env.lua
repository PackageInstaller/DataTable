local this = class("situationData_env")

function this:ctor()
  self.class = nil
  self.configId = nil
end

function this:deserialize(data)
  self.configId = data.configId
end

return this
