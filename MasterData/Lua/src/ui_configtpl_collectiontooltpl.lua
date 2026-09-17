local this = class("collectionToolTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRarity(tpl)
  return tpl.rarity
end

function this:getWay2desc(tpl)
  return tpl.way2desc
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getWeaponId(tpl)
  return tpl.weaponId
end

function this:getDropRate(tpl)
  return tpl.dropRate
end

function this:getDamage(tpl)
  return tpl.damage
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getEnduranceCost(tpl)
  return tpl.enduranceCost
end

function this:getWay3desc(tpl)
  return tpl.way3desc
end

function this:getWay1(tpl)
  return tpl.way1
end

function this:getWay3(tpl)
  return tpl.way3
end

function this:getSpecialDesc(tpl)
  return L_Config:provider(tpl.specialDesc)
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getEndurance(tpl)
  return tpl.endurance
end

function this:getTag(tpl)
  return tpl.tag
end

function this:getWay2(tpl)
  return tpl.way2
end

function this:getWay1desc(tpl)
  return L_Config:provider(tpl.way1desc)
end

function this:getTechnologyExp(tpl)
  return tpl.technologyExp
end

return this
