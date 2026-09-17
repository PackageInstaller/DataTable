local this = class("homeRanchTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getMaxLv()
  return #self.data
end

function this:getPetProductLimit(tpl)
  return tpl.petProductLimit
end

function this:getUpgradeCondition(tpl)
  return tpl.upgradeCondition
end

function this:getPetLimit(tpl)
  return tpl.petLimit
end

function this:getPetProductLimit(tpl)
  return tpl.petProductLimit
end

function this:getStorageLimit(tpl)
  return tpl.storageLimit
end

function this:getCost(tpl)
  return tpl.cost
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getUpgradeDesc(tpl)
  return tpl.upgradeDesc
end

return this
