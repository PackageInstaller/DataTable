local this = class("chargeSatietyTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getId2IntervalDic()
  local id2IntervalDic = {}
  for id, tpl in pairs(self.data) do
    local interval = tpl.interval
    id2IntervalDic[id] = interval
  end
  return id2IntervalDic
end

function this:getId2IntervalMin(tpl)
  return tpl.interval[1]
end

function this:getId2IntervalMax(tpl)
  return tpl.interval[2]
end

function this:getAmplitudeById(id)
  return self.data[id].amplitude
end

return this
