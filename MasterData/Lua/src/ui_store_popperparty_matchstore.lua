local MatchLogicManager = {}
local MatchData = require(L_R.store .. "popperparty.MatchData")
local pb = require("core.pbc.protobuf")
local MSG = {
  CS_MATCH = MsgGenCode and MsgGenCode.CSProtoPopperPartyMatch or 11537,
  CS_CANCEL_MATCH = MsgGenCode and MsgGenCode.CSProtoPopperPartyCancelMatch or 11538,
  SC_MATCH_SYNC = MsgGenCode and MsgGenCode.SCProtoPopperPartyMatchSync or 11539
}
local instance

local function getOptionalGlobal(name)
  return rawget(_G, name)
end

local function newDispatcher()
  local dispatcher = {
    listeners = {}
  }
  
  function dispatcher:addEventListener(eventName, callback)
    if type(callback) ~= "function" then
      return
    end
    self.listeners[eventName] = self.listeners[eventName] or {}
    table.insert(self.listeners[eventName], callback)
  end
  
  function dispatcher:dispatch(eventName, ...)
    local callbacks = self.listeners[eventName]
    if not callbacks then
      return
    end
    for _, cb in ipairs(callbacks) do
      cb(...)
    end
  end
  
  return dispatcher
end

local function getData()
  return MatchData._data or {}
end

local function hasLuaProto(protoName)
  if type(protoName) ~= "string" or protoName == "" then
    return false
  end
  local ok = pcall(function()
    pb.encode(protoName, {})
  end)
  return ok
end

local function canListenMatchSyncInLua()
  if not MsgGenCode or not MsgGenCode.rsp then
    return false
  end
  local protoName = MsgGenCode.rsp[MSG.SC_MATCH_SYNC]
  return hasLuaProto(protoName)
end

function MatchLogicManager:init()
  self.eventDispatcher = newDispatcher()
  self.canUseServerMatchSync = canListenMatchSyncInLua()
  if self.canUseServerMatchSync then
    if L_Net and L_Net.registerMsgListener then
      L_Net:registerMsgListener(MSG.SC_MATCH_SYNC, handler(self, self.onMatchSyncFromServer))
    elseif L_Net and L_Net.addListener then
      L_Net:addListener(MSG.SC_MATCH_SYNC, handler(self, self.onMatchSyncFromServer))
    end
  else
    print(string.format("[PopperParty] lua proto missing for msgId=%s, match state can only stay on local pending state", tostring(MSG.SC_MATCH_SYNC)))
  end
end

function MatchLogicManager:getInstance()
  if not instance then
    instance = setmetatable({}, {__index = MatchLogicManager})
    instance:init()
  end
  return instance
end

function MatchLogicManager.new()
  return MatchLogicManager:getInstance()
end

function MatchLogicManager:getBusinessStatusEnum()
  return MatchData.BusinessStatus
end

function MatchLogicManager:getBusinessState()
  return getData().businessState or MatchData.BusinessStatus.IDLE
end

function MatchLogicManager:getMatchConfig()
  return getData().matchConfig or {}
end

function MatchLogicManager:getRemainingTime()
  return getData().remainingTime or 0
end

function MatchLogicManager:getPlayerList()
  return getData().playerList or {}
end

function MatchLogicManager:getActId()
  return getData().actId or 0
end

function MatchLogicManager:startMatch(actId, heroGuid)
  local BS = self:getBusinessStatusEnum()
  if not actId or actId == 0 then
    self.eventDispatcher:dispatch("match_failed", "活动ID无效")
    return
  end
  if not heroGuid or heroGuid == 0 then
    self.eventDispatcher:dispatch("match_failed", "请选择参与匹配的角色")
    return
  end
  local currentState = self:getBusinessState()
  if currentState == BS.MATCHING or currentState == BS.EXTRA_WAIT then
    self.eventDispatcher:dispatch("match_state_changed")
    return
  end
  local okQuit = pcall(function()
    self:quitCurrentTeamAndOtherMatch()
  end)
  MatchData:reset()
  MatchData:initMatchConfig(actId)
  MatchData:setSelectedHeroGuid(heroGuid)
  MatchData:setBusinessState(BS.MATCHING)
  print(string.format("[PopperParty][Match] startMatch enter actId=%s heroGuid=%s msgId=%s", tostring(actId), tostring(heroGuid), tostring(MSG.CS_MATCH)))
  if not okQuit then
    self.eventDispatcher:dispatch("match_failed", "已开始匹配，退出队伍失败请稍后重试")
  end
  if L_Net and L_Net.sendMessage then
    local okSend = pcall(function()
      print(string.format("[PopperParty][Match] send CS_MATCH begin msgId=%s", tostring(MSG.CS_MATCH)))
      L_Net:sendMessage(MSG.CS_MATCH, nil, nil)
    end)
    if not okSend then
      print(string.format("[PopperParty][Match] send CS_MATCH failed msgId=%s", tostring(MSG.CS_MATCH)))
      MatchData:setBusinessState(BS.TIMEOUT)
      self.eventDispatcher:dispatch("match_failed", "匹配请求异常，请重试")
    else
      print(string.format("[PopperParty][Match] send CS_MATCH ok msgId=%s", tostring(MSG.CS_MATCH)))
    end
  else
    print("[PopperParty][Match] send CS_MATCH skipped: L_Net unavailable")
    MatchData:setBusinessState(BS.TIMEOUT)
    self.eventDispatcher:dispatch("match_failed", "网络模块不可用")
  end
  self.eventDispatcher:dispatch("match_state_changed")
end

function MatchLogicManager:cancelMatch(actId)
  local BS = self:getBusinessStatusEnum()
  local currentState = self:getBusinessState()
  if currentState ~= BS.MATCHING and currentState ~= BS.EXTRA_WAIT then
    self.eventDispatcher:dispatch("match_state_changed")
    return
  end
  print(string.format("[PopperParty][Match] cancelMatch enter actId=%s msgId=%s", tostring(actId), tostring(MSG.CS_CANCEL_MATCH)))
  if L_Net and L_Net.sendMessage then
    local okSend = pcall(function()
      print(string.format("[PopperParty][Match] send CS_CANCEL_MATCH begin msgId=%s", tostring(MSG.CS_CANCEL_MATCH)))
      L_Net:sendMessage(MSG.CS_CANCEL_MATCH, nil, nil)
    end)
    if not okSend then
      print(string.format("[PopperParty][Match] send CS_CANCEL_MATCH failed msgId=%s", tostring(MSG.CS_CANCEL_MATCH)))
      self.eventDispatcher:dispatch("match_failed", "取消匹配失败")
      return
    end
    print(string.format("[PopperParty][Match] send CS_CANCEL_MATCH ok msgId=%s", tostring(MSG.CS_CANCEL_MATCH)))
    MatchData:setBusinessState(BS.CANCELED)
    self.eventDispatcher:dispatch("match_state_changed")
  else
    print("[PopperParty][Match] send CS_CANCEL_MATCH skipped: L_Net unavailable")
    MatchData:setBusinessState(BS.CANCELED)
    self.eventDispatcher:dispatch("match_state_changed")
  end
end

function MatchLogicManager:onMatchSyncFromServer(rspData)
  print(string.format("[PopperParty][Match] recv SC_MATCH_SYNC msgId=%s", tostring(MSG.SC_MATCH_SYNC)))
  local rawMatchTime = rspData and (rspData.matchTime or rspData.match_time)
  local rawReason = tonumber(rspData and rspData.reason) or 0
  print(string.format("[PopperParty][Match] SC_MATCH_SYNC raw matchTime=%s reason=%s", tostring(rawMatchTime), tostring(rawReason)))
  MatchData:updateFromServerSyncData(rspData or {})
  local BS = self:getBusinessStatusEnum()
  local currentState = self:getBusinessState()
  print(string.format("[PopperParty][Match] SC_MATCH_SYNC synced businessState=%s remainingTime=%s actId=%s", tostring(currentState), tostring(self:getRemainingTime()), tostring(self:getActId())))
  if rawReason == 1 then
    self.eventDispatcher:dispatch("match_state_changed")
    self.eventDispatcher:dispatch("match_success", self:getPlayerList())
    return
  elseif rawReason == 2 then
    self.eventDispatcher:dispatch("match_state_changed")
    return
  end
  self.eventDispatcher:dispatch("match_state_changed")
  if currentState == BS.PRE_START then
    self.eventDispatcher:dispatch("match_pre_start", self:getRemainingTime())
  elseif currentState == BS.GAME_START then
    self.eventDispatcher:dispatch("match_success", self:getPlayerList())
  elseif currentState == BS.QUIT_TIMEOUT then
    self.eventDispatcher:dispatch("match_quit_timeout", self:getRemainingTime())
  end
end

function MatchLogicManager:quitCurrentTeamAndOtherMatch()
  local TeamManager = getOptionalGlobal("L_TeamManager") or getOptionalGlobal("_TeamManager")
  local PlayerMatchStore = getOptionalGlobal("L_PlayerMatchStore") or getOptionalGlobal("_PlayerMatchStore")
  if TeamManager and TeamManager.quitCurrentTeam then
    TeamManager:quitCurrentTeam(function()
    end)
  end
  if PlayerMatchStore and PlayerMatchStore.cancelAllMatch then
    PlayerMatchStore:cancelAllMatch(self:getActId())
  end
end

function MatchLogicManager:addStateChangeListener(callback)
  self.eventDispatcher:addEventListener("match_state_changed", callback)
end

function MatchLogicManager:addMatchFailedListener(callback)
  self.eventDispatcher:addEventListener("match_failed", callback)
end

function MatchLogicManager:addPreStartListener(callback)
  self.eventDispatcher:addEventListener("match_pre_start", callback)
end

function MatchLogicManager:addQuitTimeoutListener(callback)
  self.eventDispatcher:addEventListener("match_quit_timeout", callback)
end

function MatchLogicManager:addMatchSuccessListener(callback)
  self.eventDispatcher:addEventListener("match_success", callback)
end

return MatchLogicManager
