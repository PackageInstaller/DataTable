local this = class("kiboDuelTaskTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTask(tpl)
  return L_Config:provider(tpl.task)
end

function this:getId(tpl)
  return tpl.id
end

function this:getCompletionTimes(tpl)
  return tpl.completionTimes
end

return this
