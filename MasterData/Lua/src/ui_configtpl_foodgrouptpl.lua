local this = class("foodGroupTpl")

function this:init(config)
  self.data = config
end

function this:getConfig()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getName(tpl)
  return L_Lang:get(tpl.name)
end

function this:getFoodType(tpl)
  return tpl.foodType
end

function this:getId(tpl)
  return tpl.id
end

function this:getTimesLimit(tpl)
  return tpl.timesLimit
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getIsNeedPet(tpl)
  return tpl.isNeedPet
end

function this:getUnlockLevel(tpl)
  return tpl.unlockLevel
end

return this
