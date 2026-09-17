local this = class("gameEventsDayAttendanceTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getEventConfigDataByEventId(eventId)
  local configData = {}
  local eventTplIds = self:getEventTplIdsByEventId(eventId)
  for _, eventTplId in ipairs(eventTplIds) do
    local tmp = {}
    local tpl = self:getTplById(eventTplId)
    tmp.tplId = eventTplId
    tmp.reward = self:getReward(tpl)
    tmp.date = self:getDate(tpl)
    configData[tmp.date] = tmp
  end
  return configData
end

function this:getEventTplIdsByEventId(eventId)
  local result = {}
  for tplId, tpl in pairs(self.data) do
    local tplEventId = tpl.eventId
    if tplEventId == eventId then
      table.insert(result, tplId)
    end
  end
  table.sort(result, function(leftEventId, rightEventId)
    local leftDate = self:getDate(self:getTplById(leftEventId))
    local rightDate = self:getDate(self:getTplById(rightEventId))
    return leftDate < rightDate
  end)
  return result
end

function this:getReward(tpl)
  return tpl.reward
end

function this:getDate(tpl)
  return tpl.date
end

return this
