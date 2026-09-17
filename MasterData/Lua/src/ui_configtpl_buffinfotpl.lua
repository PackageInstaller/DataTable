local this = class("buffInfoTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getNote(tpl)
  return tpl.note
end

function this:getTimes(tpl)
  return tpl.times
end

function this:getStages(tpl)
  return tpl.stages
end

function this:getType(tpl)
  return tpl.type
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.unitId)
  return icon
end

function this:getSpecialIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.SpecialIcon)
  return icon
end

function this:getAttrIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.attrIcon)
  return icon
end

function this:getDisplayPriority(tpl)
  return tpl.displaypriority
end

return this
