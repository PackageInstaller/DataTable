local SocialErrorCode = {
  SOCIAL_SUCC = 0,
  SOCIAL_FAILED = 1,
  SOCIAL_ERROR_SYSTEM = 10,
  SOCIAL_ERROR_SYSTEM_RMI = 11,
  SOCIAL_ERROR_DB = 12,
  SOCIAL_ERROR_PARAM = 100,
  SOCIAL_ERROR_DUPLICATE = 200,
  SOCIAL_ERROR_SELF_COUNT_MAX = 201,
  SOCIAL_ERROR_PEER_COUNT_MAX = 202,
  SOCIAL_ERROR_SELF = 203,
  SOCIAL_ERROR_NULL_SOC = 204,
  SOCIAL_ERROR_INVITATION_COUNT_MAX = 301,
  SOCIAL_ERROR_INVITATION_SELF = 302,
  SOCIAL_ERROR_DUPLICATE_BLACK = 400,
  SOCIAL_ERROR_SELF_IN_BLACK = 401,
  SOCIAL_ERROR_PEER_IN_BLACK = 402,
  SOCIAL_ERROR_IN_PEER_INV_LIST = 403,
  SOCIAL_ERROR_ALREAD_PEER_FRIEND = 404,
  SOCIAL_CHAT_ERROR_PARAM = 501,
  SOCIAL_CHAT_ERROR_S2SRMI_FAIL = 502,
  SOCIAL_CHAT_ERROR_CHANNEL_NOT_FOUND = 503,
  SOCIAL_CHAT_ERROR_NOT_IN_CHANNEL = 504,
  SOCIAL_CHAT_ERROR_NOT_PERMISSION_LOW_LEVEL = 505,
  SOCIAL_CHAT_ERROR_FREQUENCY_LIMIT = 506,
  SOCIAL_CHAT_ERROR_LENGTH_LIMIT = 507,
  SOCIAL_CHAT_ERROR_PLAYER_STATISICS_GET_FAIL = 508,
  SOCIAL_CHAT_ERROR_PLAYER_GET_INFO_FAIL = 509,
  SOCIAL_CHAT_ERROR_PLAYER_REFUSE_RECEIVE = 510,
  SOCIAL_CHAT_NOT_FRIEND = 511,
  SOCIAL_CHAT_PEER_NOT_FRIEND = 512,
  SOCIAL_CHAT_SEND_TARGET_ERROR = 513,
  SOCIAL_CHAT_IS_EMPTY = 514,
  SOCIAL_SEARCH_PSTID_INVALID = 515,
  SOCIAL_CHAT_ERROR_TIME_OUT = 516,
  SOCIAL_CHAT_SEND_TYPE_ERROR = 517,
  SOCIAL_CHAT_EMOJI_NUM_ERROR = 518,
  SOCIAL_REMARK_LIMIT = 519,
  SOCIAL_REMARK_DIRTY = 520,
  SOCIAL_REMARK_SPE = 521,
  SOCIAL_REMARK_INVALID = 522,
  SOCIAL_BLACK_LIST_LIMIT = 523,
  SOCIAL_INVITATION_MUTUAL_SUCCESS = 524
}
_enum("SocialErrorCode", SocialErrorCode)
local SocialChatErrorCode = {SOCIAL_CHAT_SUCCESS = 0, SOCIAL_CHAT_FAILED = 1}
_enum("SocialChatErrorCode", SocialChatErrorCode)
local SocialType = {
  SOCIAL_TYPE_NONE = 0,
  SOCIAL_TYPE_SELF = 1,
  SOCIAL_TYPE_STRANGER = 100,
  SOCIAL_TYPE_FRIEND = 1000,
  SOCIAL_TYPE_LOVER = 2000
}
_enum("SocialType", SocialType)
local InvitationType = {
  INVAITATION_TYPE_NONE = 0,
  INVAITATION_TYPE_FRIEND = 1,
  INVAITATION_TYPE_LOVER = 2
}
_enum("InvitationType", InvitationType)
local UpdateFriendInfoType = {
  UpdateFriendInfoType_Update = 0,
  UpdateFriendInfoType_Add = 1,
  UpdateFriendInfoType_Del = 2
}
_enum("UpdateFriendInfoType", UpdateFriendInfoType)
local SocialRecommendType = {
  SocialRecommendType_Common = 0,
  SocialRecommendType_Help = 1,
  SocialRecommendType_Niubility = 2,
  SocialRecommendType_Random = 3,
  SocialRecommendType_Count = 4
}
_enum("SocialRecommendType", SocialRecommendType)
_class("role_world_boss_info", Object)
role_world_boss_info = role_world_boss_info

function role_world_boss_info:Constructor()
  self.dan_head_switch = true
  self.dan = 0
  self.grading = 0
end

role_world_boss_info._proto = {
  [1] = {
    "dan_head_switch",
    "bool"
  },
  [2] = {"dan", "int"},
  [3] = {"grading", "int"}
}
_class("social_player_info", Object)
social_player_info = social_player_info

function social_player_info:Constructor()
  self.pstid = 0
  self.nick = ""
  self.head = 0
  self.head_bg = 0
  self.level = 0
  self.is_online = false
  self.create_time = 0
  self.last_logout_time = 0
  self.remark_name = ""
  self.help_pet = {}
  self.frame_id = 0
  self.world_boss_info = role_world_boss_info:New()
  self.peak_score = 0
  self.homeland_info = HomelandSimpleInfo:New()
  self.difficulty_mission = 0
  self.sailing_mission = 0
  self.title_used = 0
  self.fifure_used = 0
  self.medal_placement = medal_placement_info:New()
  self.collect_cards = {}
end

social_player_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"nick", "string"},
  [3] = {"head", "int"},
  [4] = {"head_bg", "int"},
  [5] = {"level", "int"},
  [6] = {"is_online", "bool"},
  [7] = {
    "create_time",
    "time"
  },
  [8] = {
    "last_logout_time",
    "time"
  },
  [9] = {
    "remark_name",
    "string"
  },
  [10] = {
    "help_pet",
    "list<role_help_pet_info>"
  },
  [11] = {"frame_id", "int"},
  [12] = {
    "world_boss_info",
    "role_world_boss_info"
  },
  [13] = {"peak_score", "int64"},
  [14] = {
    "homeland_info",
    "HomelandSimpleInfo"
  },
  [15] = {
    "difficulty_mission",
    "int"
  },
  [16] = {
    "sailing_mission",
    "int"
  },
  [17] = {"title_used", "int"},
  [18] = {
    "fifure_used",
    "int"
  },
  [19] = {
    "medal_placement",
    "medal_placement_info"
  },
  [26] = {
    "collect_cards",
    "map<int,map<int,int>>"
  }
}
_class("social_info_mobile", Object)
social_info_mobile = social_info_mobile

function social_info_mobile:Constructor()
  self.simple_info = social_player_info:New()
  self.create_time = 0
  self.un_read_msg_num = 0
  self.end_msg_time = 0
end

social_info_mobile._proto = {
  [1] = {
    "simple_info",
    "social_player_info"
  },
  [2] = {
    "create_time",
    "time"
  },
  [3] = {
    "un_read_msg_num",
    "int"
  },
  [4] = {
    "end_msg_time",
    "time"
  }
}
_class("social_recommend", Object)
social_recommend = social_recommend

function social_recommend:Constructor()
  self.nRecommendType = 0
  self.recommend_info = social_player_info:New()
end

social_recommend._proto = {
  [1] = {
    "nRecommendType",
    "int"
  },
  [2] = {
    "recommend_info",
    "social_player_info"
  }
}
_class("social_player_detail_info", Object)
social_player_detail_info = social_player_detail_info

function social_player_detail_info:Constructor()
  self.simple_info = social_player_info:New()
  self.role_sign_text = ""
  self.fight_info = role_fight_info:New()
  self.choose_painting = MobileChoosePainting:New()
end

social_player_detail_info._proto = {
  [1] = {
    "simple_info",
    "social_player_info"
  },
  [2] = {
    "role_sign_text",
    "string"
  },
  [3] = {
    "fight_info",
    "role_fight_info"
  },
  [4] = {
    "choose_painting",
    "MobileChoosePainting"
  }
}
_class("social_invitation_info_mobile", Object)
social_invitation_info_mobile = social_invitation_info_mobile

function social_invitation_info_mobile:Constructor()
  self.sender_info = social_player_info:New()
  self.create_time = 0
end

social_invitation_info_mobile._proto = {
  [1] = {
    "sender_info",
    "social_player_info"
  },
  [2] = {
    "create_time",
    "time"
  }
}
_class("send_invitation", Object)
send_invitation = send_invitation

function send_invitation:Constructor()
  self.receiver_pstid = 0
  self.invitation_type = 0
end

send_invitation._proto = {
  [1] = {
    "receiver_pstid",
    "int64"
  },
  [2] = {
    "invitation_type",
    "int"
  }
}
_class("process_invitation", Object)
process_invitation = process_invitation

function process_invitation:Constructor()
  self.sender_pstid = 0
  self.is_pass = false
end

process_invitation._proto = {
  [1] = {
    "sender_pstid",
    "int64"
  },
  [2] = {"is_pass", "bool"}
}
_class("social_black_info", Object)
social_black_info = social_black_info

function social_black_info:Constructor()
  self.self_pstid = 0
  self.black_pstid = 0
  self.create_time = 0
end

social_black_info._proto = {
  [1] = {"self_pstid", "int64"},
  [2] = {
    "black_pstid",
    "int64"
  },
  [3] = {
    "create_time",
    "time"
  }
}
_class("social_msg_mobile", Object)
social_msg_mobile = social_msg_mobile

function social_msg_mobile:Constructor()
  self.chat_time = 0
  self.chat_message = ""
end

social_msg_mobile._proto = {
  [1] = {"chat_time", "time"},
  [2] = {
    "chat_message",
    "string"
  }
}
