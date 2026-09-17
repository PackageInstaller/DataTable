local this = class("gameActTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getValue(tpl)
  return tpl.value
end

function this:getName(tpl)
  return L_Config:provider(tpl.name)
end

function this:getSort(tpl)
  return tpl.sort
end

function this:getJoinStart(tpl)
  return tpl.joinStart
end

function this:getId(tpl)
  return tpl.id
end

function this:getCondition(tpl)
  return tpl.condition
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getJoinDuration(tpl)
  return tpl.joinDuration
end

function this:getType(tpl)
  return tpl.type
end

function this:getTimeType(tpl)
  return tpl.timeType
end

function this:getAllData()
  return self.data
end

return this
