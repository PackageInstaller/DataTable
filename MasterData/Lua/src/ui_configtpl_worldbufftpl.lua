local this = class("worldBuffTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getBuffIcon(tpl)
  return tpl.buffIcon
end

function this:getName(tpl)
  return L_Lang:get(tpl.name)
end

function this:getBuffInfos(tpl)
  return tpl.buffId, tpl.buffParams, tpl.condition
end

function this:getDurationInfo(tpl)
  return tpl.duration_type, tpl.duration
end

function this:getPriortyInfo(tpl)
  return tpl.group, tpl.priority
end

function this:getBuffElementId(tpl)
  return tpl.buffElementId
end

return this
