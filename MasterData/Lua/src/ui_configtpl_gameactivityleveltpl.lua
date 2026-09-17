local this = class("gameActivityLevelTpl")

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

function this:getGroupId(tpl)
  return tpl.groupid
end

function this:getDifficulty(tpl)
  return tpl.difficulty
end

function this:getDungeonId(tpl)
  return tpl.dungeonId
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getDungeonTarget(tpl)
  return tpl.dungeonTarget
end

function this:getTrialrole(tpl)
  return tpl.trialrole
end

function this:getStamina(tpl)
  return tpl.stamina
end

function this:getTaskUnlock(tpl)
  return tpl.taskUnlock
end

function this:getStartTimeNum(tpl)
  return tpl.starttimenum
end

function this:getAllData()
  return self.data
end

return this
