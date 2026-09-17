local this = class("rarityTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return tpl.name
end

function this:getColor(tpl)
  return tpl.colorAst
end

function this:getId(tpl)
  return tpl.id
end

function this:getIconByType(quality, type)
  local tpl = self.data[quality]
  return tpl.frameIcon[type]
end

function this:getColorCircle(tpl)
  return tpl.colorCircle
end

function this:getEquipmentColorAst(tpl)
  return tpl.EquipmentColorAst
end

function this:getRarityName(tpl)
  return L_Config:provider(tpl.rarityName)
end

return this
