_class("ChatMessage", Object)
ChatMessage = ChatMessage

function ChatMessage:Constructor()
  self.chat_type = 0
  self.send_id = 0
  self.send_nick = ""
  self.msg = ""
  self.send_time = 0
  self.target_id = 0
  self.server_name = ""
  self.is_same_server = true
  self.speed = 0
  self.msg_flag = 0
  self.msg_length = 0
  self.server_id = 0
  self.room_id = 0
  self.room_show_id = 0
  self.explore_id = 0
  self.difficuty = 0
  self.rate = 0
  self.mode = 0
  self.military_rank_level = 1
end

ChatMessage._proto = {
  [1] = {"chat_type", "int"},
  [2] = {"send_id", "int64"},
  [3] = {"send_nick", "string"},
  [4] = {"msg", "string"},
  [5] = {"send_time", "time"},
  [6] = {"target_id", "int64"},
  [7] = {
    "server_name",
    "string"
  },
  [8] = {
    "is_same_server",
    "bool"
  },
  [9] = {"speed", "int"},
  [10] = {"msg_flag", "int"},
  [11] = {"msg_length", "int"},
  [12] = {"server_id", "int"},
  [14] = {"room_id", "int64"},
  [15] = {
    "room_show_id",
    "int"
  },
  [16] = {"explore_id", "int"},
  [17] = {"difficuty", "int"},
  [18] = {"rate", "int"},
  [19] = {"mode", "int"},
  [20] = {
    "military_rank_level",
    "int"
  }
}
local CHAT_CHANNEL_TYPE = {
  CHAT_CHANNEL_TYPE_UNKONW = 0,
  CHAT_CHANNEL_TYPE_GROUP = 1,
  CHAT_CHANNEL_TYPE_STATIC = 2,
  CHAT_CHANNEL_TYPE_WORLD = 3,
  CHAT_CHANNEL_TYPE_PRIVATE = 4,
  CHAT_CHANNEL_TYPE_BACKEND = 5,
  CHAT_CHANNEL_TYPE_SYSTEM = 6
}
_enum("CHAT_CHANNEL_TYPE", CHAT_CHANNEL_TYPE)
local CHAT_CHANNEL_CONFIG_TYPE = {
  CHAT_CHANNEL_CONFIG_TYPE_UNKONW = 0,
  CHAT_CHANNEL_CONFIG_TYPE_PRIVATE = 1,
  CHAT_CHANNEL_CONFIG_TYPE_WORLD = 2,
  CHAT_CHANNEL_CONFIG_TYPE_VIP = 100,
  CHAT_CHANNEL_CONFIG_TYPE_ROOM = 200,
  CHAT_CHANNEL_CONFIG_TYPE_MATCH = 201,
  CHAT_CHANNEL_CONFIG_TYPE_GUILD = 300,
  CHAT_CHANNEL_CONFIG_TYPE_SYSTEM = 400
}
_enum("CHAT_CHANNEL_CONFIG_TYPE", CHAT_CHANNEL_CONFIG_TYPE)
local SERVER_TYPE = {
  SERVER_TYPE_GAME = 54,
  SERVER_TYPE_UNIQUE = 57,
  SERVER_TYPE_MATCH = 62,
  SERVER_TYPE_ROOM = 63
}
_enum("SERVER_TYPE", SERVER_TYPE)
local CHAT_STATIC_CHANNEL_ID = {CHAT_STATIC_CHANNEL_ID_UNKONW = 0, CHAT_STATIC_CHANNEL_ID_VIP = 1}
_enum("CHAT_STATIC_CHANNEL_ID", CHAT_STATIC_CHANNEL_ID)
_class("ChatChannelConfig", Object)
ChatChannelConfig = ChatChannelConfig

function ChatChannelConfig:Constructor()
  self.config_type = 0
  self.channel_name = ""
  self.chat_frequency_check_interval = 0
  self.chat_frequency_check_count = 0
  self.chat_length_limit = 0
end

ChatChannelConfig._proto = {
  [1] = {
    "config_type",
    "int"
  },
  [2] = {
    "channel_name",
    "string"
  },
  [3] = {
    "chat_frequency_check_interval",
    "int"
  },
  [4] = {
    "chat_frequency_check_count",
    "int"
  },
  [5] = {
    "chat_length_limit",
    "int"
  }
}
_class("ChatStatistics", Object)
ChatStatistics = ChatStatistics

function ChatStatistics:Constructor()
  self.last_send_chat_message = 0
  self.chat_message_count = 0
end

ChatStatistics._proto = {
  [1] = {
    "last_send_chat_message",
    "uint"
  },
  [2] = {
    "chat_message_count",
    "int"
  }
}
_class("chat_player_info", Object)
chat_player_info = chat_player_info

function chat_player_info:Constructor()
  self.pstid = 0
  self.nick = ""
  self.level = 0
end

chat_player_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"nick", "string"},
  [3] = {"level", "int"}
}
_class("chat_channel_token", Object)
chat_channel_token = chat_channel_token

function chat_channel_token:Constructor()
  self.server_type = 0
  self.server_id = 0
  self.channel_type = 0
  self.channel_id = 0
end

chat_channel_token._proto = {
  [1] = {
    "server_type",
    "short"
  },
  [2] = {"server_id", "short"},
  [3] = {
    "channel_type",
    "short"
  },
  [4] = {"channel_id", "int64"}
}
local FRIEND_CHAT_MSG_TYPE = {FRIEND_CHAT_MSG_TYPE_STR = 0, FRIEND_CHAT_MSG_TYPE_EMOJI = 1}
_enum("FRIEND_CHAT_MSG_TYPE", FRIEND_CHAT_MSG_TYPE)
_class("chat_message_info", Object)
chat_message_info = chat_message_info

function chat_message_info:Constructor()
  self.chat_time = 0
  self.chat_message = ""
  self.china_chat_message = ""
  self.msg_id = 0
  self.friend_msg_type = FRIEND_CHAT_MSG_TYPE.FRIEND_CHAT_MSG_TYPE_STR
  self.emoji_id = 0
end

chat_message_info._proto = {
  [1] = {"chat_time", "time"},
  [2] = {
    "chat_message",
    "string"
  },
  [3] = {
    "china_chat_message",
    "string"
  },
  [4] = {"msg_id", "uint64"},
  [5] = {
    "friend_msg_type",
    "short"
  },
  [6] = {"emoji_id", "short"}
}
_class("ChatChannelMessage", Object)
ChatChannelMessage = ChatChannelMessage

function ChatChannelMessage:Constructor()
  self.m_sender = chat_player_info:New()
  self.m_channel = chat_channel_token:New()
  self.m_message = chat_message_info:New()
end

ChatChannelMessage._proto = {
  [1] = {
    "m_sender",
    "chat_player_info"
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
_class("ChatPrivateMessage", Object)
ChatPrivateMessage = ChatPrivateMessage

function ChatPrivateMessage:Constructor()
  self.m_sender = chat_player_info:New()
  self.m_receiver_pstid = 0
  self.m_message = chat_message_info:New()
end

ChatPrivateMessage._proto = {
  [1] = {
    "m_sender",
    "chat_player_info"
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
