local this = class("iconographyTaskTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

return this
