local this = class("commonWorldRepairTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDesc(tpl)
  return tpl.desc
end

function this:getId(tpl)
  return tpl.id
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getCost(tpl)
  return tpl.cost
end

return this
