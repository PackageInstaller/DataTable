local this = class("homeTechnologyTabTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTabSubclass(tpl)
  return tpl.tabSubclass
end

function this:getTabName(tpl)
  return L_Config:provider(tpl.tabName)
end

function this:getTabCategory(tpl)
  return tpl.tabCategory
end

return this
