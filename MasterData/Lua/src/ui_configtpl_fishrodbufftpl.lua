local this = class("fishRodBuffTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getIconDark(tpl)
  return tpl.icon[1]
end

function this:getIconLight(tpl)
  return tpl.icon[2]
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getPondId(tpl)
  return tpl.pondId
end

return this
