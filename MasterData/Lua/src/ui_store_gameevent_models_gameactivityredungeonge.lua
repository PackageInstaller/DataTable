local this = class("gameActivityRedungeonGE", L_GameEventStore.baseGameEventCls)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()

function this:ctor(eventId, type, data)
  this.super.ctor(self, eventId, type, data)
end

function this:initData()
  self.data = {
    state = L_Const.ActivityTaskState.KDT_NONE
  }
end

function this:dispose()
end

function this:populate(protoData)
end

function this:isActivityCompleted()
  return false
end

function this:getRedState()
  local gameEventData = L_GameEventStore:getGameEventData(self.id)
  if not gameEventData:IsConditionComplete() then
    return false
  end
  local dotKey = string.format("IsShowEvent_%d", self.id)
  if tonumber(L_CommonUtil.getLocalValue(dotKey)) == 0 then
    return true
  end
  return false
end

function this:checkIsCompletById(id)
  if self.data.data_list[id] then
    return self.data.data_list[id].state == "CS_FINISH" or self.data.data_list[id].state == L_Const.CommonState.CS_FINISH
  end
  return false
end

return this
