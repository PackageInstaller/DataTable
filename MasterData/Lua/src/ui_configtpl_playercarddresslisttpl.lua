local this = class("playercardDressListTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTeam(tpl)
  return tpl.team
end

function this:getShow(tpl)
  return tpl.show
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getOrder(tpl)
  return tpl.order
end

return this
