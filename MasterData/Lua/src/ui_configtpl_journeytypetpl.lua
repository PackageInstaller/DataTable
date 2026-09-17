local this = class("journeyTypeTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getNameById(id)
  if self.data[id] then
    return L_Config:provider(self.data[id].name)
  end
  return nil
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getUnlockCondition(tpl)
  return tpl.unlockCondition
end

function this:getOrder(tpl)
  return tpl.order
end

return this
