require("message_def")
local chatMessageDef = {
  CLSID_CChatPushEvent = 3000,
  CLSID_CEventSendChatMessageToChannel = 3001,
  CLSID_CEventSendChatMessageToChannelResult = 3002,
  CLSID_CEventSendChatMessageToPlayer = 3003,
  CLSID_CEventSendChatMessageToPlayerResult = 3004,
  CLSID_CEventPushChatMessageToChannel = 3005,
  CLSID_CEventPushChatMessageToPlayer = 3006,
  CLSID_CEventPushJoinChatChannelResultMessage = 3007,
  CLSID_CEventPushLeaveChatChannelResultMessage = 3008
}
table.append(MessageDef, chatMessageDef)
_class("CChatPushEvent", CPushEvent)
CChatPushEvent = CChatPushEvent

function CChatPushEvent:Constructor()
end

CChatPushEvent._proto = {}
_class("CEventSendChatMessageToChannel", CCallRequestEvent)
CEventSendChatMessageToChannel = CEventSendChatMessageToChannel

function CEventSendChatMessageToChannel:Constructor()
  self.m_sender_pstid = 0
  self.m_channel = chat_channel_token:New()
  self.m_message = chat_message_info:New()
end

CEventSendChatMessageToChannel._proto = {
  [1] = {
    "m_sender_pstid",
    "int64"
  },
  [2] = {
    "m_channel",
    "chat_channel_token"
  },
  [3] = {
    "m_message",
    "chat_message_info"
  }
}
_class("CEventSendChatMessageToChannelResult", CCallReplyEvent)
CEventSendChatMessageToChannelResult = CEventSendChatMessageToChannelResult

function CEventSendChatMessageToChannelResult:Constructor()
  self.m_ret = 0
end

CEventSendChatMessageToChannelResult._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventSendChatMessageToPlayer", CCallRequestEvent)
CEventSendChatMessageToPlayer = CEventSendChatMessageToPlayer

function CEventSendChatMessageToPlayer:Constructor()
  self.m_sender_pstid = 0
  self.m_receiver_pstid = 0
  self.m_message = chat_message_info:New()
end

CEventSendChatMessageToPlayer._proto = {
  [1] = {
    "m_sender_pstid",
    "int64"
  },
  [2] = {
    "m_receiver_pstid",
    "int64"
  },
  [3] = {
    "m_message",
    "chat_message_info"
  }
}
_class("CEventSendChatMessageToPlayerResult", CCallReplyEvent)
CEventSendChatMessageToPlayerResult = CEventSendChatMessageToPlayerResult

function CEventSendChatMessageToPlayerResult:Constructor()
  self.m_ret = 0
end

CEventSendChatMessageToPlayerResult._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventPushChatMessageToChannel", CChatPushEvent)
CEventPushChatMessageToChannel = CEventPushChatMessageToChannel

function CEventPushChatMessageToChannel:Constructor()
  self.m_msg = ChatChannelMessage:New()
  self.m_ret = 0
end

CEventPushChatMessageToChannel._proto = {
  [1] = {
    "m_msg",
    "ChatChannelMessage"
  },
  [2] = {"m_ret", "int"}
}
_class("CEventPushChatMessageToPlayer", CChatPushEvent)
CEventPushChatMessageToPlayer = CEventPushChatMessageToPlayer

function CEventPushChatMessageToPlayer:Constructor()
  self.m_msg = ChatPrivateMessage:New()
  self.m_ret = 0
end

CEventPushChatMessageToPlayer._proto = {
  [1] = {
    "m_msg",
    "ChatPrivateMessage"
  },
  [2] = {"m_ret", "int"}
}
_class("CEventPushJoinChatChannelResultMessage", CChatPushEvent)
CEventPushJoinChatChannelResultMessage = CEventPushJoinChatChannelResultMessage

function CEventPushJoinChatChannelResultMessage:Constructor()
  self.m_channel = chat_channel_token:New()
  self.m_channel_config = ChatChannelConfig:New()
  self.m_ret = 0
end

CEventPushJoinChatChannelResultMessage._proto = {
  [1] = {
    "m_channel",
    "chat_channel_token"
  },
  [2] = {
    "m_channel_config",
    "ChatChannelConfig"
  },
  [3] = {"m_ret", "int"}
}
_class("CEventPushLeaveChatChannelResultMessage", CChatPushEvent)
CEventPushLeaveChatChannelResultMessage = CEventPushLeaveChatChannelResultMessage

function CEventPushLeaveChatChannelResultMessage:Constructor()
  self.m_channel = chat_channel_token:New()
  self.m_ret = 0
end

CEventPushLeaveChatChannelResultMessage._proto = {
  [1] = {
    "m_channel",
    "chat_channel_token"
  },
  [2] = {"m_ret", "int"}
}
