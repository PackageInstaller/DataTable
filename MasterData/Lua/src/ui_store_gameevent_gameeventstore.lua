local this = class("gameEventStore", G_BaseStore)
local _GameEventTpl = L_GameTpl:getGameEventsTpl()
this.baseGameEventCls = require(L_R.store .. "gameEvent.baseGameEvent")
this.gameEventDataCls = require(L_R.store .. "gameEvent.gameEventData")
this.event = {
  gameEventSync = "gameEventSync",
  gameEventEnd = "gameEventEnd",
  gameEventReward = "gameEventReward",
  gameEventRedDot = "gameEventRedDot",
  gameEventDelete = "gameEventDelete",
  gameEventMaskOpen = "gameEventMaskOpen",
  gameEventMaskClose = "gameEventMaskClose",
  gameEventRefreshTabs = "gameEventRefreshTabs"
}
this:importPartialClass(require(L_R.store .. "gameEvent.gameEventState"))
this:importPartialClass(require(L_R.store .. "gameEvent.gameEventConfig"))

function this:syncGameEventDatas(protoData, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc or not protoData then
    return
  end
  for _, data in ipairs(protoData.confs or L_Const.emptyTable) do
    local id = data.activity_id
    if not self.data.gameEventDatas[id] and self:_canShow(id) then
      self.data.gameEventDatas[id] = self.data.gameEventDatas[id] or this.gameEventDataCls.new(id)
      self.data.gameEventDatas[id]:populate(data)
    end
  end
  for _, data in ipairs(protoData.activitys or L_Const.emptyTable) do
    local id = data.id
    if not self.data.gameEventDatas[id] then
      printf("活动" .. id .. "没有时间数据(前端记录LOG)")
    else
      self.data.gameEventDatas[id]:populateEventData(data)
    end
  end
  for _, id in ipairs(protoData.del_activitys or L_Const.emptyTable) do
    if self.data.gameEventDatas[id] then
      self.data.gameEventDatas[id]:dispose()
      self.data.gameEventDatas[id] = nil
      self:call(this.event.gameEventDelete, id)
    end
  end
  self:call(this.event.gameEventSync)
  self:call(this.event.gameEventRedDot)
  self._init = true
  if not self._isInitTimer then
    self._isInitTimer = true
  end
  L_ReddotManager:setDirty(L_ReddotManager.DotDef.GameAct_Events_Kibo_Travel, true)
end

function this:_canShow(activityId)
  local tpl = _GameEventTpl:getTplById(activityId)
  local actType = tpl.type
  if actType == 8 or actType == 50 or actType == 130 then
    return false
  end
  return true
end

function this:syncRewardSync(data, errorCode)
  if errorCode ~= L_Const.errorCode.ErrCodeSucc or not data then
    return
  end
end

function this:req_gameEventDatas(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoActivityGet, nil, function(rspData, errorCode)
    self:syncGameEventDatas(rspData, errorCode)
    if callback and errorCode == L_Const.errorCode.ErrCodeSucc then
      callback()
    end
  end)
end

function this:req_CSProtoKiboDuelGetGroup(levelId, callback)
  local gameEventKiboDuleTpl = L_GameTpl:getGameEventsKiboDuelTpl()
  local list = gameEventKiboDuleTpl:getData()
  local activityId = 0
  for _, v in pairs(list) do
    if v.kiboDuelId == levelId then
      activityId = v.id
      break
    end
  end
  if activityId == 0 then
    errorf("活动" .. "not found activityId for levelId:" .. levelId, 2)
  else
    L_Net:sendMessage(MsgGenCode.CSProtoActivityKiboDuelStart, {u32 = activityId}, function(rspData, errorCode)
      if callback then
        callback()
      end
    end)
  end
end

function this:req_CsProtoActivityReward(activityId, RewardIdList, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoActivityReward, {activity_id = activityId, reward_id_list = RewardIdList}, function(rspData, errCode)
    if errCode == L_Const.errorCode.ErrCodeSucc then
      self:call(this.event.gameEventRefreshTabs, activityId)
      if rspData ~= nil and callback then
        callback(rspData)
      end
    end
    self:call(this.event.gameEventReward)
    self:changeRedDot()
  end)
end

function this:markAllGameEventReddot()
  for _, gameEvent in pairs(self.data.gameEventDatas) do
    local tpl = _GameEventTpl:getTplById(gameEvent.id)
    if not tpl then
      return
    end
    local canShow = _GameEventTpl:getUnlockShow(tpl)
    if canShow == 1 then
      L_ReddotManager:markNew(L_ReddotManager.DotDef.GameAct_New, gameEvent.id)
    end
  end
end

function this:repeatCountDown()
  for _, gameEvent in pairs(self.data.gameEventDatas) do
    if self._current_time <= gameEvent:getEndTime() and self._current_time + 1 > gameEvent:getEndTime() then
      self:call(this.event.gameEventEnd, gameEvent:getActivityId())
    end
  end
  self._current_time = L_TimeUtil:getServerTime()
end

function this:forceRefreshDot()
  self:call(this.event.gameEventRedDot)
end

function this:addFackData()
  local id = _GameEventTpl:getFackId()
  local tpl = _GameEventTpl:getTplById(id)
  local data = {
    start_time = C_CommonTimerMgr.GetStartTime(_GameEventTpl:getTimeLimit(tpl)),
    end_time = C_CommonTimerMgr.GetEndTime(_GameEventTpl:getTimeLimit(tpl))
  }
  if not self.data.gameEventDatas[id] then
    self.data.gameEventDatas[id] = self.data.gameEventDatas[id] or this.gameEventDataCls.new(id)
    self.data.gameEventDatas[id]:populate(data)
  end
end

function this:parseTimeString(timeStr)
  if string.isEmpty(timeStr) then
    return nil
  end
  local year = tonumber(string.sub(timeStr, 1, 4))
  local month = tonumber(string.sub(timeStr, 5, 6))
  local day = tonumber(string.sub(timeStr, 7, 8))
  local hour = tonumber(string.sub(timeStr, 10, 11))
  local min = tonumber(string.sub(timeStr, 12, 13))
  local sec = tonumber(string.sub(timeStr, 14, 15))
  local timestamp = os.time({
    year = year,
    month = month,
    day = day,
    hour = hour,
    min = min,
    sec = sec
  })
  return timestamp
end

return this
