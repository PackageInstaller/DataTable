local this = class("journeyTaskTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getTplByTaskId(taskId)
  for k, v in pairs(self.data) do
    if v.taskId == taskId then
      return v
    end
  end
  return nil
end

function this:getTitle(tpl)
  return L_Config:provider(tpl.title)
end

function this:getTypeId(tpl)
  return tpl.typeId
end

function this:getPic(tpl)
  return tpl.pic
end

return this
