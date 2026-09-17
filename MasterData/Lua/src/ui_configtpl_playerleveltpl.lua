local this = class("playerLevelTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getExp(tpl)
  return tpl.exp
end

function this:getCost(tpl)
  return tpl.cost
end

function this:getStamina(tpl)
  return tpl.stamina
end

function this:getMaxLevel()
  return self.data[#self.data].id
end

function this:getMinLevel()
  return self.data[1].id
end

function this:getCharge(tpl)
  return tpl.charge
end

function this:getLevelReward(tpl)
  return tpl.reward
end

return this
