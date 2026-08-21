_class("ChatModule", GameModule)
ChatModule = ChatModule

function ChatModule:Constructor()
  self.m_module_map = {}
  self.m_config_map = {}
end

function ChatModule:Init()
  self.caller:RegisterPushHandler(CEventPushJoinChatChannelResultMessage, self.HandlePushJoinStaticChatChannelResultMessage, self)
  self.caller:RegisterPushHandler(CEventPushChatMessageToChannel, self.HandlePushGameChatMessage, self)
  self.caller:RegisterPushHandler(CEventPushChatMessageToPlayer, self.HandlePushGameChatMessagePlayer, self)
end

function ChatModule:Dispose()
  self.caller:UnRegisterPushHandler(CEventPushJoinChatChannelResultMessage)
  self.caller:UnRegisterPushHandler(CEventPushChatMessageToChannel)
  self.caller:UnRegisterPushHandler(CEventPushChatMessageToPlayer)
  ChatModule.super.Dispose(self)
end

function ChatModule:RegisterChannel(channel_token, game_module, channel_config)
  local key = tostring(channel_token.server_type) .. tostring(channel_token.server_id) .. tostring(channel_token.channel_type) .. tostring(channel_token.channel_id)
  self.m_module_map[key] = game_module
  self.m_config_map[key] = channel_config
end

function ChatModule:UnRegisterChannel(channel_token)
  local key = tostring(channel_token.server_type) .. tostring(channel_token.server_id) .. tostring(channel_token.channel_type) .. tostring(channel_token.channel_id)
  self.m_module_map[key] = nil
  self.m_config_map[key] = nil
end

function ChatModule:GetChannelConfig(channel_token)
  local key = tostring(channel_token.server_type) .. tostring(channel_token.server_id) .. tostring(channel_token.channel_type) .. tostring(channel_token.channel_id)
  return self.m_config_map[key]
end

function ChatModule:ReceiveChatMessage(chatMessage)
  if chatMessage.m_msg.m_channel.channel_type == CHAT_CHANNEL_TYPE.CHAT_CHANNEL_TYPE_SYSTEM then
    self:ReceiveSystemMessage(chatMessage.m_msg.m_sender, chatMessage.m_msg.m_message)
  elseif chatMessage.m_msg.m_channel.server_type == SERVER_TYPE.SERVER_TYPE_GAME or chatMessage.m_msg.m_channel.server_type == SERVER_TYPE.SERVER_TYPE_UNIQUE then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DemoGameChatEvent, chatMessage)
  elseif chatMessage.m_msg.m_channel.server_type == SERVER_TYPE.SERVER_TYPE_ROOM then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DemoRoomChatEvent, chatMessage)
  elseif chatMessage.m_msg.m_channel.server_type == SERVER_TYPE.SERVER_TYPE_MATCH then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DemoMatchChatEvent, chatMessage)
  end
end

function ChatModule:ReceiveChatMessagePlayer(chatMessage)
  if chatMessage.m_msg.m_channel.channel_type == CHAT_CHANNEL_TYPE.CHAT_CHANNEL_TYPE_SYSTEM then
    self:ReceiveSystemMessage(chatMessage.m_msg.m_sender, chatMessage.m_msg.m_message)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DemoGameChatPrivateEvent, chatMessage)
  end
end

function ChatModule:ReceiveSystemMessage(sender, message)
  local sysmessage = string.split(message.chat_message, " ")
  local title = ""
  local notify_params = {}
  local index = 1
  for key, value in ipairs(sysmessage) do
    if key == 1 then
      title = value
    else
      notify_params[index] = value
      index = index + 1
    end
  end
  Log.debug("System Notify sender:" .. sender.nick .. ", message:" .. message.chat_message .. ", split count:" .. #sysmessage)
end

function ChatModule:SendChatMessage(TT, sender_pstid, channel, message)
  if 0 == sender_pstid or 0 == channel.server_id or "" == message.chat_message or nil == message.chat_message then
    Log.fatal("chat param error")
    return
  end
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local key = tostring(channel.server_type) .. tostring(channel.server_id) .. tostring(channel.channel_type) .. tostring(channel.channel_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSendChatMessageToChannel)
  request.m_sender_pstid = sender_pstid
  request.m_channel = channel
  request.m_message = message
  local module = self.m_module_map[key]
  if nil == module then
    Log.fatal("ChatModule:SendChatMessage 还没有加入频道[" .. key .. "]")
    return
  end
  local reply = module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("ChatModule:SendChatMessage failed with !reply:Succ()")
    return res
  end
  local replyEvent = CEventSendChatMessageToChannelResult(reply.msg)
  if replyEvent == nil then
    Log.fatal("ChatModule:SendChatMessage failed with replyEvent == nil")
    return res
  end
  if replyEvent.m_ret ~= 0 then
    Log.fatal("ChatModule:SendChatMessage failed with ret= " .. replyEvent.m_ret)
    return res
  end
  res:SetSucc(true)
  return res
end

function ChatModule:SendChatPrivateMessage(TT, sender_pstid, receiver_pstid, message)
  if 0 == sender_pstid or 0 == receiver_pstid or nil == receiver_pstid or "" == message.chat_message or nil == message.chat_message then
    Log.fatal("chat param error")
    return
  end
  local res = AsyncRequestRes:New()
  res:SetSucc(false)
  local login_module = self:GetModule(LoginModule)
  local channel = chat_channel_token:New()
  channel.server_type = SERVER_TYPE.SERVER_TYPE_GAME
  channel.server_id = login_module.svrId
  channel.channel_type = CHAT_CHANNEL_TYPE.CHAT_CHANNEL_TYPE_PRIVATE
  channel.channel_id = 0
  local key = tostring(channel.server_type) .. tostring(channel.server_id) .. tostring(channel.channel_type) .. tostring(channel.channel_id)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSendChatMessageToPlayer)
  request.m_sender_pstid = sender_pstid
  request.m_receiver_pstid = receiver_pstid
  request.m_message = message
  local module = self.m_module_map[key]
  if nil == module then
    Log.fatal("ChatModule:SendChatMessage m_module_map[" .. key .. "] == nil")
    return
  end
  local reply = module:Call(TT, request)
  if not reply:Succ() then
    Log.fatal("ChatModule:SendChatMessage failed with !reply:Succ()")
    return res
  end
  local replyEvent = CEventSendChatMessageToPlayerResult(reply.msg)
  if replyEvent == nil then
    Log.fatal("ChatModule:SendChatMessage failed with replyEvent == nil")
    return res
  end
  if replyEvent.m_ret ~= 0 then
    Log.fatal("ChatModule:SendChatMessage failed with ret= " .. replyEvent.m_ret)
    return res
  end
  res:SetSucc(true)
  return res
end

function ChatModule:HandlePushJoinStaticChatChannelResultMessage(msg)
  Log.fatal("LoginModule:玩家加入常驻频道! channel_id: ", msg.m_channel.channel_id, ", name:", msg.m_channel_config.channel_name)
  self:RegisterChannel(msg.m_channel, self, msg.m_channel_config)
end

function ChatModule:HandlePushGameChatMessage(msg)
  self:ReceiveChatMessage(msg)
end

function ChatModule:HandlePushGameChatMessagePlayer(msg)
  self:ReceiveChatMessagePlayer(msg)
end
