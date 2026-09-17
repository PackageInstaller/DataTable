local this = class("pamiTalkTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getWeight(tpl)
  return tpl.weight
end

function this:getText(tpl)
  return tpl.text
end

function this:getDesc(tpl)
  return tpl.desc
end

function this:getOrder(tpl)
  return tpl.order
end

function this:getEndTime(tpl)
  return tpl.endTime
end

function this:getType(tpl)
  return tpl.type
end

function this:getStartTime(tpl)
  return tpl.startTime
end

function this:getId(tpl)
  return tpl.id
end

return this
