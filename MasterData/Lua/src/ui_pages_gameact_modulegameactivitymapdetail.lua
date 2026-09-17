local this = class("moduleGameActivityMapDetail", G_UIModuleBase)

function this.bind()
  return {
    go_module = true,
    txt_tittle = "",
    txt_desc = "",
    txt_time = ""
  }
end

function this.methods()
  return {}
end

function this:open()
  L_GameEventStore:listenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity, self)
  local activityId = 20001
  local ret = self:isShow(activityId)
  self.bind.go_module = ret
  if ret then
    self:refreshUI(activityId)
    self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  else
    self:destroyTimer()
  end
end

function this:close()
  self:destroyTimer()
  L_GameEventStore:unListenCallFunc(L_GameEventStore.event.gameEventEnd, self.endActivity)
end

function this:refreshUI(id)
  local desc = self:getDescByActivityId(id)
  self.bind.txt_desc = desc
  local eventTpl = L_GameTpl:getGameEventsTpl()
  local tpl = eventTpl:getTplById(id)
  local title = L_Config:provider(eventTpl:getName(tpl))
  self.bind.txt_tittle = title
  local eventData = L_GameEventStore:getGameEventData(id)
  if eventData then
    self.endTime = eventData:getEndTime()
    local leftTimeStr = L_TimeUtil.getLeftTimeFormatString(self.endTime)
    self.bind.txt_time = L_WordsTpl:getValue("ui_game_events_end_time")
  end
end

function this:getDescByActivityId(id)
  local mapTpl = L_GameTpl:getGameEventsKiboDuelMapTpl()
  local data = mapTpl:getData()
  local content = string.empty
  if data == nil then
    return content
  end
  for i, v in pairs(data) do
    if mapTpl:getGameEventId(v) == id then
      content = mapTpl:getDesc(v)
      break
    end
  end
  return content
end

function this:repeatShowTime()
  local isChange, str = L_TimeUtil.tryGetLeftTimeFormatString(self.endTime, 1)
  if isChange then
    self.bind.txt_time = L_WordsTpl:getValue("ui_game_events_end_time")
  end
end

function this:isShow(id)
  local ret = false
  local eventData = L_GameEventStore:getGameEventData(id)
  if eventData == nil then
    return ret
  end
  ret = eventData:isShow() and eventData:isFinishGuideTask()
  return ret
end

function this:destroyTimer()
  if self.timer then
    L_GameTimer.remove(self.timer)
    self.timer = nil
  end
end

function this:endActivity()
  local activityId = 20001
  local ret = self:isShow(activityId)
  self.bind.go_module = ret
  if ret then
    self:refreshUI(activityId)
    self.timer = L_GameTimer.repeated(1, self.repeatShowTime, self)
  else
    self:destroyTimer()
  end
end

return this
