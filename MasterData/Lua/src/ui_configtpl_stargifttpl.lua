local this = class("stargiftTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getDec(tpl)
  return L_Config:provider(tpl.note)
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getAttribute(tpl)
  return tpl.attribute
end

function this:getAttributeAll(tpl)
  return tpl.attributeAll
end

function this:getId(tpl)
  return tpl.id
end

function this:getTexture(tpl)
  local texture = L_Config:getPathByHash(tpl.texture)
  return texture
end

function this:getClassIcon(tpl)
  local texture = L_Config:getPathByHash(tpl.classicon)
  return texture
end

return this
