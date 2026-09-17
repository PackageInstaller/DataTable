local this = class("commonTabTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTeamId(tpl)
  return tpl.teamId
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getIcon(tpl)
  return tpl.icon
end

function this:getIconSmall(tpl)
  return tpl.iconSmall
end

function this:getProductBuild(tpl)
  return L_Config:provider(tpl.productBuild)
end

function this:getId(tpl)
  return tpl.id
end

function this:getColor(tpl)
  return tpl.color
end

function this:getValue(tpl)
  return tpl.value
end

return this
