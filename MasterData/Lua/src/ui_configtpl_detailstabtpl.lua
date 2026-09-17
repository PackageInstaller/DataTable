local this = class("detailsTabTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTabName(tpl)
  return L_Config:provider(tpl.tabName)
end

return this
