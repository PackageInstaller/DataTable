local this = class("gameActivityDoubleReward", L_GameEventStore.baseGameEventCls)
local _GameEventsDoubleDropTpl = L_GameTpl.getGameEventsDoubleDropTpl()
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this:initData()
  self.data.resetTime = 0
  self.data.remainCount = {
    [self.id] = 0
  }
end

function this:populate(protoData)
  local data = protoData.double_drop
  self.data.resetTime = data.reset_time
  if data.data then
    table.clear(self.data.remainCount)
    for _, doubleDropData in pairs(data.data) do
      self.data.remainCount[doubleDropData.id] = doubleDropData.times
    end
  else
    self.data.remainCount[self.id] = 0
  end
end

function this:getCount()
  local id, count = next(self.data.remainCount)
  local tpl = _GameEventsDoubleDropTpl:getTplById(id)
  local maxCount = tpl and _GameEventsDoubleDropTpl:getUpTime(tpl) or 0
  count = maxCount - (count or 0)
  return count, maxCount
end

function this:getLockState()
  local tpl = _GameEventTpl:getTplById(self.id)
  local conditions = _GameEventTpl:getCondition(tpl)
  for _, con in pairs(conditions) do
    if not L_ConditionManager:singleIsComplete(con) then
      return true
    end
  end
  return false
end

function this:getData()
  return self.data
end

function this:isActivityCompleted()
  local currentCount, maxCount = self:getCount()
  local str = string.empty
  if currentCount == 0 then
    str = "活动完成"
  else
    str = "活动未完成"
  end
  return currentCount == 0
end

function this:SetRedState(show)
end

function this:getRedState()
  return L_ReddotManager:haveDailyNew(L_ReddotManager.DotDef.GameAct_EventsInCenter, self.id) and not self:isUnlock()
end

function this:isUnlock()
  local lock = false
  local _GameEventTpl = L_GameTpl:getGameEventsTpl()
  local tpl = _GameEventTpl:getTplById(self.id)
  local conditions = _GameEventTpl:getCondition(tpl)
  for i, con in pairs(conditions) do
    if not L_ConditionManager:singleIsComplete(con) then
      lock = true
    end
  end
  return lock
end

return this
