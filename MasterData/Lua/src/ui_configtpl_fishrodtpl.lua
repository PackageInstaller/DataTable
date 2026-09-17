local this = class("fishRodTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getFishRodName(tpl)
  return L_Config:provider(tpl.fishRodName)
end

function this:getFishRodMod(tpl)
  return L_Config:getPathByHash(tpl.fishRodMod)
end

function this:getDescription(tpl)
  return L_Config:provider(tpl.description)
end

function this:getId(tpl)
  return tpl.id
end

function this:getStrengthNum(tpl)
  return tpl.strengthNum
end

function this:getWeaponId(tpl)
  return tpl.weaponId
end

function this:getIcon(tpl)
  return tpl.iconMain
end

function this:getBuffInfo(tpl)
  return tpl.buffInfo
end

return this
