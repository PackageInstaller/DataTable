local this = class("rouletteTabTpl")

function this:init(config)
  self.data = config
end

function this:getConfig()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getType(tpl)
  return tpl.type
end

function this:getIcon(tpl)
  return tpl.icon
end

return this
