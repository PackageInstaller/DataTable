local this = class("multiDungeonGroupTpl")

function this:init(config)
  self.data = config
end

function this:getTplById(id)
  return self.data[id]
end

function this:getDungeonGroupId(tpl)
  return tpl.dungeonGroupId
end

function this:getOpenTime(tpl)
  return tpl.openTime
end

function this:getCloseTime(tpl)
  return tpl.closeTime
end

function this:getOpenTplList()
  local res = {}
  for i, v in pairs(self.data) do
    local openTime = L_TimeUtil.getDateTimeStamp(self:getOpenTime(v))
    local closeTime = L_TimeUtil.getDateTimeStamp(self:getCloseTime(v))
    local nowTime = L_TimeUtil.getServerTime()
    if openTime <= nowTime and closeTime >= nowTime then
      table.insert(res, v)
    end
  end
  return res
end

return this
