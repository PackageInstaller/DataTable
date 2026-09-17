local this = class("worldObjTemplateTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getWanderSpeed(tpl)
  return tpl.wanderSpeed
end

function this:getWanderInterval(tpl)
  return tpl.wanderInterval
end

function this:getMoveToTargetAnim(tpl)
  return tpl.moveToTargetAnim
end

function this:getMoveToTargetSpeed(tpl)
  return tpl.moveToTargetSpeed
end

function this:getWanderRadius(tpl)
  return tpl.wanderRadius
end

function this:getChaseAnim(tpl)
  return tpl.chaseAnim
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getChaseSpeed(tpl)
  return tpl.chaseSpeed
end

function this:getChaseRadius(tpl)
  return tpl.chaseRadius
end

function this:getId(tpl)
  return tpl.id
end

function this:getWanderAnim(tpl)
  return tpl.wanderAnim
end

function this:getScale(tpl)
  return tpl.scale
end

return this
