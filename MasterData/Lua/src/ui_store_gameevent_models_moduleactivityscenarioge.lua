local this = class("moduleActivityScenarioGE", L_GameEventStore.baseGameEventCls)
local _viewedLocalKeyFmt = "ScenarioPreTask_Viewed_%s"

local function getViewedLocalKey(id)
  return string.format(_viewedLocalKeyFmt, tostring(id))
end

local function hasViewedPreTask(id)
  return tonumber(L_CommonUtil.getLocalValue(getViewedLocalKey(id))) == 1
end

local function markViewedPreTask(id)
  L_CommonUtil.setLocalValue(getViewedLocalKey(id), "1")
end

function this:needPreTaskReddot()
  local gameEventData = L_GameEventStore:getGameEventData(self.id)
  if not gameEventData or not gameEventData:canParticipateIn() then
    return false
  end
  if not hasViewedPreTask(self.id) then
    return true
  end
  return false
end

function this:clearScenarioPreTaskReddot()
  markViewedPreTask(self.id)
  L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_New, self.id)
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_EventsInCenter, true)
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_Single_New, true)
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_Scenario_PreTask, true)
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_New, true)
  AzurWorld.RedDotMgr:MarkDirty(string.format("GameAct_Events_%d", self.id))
  L_GameEventStore:forceRefreshDot()
end

function this:checkRedDot()
  return self:needPreTaskReddot()
end

function this:getRedState()
  return self:needPreTaskReddot()
end

return this
