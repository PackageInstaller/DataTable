local this = class("iconographyTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getRewardtype(tpl)
  return tpl.rewardtype
end

function this:getAbilities(tpl)
  return tpl.abilities
end

function this:getRewardpet(tpl)
  return tpl.rewardpet
end

function this:getId(tpl)
  return tpl.id
end

return this
