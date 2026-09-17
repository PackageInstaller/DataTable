local this = class("photographGroupTpl")

function this:init(config)
  self.data = config
end

function this:getConfig()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getShow(tpl)
  return tpl.show == 1
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getType(tpl)
  return tpl.type
end

function this:getTabIcon(tpl)
  return tpl.tabIcon
end

return this
