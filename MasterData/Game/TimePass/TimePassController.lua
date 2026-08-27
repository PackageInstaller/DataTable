local TimePassController = class("TimePassController", ControllerBase)
local base = ControllerBase
local TimePassFunc = require("Game.TimePass.TimePassFunc")
local TimePassPostprocessFunc = require("Game.TimePass.TimePassPostprocessFunc")
local TimePassOrder = {
  proto_object_CounterModule.CounterModuleWeeklyChallengeFresh << 54,
  proto_object_CounterModule.CounterModuleGlobalDailyFlush << 54
}

function TimePassController:OnInit()
  self.timestampList = {}
  self.timestampDataDic = {}
  self.dataDic = {}
  self.timeFuncData = {
    maintainTimerId = nil,
    maintainTimeIsPoped = {}
  }
  self:_InitEventTimer()
  self.couldUpdate = true
  self.__OnUpdate = BindCallback(self, self.OnUpdate)
  UpdateManager:AddUpdate(self.__OnUpdate)
end

function TimePassController:_InitEventTimer()
  self.eventTimerDic = {}
  self._eventIdTsDic = {}
  self._curEventNum = 0
  self.nextEventTimestamp = nil
end

function TimePassController:AddEventTimer(timestamp, event)
  local eventDic = self.eventTimerDic[timestamp] or {}
  if self.eventTimerDic[timestamp] == nil then
    self.eventTimerDic[timestamp] = eventDic
  end
  if self.nextEventTimestamp == nil or timestamp < self.nextEventTimestamp then
    self.nextEventTimestamp = timestamp
  end
  self._curEventNum = self._curEventNum + 1
  local eventId = self._curEventNum
  self._eventIdTsDic[eventId] = timestamp
  eventDic[eventId] = event
  return eventId
end

function TimePassController:RemoveEventTimer(eventId)
  if eventId == nil then
    return
  end
  local ts = self._eventIdTsDic[eventId]
  if ts == nil then
    return
  end
  self._eventIdTsDic[eventId] = nil
  local eventDic = self.eventTimerDic[ts]
  if eventDic == nil then
    return
  end
  eventDic[eventId] = nil
  local isEmpty = true
  for k, v in pairs(eventDic) do
    isEmpty = false
    break
  end
  if isEmpty then
    self.eventTimerDic[ts] = nil
  end
end

function TimePassController:_EventTimeIsUp()
  local eventDic = self.eventTimerDic[self.nextEventTimestamp]
  if eventDic == nil then
    return
  end
  for eventId, event in pairs(eventDic) do
    event()
    self._eventIdTsDic[eventId] = nil
  end
  self.eventTimerDic[self.nextEventTimestamp] = nil
  local earlist
  for timestamp, v in pairs(self.eventTimerDic) do
    if earlist == nil or timestamp < earlist then
      earlist = timestamp
    end
  end
  self.nextEventTimestamp = earlist
end

function TimePassController:_UpdEventTimer()
  if self.nextEventTimestamp ~= nil and PlayerDataCenter.timestamp >= self.nextEventTimestamp then
    self:_EventTimeIsUp()
  end
end

function TimePassController:AddRefreshTimePoint(m_id, data)
  self.couldUpdate = false
  local timestamp = data.nextExpiredTm
  local curTimestamp = self:GetNextRefreshTimePoint()
  local isInserted
  for index, timestampInList in ipairs(self.timestampList) do
    if timestampInList > timestamp then
      table.insert(self.timestampList, index, timestamp)
      isInserted = true
      break
    elseif timestamp == timestampInList then
      isInserted = true
      break
    end
  end
  if not isInserted then
    table.insert(self.timestampList, timestamp)
  end
  if self.timestampDataDic[timestamp] == nil then
    self.timestampDataDic[timestamp] = {}
    self.timestampDataDic[timestamp][m_id] = data
  else
    self.timestampDataDic[timestamp][m_id] = data
  end
  self.couldUpdate = true
end

function TimePassController:RemoveRefreshTimePoint(m_id)
  self.couldUpdate = false
  local data = self.dataDic[m_id]
  local oldNextRefreshTimePoint = self:GetNextRefreshTimePoint()
  local timestamp = data.nextExpiredTm
  local dataDic = self.timestampDataDic[timestamp]
  if dataDic ~= nil then
    dataDic[m_id] = nil
    if table.count(dataDic) == 0 then
      self.timestampDataDic[timestamp] = nil
      table.removebyvalue(self.timestampList, timestamp)
    end
  end
  self.couldUpdate = true
end

function TimePassController:GetNextRefreshTimePoint()
  return self.timestampList[1]
end

function TimePassController:OnUpdate()
  self:_UpdEventTimer()
  if not self.couldUpdate then
    return
  end
  local NextRefreshTimePoint = self:GetNextRefreshTimePoint()
  if NextRefreshTimePoint ~= nil and NextRefreshTimePoint < PlayerDataCenter.timestamp then
    self.couldUpdate = false
    self:OnTimeUp()
  end
end

function TimePassController:OnTimeUp()
  local curTimestamp = self:GetNextRefreshTimePoint()
  local dataDic = self.timestampDataDic[curTimestamp]
  if dataDic == nil then
    self.timestampDataDic[curTimestamp] = nil
    table.removebyvalue(self.timestampList, curTimestamp)
    return
  end
  local moduleRefreshTables = {}
  for _, m_id in ipairs(TimePassOrder) do
    local data = dataDic[m_id]
    if data ~= nil then
      local func = TimePassFunc[data.moduleId]
      if func == nil then
        error(string.format("At timestamp %s can't find func for moduleId:%s", curTimestamp, data.moduleId))
      else
        func(data, moduleRefreshTables)
      end
      dataDic[m_id] = nil
    end
  end
  for m_id, data in pairs(dataDic) do
    local func = TimePassFunc[data.moduleId]
    if func == nil then
      error(string.format("At timestamp %s can't find func for moduleId:%s", curTimestamp, data.moduleId))
    else
      func(data, moduleRefreshTables)
    end
  end
  self.timestampDataDic[curTimestamp] = nil
  table.remove(self.timestampList, 1)
  self.couldUpdate = true
end

function TimePassController:InitTimePassData(callback)
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_COUNTER_Detail(function(args)
    if args ~= nil and args.Count > 0 then
      local CounterSeriesData = args[0]
      for m_id, CounterElem in pairs(CounterSeriesData.data) do
        local moduleId = CounterElem.moduleId
        if TimePassController.isModuleAdd2List(moduleId) then
          self:AddRefreshTimePoint(m_id, CounterElem)
        end
        self.dataDic[m_id] = CounterElem
        local func = TimePassPostprocessFunc[moduleId]
        if func ~= nil then
          func(true, CounterElem, self.timeFuncData)
        end
      end
    end
    callback()
  end)
end

function TimePassController:OnUpdateTimePassData(msg)
  local update = msg.update
  for m_id, CounterElem in pairs(update) do
    local moduleId = CounterElem.moduleId
    if TimePassController.isModuleAdd2List(moduleId) then
      if self.dataDic[m_id] ~= nil then
        self:RemoveRefreshTimePoint(m_id)
      end
      self:AddRefreshTimePoint(m_id, CounterElem)
    end
    self.dataDic[m_id] = CounterElem
    local func = TimePassPostprocessFunc[moduleId]
    if func ~= nil then
      func(true, CounterElem, self.timeFuncData)
    end
  end
  local delete = msg.delete
  for m_id, _ in pairs(delete) do
    local moduleId = m_id >> 54
    if TimePassController.isModuleAdd2List(moduleId) and self.dataDic[m_id] ~= nil then
      self:RemoveRefreshTimePoint(m_id)
    end
    self.dataDic[m_id] = nil
    local func = TimePassPostprocessFunc[moduleId]
    if func ~= nil then
      func(false, nil, self.timeFuncData)
    end
  end
end

function TimePassController.isModuleAdd2List(moduleId)
  return moduleId < proto_object_CounterModule.CounterModuleSeperate
end

function TimePassController:getCounterElemData(moduleId, spcifyId)
  local id = moduleId << 54 | spcifyId
  return self.dataDic[id]
end

function TimePassController:GetDungeonPeriodDropTimes(dungeonType)
  local elem = self:getCounterElemData(proto_object_CounterModule.CounterModuleDungeonPeriodDropTimes, dungeonType)
  if elem == nil or elem.nextExpiredTm < PlayerDataCenter.timestamp then
    return 0
  end
  return elem.times
end

function TimePassController:GetLogicWeekNum(timeStamp)
  local nextExpiredTm = self:GetLogicTodayPassTimeStamp()
  local nowTm = timeStamp or math.floor(PlayerDataCenter.timestamp)
  local weekNum = TimeUtil:TimestampToDate(TimeUtil:TimpApplyLogicOffset(nowTm + 1)).wday
  if weekNum == 1 then
    return 7, nextExpiredTm
  else
    return weekNum - 1, nextExpiredTm
  end
end

function TimePassController:GetIsLogicToday(timeStamp)
  local nextExpiredTm = self:GetLogicTodayPassTimeStamp()
  if nextExpiredTm - timeStamp < 86400 then
    return true, nextExpiredTm
  end
  return false, nextExpiredTm
end

function TimePassController:GetLogicTodayPassTimeStamp()
  local timePassData = self:getCounterElemData(proto_object_CounterModule.CounterModuleGlobalDailyFlush, 0)
  local nextExpiredTm = timePassData.nextExpiredTm
  return nextExpiredTm
end

function TimePassController:GetCounterModuleDungeonEnter(dungeonId)
  local counterData = self:getCounterElemData(proto_object_CounterModule.CounterModuleDungeonEnter, dungeonId)
  local num = counterData ~= nil and counterData.times or 0
  return num
end

function TimePassController:GetDungeonRateEnterNum(moduleId)
  local counterData = self:getCounterElemData(proto_object_CounterModule.CounterModuleDungeonModuleCountExtra, moduleId)
  local num = counterData ~= nil and counterData.times or 0
  return num
end

function TimePassController:GetDungeonShareRateEnterNum(shareId)
  local counterData = self:getCounterElemData(proto_object_CounterModule.CounterModuleDungeonShareCount, shareId)
  local num = counterData ~= nil and counterData.times or 0
  return num
end

function TimePassController:GetEpQuickBattleNum(stageId)
  local counterData = self:getCounterElemData(proto_object_CounterModule.CounterModuleExplorationQuitModeNum, stageId)
  local num = counterData ~= nil and counterData.times or 0
  return num
end

function TimePassController:OnDelete()
  if self.timeFuncData.maintainTimerId ~= nil then
    TimerManager:StopTimer(self.timeFuncData.maintainTimerId)
    self.timeFuncData.maintainTimerId = nil
  end
  self.timeFuncData.maintainTimeIsPoped = {}
  UpdateManager:RemoveUpdate(self.__OnUpdate)
  base.OnDelete(self)
end

return TimePassController
