local this = class("moduleGameActivityKiboTravelGE", L_GameEventStore.baseGameEventCls)
local gameConstTpl = L_GameTpl:getGameConstTpl()

function this:initData()
  self._info = {}
end

function this:populate(protoData)
  self._info = protoData.tour_group or L_Const.emptyTable
end

function this:getData()
  return self.data
end

function this:GetMaxTravelCount()
  local value = gameConstTpl:getData("GAME_EVENT_KIBO_TOUR_TOTAL_NUM", L_Const.GameTplType.int) or 10
  return value
end

function this:GetMaxSameTravelCount()
  local value = gameConstTpl:getData("GAME_EVENT_KIBO_TOUR_SAME_TIME_NUM", L_Const.GameTplType.int) or 1
  return value
end

function this:GetTravelList()
  return self._info.tour_data or L_Const.emptyTable
end

function this:GetTotalTimes()
  local count = self._info.total_times or 0
  count = count + #self:GetTravelList()
  return count
end

function this:getTravelState(cid)
  for _, data in pairs(self:GetTravelList()) do
    if data.tour_id == cid then
      return data.state
    end
  end
  return -1
end

function this:isTravelRuning(cid)
  local state = self:getTravelState(cid)
  if state == L_Const.ActivityRewardState.ARS_NONE or state == L_Const.ActivityRewardState.ARS_FINISH then
    return true
  end
  return false
end

function this:getRedState()
  local gameEventData = L_GameEventStore:getGameEventData(self.id)
  if gameEventData:IsConditionComplete() then
    if self:hasCanDispatchCount() then
      return true
    end
    if self:hasAnyRewardNewData() then
      return true
    end
  end
  return false
end

function this:hasCanDispatchCount()
  if self:GetTotalTimes() < self:GetMaxTravelCount() and #self:GetTravelList() < self:GetMaxSameTravelCount() then
    return true
  end
  return false
end

function this:hasAnyRewardNewData()
  local list = self:GetTravelList()
  for _, data in pairs(list) do
    if self:hasRewardNewData(data.tour_id) then
      return true
    end
  end
end

function this:hasRewardNewData(cid)
  local state = self:getTravelState(cid)
  if state == L_Const.ActivityRewardState.ARS_FINISH then
    return true
  end
end

return this
