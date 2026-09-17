local this = class("pamiLetterListTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTaskId(tpl)
  return tpl.taskId
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getType(tpl)
  return tpl.type
end

function this:getId(tpl)
  return tpl.id
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getTitle(tpl)
  return tpl.title
end

return this
