local this = class("activityTabTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTabNameByTableId(tableId)
  return L_Config:provider(self.data[tableId].name)
end

function this:getSystemIdByTableId(tableId)
  return self.data[tableId].systemId
end

return this
