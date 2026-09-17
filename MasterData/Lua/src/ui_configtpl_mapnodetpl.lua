local this = class("mapNodeTpl")

function this:init(config)
  self.data = config
  self.dataArray = table.toArray(config)
end

function this:getAllData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getIcon(tpl)
  local icon = L_Config:getPathByHash(tpl.icon)
  return icon
end

function this:getIconBig(tpl)
  local icon = L_Config:getPathByHash(tpl.iconBig)
  return icon
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getArray()
  return self.dataArray
end

return this
