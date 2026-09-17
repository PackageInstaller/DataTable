local this = class("worldInteractTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getInteractCond(tpl)
  return tpl.interactCond
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getDesc(tpl)
  return tpl.desc
end

function this:getId(tpl)
  return tpl.id
end

function this:getInteractSE(tpl)
  return tpl.interactSE
end

return this
