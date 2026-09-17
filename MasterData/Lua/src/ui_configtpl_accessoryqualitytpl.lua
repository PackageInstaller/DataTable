local this = class("accessoryQualityTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getNameByTpl(tpl)
  return L_Config:provider(tpl.name)
end

function this:getValueByTpl(tpl)
  return tpl.value
end

function this:getMaxQuality()
  return self.data[#self.data].id
end

return this
