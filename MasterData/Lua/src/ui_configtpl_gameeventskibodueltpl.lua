local this = class("gameEventsKiboDuelTpl")

function this:init(config)
  self.data = config
end

function this:getData()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId(tpl)
  return tpl.id
end

function this:getBuffDesc(tpl)
  return L_Config:provider(tpl.buffDesc)
end

function this:getGroupId(tpl)
  return tpl.groupId
end

function this:getKiboDuelId(tpl)
  return tpl.kiboDuelId
end

function this:getUnlockTime(tpl)
  return tpl.unlockTime
end

function this:getExId(tpl)
  return tpl.exId
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getLevel(tpl)
  return tpl.level
end

function this:getBuff(tpl)
  return tpl.buff
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

return this
