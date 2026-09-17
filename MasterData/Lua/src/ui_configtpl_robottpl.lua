local this = class("robotTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getLv(tpl)
  return tpl.lv
end

function this:getStageid(tpl)
  return tpl.stageid
end

function this:getHeroid(tpl)
  return tpl.heroid
end

function this:getCombat(tpl)
  return tpl.combat
end

function this:getId(tpl)
  return tpl.id
end

function this:getType(tpl)
  return tpl.type
end

function this:getRobotlv(tpl)
  return tpl.robotlv
end

return this
