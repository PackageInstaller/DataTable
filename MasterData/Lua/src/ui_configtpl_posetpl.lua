local this = class("poseTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getType(tpl)
  return tpl.type
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getAnimname(tpl)
  return tpl.animname
end

function this:getTexture(tpl)
  local texture = L_Config:getPathByHash(tpl.texture)
  return texture
end

function this:getMultiaction(tpl)
  return tpl.multiaction
end

function this:getMultiactionPosition(tpl)
  return tpl.multiactionposition
end

return this
