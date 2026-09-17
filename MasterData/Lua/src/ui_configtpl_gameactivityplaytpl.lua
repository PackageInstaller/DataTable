local this = class("gameActivityPlayTpl")

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

function this:getActivityId(tpl)
  return tpl.activityid
end

function this:getSortId(tpl)
  return tpl.sortId
end

function this:getIntroduce(tpl)
  return tpl.introduce
end

function this:getDungeonId(tpl)
  return tpl.dungeonId
end

function this:getTaskUnlock(tpl)
  return tpl.taskUnlock
end

function this:getAllData()
  return self.data
end

return this
