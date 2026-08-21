_class("MatchModule", LoginBaseModule)
MatchModule = MatchModule

function MatchModule:Constructor()
  self.m_login_lock = false
  self.auth = GroupAuthInfo:New()
  self.m_match_enter_data = nil
  self.m_match_enter_preference_data = nil
  self.m_have_match_result = false
  self.m_have_match_start = false
  self._wait_for_net_result_tick = 20000
  self._check_net_result_tick = 100
  self._matchID = 0
  self._bRestartMatch = false
end

function MatchModule:Init()
  MatchModule.super.Init(self)
  self.caller:RegisterPushHandler(CEventMatchStartLoading, self.HandleCEventMatchStartLoading, self)
  self.caller:RegisterPushHandler(CEventMatchStart, self.HandleCEventMatchStart, self)
  self.caller:RegisterPushHandler(CEventSvrPushLogout, self.HandleLogout, self)
  self.caller:RegisterPushHandler(CEventPushChatMessageToChannel, self.HandlePushMatchChatMessage, self)
  self.caller:RegisterPushHandler(CEventLuaCommand, self.HandleLuaCommand, self)
end

function MatchModule:HandleLogout(msg)
  Log.debug(self:Key(), "MatchModule HandleLogout, err: ", tostring(msg.m_err), " reason: ", msg.m_reason)
  self:StopFastCheck()
  self:Reset(msg.m_reason)
end

function MatchModule:Reset(reason)
  local isNormal = not self:IsLogin() and not self.caller:IsConnected() or self.caller:HasAuth()
  MatchModule.super.Reset(self, reason)
  if isNormal then
    return
  end
  GameGlobal.GameLogic():GoBack()
end

function MatchModule:SetMatchResult(result)
  self._match_result = result
end

function MatchModule:GetMatchResult()
  return self._match_result
end

function MatchModule:GetMatchEnterData()
  return self.m_match_enter_data
end

function MatchModule:GetMatchEnterPreferenceData()
  return self.m_match_enter_preference_data
end

function MatchModule:GetMatchType()
  return self.m_match_enter_data:GetMatchType()
end

function MatchModule:GetSubMatchType()
  return self.m_match_enter_data:GetSubMatchType()
end

function MatchModule:ClearMatchEnterData()
  self.m_match_enter_data = nil
  self.m_match_enter_preference_data = nil
end

function MatchModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventMatchStartLoading)
  self.caller:UnRegisterPushHandler(CEventMatchStart)
  self.caller:UnRegisterPushHandler(CEventSvrPushLogout)
  self.caller:UnRegisterPushHandler(CEventPushChatMessageToChannel)
  self.caller:UnRegisterPushHandler(CEventLuaCommand)
  MatchModule.super.Dispose(self)
end

function MatchModule:StartEnterMatch()
  self.m_have_match_start = false
end

function MatchModule:Login(TT, svrId, silent, timeout)
  local res = AsyncRequestRes:New()
  if self.m_login_lock then
    Log.warn(self:Key(), " login match lock is locked")
    return res
  end
  if self.svrId == svrId and self:IsLogin() and self.caller:HasAuth() then
    Log.warn(self:Key(), " already pass login match verify")
    res:SetSucc(true)
    return res
  end
  if not GameGlobal.GameLogic().ClientInfo then
    Log.fatal(self:Key(), " login match client info is null")
    return res
  end
  self.m_login_lock = true
  if self.svrId ~= svrId or not self:IsLogin() then
    self.svrId = svrId
    self.isLogin = false
    self.caller:SetPipe2Conn(NetToken:New(NetTokenType.TOKEN_MATCH, "MT", self.svrId), "gateway")
  end
  self.caller:LostAuth()
  self.curTaskId = GetCurTaskId()
  Log.debug(self:Key(), " player ", GameGlobal.GameLogic():GetOpenId(), self:IsLogin() and " reconn to " or " login match to ", self.svrId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestLoginVerify)
  request.m_is_login = self:IsLogin()
  request.m_client_info = GameGlobal.GameLogic().ClientInfo
  request.m_client_info.client_version = GameGlobal.Version
  request.m_login_info = GameGlobal.GameLogic().msdkAuthorityInfo
  request.m_group_auth = self.auth
  local nLoginStep = Enum_Login_Step.E_Login_Step_RequestLoginVerify
  local retry_times = 0
  local retry_ms = 1000
  while true do
    local replyInfo = self:Call(TT, request, not silent, timeout)
    res:SetCallErr(replyInfo.res)
    if not replyInfo:Succ() then
      Log.fatal(self:Key(), " login match reply failed ", replyInfo.res)
      break
    end
    local reply = CEventReplyLoginVerify(replyInfo.msg)
    if reply == nil then
      Log.fatal(self:Key(), " login match reply msg is null")
      break
    end
    res:SetResult(reply.m_ret)
    local ret = res:GetResult()
    if ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_OK then
      Log.debug(self:Key(), " login match ", ret, ", resend request")
      self.isLogin = true
      self.caller:GainAuth()
      res:SetSucc(true)
      AdjustTimeCS(reply.m_server_time)
      break
    elseif ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_RETRY then
      if 3 <= retry_times then
        Log.fatal(self:Key(), " login match ", ret, ", retry ", retry_times, " limit")
        GameGlobal.GameLogic():BackToLogin(false, MatchModule, "retry limit: LoginMatch[" .. tostring(nLoginStep) .. ", " .. tostring(ret) .. "]", true, MOBILE_LOGOUT_ERROR.MOBILE_LOGOUT_MATCH_ERROR)
        break
      end
      retry_times = retry_times + 1
      Log.debug(self:Key(), " login ", ret, ", retry ", retry_times, " times after ", retry_ms, " ms")
      YIELD(TT, retry_ms)
    else
      Log.fatal(self:Key(), " login match ", ret, ", reset")
      GameGlobal.GameLogic():BackToLogin(false, MatchModule, "login failed: : LoginMatch[" .. tostring(nLoginStep) .. ", " .. tostring(ret) .. "]", true, MOBILE_LOGOUT_ERROR.MOBILE_LOGOUT_MATCH_ERROR)
      break
    end
  end
  self.curTaskId = 0
  GameGlobal.EventDispatcher():Dispatch(GameEventType.NetWorkRetryEnd)
  self.m_login_lock = false
  Log.debug(self:Key(), " login match end")
  return res
end

function MatchModule:EnterMatch(TT, player_id, match_to_enter)
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestEnterMatch)
  request.m_match_to_enter = match_to_enter
  request.m_player_id = player_id
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("MatchModule:EnterMatch failed with !reply:Succ()")
    res:SetResult(-1)
    return res
  end
  local replyEvent = CEventReplyEnterMatch(reply.msg)
  if replyEvent == nil then
    Log.fatal("MatchModule:EnterMatch failed with replyEvent == nil")
    res:SetResult(-1)
    return res
  end
  if replyEvent.m_ret ~= 0 then
    Log.fatal("MatchModule:EnterMatch failed with ret=" .. replyEvent.m_ret)
    res:SetResult(replyEvent.m_ret)
    return res
  end
  res:SetSucc(true)
  self.m_match_enter_data = MatchEnterData:New(player_id, replyEvent.create_info, replyEvent.player_list)
  self.m_match_enter_preference_data = MatchEnterPreFerenceData:New(self.m_match_enter_data._joined_players)
  GameGlobal.GameRecorder():StartRecord()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.StartMatch, {
    match_enter_data = table_to_class(self.m_match_enter_data)
  })
  self._matchID = match_to_enter.group_id
  Log.debug("MatchModule:EnterMatch succeeded PlayerID:", player_id, " MatchID:", match_to_enter.group_id)
  return res
end

function MatchModule:SetMatchEnterData(match_enter_data)
  self.m_match_enter_data = match_enter_data
  self.m_match_enter_preference_data = MatchEnterPreFerenceData:New(self.m_match_enter_data._joined_players)
end

function MatchModule:Loading(progress)
  Log.debug("sending CEventUpdateLoadingProgress" .. progress)
  if 100 <= progress and GameGlobal:GetInstance():IsOfflineMatch() then
    self.m_have_match_result = false
    self.m_have_match_start = true
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MatchStart)
    return
  end
  local msg = NetMessageFactory:GetInstance():CreateMessage(CEventUpdateLoadingProgress)
  msg.testaaaaaa = 12
  msg.m_progress = progress
  self:Push(msg)
  if 100 <= progress then
    TaskManager:GetInstance():StartTask(MatchModule.WaitMatchStartTask, self)
  end
end

function MatchModule:WaitMatchStartTask(TT)
  if GameGlobal:GetInstance():IsCoreGameRunning() == false then
    return
  end
  if not self.m_have_match_start then
    for i = 1, self._wait_for_net_result_tick / self._check_net_result_tick do
      YIELD(TT, self._check_net_result_tick)
      if GameGlobal:GetInstance():IsCoreGameRunning() == false then
        Log.error("WaitMatchStartTask() IsCoreGameRunning false")
        return
      end
      if self.m_have_match_start then
        break
      end
    end
  end
  if not self.m_have_match_start then
    Log.error("WaitMatchStartTask() timeout !!")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MatchError)
  end
end

function MatchModule:HandleMatchEndMsg(msg)
  self.m_have_match_result = true
end

function MatchModule:GameOver(result)
  Log.notice("GameOver -------------")
  if GameSingle then
    return
  end
  if GameGlobal:GetInstance():IsOfflineMatch() then
    GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Exit_Core_Game)
    return
  end
  local login = self:GetModule(LoginModule)
  local msg = CEventGameOver:New()
  msg.m_player_pstid = login.PstID
  msg.m_result = result
  self:Push(msg)
  TaskManager:GetInstance():StartTask(MatchModule.WaitSendGameOverTask, self, result)
end

function MatchModule:WaitSendGameOverTask(TT, result)
  if GameGlobal:GetInstance():IsCoreGameRunning() == false then
    Log.debug("leave GameOverTask for coregamerunning false")
    return
  end
  if not self.m_have_match_result then
    for i = 1, self._wait_for_net_result_tick / self._check_net_result_tick do
      YIELD(TT, self._check_net_result_tick)
      if GameGlobal:GetInstance():IsCoreGameRunning() == false then
        Log.error("WaitSendGameOverTask() IsCoreGameRunning false")
        return
      end
      if self.m_have_match_result then
        break
      end
    end
  end
  if not self.m_have_match_result then
    Log.error("WaitSendGameOverTask() timeout !!")
    GameGlobal.EventDispatcher():Dispatch(GameEventType.MatchError)
  end
end

function MatchModule:HandleCEventMatchStartLoading(msg)
  Log.fatal("CEventMatchStartLoading : ", msg)
end

function MatchModule:HandleCEventMatchStart(msg)
  GameGlobal:GetInstance():GetCollector("CoreGameLoading"):Sample("MatchModule:HandleCEventMatchStart()")
  self.m_have_match_result = false
  self.m_have_match_start = true
  GameGlobal.EventDispatcher():Dispatch(GameEventType.MatchStart)
end

function MatchModule:SendBattleLog(logString)
  Log.notice("SendBattleLog --------------")
  local logMsg = CEventBattleLog:New()
  logMsg.m_data_point_log = logString
  self:Push(logMsg)
end

function MatchModule:HandlePushMatchChatMessage(msg)
  local chat = self:GetModule(ChatModule)
  chat:ReceiveChatMessage(msg)
end

function MatchModule:HandleLuaCommand(msg)
  local mainWorld = GameGlobal:GetInstance():GetMainWorld()
  if not mainWorld then
    Log.error("HandleLuaCommand not find main world!!")
    return
  end
  local networkService = mainWorld:GetService("Network")
  networkService:ReceiveMessage(msg)
end

function MatchModule:HandleWaveEnd(waveIndex)
  Log.notice("WaveEnd ------------- WaveIndex:", waveIndex)
  local msg = CEventWaveEnd:New()
  msg.wave_index = waveIndex
  self:Push(msg)
end

function MatchModule:SetReStartMatchState(state)
  self._bRestartMatch = state
end

function MatchModule:IsQuickReStartMatch()
  return self._bRestartMatch
end
