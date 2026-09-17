local this = class("mountSaddleTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDefaultSaddle(tpl)
  return tpl.defaultSaddle
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getDefaultID(tpl)
  return tpl.defaultID
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getSpecialDesc(tpl)
  return L_Config:provider(tpl.specialDesc)
end

function this:getId(tpl)
  return tpl.id
end

return this
