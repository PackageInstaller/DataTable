local this = class("commonItemTypeIconTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTabId(tpl)
  return tpl.tabId
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

return this
