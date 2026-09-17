local this = class("moduleXiaoYuActivityEntranceGE", L_GameEventStore.baseGameEventCls)
local _GameEventStore = L_GameEventStore
local _showNewReddotDays = 3
local _clickedLocalKeyFmt = "XiaoYuActEntrance_Clicked_%s"

local function getDayRefreshOffset()
  local refreshHour = tonumber(L_GameConstTpl:getData("DAILY_REFRESH_TIME", L_Const.GameTplType.int)) or 0
  return refreshHour * 3600
end

local function getClickedLocalKey(id)
  return string.format(_clickedLocalKeyFmt, tostring(id))
end

local function hasEverClicked(id)
  return tonumber(L_CommonUtil.getLocalValue(getClickedLocalKey(id))) == 1
end

local function markEverClicked(id)
  L_CommonUtil.setLocalValue(getClickedLocalKey(id), "1")
end

local function refreshRelatedReddotNodes()
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_EventsInCenter, true)
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_Single_New, true)
end

function this:initData()
  self._info = {
    task_list = L_Const.emptyTable
  }
end

function this:populate(protoData)
  local data
  if protoData then
    data = protoData.jade_web_game or protoData.jadeWebGame
  end
  self._info = {
    task_list = data and (data.task_list or data.taskLists) or L_Const.emptyTable
  }
end

function this:getData()
  return self._info
end

function this:getTaskList()
  return self._info.task_list or L_Const.emptyTable
end

function this:isInNewReddotPeriod()
  local gameEventData = _GameEventStore:getGameEventData(self.id)
  if not gameEventData or not gameEventData:isShow() then
    return false
  end
  local dayRefreshOffset = getDayRefreshOffset()
  local startDayTime = L_TimeUtil.getServerTimeOfDate(gameEventData:getStartTime() - dayRefreshOffset)
  local todayDayTime = L_TimeUtil.getServerTimeOfDate(L_TimeUtil.getServerTime() - dayRefreshOffset)
  local dayOffset = math.floor((todayDayTime - startDayTime) / 86400)
  return 0 <= dayOffset and dayOffset < _showNewReddotDays
end

function this:syncEntranceNewReddot()
  local gameEventData = _GameEventStore:getGameEventData(self.id)
  if not gameEventData or not gameEventData:isShow() then
    L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_New, self.id)
    return false
  end
  if self:isInNewReddotPeriod() then
    if L_ReddotManager:haveDailyNew(L_ReddotManager.DotDef.GameAct_New, self.id) then
      L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_New, self.id)
    else
      L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_New, self.id)
    end
  elseif not hasEverClicked(self.id) then
    L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_New, self.id)
  end
  return L_ReddotManager:haveNew(L_ReddotManager.DotDef.GameAct_New, self.id)
end

function this:clearEntranceNewReddot()
  markEverClicked(self.id)
  L_ReddotManager:clearDailyNew(L_ReddotManager.DotDef.GameAct_New, self.id)
  L_ReddotManager:clearNew(L_ReddotManager.DotDef.GameAct_New, self.id)
  AzurWorld.RedDotMgr:ClearNew(string.format(L_ReddotManager.DotDef.GameAct_New, self.id))
  AzurWorld.RedDotMgr:MarkDirty(string.format(L_ReddotManager.DotDef.GameAct_New, self.id))
  AzurWorld.RedDotMgr:MarkDirty(string.format("GameAct_Events_%d", self.id))
  refreshRelatedReddotNodes()
  L_GameEventStore:call(L_GameEventStore.event.gameEventRedDot)
end

function this:checkRedDot()
  return self:syncEntranceNewReddot()
end

function this:getRedState()
  return self:syncEntranceNewReddot()
end

return this
