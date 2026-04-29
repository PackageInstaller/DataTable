_class("RoomModule", LoginBaseModule)
RoomModule = RoomModule

function RoomModule:Constructor()
  self.m_login_lock = false
  self.auth = GroupAuthInfo:New()
end

function RoomModule:Init()
  RoomModule.super.Init(self)
  self.caller:RegisterPushHandler(CEventPushEnterMatch, self.HandleCEventPushEnterMatch, self)
  self.caller:RegisterPushHandler(CEventPushChatMessageToChannel, self.HandlePushRoomChatMessage, self)
end

function RoomModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventPushEnterMatch)
  self.caller:UnRegisterPushHandler(CEventPushChatMessageToChannel)
  RoomModule.super.Dispose(self)
end

function RoomModule:Login(TT, svrId, silent, timeout)
  local res = AsyncRequestRes:New()
  if self.m_login_lock then
    Log.warn(self:Key(), " login room lock is locked")
    return res
  end
  if self.svrId == svrId and self:IsLogin() and self.caller:HasAuth() then
    Log.warn(self:Key(), " already pass login room verify")
    res:SetSucc(true)
    return res
  end
  if not GameGlobal.GameLogic().ClientInfo then
    Log.fatal(self:Key(), " login room client info is null")
    return res
  end
  self.m_login_lock = true
  if self.svrId ~= svrId or not self:IsLogin() then
    self.svrId = svrId
    self.isLogin = false
    self.caller:SetPipe2Conn(NetToken:New(NetTokenType.TOKEN_ROOM, "RM", self.svrId), "gateway")
  end
  self.caller:LostAuth()
  self.curTaskId = GetCurTaskId()
  Log.debug(self:Key(), " player ", GameGlobal.GameLogic():GetOpenId(), self:IsLogin() and " reconn to " or " login room to ", self.svrId)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestLoginVerify)
  request.m_is_login = self:IsLogin()
  request.m_client_info = GameGlobal.GameLogic().ClientInfo
  request.m_login_info = GameGlobal.GameLogic().msdkAuthorityInfo
  request.m_group_auth = self.auth
  local nLoginStep = Enum_Login_Step.E_Login_Step_RequestLoginVerify
  local retry_times = 0
  local retry_ms = 1000
  while true do
    local replyInfo = self:Call(TT, request, not silent, timeout)
    res:SetCallErr(replyInfo.res)
    if not replyInfo:Succ() then
      Log.fatal(self:Key(), " login room room reply failed ", replyInfo.res)
      break
    end
    local reply = CEventReplyLoginVerify(replyInfo.msg)
    res:SetResult(reply.m_ret)
    local ret = res:GetResult()
    if ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_OK then
      Log.debug(self:Key(), " login room ", ret, ", resend request")
      self.isLogin = true
      self.caller:GainAuth()
      res:SetSucc(true)
      AdjustTimeCS(reply.m_server_time)
      break
    elseif ret == MOBILE_LOGIN_ERROR.MOBILE_LOGIN_RETRY then
      if 3 <= retry_times then
        Log.fatal(self:Key(), " login room ", ret, ", retry ", retry_times, " limit")
        GameGlobal.GameLogic():BackToLogin(false, RoomModule, "retry limit: LoginRoom[" .. tostring(nLoginStep) .. ", " .. tostring(ret) .. "]")
        break
      end
      retry_times = retry_times + 1
      Log.debug(self:Key(), " login room ", ret, ", retry ", retry_times, " times after ", retry_ms, " ms")
      YIELD(TT, retry_ms)
    else
      Log.fatal(self:Key(), " login room ", ret, ", reset")
      GameGlobal.GameLogic():BackToLogin(false, RoomModule, "login failed: LoginRoom[" .. tostring(nLoginStep) .. ", " .. tostring(ret) .. "]")
      break
    end
  end
  self.curTaskId = 0
  self.m_login_lock = false
  Log.debug(self:Key(), " login room end")
  return res
end

function RoomModule:EnterRoom(TT, player_id, room_to_enter)
  Log.debug("sending CEventRequestEnterRoom")
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestEnterRoom)
  request.m_room_to_enter = room_to_enter
  request.m_player_id = player_id
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("RoomModule:EnterRoom failed with !reply:Succ()")
    return res
  end
  local replyEvent = CEventReplyEnterRoom(reply.msg)
  if replyEvent == nil then
    Log.fatal("RoomModule:EnterRoom failed with replyEvent == nil")
    return res
  end
  if replyEvent.m_ret ~= 0 then
    Log.fatal("RoomModule:EnterRoom failed with ret= " .. replyEvent.m_ret)
    return res
  end
  res:SetSucc(true)
  return res
end

function RoomModule:EnterMatch(TT, push_msg)
  Log.fatal("RoomModule:EnterMatch")
  local login = self:GetModule(LoginModule)
  local match = self:GetModule(MatchModule)
  match.auth.player_id = login.PstID
  match.auth.token = push_msg.m_match_to_enter
  match.auth.vkey = push_msg.m_vkey
  local res = match:Login(TT, push_msg.m_match_to_enter.server_id, false)
  if not res:GetSucc() then
    Log.fatal("RoomModule:EnterMatch failed due to match:Login failure", ", call: ", res:GetCallErr(), ", ret: ", res:GetResult())
    return
  end
  res = match:EnterMatch(TT, login.PstID, push_msg.m_match_to_enter)
  if not res:GetSucc() then
    Log.fatal("RoomModule:EnterMatch failed due to match:EnterMatch failure")
    return
  end
  match:Loading(50)
  match:Loading(100)
end

function RoomModule:HandleCEventPushEnterMatch(msg)
  Log.fatal("RoomModule:HandleCEventPushEnterMatch")
  local push_msg = CEventPushEnterMatch(msg)
  Log.fatal("HandleCEventPushEnterMatch self:StartTask")
  GameGlobal.TaskManager():StartTask(self.EnterMatch, self, push_msg)
  Log.fatal("HandleCEventPushEnterMatch self:StartTask")
end

function RoomModule:HandlePushRoomChatMessage(msg)
  local chat = self:GetModule(ChatModule)
  chat:ReceiveChatMessage(msg)
end
