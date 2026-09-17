local this = class("battleTagTpl")

function this:init(config)
  self.data = config
end

function this:getValue()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getType(tpl)
  return tpl.type
end

function this:getTitle(tpl)
  return L_Config:provider(tpl.title)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getColor(tpl)
  return tpl.color
end

function this:getIcon(tpl)
  return tpl.battle
end

return this
