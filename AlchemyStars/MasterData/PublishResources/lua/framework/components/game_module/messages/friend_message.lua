require("message_def")
local friendMessageDef = {
  CLSID_CEventGetOnlinePlayer = 27000,
  CLSID_CEventGetOnlinePlayerResult = 27001,
  CLSID_CEventGetFriendList = 27002,
  CLSID_CEventGetFriendListResult = 27003,
  CLSID_CEventGetFriendInvitationList = 27004,
  CLSID_CEventGetFriendInvitationListResult = 27005,
  CLSID_CEventGetSocialBlackList = 27006,
  CLSID_CEventGetSocialBlackListResult = 27007,
  CLSID_CEventAddFriend = 27008,
  CLSID_CEventAddFriendResult = 27009,
  CLSID_CEventProcessAddFriend = 27010,
  CLSID_CEventProcessAddFriendResult = 27011,
  CLSID_CEventUpdateSocialBlackList = 27012,
  CLSID_CEventUpdateSocialBlackListResult = 27013,
  CLSID_CEventDelFriend = 27014,
  CLSID_CEventDelFriendResult = 27015,
  CLSID_CEventUpdateIntimacy = 27016,
  CLSID_CEventUpdateIntimacyResult = 27017,
  CLSID_CEventPushUpdateFriendInvitation = 27018,
  CLSID_CEventPushUpdateFriendOtherInvitation = 27019,
  CLSID_CEventPushUpdateFriendList = 27020,
  CLSID_CEventEnterChatFriendModule = 27021,
  CLSID_CEventEnterChatFriendModuleResult = 27022,
  CLSID_CEventLeaveChatFriendModule = 27023,
  CLSID_CEventLeaveChatFriendModuleResult = 27024,
  CLSID_CEventSelectChatFriend = 27025,
  CLSID_CEventSelectChatFriendResult = 27026,
  CLSID_CEventPushClientRecvMaxMsgIdAck = 27027,
  CLSID_CEventPushHaveNewFriendMsg = 27028,
  CLSID_CEventPushHaveNewFriendMsgInner = 27029,
  CLSID_CEventSendFriendMsg = 27030,
  CLSID_CEventSendFriendMsgResult = 27031,
  CLSID_CEventPushFriendMsg = 27032,
  CLSID_CEventSearchFriend = 27033,
  CLSID_CEventSearchFriendResult = 27034,
  CLSID_CEventPushHaveNewMsg = 27035,
  CLSID_CEventOutSidePushNewMsg = 27036,
  CLSID_CEventGetPlayerDetailInfo = 27037,
  CLSID_CEventGetPlayerDetailInfoResult = 27038,
  CLSID_CEventSetFriendRemarkName = 27039,
  CLSID_CEventSetFriendRemarkNameResult = 27040,
  CLSID_CEventRefreshRecommendPlayer = 27041,
  CLSID_CEventRefreshRecommendPlayerResult = 27042,
  CLSID_CEventRefreshFriendOnlineState = 27043,
  CLSID_CEventRefreshFriendOnlineStateResult = 27044,
  CLSID_CEventBothwayFriendReq = 27045,
  CLSID_CEventBothwayFriendResult = 27046
}
table.append(MessageDef, friendMessageDef)
_class("CEventGetOnlinePlayer", CCallRequestEvent)
CEventGetOnlinePlayer = CEventGetOnlinePlayer

function CEventGetOnlinePlayer:Constructor()
  self.page_number = 0
end

CEventGetOnlinePlayer._proto = {
  [1] = {
    "page_number",
    "int"
  }
}
_class("CEventGetOnlinePlayerResult", CCallReplyEvent)
CEventGetOnlinePlayerResult = CEventGetOnlinePlayerResult

function CEventGetOnlinePlayerResult:Constructor()
  self.ret = 0
  self.player_list = {}
end

CEventGetOnlinePlayerResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "player_list",
    "list<role_simple_info>"
  }
}
_class("CEventGetFriendList", CCallRequestEvent)
CEventGetFriendList = CEventGetFriendList

function CEventGetFriendList:Constructor()
end

CEventGetFriendList._proto = {}
_class("CEventGetFriendListResult", CCallReplyEvent)
CEventGetFriendListResult = CEventGetFriendListResult

function CEventGetFriendListResult:Constructor()
  self.ret = 0
  self.friend_list = {}
end

CEventGetFriendListResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "friend_list",
    "map<int64,social_info_mobile>"
  }
}
_class("CEventGetFriendInvitationList", CCallRequestEvent)
CEventGetFriendInvitationList = CEventGetFriendInvitationList

function CEventGetFriendInvitationList:Constructor()
end

CEventGetFriendInvitationList._proto = {}
_class("CEventGetFriendInvitationListResult", CCallReplyEvent)
CEventGetFriendInvitationListResult = CEventGetFriendInvitationListResult

function CEventGetFriendInvitationListResult:Constructor()
  self.ret = 0
  self.invitation_list = {}
end

CEventGetFriendInvitationListResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "invitation_list",
    "list<social_invitation_info_mobile>"
  }
}
_class("CEventGetSocialBlackList", CCallRequestEvent)
CEventGetSocialBlackList = CEventGetSocialBlackList

function CEventGetSocialBlackList:Constructor()
end

CEventGetSocialBlackList._proto = {}
_class("CEventGetSocialBlackListResult", CCallReplyEvent)
CEventGetSocialBlackListResult = CEventGetSocialBlackListResult

function CEventGetSocialBlackListResult:Constructor()
  self.ret = 0
  self.black_list = {}
end

CEventGetSocialBlackListResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "black_list",
    "map<int64,social_player_info>"
  }
}
_class("CEventAddFriend", CCallRequestEvent)
CEventAddFriend = CEventAddFriend

function CEventAddFriend:Constructor()
  self.send_invt = send_invitation:New()
end

CEventAddFriend._proto = {
  [1] = {
    "send_invt",
    "send_invitation"
  }
}
_class("CEventAddFriendResult", CCallReplyEvent)
CEventAddFriendResult = CEventAddFriendResult

function CEventAddFriendResult:Constructor()
  self.ret = 0
end

CEventAddFriendResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventProcessAddFriend", CCallRequestEvent)
CEventProcessAddFriend = CEventProcessAddFriend

function CEventProcessAddFriend:Constructor()
  self.proc_invt = process_invitation:New()
end

CEventProcessAddFriend._proto = {
  [1] = {
    "proc_invt",
    "process_invitation"
  }
}
_class("CEventProcessAddFriendResult", CCallReplyEvent)
CEventProcessAddFriendResult = CEventProcessAddFriendResult

function CEventProcessAddFriendResult:Constructor()
  self.ret = 0
end

CEventProcessAddFriendResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventUpdateSocialBlackList", CCallRequestEvent)
CEventUpdateSocialBlackList = CEventUpdateSocialBlackList

function CEventUpdateSocialBlackList:Constructor()
  self.black_pstid = 0
  self.is_del = false
end

CEventUpdateSocialBlackList._proto = {
  [1] = {
    "black_pstid",
    "int64"
  },
  [2] = {"is_del", "bool"}
}
_class("CEventUpdateSocialBlackListResult", CCallReplyEvent)
CEventUpdateSocialBlackListResult = CEventUpdateSocialBlackListResult

function CEventUpdateSocialBlackListResult:Constructor()
  self.ret = 0
  self.player_info = social_player_info:New()
end

CEventUpdateSocialBlackListResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "player_info",
    "social_player_info"
  }
}
_class("CEventDelFriend", CCallRequestEvent)
CEventDelFriend = CEventDelFriend

function CEventDelFriend:Constructor()
  self.peer_pstid = 0
end

CEventDelFriend._proto = {
  [1] = {"peer_pstid", "int64"}
}
_class("CEventDelFriendResult", CCallReplyEvent)
CEventDelFriendResult = CEventDelFriendResult

function CEventDelFriendResult:Constructor()
  self.ret = 0
end

CEventDelFriendResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventUpdateIntimacy", CCallRequestEvent)
CEventUpdateIntimacy = CEventUpdateIntimacy

function CEventUpdateIntimacy:Constructor()
  self.friend_pstid = 0
  self.change_value = 0
end

CEventUpdateIntimacy._proto = {
  [1] = {
    "friend_pstid",
    "int64"
  },
  [2] = {
    "change_value",
    "int"
  }
}
_class("CEventUpdateIntimacyResult", CCallReplyEvent)
CEventUpdateIntimacyResult = CEventUpdateIntimacyResult

function CEventUpdateIntimacyResult:Constructor()
  self.ret = 0
end

CEventUpdateIntimacyResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventPushUpdateFriendInvitation", CSvrPushEvent)
CEventPushUpdateFriendInvitation = CEventPushUpdateFriendInvitation

function CEventPushUpdateFriendInvitation:Constructor()
  self.bHaveNewInvitation = false
end

CEventPushUpdateFriendInvitation._proto = {
  [1] = {
    "bHaveNewInvitation",
    "bool"
  }
}
_class("CEventPushUpdateFriendOtherInvitation", CSvrPushEvent)
CEventPushUpdateFriendOtherInvitation = CEventPushUpdateFriendOtherInvitation

function CEventPushUpdateFriendOtherInvitation:Constructor()
  self.receiver_pstid = 0
  self.simple_info = role_simple_info:New()
  self.is_del = false
  self.is_pass = false
end

CEventPushUpdateFriendOtherInvitation._proto = {
  [1] = {
    "receiver_pstid",
    "int64"
  },
  [2] = {
    "simple_info",
    "role_simple_info"
  },
  [3] = {"is_del", "bool"},
  [4] = {"is_pass", "bool"}
}
_class("CEventPushUpdateFriendList", CSvrPushEvent)
CEventPushUpdateFriendList = CEventPushUpdateFriendList

function CEventPushUpdateFriendList:Constructor()
  self.update_info = social_info_mobile:New()
  self.update_type = 0
end

CEventPushUpdateFriendList._proto = {
  [1] = {
    "update_info",
    "social_info_mobile"
  },
  [2] = {
    "update_type",
    "int"
  }
}
_class("CEventEnterChatFriendModule", CCallRequestEvent)
CEventEnterChatFriendModule = CEventEnterChatFriendModule

function CEventEnterChatFriendModule:Constructor()
end

CEventEnterChatFriendModule._proto = {}
_class("CEventEnterChatFriendModuleResult", CCallReplyEvent)
CEventEnterChatFriendModuleResult = CEventEnterChatFriendModuleResult

function CEventEnterChatFriendModuleResult:Constructor()
  self.ret = 0
  self.friend_list = {}
  self.bHaveInvitation = false
  self.bIsGotInvitationList = false
end

CEventEnterChatFriendModuleResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "friend_list",
    "map<int64,social_info_mobile>"
  },
  [3] = {
    "bHaveInvitation",
    "bool"
  },
  [4] = {
    "bIsGotInvitationList",
    "bool"
  }
}
_class("CEventLeaveChatFriendModule", CCallRequestEvent)
CEventLeaveChatFriendModule = CEventLeaveChatFriendModule

function CEventLeaveChatFriendModule:Constructor()
end

CEventLeaveChatFriendModule._proto = {}
_class("CEventLeaveChatFriendModuleResult", CCallReplyEvent)
CEventLeaveChatFriendModuleResult = CEventLeaveChatFriendModuleResult

function CEventLeaveChatFriendModuleResult:Constructor()
  self.ret = 0
end

CEventLeaveChatFriendModuleResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventSelectChatFriend", CCallRequestEvent)
CEventSelectChatFriend = CEventSelectChatFriend

function CEventSelectChatFriend:Constructor()
  self.select_friend = 0
end

CEventSelectChatFriend._proto = {
  [1] = {
    "select_friend",
    "int64"
  }
}
_class("CEventSelectChatFriendResult", CCallReplyEvent)
CEventSelectChatFriendResult = CEventSelectChatFriendResult

function CEventSelectChatFriendResult:Constructor()
  self.ret = 0
  self.sender_pstid = 0
  self.msg_list = {}
end

CEventSelectChatFriendResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "sender_pstid",
    "int64"
  },
  [3] = {
    "msg_list",
    "list<chat_message_info>"
  }
}
_class("CEventPushClientRecvMaxMsgIdAck", CCliPushEvent)
CEventPushClientRecvMaxMsgIdAck = CEventPushClientRecvMaxMsgIdAck

function CEventPushClientRecvMaxMsgIdAck:Constructor()
  self.sender_pstid = 0
  self.recv_msg_max_id = 0
end

CEventPushClientRecvMaxMsgIdAck._proto = {
  [1] = {
    "sender_pstid",
    "int64"
  },
  [2] = {
    "recv_msg_max_id",
    "uint64"
  }
}
_class("CEventPushHaveNewFriendMsg", CSvrPushEvent)
CEventPushHaveNewFriendMsg = CEventPushHaveNewFriendMsg

function CEventPushHaveNewFriendMsg:Constructor()
end

CEventPushHaveNewFriendMsg._proto = {}
_class("CEventPushHaveNewFriendMsgInner", CSvrPushEvent)
CEventPushHaveNewFriendMsgInner = CEventPushHaveNewFriendMsgInner

function CEventPushHaveNewFriendMsgInner:Constructor()
  self.msg_player_list = {}
end

CEventPushHaveNewFriendMsgInner._proto = {
  [1] = {
    "msg_player_list",
    "list<int64>"
  }
}
_class("CEventSendFriendMsg", CCallRequestEvent)
CEventSendFriendMsg = CEventSendFriendMsg

function CEventSendFriendMsg:Constructor()
  self.select_friend = 0
  self.send_message = ""
  self.friend_msg_type = FRIEND_CHAT_MSG_TYPE.FRIEND_CHAT_MSG_TYPE_STR
  self.emoji_id = 0
end

CEventSendFriendMsg._proto = {
  [1] = {
    "select_friend",
    "int64"
  },
  [2] = {
    "send_message",
    "string"
  },
  [3] = {
    "friend_msg_type",
    "short"
  },
  [4] = {"emoji_id", "short"}
}
_class("CEventSendFriendMsgResult", CCallReplyEvent)
CEventSendFriendMsgResult = CEventSendFriendMsgResult

function CEventSendFriendMsgResult:Constructor()
  self.ret = 0
  self.send_msg = chat_message_info:New()
end

CEventSendFriendMsgResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "send_msg",
    "chat_message_info"
  }
}
_class("CEventPushFriendMsg", CSvrPushEvent)
CEventPushFriendMsg = CEventPushFriendMsg

function CEventPushFriendMsg:Constructor()
  self.sender_pstid = 0
  self.msg_list = {}
end

CEventPushFriendMsg._proto = {
  [1] = {
    "sender_pstid",
    "int64"
  },
  [2] = {
    "msg_list",
    "list<chat_message_info>"
  }
}
_class("CEventSearchFriend", CCallRequestEvent)
CEventSearchFriend = CEventSearchFriend

function CEventSearchFriend:Constructor()
  self.search_pstid_list = {}
end

CEventSearchFriend._proto = {
  [1] = {
    "search_pstid_list",
    "list<int64>"
  }
}
_class("CEventSearchFriendResult", CCallReplyEvent)
CEventSearchFriendResult = CEventSearchFriendResult

function CEventSearchFriendResult:Constructor()
  self.ret = 0
  self.player_info_list = {}
end

CEventSearchFriendResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "player_info_list",
    "list<social_player_info>"
  }
}
_class("CEventPushHaveNewMsg", CSvrPushEvent)
CEventPushHaveNewMsg = CEventPushHaveNewMsg

function CEventPushHaveNewMsg:Constructor()
  self.sender_pstid = 0
  self.send_time = 0
end

CEventPushHaveNewMsg._proto = {
  [1] = {
    "sender_pstid",
    "int64"
  },
  [2] = {"send_time", "time"}
}
_class("CEventOutSidePushNewMsg", CSvrPushEvent)
CEventOutSidePushNewMsg = CEventOutSidePushNewMsg

function CEventOutSidePushNewMsg:Constructor()
end

CEventOutSidePushNewMsg._proto = {}
_class("CEventGetPlayerDetailInfo", CCallRequestEvent)
CEventGetPlayerDetailInfo = CEventGetPlayerDetailInfo

function CEventGetPlayerDetailInfo:Constructor()
  self.pst_id = 0
end

CEventGetPlayerDetailInfo._proto = {
  [1] = {"pst_id", "int64"}
}
_class("CEventGetPlayerDetailInfoResult", CCallReplyEvent)
CEventGetPlayerDetailInfoResult = CEventGetPlayerDetailInfoResult

function CEventGetPlayerDetailInfoResult:Constructor()
  self.ret = 0
  self.m_social_info = social_player_detail_info:New()
end

CEventGetPlayerDetailInfoResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "m_social_info",
    "social_player_detail_info"
  }
}
_class("CEventSetFriendRemarkName", CCallRequestEvent)
CEventSetFriendRemarkName = CEventSetFriendRemarkName

function CEventSetFriendRemarkName:Constructor()
  self.pst_id = 0
  self.remark_name = ""
end

CEventSetFriendRemarkName._proto = {
  [1] = {"pst_id", "int64"},
  [2] = {
    "remark_name",
    "string"
  }
}
_class("CEventSetFriendRemarkNameResult", CCallReplyEvent)
CEventSetFriendRemarkNameResult = CEventSetFriendRemarkNameResult

function CEventSetFriendRemarkNameResult:Constructor()
  self.ret = 0
end

CEventSetFriendRemarkNameResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventRefreshRecommendPlayer", CCallRequestEvent)
CEventRefreshRecommendPlayer = CEventRefreshRecommendPlayer

function CEventRefreshRecommendPlayer:Constructor()
  self.bRefresh = false
end

CEventRefreshRecommendPlayer._proto = {
  [1] = {"bRefresh", "bool"}
}
_class("CEventRefreshRecommendPlayerResult", CCallReplyEvent)
CEventRefreshRecommendPlayerResult = CEventRefreshRecommendPlayerResult

function CEventRefreshRecommendPlayerResult:Constructor()
  self.rec_vec = {}
end

CEventRefreshRecommendPlayerResult._proto = {
  [2] = {
    "rec_vec",
    "list<social_recommend>"
  }
}
_class("CEventRefreshFriendOnlineState", CCallRequestEvent)
CEventRefreshFriendOnlineState = CEventRefreshFriendOnlineState

function CEventRefreshFriendOnlineState:Constructor()
end

CEventRefreshFriendOnlineState._proto = {}
_class("CEventRefreshFriendOnlineStateResult", CCallReplyEvent)
CEventRefreshFriendOnlineStateResult = CEventRefreshFriendOnlineStateResult

function CEventRefreshFriendOnlineStateResult:Constructor()
  self.update_friend_list = {}
end

CEventRefreshFriendOnlineStateResult._proto = {
  [1] = {
    "update_friend_list",
    "list<social_info_mobile>"
  }
}
_class("CEventBothwayFriendReq", CCallRequestEvent)
CEventBothwayFriendReq = CEventBothwayFriendReq

function CEventBothwayFriendReq:Constructor()
  self.pst_id = 0
end

CEventBothwayFriendReq._proto = {
  [1] = {"pst_id", "int64"}
}
_class("CEventBothwayFriendResult", CCallReplyEvent)
CEventBothwayFriendResult = CEventBothwayFriendResult

function CEventBothwayFriendResult:Constructor()
  self.ret = 0
end

CEventBothwayFriendResult._proto = {
  [1] = {"ret", "int"}
}
