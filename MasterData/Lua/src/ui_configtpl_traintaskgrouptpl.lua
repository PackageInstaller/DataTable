local this = class("trainTaskGroupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTrainTaskName(tpl)
  return L_Config:provider(tpl.trainTaskName)
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getImgPath(tpl)
  return tpl.imgPath
end

function this:getTaskId(tpl)
  return tpl.taskId
end

return this
