local this = class("situationTabTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAreaId(tpl)
  return tpl.areaId
end

function this:getTabIcon(tpl)
  return tpl.tabIcon
end

function this:getNumber(tpl)
  return tpl.number
end

function this:getTabName(tpl)
  return L_Config:provider(tpl.tabName)
end

function this:getTabId(tpl)
  return tpl.tabId
end

return this
