_class("GameRoomModule", GameModule)
GameRoomModule = GameRoomModule

function GameRoomModule:Constructor()
  self.room_token = GroupToken:New()
  self.vkey = 0
  self.ip = ""
  self.port = 0
end

function GameRoomModule:Init()
end

function GameRoomModule:CreateRoom(TT, room_type)
  Log.debug("sending CEventRequestCreateRoom")
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestCreateRoom)
  request.m_room_type = room_type
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("GameRoomModule:CreateRoom failed with !reply:Succ()")
    return res
  end
  local replyEvent = CEventReplyCreateRoom(reply.msg)
  if replyEvent == nil then
    Log.fatal("GameRoomModule:CreateRoom failed with replyEvent == nil")
    return res
  end
  if replyEvent.m_ret ~= 0 then
    Log.fatal("GameRoomModule:CreateRoom failed with ret=" .. replyEvent.m_ret)
    return res
  end
  res:SetSucc(true)
  self.room_token = replyEvent.m_room_created
  self.vkey = replyEvent.m_vkey
  self.ip = replyEvent.m_server_ip
  self.port = replyEvent.m_server_port
  Log.debug("GameRoomModule:CreateRoom succeeded, ip=" .. self.ip .. ":" .. self.port)
  return res
end

function GameRoomModule:JoinRoom(TT, res, room_to_join)
  Log.debug("sending CEventRequestJoinRoom")
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestJoinRoom)
  request.m_room_to_join = room_to_join
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("GameRoomModule:JoinRoom failed with !reply:Succ()")
    return res
  end
  local replyEvent = CEventReplyJoinRoom(reply.msg)
  if replyEvent == nil then
    Log.fatal("GameRoomModule:JoinRoom failed with replyEvent == nil")
    return res
  end
  if replyEvent.m_ret ~= 0 then
    Log.fatal("GameRoomModule:JoinRoom failed with ret=" .. replyEvent.m_ret)
    return res
  end
  res:SetSucc(true)
  self.room_token = replyEvent.m_room_to_join
  self.vkey = replyEvent.m_vkey
  self.ip = replyEvent.m_server_ip
  self.port = replyEvent.m_server_port
  return res
end

function GameRoomModule:LeaveRoom(TT)
  Log.debug("sending CEventRequestLeaveRoom")
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestLeaveRoom)
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    return res
  end
  local replyEvent = CEventReplyLeaveRoom(reply.msg)
  if replyEvent == nil then
    return res
  end
  res:SetSucc(true)
  self.room_token = GroupToken:New()
  self.vkey = 0
  self.ip = ""
  self.port = 0
  return res
end

function GameRoomModule:StartMatch(TT, match_type, level_id)
  Log.debug("sending CEventRequestStartMatch")
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventRequestStartMatch)
  request.m_match_type = match_type
  request.m_level_id = level_id
  local reply = self:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("GameRoomModule:StartMatch failed with !reply:Succ()")
    return res
  end
  local replyEvent = CEventReplyStartMatch(reply.msg)
  if replyEvent == nil then
    Log.fatal("GameRoomModule:StartMatch failed with replyEvent == nil")
    return res
  end
  if replyEvent.m_ret ~= 0 then
    Log.fatal("GameRoomModule:StartMatch failed with ret=" .. replyEvent.m_ret)
    return res
  end
  res:SetSucc(true)
  Log.debug("GameRoomModule:StartMatch succeeded")
  return res
end
