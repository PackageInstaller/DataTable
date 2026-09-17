local MatchData = {
  PopperPartyState = L_Const.PopperPartyState or protoEnum.PopperPartyState,
  BusinessStatus = {
    IDLE = 0,
    MATCHING = 1,
    EXTRA_WAIT = 2,
    QUIT_TIMEOUT = 3,
    PRE_START = 4,
    GAME_START = 5,
    GAME_END = 6,
    CANCELED = 7,
    TIMEOUT = 8
  },
  _data = {
    serverState = 0,
    businessState = 0,
    playerList = {},
    remainingTime = 0,
    matchStartTime = 0,
    actId = 0,
    selectedHeroGuid = 0,
    matchConfig = {
      minMember = nil,
      maxMember = nil,
      maxMatchTime = nil,
      extraWaitTime = nil,
      loadingTime = nil,
      loadingExtraTime = nil,
      roundTime = nil
    }
  }
}

local function normalizeMatchStartTime(rawMatchTime, fallbackTime)
  local matchTime = tonumber(rawMatchTime) or 0
  if matchTime <= 0 then
    return 0
  end
  if 9999999999 < matchTime then
    matchTime = math.floor(matchTime / 1000)
  end
  local now = tonumber(fallbackTime) or 0
  if 0 < now and math.abs(now - matchTime) > 86400 then
    return 0
  end
  return matchTime
end

function MatchData:reset()
  local PPS = self.PopperPartyState
  local BS = self.BusinessStatus
  self._data = {
    serverState = PPS.PPCS_NONE,
    businessState = BS.IDLE,
    playerList = {},
    remainingTime = 0,
    matchStartTime = 0,
    actId = 0,
    selectedHeroGuid = 0,
    matchConfig = {
      minMember = nil,
      maxMember = nil,
      maxMatchTime = nil,
      extraWaitTime = nil,
      loadingTime = nil,
      loadingExtraTime = nil,
      roundTime = nil
    }
  }
end

function MatchData:_mapServerStateToBusiness(serverState)
  local PPS = self.PopperPartyState
  local BS = self.BusinessStatus
  local data = self._data
  data.serverState = serverState
  if serverState == PPS.PPCS_NONE then
    data.businessState = BS.IDLE
  elseif serverState == PPS.PPCS_READY1 then
    data.businessState = BS.MATCHING
  elseif serverState == PPS.PPCS_READY2 then
    data.businessState = BS.EXTRA_WAIT
  elseif serverState == PPS.PPCS_QUIT_TIMEOUT then
    data.businessState = BS.QUIT_TIMEOUT
  elseif serverState == PPS.PPCS_PRE_START then
    data.businessState = BS.PRE_START
  elseif serverState == PPS.PPCS_START then
    data.businessState = BS.GAME_START
  elseif serverState == PPS.PPCS_END then
    data.businessState = BS.GAME_END
  end
end

function MatchData:initMatchConfig(actId)
  local _PartyGameTpl = L_GameTpl:getGameEventsPartygameTpl()
  local okTpl, tpl = pcall(function()
    return _PartyGameTpl:getTplById(actId)
  end)
  if not okTpl or not tpl then
    self._data.actId = actId
    self._data.matchConfig = {
      minMember = 2,
      maxMember = 4,
      maxMatchTime = 60,
      extraWaitTime = 15,
      loadingTime = 10,
      loadingExtraTime = 10,
      roundTime = 180
    }
    return
  end
  
  local function safeRead(reader, defaultValue)
    local ok, value = pcall(reader)
    if not ok or value == nil then
      return defaultValue
    end
    return value
  end
  
  self._data.actId = actId
  self._data.matchConfig = {
    minMember = safeRead(function()
      return _PartyGameTpl:getMatchMinMember(tpl)
    end, 2),
    maxMember = safeRead(function()
      return _PartyGameTpl:getMatchMaxMember(tpl)
    end, 4),
    maxMatchTime = safeRead(function()
      return _PartyGameTpl:getMatchMaxTime(tpl)
    end, 60),
    extraWaitTime = safeRead(function()
      return _PartyGameTpl:getMatchExtraTime(tpl)
    end, 15),
    loadingTime = safeRead(function()
      return _PartyGameTpl:getLoadingTime(tpl)
    end, 10),
    loadingExtraTime = safeRead(function()
      return _PartyGameTpl:getLoadingExtraTime(tpl)
    end, 10),
    roundTime = safeRead(function()
      return _PartyGameTpl:getRoundTime(tpl)
    end, 180)
  }
end

function MatchData:updateFromServerSyncData(syncData)
  local data = self._data
  local BS = self.BusinessStatus
  local rawMatchTime = syncData and (syncData.matchTime or syncData.match_time)
  local rawReason = tonumber(syncData and syncData.reason) or 0
  if rawReason == 2 then
    data.remainingTime = 0
    data.businessState = BS.TIMEOUT
    data.serverState = self.PopperPartyState.PPCS_NONE
    if rawMatchTime ~= nil then
      local now = L_TimeUtil:getServerTime()
      local matchTime = normalizeMatchStartTime(rawMatchTime, now)
      data.matchStartTime = 0 < matchTime and matchTime or data.matchStartTime or 0
    end
    return
  end
  if rawMatchTime ~= nil then
    local now = L_TimeUtil:getServerTime()
    local matchTime = normalizeMatchStartTime(rawMatchTime, now)
    if rawReason == 1 then
      data.matchStartTime = 0 < matchTime and matchTime or data.matchStartTime or 0
      data.remainingTime = 0
      data.businessState = BS.GAME_START
      return
    end
    if matchTime <= 0 then
      if 0 >= (tonumber(data.matchStartTime) or 0) then
        data.matchStartTime = now
      end
      local maxMatchTime = tonumber(data.matchConfig and data.matchConfig.maxMatchTime) or 60
      data.remainingTime = math.max(0, maxMatchTime - math.max(0, now - data.matchStartTime))
      if data.businessState == BS.IDLE or data.businessState == BS.MATCHING or data.businessState == BS.EXTRA_WAIT then
        data.businessState = BS.MATCHING
      end
      return
    end
    local maxMatchTime = tonumber(data.matchConfig and data.matchConfig.maxMatchTime) or 60
    data.matchStartTime = matchTime
    data.remainingTime = math.max(0, maxMatchTime - math.max(0, now - data.matchStartTime))
    if data.businessState == BS.IDLE or data.businessState == BS.MATCHING or data.businessState == BS.EXTRA_WAIT then
      data.businessState = BS.MATCHING
    end
    return
  end
end

function MatchData:setBusinessState(businessState)
  local data = self._data
  data.businessState = businessState
  if businessState == self.BusinessStatus.MATCHING and (tonumber(data.matchStartTime) or 0) <= 0 then
    data.matchStartTime = L_TimeUtil:getServerTime()
  end
  if businessState == self.BusinessStatus.CANCELED or businessState == self.BusinessStatus.TIMEOUT then
    data.remainingTime = 0
    data.serverState = self.PopperPartyState.PPCS_NONE
  end
end

function MatchData:setSelectedHeroGuid(heroGuid)
  self._data.selectedHeroGuid = heroGuid
end

function MatchData:getRawData()
  return clone(self._data)
end

return MatchData
