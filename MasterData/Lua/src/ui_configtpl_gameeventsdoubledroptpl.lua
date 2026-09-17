local this = class("gameEventsDoubleDropTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getEntrustTypeid(tpl)
  return tpl.entrustTypeid
end

function this:getMaterialTypeid(tpl)
  return tpl.materialTypeid
end

function this:getUpTime(tpl)
  return tpl.upTime
end

return this
