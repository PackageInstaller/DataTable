local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    gameEventDatas = {}
  }
  self._isInitTimer = false
  self._init = false
  self._guideTask = {}
  self._current_time = L_TimeUtil:getServerTime()
  if self._timer then
    Timer.remove(self._timer)
  end
  self._timer = Timer.repeated(1, function()
    self:repeatCountDown()
  end)
  self:initEventGuideTask()
  for _, v in pairs(self.GameEventModules) do
    if self.gameEventGEModels[_] == nil or string.isEmpty(self.gameEventGEModels[_]) then
      self.gameEventGEModels[_] = v .. "GE"
    end
  end
end

function this:getAllGameEventDatas()
  return self.data.gameEventDatas
end

function this:getGameEventData(id)
  return self.data.gameEventDatas[id]
end

function this:getIdByType(eType)
  for _, gameEvent in pairs(self.data.gameEventDatas) do
    if gameEvent:getType() == eType and gameEvent:isShow() then
      return gameEvent.id
    end
  end
  return 0
end

function this:getDataByType(eType)
  local gameEventId = self:getIdByType(eType)
  if gameEventId then
    return self.data.gameEventDatas[gameEventId]
  end
end

function this:changeRedDot()
end

function this:initEventGuideTask()
  self._guideTask = {}
  local gameEventTpl = L_GameTpl:getGameEventsTpl()
  local data = gameEventTpl:getAllData()
  for _, gameEvent in pairs(data) do
    local guideTaskId = gameEventTpl:getGuideTaskId(gameEvent)
    if guideTaskId ~= nil and guideTaskId ~= 0 then
      table.insert(self._guideTask, {
        eventId = gameEventTpl:getId(gameEvent),
        guideTaskId = guideTaskId,
        eventType = gameEventTpl:getType(gameEvent)
      })
    end
  end
end

function this:onEventTaskAllExecuteOver(type, deleteList)
  C_MJLog.LogDebug("测试活动，收到onEventTaskAllExecuteOver", C_ELogModule.Home)
  if deleteList == nil and deleteList.count > 0 then
    return
  end
  local data = deleteList:GetObject(0)
  for k, v in pairs(data) do
    C_MJLog.LogDebug("测试活动，指引任务完成事件，指引任务id " .. v, C_ELogModule.Home)
    printf("活动", "指引任务完成事件，指引任务id" .. v)
    local EventTask, isFind = table.find(self._guideTask, function(iter)
      return iter.guideTaskId == v
    end)
    if isFind == true and EventTask.eventId then
      C_MJLog.LogDebug("测试活动，找到活动对应的Event ID" .. EventTask.eventId .. "活动类型id" .. EventTask.eventType, C_ELogModule.Home)
      if self:getGameEventData(EventTask.eventId) and self:getGameEventData(EventTask.eventId):isValid() then
        C_MJLog.LogDebug("测试活动，找到活动对应的Event ID" .. EventTask.eventId .. "合法", C_ELogModule.Home)
      end
    end
    if isFind and EventTask.eventId and self:getGameEventData(EventTask.eventId) and self:getGameEventData(EventTask.eventId):isValid() and EventTask.eventType ~= L_Const.ActivityType.AT_DAILY_SIGN and EventTask.eventType ~= L_Const.ActivityType.AT_GROWUP then
      C_MJLog.LogDebug("测试活动，真正打开活动 任务id " .. v .. "活动 Id " .. EventTask.eventId, C_ELogModule.Home)
      L_UI:open("pageGameAct", {
        gameEventId = EventTask.eventId
      })
      L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_Events_Battle, true)
      break
    end
  end
end

function this:clear()
  for id, _ in pairs(self.data.gameEventDatas) do
    self.data.gameEventDatas[id]:dispose()
    self.data.gameEventDatas[id] = nil
  end
  self.data.gameEventDatas = {}
  self._init = false
end

return this
