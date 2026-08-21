require("message_def")
local roleMessageDef = {
  CLSID_CEventMobileChooseRole = 20000,
  CLSID_CEventMobileChooseRoleResult = 20001,
  CLSID_CEventMobileCreateRole = 20002,
  CLSID_CEventMobileCreateRoleResult = 20003,
  CLSID_CEventPushPropertyChange = 20004,
  CLSID_CEventRoleHealthPoint = 20005,
  CLSID_CEventRoleHealthPointResult = 20006,
  CLSID_CEventUpdateMSDKAuthInfo = 20007,
  CLSID_CEventUpdateMSDKAuthInfoResult = 20008,
  CLSID_CEventMobileGetRandomNick = 20009,
  CLSID_CEventMobileGetRandomNickResult = 20010,
  CLSID_CEventRequestLoadCharList = 20011,
  CLSID_CEventLoadCharListResult = 20012,
  CLSID_CEventMobileRoleGetCardBaseInfo = 20013,
  CLSID_CEventMobileRoleGetCardBaseInfoResult = 20014,
  CLSID_CEventPushLevelChange = 20015,
  CLSID_CEventPushGuideChange = 20016,
  CLSID_CEventPushTextChange = 20017,
  CLSID_CEventPushUnlockCG = 20018,
  CLSID_CEventMobileRoleGetGuideInfo = 20019,
  CLSID_CEventMobileRoleGetGuideInfoResult = 20020,
  CLSID_CEventMobileRoleSetGuideInfo = 20021,
  CLSID_CEventMobileRoleSetGuideInfoResult = 20022,
  CLSID_CEventPushTips = 20023,
  CLSID_CEventPushDiamondChange = 20024,
  CLSID_CEventQueryQQVip = 20025,
  CLSID_CEventQueryQQVipResult = 20026,
  CLSID_CEventPushSyncItem = 20027,
  CLSID_CEventRequestSendAntiData = 20028,
  CLSID_CEventReplySendAntiData = 20029,
  CLSID_CEventPushRecvAntiData = 20030,
  CLSID_CEventPushStrongerAction = 20031,
  CLSID_CEventPushModuleCloseInfo = 20032,
  CLSID_CEventPushMsg = 20033,
  CLSID_CEventClientResume = 20034,
  CLSID_CEventClientResumeResult = 20035,
  CLSID_CEventPlayerShare = 20036,
  CLSID_CEventPlayerShareResult = 20037,
  CLSID_CEventChangePlayerName = 20038,
  CLSID_CEventChangePlayerNameResult = 20039,
  CLSID_CEventGetRandomSeed = 20040,
  CLSID_CEventGetRandomSeedResult = 20041,
  CLSID_CEventSetExtFlag = 20042,
  CLSID_CEventSetExtFlagResult = 20043,
  CLSID_CEventSetGuideReq = 20044,
  CLSID_CEventSetGuideAsw = 20045,
  CLSID_CEventPushModuleUnlocked = 20046,
  CLSID_CEventHomePageEnter = 20047,
  CLSID_CEventSkipStory = 20048,
  CLSID_CEventSkipStoryResult = 20049,
  CLSID_CEventEndStory = 20050,
  CLSID_CEventEndStoryResult = 20051,
  CLSID_CEventChangeLeader = 20052,
  CLSID_CEventChoosePainting = 20053,
  CLSID_CEventChoosePaintingResult = 20054,
  CLSID_CEventAmendRoleName_Req = 20055,
  CLSID_CEventAmendRoleName_Asw = 20056,
  CLSID_CEventAmendSignText_Req = 20057,
  CLSID_CEventAmendSignText_Asw = 20058,
  CLSID_CEventAmendHeadImage_Req = 20059,
  CLSID_CEventAmendHeadImage_Asw = 20060,
  CLSID_CEventClearHeadImageLock_Req = 20061,
  CLSID_CEventClearHeadImageLock_Asw = 20062,
  CLSID_CEventRoleInfo_Req = 20063,
  CLSID_CEventRoleInfo_Asw = 20064,
  CLSID_CEventRoleHeadImageLock_Req = 20065,
  CLSID_CEventRoleHeadImageLock_Asw = 20066,
  CLSID_CEventTssReportData = 20067,
  CLSID_CEventStoryAffinity = 20068,
  CLSID_CEventStoryAffinityResult = 20069,
  CLSID_CEventAddStoryAffinity = 20070,
  CLSID_CEventAddStoryAffinityResult = 20071,
  CLSID_CEventClientSaveLog = 20072,
  CLSID_CEventPrepareAll = 20073,
  CLSID_CEventPrepareAllResult = 20074,
  CLSID_CEventPrepareWork = 20075,
  CLSID_CEventPrepareWorkResult = 20076,
  CLSID_CEventEraseAccount = 20077,
  CLSID_CEventEraseAccountResult = 20078,
  CLSID_CEventAppHome = 20079,
  CLSID_CEventAppResume = 20080,
  CLSID_CEventMobileSettingInfo = 20081,
  CLSID_CEventAmendHeadFrame_Req = 20082,
  CLSID_CEventAmendHeadFrame_Asw = 20083,
  CLSID_CEventClearHeadFrameLock_Req = 20084,
  CLSID_CEventClearHeadFrameLock_Asw = 20085,
  CLSID_CEventRoleHeadFrameLock_Req = 20086,
  CLSID_CEventRoleHeadFrameLock_Asw = 20087,
  CLSID_CEventChooseBackImage = 20088,
  CLSID_CEventChooseBackImageResult = 20089,
  CLSID_CEventMinorChatResult = 20090,
  CLSID_CEventChooseBgm = 20091,
  CLSID_CEventChooseBgmResult = 20092,
  CLSID_CEventChangeTitle = 20093,
  CLSID_CEventChangeTitleResult = 20094,
  CLSID_CEventChangeTitleInfoResult = 20095,
  CLSID_CEventPushLoginComplete = 20096,
  CLSID_CEventMobileBadgeInfo = 20097,
  CLSID_CEventSeasonStoryReq = 20098,
  CLSID_CEventSeasonStoryResult = 20099
}
table.append(MessageDef, roleMessageDef)
local ROLE_RESULT_CODE = {
  ROLE_TRUE = 0,
  ROLE_SUCCESS = 0,
  ROLE_FALSE = 1,
  ROLE_FAILED = 1,
  ROLE_PERSIST_ERROR = 2,
  ROLE_ERROR_NULL_OBJECT = 3,
  ROLE_ERROR_NULL_PSTID = 4,
  ROLE_ERROR_ALREADY_HAVE_ROLE = 5,
  ROLE_ERROR_SEX = 6,
  ROLE_ERROR_NOT_ROLE = 7,
  ROLE_ERROR_DUPLICATE_NICK = 8,
  ROLE_ERROR_DIRTY_NICK = 9,
  ROLE_ERROR_LONG_NICK = 10,
  ROLE_ERROR_NOT_OPENID_ACCOUNTID = 11,
  ROLE_ERROR_ACCOUNT_HAVE_ROLE = 12,
  ROLE_ERROR_SERVER_MAINTAIN = 13,
  ROLE_ERROR_MSDK_ERROR = 14,
  ROLE_ALREADY_LOGIN = 15,
  ROLE_ERROR_MAX_REGISTER = 16,
  ROLE_ERROR_SERVERID = 17,
  ROLE_ERROR_NULL_RANDOMNICK = 18,
  ROLE_ERROR_NOT_ENOUGH_DIAMOND = 19,
  ROLE_ERROR_REGISTER_FLOWCONTROL = 20,
  ROLE_ERROR_CACHE_FAILURE = 21,
  ROLE_ERROR_CHANGE_NICK_INVALID = 22,
  ROLE_ERROR_CHANGE_NICK_LIMIT = 23,
  ROLE_ERROR_CHANGE_NICK_REPEAT = 24,
  ROLE_ERROR_CHANGE_NICK_SPE = 25,
  ROLE_CHOOSE_PAINTING_PET_INEXISTENCE = 26,
  ROLE_CHOOSE_PAINTING_PET_GRADE_TOOLOW = 27,
  ROLE_ERROR_INVALID_DATA = 28,
  ROLE_ERROR_HEAD_IMAGE_LOCK = 29,
  ROLE_ERROR_HEAD_IMAGE_LOCK_CONDITION = 30,
  ROLE_ERROR_AMEND_NAME_DIAMOND = 31,
  ROLE_ERROR_CHANGE_SIGN_LIMIT = 32,
  ROLE_ERROR_AMEND_NAME_BAN = 33,
  ROLE_ERROR_AMEND_SIGNS_BAN = 34,
  ROLE_TSSSDK_UIC_FAIL = 35,
  ROLE_STORYAFFINITY_NO_ID = 36,
  ROLE_STORYAFFINITY_NO_PET = 37,
  ROLE_STORYAFFINITY_RECEIVED = 38,
  ROLE_ERROR_HEAD_FRAME_LOCK = 39,
  ROLE_ERROR_HEAD_FRAME_LOCK_CONDITION = 40,
  ROLE_CHOOSE_PAINTING_PET_NO_SKIN = 41,
  ROLE_CHOOSE_PAINTING_NO_BOARD_PET = 42,
  ROLE_TITLE_NOT_ACCESS = 43,
  ROLE_FIFURE_NOT_ACCESS = 44,
  ROLE_CHOOSE_PAINTING_UNCHANGED = 60,
  ROLE_CHOOSE_PAINTING_INVALID_DATA = 61,
  ROLE_CHOOSE_PAINTING_CLEAR = 62,
  ROLE_ERROR_BANNED_LOGIN = 1000,
  ROLE_IS_CHOOSING_ROLE = 1001,
  ROLE_ERROR_CLOSE_REGISTER = 1002
}
_enum("ROLE_RESULT_CODE", ROLE_RESULT_CODE)
local EnumMaxStringLen = {E_MaxString_RoleName = 14, E_MaxString_SignText = 150}
_enum("EnumMaxStringLen", EnumMaxStringLen)
local RoleCardMessageError = {
  RCM_Succ = 0,
  RCM_NoPlayer = 1,
  RCM_Unknown = 2
}
_enum("RoleCardMessageError", RoleCardMessageError)
local CLICKENTRANCE = {
  CE_TASK = 1,
  CE_CHANGE_ASSISTANT = 2,
  CE_ADD_PHY = 3,
  CE_ADD_DIAMOND = 4,
  CE_PICTURE = 5,
  CE_GUILD = 6,
  CE_EXPLORE = 7,
  CE_SHOP = 8,
  CE_SETTING = 10,
  CE_MAIL = 11,
  CE_FRIEND = 12,
  CE_NOTICE = 13,
  CE_PLAYER_INFO = 14,
  CE_TEAM = 15,
  CE_PET = 16,
  CE_SUMMON = 17,
  CE_AIRCRAFT = 18,
  CE_STORE = 19
}
_enum("CLICKENTRANCE", CLICKENTRANCE)
_class("CEventMobileChooseRole", CCallRequestEvent)
CEventMobileChooseRole = CEventMobileChooseRole

function CEventMobileChooseRole:Constructor()
  self.server_id = 0
  self.persistid = 0
  self.intl_detect_country = ""
  self.player_choose_country = ""
  self.client_language_type = ""
end

CEventMobileChooseRole._proto = {
  [1] = {"server_id", "int"},
  [2] = {"persistid", "int64"},
  [3] = {
    "intl_detect_country",
    "string"
  },
  [4] = {
    "player_choose_country",
    "string"
  },
  [5] = {
    "client_language_type",
    "string"
  }
}
_class("CEventMobileChooseRoleResult", CCallReplyEvent)
CEventMobileChooseRoleResult = CEventMobileChooseRoleResult

function CEventMobileChooseRoleResult:Constructor()
  self.ret = 0
  self.mobile_char_info = MobileCharInfo:New()
  self.item_info_vec = {}
  self.offline_msg = {}
  self.pet_data_vec = {}
  self.pass_mission = {}
  self.already_return_power_mission_list = {}
  self.m_formation_info = {}
  self.client_aircraft_info = aircraft_info:New()
  self.aircraft_spaces = {}
  self.missionStoryData = mission_story_data:New()
  self.m_maze_info = maze_info:New()
  self.resdungeonAllData = dungeon_all_data:New()
  self.already_returned_power_resinstance = {}
  self.missionChapterAwardData = mission_chapter_award_data:New()
  self.all_market_info = all_market_data:New()
  self.shop_config = AllShopConfig:New()
  self.quest_data = MobileAllQuestData:New()
  self.new_pet_list = {}
  self.mobile_choose_painting = MobileChoosePainting:New()
  self.bHaveNewMail = false
  self.level_info = {}
  self.tower_data = player_tower_data:New()
  self.ban_info = idip_ban_msg:New()
  self.guide = false
  self.bHaveNewMsg = false
  self.story_affinity = {}
  self.tmMazeInitTime = 0
  self.gamble_pool_vec = {}
  self.today_first_login = false
  self.zone_id_type = 0
  self.is_sign_in_today = false
  self.next_sign_in_time = 0
  self.b_can_re_sign_in_ex_vig = false
  self.nChangeDayLoginDays = 0
  self.nNextTotalLoginRewardDays = 0
  self.total_diamond_count_ = 0
  self.m_extStoryDataList = DExtStoryDataList:New()
  self.b_tale_do = false
  self.b_tale_call = false
  self.next_zero_time = 0
  self.accept_status = {}
  self.reward_cfg = {}
  self.tale_stage_reward2accept = false
  self.minor_chat_open = false
  self.return_power_cam_mission_list = {}
  self.store_review = false
  self.apppublishsubtype = 0
  self.pet_skin_data_vec = {}
  self.next_GMT_zero_time = 0
  self.skin_market_datas = {}
  self.server_time_zone_diff = 0
  self.area_design_cfg = {}
  self.area_level_group_cfg = {}
  self.b_key_switch = false
  self.campaign_refresh_time = 0
  self.b_tale_task = false
  self.task_group_timeline = {}
  self.task_group_close_timeline = {}
  self.homeland_forge_data = ForgeQueueInfo:New()
  self.homeland_cultivation_data = CultivationInfo:New()
  self.homeland_visit_help_data = {}
  self.homeland_unlock_functions = {}
  self.group_id_set = {}
  self.is_fix = false
  self.fix_not_enough = {}
  self.medal_data = all_medal_data:New()
  self.movice_info = MoviceInfo:New()
  self.equip_refine_new = false
  self.season = season_ext_info:New()
  self.is_hand_operate = false
  self.spine_id = 0
end

CEventMobileChooseRoleResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "mobile_char_info",
    "MobileCharInfo"
  },
  [3] = {
    "item_info_vec",
    "list<item_data_info>"
  },
  [4] = {
    "offline_msg",
    "list<ChatMessage>"
  },
  [5] = {
    "pet_data_vec",
    "list<pet_data>"
  },
  [6] = {
    "pass_mission",
    "list<mission_info>"
  },
  [7] = {
    "already_return_power_mission_list",
    "list<int>"
  },
  [8] = {
    "m_formation_info",
    "list<formation_info>"
  },
  [9] = {
    "client_aircraft_info",
    "aircraft_info"
  },
  [10] = {
    "aircraft_spaces",
    "map<int,aircraft_space_info>"
  },
  [11] = {
    "missionStoryData",
    "mission_story_data"
  },
  [12] = {
    "m_maze_info",
    "maze_info"
  },
  [13] = {
    "resdungeonAllData",
    "dungeon_all_data"
  },
  [14] = {
    "already_returned_power_resinstance",
    "list<int>"
  },
  [15] = {
    "missionChapterAwardData",
    "mission_chapter_award_data"
  },
  [16] = {
    "all_market_info",
    "all_market_data"
  },
  [17] = {
    "shop_config",
    "AllShopConfig"
  },
  [18] = {
    "quest_data",
    "MobileAllQuestData"
  },
  [19] = {
    "new_pet_list",
    "list<int>"
  },
  [20] = {
    "mobile_choose_painting",
    "MobileChoosePainting"
  },
  [21] = {
    "bHaveNewMail",
    "bool"
  },
  [22] = {"level_info", "list<int>"},
  [23] = {
    "tower_data",
    "player_tower_data"
  },
  [24] = {
    "ban_info",
    "idip_ban_msg"
  },
  [25] = {"guide", "bool"},
  [26] = {
    "bHaveNewMsg",
    "bool"
  },
  [27] = {
    "story_affinity",
    "list<int>"
  },
  [28] = {
    "tmMazeInitTime",
    "time"
  },
  [29] = {
    "gamble_pool_vec",
    "list<PrizePoolInfo>"
  },
  [30] = {
    "today_first_login",
    "bool"
  },
  [31] = {
    "zone_id_type",
    "int"
  },
  [32] = {
    "is_sign_in_today",
    "bool"
  },
  [33] = {
    "next_sign_in_time",
    "time"
  },
  [34] = {
    "b_can_re_sign_in_ex_vig",
    "bool"
  },
  [35] = {
    "nChangeDayLoginDays",
    "int"
  },
  [36] = {
    "nNextTotalLoginRewardDays",
    "int"
  },
  [37] = {
    "total_diamond_count_",
    "int64"
  },
  [38] = {
    "m_extStoryDataList",
    "DExtStoryDataList"
  },
  [39] = {"b_tale_do", "bool"},
  [40] = {
    "b_tale_call",
    "bool"
  },
  [41] = {
    "next_zero_time",
    "time"
  },
  [42] = {
    "accept_status",
    "map<int,int>"
  },
  [43] = {
    "reward_cfg",
    "map<int,list<RoleAsset>>"
  },
  [44] = {
    "tale_stage_reward2accept",
    "bool"
  },
  [45] = {
    "minor_chat_open",
    "bool"
  },
  [46] = {
    "return_power_cam_mission_list",
    "list<int>"
  },
  [47] = {
    "store_review",
    "bool"
  },
  [48] = {
    "apppublishsubtype",
    "int"
  },
  [49] = {
    "pet_skin_data_vec",
    "list<pet_skin_data>"
  },
  [50] = {
    "next_GMT_zero_time",
    "time"
  },
  [51] = {
    "skin_market_datas",
    "map<int,SkinMarketGoodsInfo>"
  },
  [52] = {
    "server_time_zone_diff",
    "time"
  },
  [53] = {
    "area_design_cfg",
    "map<int,LostAreaDesignConfig>"
  },
  [54] = {
    "area_level_group_cfg",
    "map<int,LostAreaLevelGroupConfig>"
  },
  [55] = {
    "b_key_switch",
    "bool"
  },
  [56] = {
    "campaign_refresh_time",
    "time"
  },
  [57] = {
    "b_tale_task",
    "bool"
  },
  [58] = {
    "task_group_timeline",
    "list<homeland_sametime_group>"
  },
  [59] = {
    "task_group_close_timeline",
    "list<homeland_sametime_group>"
  },
  [60] = {
    "homeland_forge_data",
    "ForgeQueueInfo"
  },
  [61] = {
    "homeland_cultivation_data",
    "CultivationInfo"
  },
  [62] = {
    "homeland_visit_help_data",
    "map<int64,VisitHelpTimeInfo>"
  },
  [63] = {
    "homeland_unlock_functions",
    "list<int64>"
  },
  [64] = {
    "group_id_set",
    "list<int>"
  },
  [65] = {"is_fix", "bool"},
  [66] = {
    "fix_not_enough",
    "map<int,int64>"
  },
  [67] = {
    "medal_data",
    "all_medal_data"
  },
  [68] = {
    "movice_info",
    "MoviceInfo"
  },
  [69] = {
    "equip_refine_new",
    "bool"
  },
  [70] = {
    "season",
    "season_ext_info"
  },
  [71] = {
    "is_hand_operate",
    "bool"
  },
  [72] = {"spine_id", "int"}
}
_class("CEventMobileCreateRole", CCallRequestEvent)
CEventMobileCreateRole = CEventMobileCreateRole

function CEventMobileCreateRole:Constructor()
  self.sex = 0
  self.name = ""
end

CEventMobileCreateRole._proto = {
  [1] = {"sex", "int"},
  [2] = {"name", "string"}
}
_class("CEventMobileCreateRoleResult", CCallReplyEvent)
CEventMobileCreateRoleResult = CEventMobileCreateRoleResult

function CEventMobileCreateRoleResult:Constructor()
  self.ret = 0
  self.pstid = 0
end

CEventMobileCreateRoleResult._proto = {
  [1] = {"ret", "int"},
  [2] = {"pstid", "int64"}
}
_class("CEventPushPropertyChange", CSvrPushEvent)
CEventPushPropertyChange = CEventPushPropertyChange

function CEventPushPropertyChange:Constructor()
  self.info = MobileCharInfo:New()
end

CEventPushPropertyChange._proto = {
  [1] = {
    "info",
    "MobileCharInfo"
  }
}
_class("CEventRoleHealthPoint", CCallRequestEvent)
CEventRoleHealthPoint = CEventRoleHealthPoint

function CEventRoleHealthPoint:Constructor()
end

CEventRoleHealthPoint._proto = {}
_class("CEventRoleHealthPointResult", CCallReplyEvent)
CEventRoleHealthPointResult = CEventRoleHealthPointResult

function CEventRoleHealthPointResult:Constructor()
  self.phy_point = 0
  self.phy_last_time = 0
  self.phy_point_max = 0
  self.phy_point_rate = 0
end

CEventRoleHealthPointResult._proto = {
  [1] = {"phy_point", "int"},
  [2] = {
    "phy_last_time",
    "time"
  },
  [3] = {
    "phy_point_max",
    "int"
  },
  [4] = {
    "phy_point_rate",
    "int"
  }
}
_class("CEventUpdateMSDKAuthInfo", CCallRequestEvent)
CEventUpdateMSDKAuthInfo = CEventUpdateMSDKAuthInfo

function CEventUpdateMSDKAuthInfo:Constructor()
  self.auth_info = MSDKAuthInfo:New()
end

CEventUpdateMSDKAuthInfo._proto = {
  [1] = {
    "auth_info",
    "MSDKAuthInfo"
  }
}
_class("CEventUpdateMSDKAuthInfoResult", CCallReplyEvent)
CEventUpdateMSDKAuthInfoResult = CEventUpdateMSDKAuthInfoResult

function CEventUpdateMSDKAuthInfoResult:Constructor()
end

CEventUpdateMSDKAuthInfoResult._proto = {}
_class("CEventMobileGetRandomNick", CCallRequestEvent)
CEventMobileGetRandomNick = CEventMobileGetRandomNick

function CEventMobileGetRandomNick:Constructor()
  self.sex = 0
end

CEventMobileGetRandomNick._proto = {
  [1] = {"sex", "int"}
}
_class("CEventMobileGetRandomNickResult", CCallReplyEvent)
CEventMobileGetRandomNickResult = CEventMobileGetRandomNickResult

function CEventMobileGetRandomNickResult:Constructor()
  self.ret = 0
  self.name = ""
end

CEventMobileGetRandomNickResult._proto = {
  [1] = {"ret", "int"},
  [2] = {"name", "string"}
}
_class("CEventRequestLoadCharList", CCallRequestEvent)
CEventRequestLoadCharList = CEventRequestLoadCharList

function CEventRequestLoadCharList:Constructor()
end

CEventRequestLoadCharList._proto = {}
_class("CEventLoadCharListResult", CCallReplyEvent)
CEventLoadCharListResult = CEventLoadCharListResult

function CEventLoadCharListResult:Constructor()
  self.char_list = {}
end

CEventLoadCharListResult._proto = {
  [1] = {
    "char_list",
    "map<string,int64>"
  }
}
_class("CEventMobileRoleGetCardBaseInfo", CCallRequestEvent)
CEventMobileRoleGetCardBaseInfo = CEventMobileRoleGetCardBaseInfo

function CEventMobileRoleGetCardBaseInfo:Constructor()
  self.pstid = 0
end

CEventMobileRoleGetCardBaseInfo._proto = {
  [2] = {"pstid", "int64"}
}
_class("CEventMobileRoleGetCardBaseInfoResult", CCallReplyEvent)
CEventMobileRoleGetCardBaseInfoResult = CEventMobileRoleGetCardBaseInfoResult

function CEventMobileRoleGetCardBaseInfoResult:Constructor()
  self.result = 0
  self.contact_type = 0
  self.picture = ""
  self.base_info = base_char_info:New()
end

CEventMobileRoleGetCardBaseInfoResult._proto = {
  [1] = {"result", "int"},
  [2] = {
    "contact_type",
    "int"
  },
  [3] = {"picture", "string"},
  [4] = {
    "base_info",
    "base_char_info"
  }
}
_class("CEventPushLevelChange", CSvrPushEvent)
CEventPushLevelChange = CEventPushLevelChange

function CEventPushLevelChange:Constructor()
  self.level_id = 0
end

CEventPushLevelChange._proto = {
  [1] = {"level_id", "int"}
}
_class("CEventPushGuideChange", CSvrPushEvent)
CEventPushGuideChange = CEventPushGuideChange

function CEventPushGuideChange:Constructor()
  self.values = false
end

CEventPushGuideChange._proto = {
  [1] = {"values", "bool"}
}
_class("CEventPushTextChange", CSvrPushEvent)
CEventPushTextChange = CEventPushTextChange

function CEventPushTextChange:Constructor()
  self.nick = ""
end

CEventPushTextChange._proto = {
  [1] = {"nick", "string"}
}
_class("CEventPushUnlockCG", CSvrPushEvent)
CEventPushUnlockCG = CEventPushUnlockCG

function CEventPushUnlockCG:Constructor()
end

CEventPushUnlockCG._proto = {}
_class("CEventMobileRoleGetGuideInfo", CCallRequestEvent)
CEventMobileRoleGetGuideInfo = CEventMobileRoleGetGuideInfo

function CEventMobileRoleGetGuideInfo:Constructor()
end

CEventMobileRoleGetGuideInfo._proto = {}
_class("CEventMobileRoleGetGuideInfoResult", CCallReplyEvent)
CEventMobileRoleGetGuideInfoResult = CEventMobileRoleGetGuideInfoResult

function CEventMobileRoleGetGuideInfoResult:Constructor()
  self.result = 0
  self.guide_info = GuideInfo:New()
end

CEventMobileRoleGetGuideInfoResult._proto = {
  [1] = {"result", "int"},
  [2] = {"guide_info", "GuideInfo"}
}
_class("CEventMobileRoleSetGuideInfo", CCallRequestEvent)
CEventMobileRoleSetGuideInfo = CEventMobileRoleSetGuideInfo

function CEventMobileRoleSetGuideInfo:Constructor()
  self.guide_info = GuideInfo:New()
  self.cur_guide_id = 0
  self.force = 0
end

CEventMobileRoleSetGuideInfo._proto = {
  [1] = {"guide_info", "GuideInfo"},
  [2] = {
    "cur_guide_id",
    "int"
  },
  [3] = {"force", "int"}
}
_class("CEventMobileRoleSetGuideInfoResult", CCallReplyEvent)
CEventMobileRoleSetGuideInfoResult = CEventMobileRoleSetGuideInfoResult

function CEventMobileRoleSetGuideInfoResult:Constructor()
  self.result = 0
  self.guide_info = GuideInfo:New()
end

CEventMobileRoleSetGuideInfoResult._proto = {
  [1] = {"result", "int"},
  [2] = {"guide_info", "GuideInfo"}
}
_class("CEventPushTips", CSvrPushEvent)
CEventPushTips = CEventPushTips

function CEventPushTips:Constructor()
  self.tips_flag = 0
end

CEventPushTips._proto = {
  [1] = {"tips_flag", "int64"}
}
_class("CEventPushDiamondChange", CSvrPushEvent)
CEventPushDiamondChange = CEventPushDiamondChange

function CEventPushDiamondChange:Constructor()
  self.balance = 0
end

CEventPushDiamondChange._proto = {
  [1] = {"balance", "int"}
}
_class("CEventQueryQQVip", CCallRequestEvent)
CEventQueryQQVip = CEventQueryQQVip

function CEventQueryQQVip:Constructor()
end

CEventQueryQQVip._proto = {}
_class("CEventQueryQQVipResult", CCallReplyEvent)
CEventQueryQQVipResult = CEventQueryQQVipResult

function CEventQueryQQVipResult:Constructor()
  self.result = -1
  self.qq_wx_vip = 0
end

CEventQueryQQVipResult._proto = {
  [1] = {"result", "int"},
  [2] = {"qq_wx_vip", "int"}
}
_class("CEventPushSyncItem", CSvrPushEvent)
CEventPushSyncItem = CEventPushSyncItem

function CEventPushSyncItem:Constructor()
  self.reason = 0
  self.remove_items = {}
end

CEventPushSyncItem._proto = {
  [1] = {"reason", "int"},
  [2] = {
    "remove_items",
    "list<int64>"
  }
}
_class("CEventRequestSendAntiData", CCallRequestEvent)
CEventRequestSendAntiData = CEventRequestSendAntiData

function CEventRequestSendAntiData:Constructor()
  self.anti_data = ""
end

CEventRequestSendAntiData._proto = {
  [1] = {"anti_data", "buffer"}
}
_class("CEventReplySendAntiData", CCallReplyEvent)
CEventReplySendAntiData = CEventReplySendAntiData

function CEventReplySendAntiData:Constructor()
end

CEventReplySendAntiData._proto = {}
_class("CEventPushRecvAntiData", CSvrPushEvent)
CEventPushRecvAntiData = CEventPushRecvAntiData

function CEventPushRecvAntiData:Constructor()
  self.anti_data = ""
end

CEventPushRecvAntiData._proto = {
  [1] = {"anti_data", "buffer"}
}
_class("CEventPushStrongerAction", CSvrPushEvent)
CEventPushStrongerAction = CEventPushStrongerAction

function CEventPushStrongerAction:Constructor()
  self.tips_flag = {}
end

CEventPushStrongerAction._proto = {
  [1] = {
    "tips_flag",
    "map<int,int>"
  }
}
_class("CEventPushModuleCloseInfo", CSvrPushEvent)
CEventPushModuleCloseInfo = CEventPushModuleCloseInfo

function CEventPushModuleCloseInfo:Constructor()
  self.info = {}
  self.func_status = {}
end

CEventPushModuleCloseInfo._proto = {
  [1] = {"info", "list<int>"},
  [2] = {
    "func_status",
    "map<int,int>"
  }
}
_class("CEventPushMsg", CSvrPushEvent)
CEventPushMsg = CEventPushMsg

function CEventPushMsg:Constructor()
  self.m_content = ""
end

CEventPushMsg._proto = {
  [1] = {"m_content", "string"}
}
_class("CEventClientResume", CCallRequestEvent)
CEventClientResume = CEventClientResume

function CEventClientResume:Constructor()
  self.activity_pause_time = 0
end

CEventClientResume._proto = {
  [1] = {
    "activity_pause_time",
    "int"
  }
}
_class("CEventClientResumeResult", CCallReplyEvent)
CEventClientResumeResult = CEventClientResumeResult

function CEventClientResumeResult:Constructor()
  self.result = 0
end

CEventClientResumeResult._proto = {
  [1] = {"result", "int"}
}
_class("CEventPlayerShare", CCallRequestEvent)
CEventPlayerShare = CEventPlayerShare

function CEventPlayerShare:Constructor()
end

CEventPlayerShare._proto = {}
_class("CEventPlayerShareResult", CCallReplyEvent)
CEventPlayerShareResult = CEventPlayerShareResult

function CEventPlayerShareResult:Constructor()
  self.result = 0
end

CEventPlayerShareResult._proto = {
  [1] = {"result", "int"}
}
_class("CEventChangePlayerName", CCallRequestEvent)
CEventChangePlayerName = CEventChangePlayerName

function CEventChangePlayerName:Constructor()
  self.new_name = ""
end

CEventChangePlayerName._proto = {
  [1] = {"new_name", "string"}
}
_class("CEventChangePlayerNameResult", CCallReplyEvent)
CEventChangePlayerNameResult = CEventChangePlayerNameResult

function CEventChangePlayerNameResult:Constructor()
  self.ret = 0
end

CEventChangePlayerNameResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventGetRandomSeed", CCallRequestEvent)
CEventGetRandomSeed = CEventGetRandomSeed

function CEventGetRandomSeed:Constructor()
end

CEventGetRandomSeed._proto = {}
_class("CEventGetRandomSeedResult", CCallReplyEvent)
CEventGetRandomSeedResult = CEventGetRandomSeedResult

function CEventGetRandomSeedResult:Constructor()
  self.ret = 0
  self.seed = 0.0
end

CEventGetRandomSeedResult._proto = {
  [1] = {"ret", "int"},
  [2] = {"seed", "double"}
}
_class("CEventSetExtFlag", CCallRequestEvent)
CEventSetExtFlag = CEventSetExtFlag

function CEventSetExtFlag:Constructor()
  self.ext_flag = 0
  self.value = false
end

CEventSetExtFlag._proto = {
  [1] = {"ext_flag", "int"},
  [2] = {"value", "bool"}
}
_class("CEventSetExtFlagResult", CCallReplyEvent)
CEventSetExtFlagResult = CEventSetExtFlagResult

function CEventSetExtFlagResult:Constructor()
  self.ret = 0
end

CEventSetExtFlagResult._proto = {
  [1] = {"ret", "int"}
}
local EnumRoleGuideType = {E_RoleGuide_ExtMission = 9}
_enum("EnumRoleGuideType", EnumRoleGuideType)
_class("CEventSetGuideReq", CCallRequestEvent)
CEventSetGuideReq = CEventSetGuideReq

function CEventSetGuideReq:Constructor()
  self.m_nGuideKey = 0
  self.m_nGuideData = 0
end

CEventSetGuideReq._proto = {
  [1] = {
    "m_nGuideKey",
    "int"
  },
  [2] = {
    "m_nGuideData",
    "int"
  }
}
_class("CEventSetGuideAsw", CCallReplyEvent)
CEventSetGuideAsw = CEventSetGuideAsw

function CEventSetGuideAsw:Constructor()
  self.m_nResult = 0
  self.m_nGuideData = 0
end

CEventSetGuideAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_nGuideData",
    "int"
  }
}
_class("CEventPushModuleUnlocked", CSvrPushEvent)
CEventPushModuleUnlocked = CEventPushModuleUnlocked

function CEventPushModuleUnlocked:Constructor()
  self.unlock_modules = 0
  self.unlock_module_id = 0
end

CEventPushModuleUnlocked._proto = {
  [1] = {
    "unlock_modules",
    "int64"
  },
  [2] = {
    "unlock_module_id",
    "int"
  }
}
_class("CEventHomePageEnter", CCliPushEvent)
CEventHomePageEnter = CEventHomePageEnter

function CEventHomePageEnter:Constructor()
  self.entrance_id = 0
end

CEventHomePageEnter._proto = {
  [1] = {
    "entrance_id",
    "int"
  }
}
_class("CEventSkipStory", CCallRequestEvent)
CEventSkipStory = CEventSkipStory

function CEventSkipStory:Constructor()
  self.skip_id = 0
end

CEventSkipStory._proto = {
  [1] = {"skip_id", "int"}
}
_class("CEventSkipStoryResult", CCallReplyEvent)
CEventSkipStoryResult = CEventSkipStoryResult

function CEventSkipStoryResult:Constructor()
  self.ret = 0
end

CEventSkipStoryResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventEndStory", CCallRequestEvent)
CEventEndStory = CEventEndStory

function CEventEndStory:Constructor()
  self.story_id = 0
  self.paragraph_id = 0
  self.section_id = 0
  self.cost_second = 0
  self.be_skipped = 0
  self.be_mission = 0
end

CEventEndStory._proto = {
  [1] = {"story_id", "int"},
  [2] = {
    "paragraph_id",
    "int"
  },
  [3] = {"section_id", "int"},
  [4] = {
    "cost_second",
    "time"
  },
  [5] = {"be_skipped", "int"},
  [6] = {"be_mission", "int"}
}
_class("CEventEndStoryResult", CCallReplyEvent)
CEventEndStoryResult = CEventEndStoryResult

function CEventEndStoryResult:Constructor()
  self.ret = 0
end

CEventEndStoryResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventChangeLeader", CCliPushEvent)
CEventChangeLeader = CEventChangeLeader

function CEventChangeLeader:Constructor()
  self.battle_type = 0
  self.mission_id = 0
  self.pets_ids = {}
  self.change_leader_times = 0
  self.before_leader_id = 0
  self.after_leader_id = 0
  self.remain_change_time = 0
  self.be_active_change = false
end

CEventChangeLeader._proto = {
  [1] = {
    "battle_type",
    "int"
  },
  [2] = {"mission_id", "int"},
  [3] = {"pets_ids", "list<int>"},
  [4] = {
    "change_leader_times",
    "int"
  },
  [5] = {
    "before_leader_id",
    "int"
  },
  [6] = {
    "after_leader_id",
    "int"
  },
  [7] = {
    "remain_change_time",
    "int"
  },
  [8] = {
    "be_active_change",
    "bool"
  }
}
_class("CEventChoosePainting", CCallRequestEvent)
CEventChoosePainting = CEventChoosePainting

function CEventChoosePainting:Constructor()
  self.pet_template_id = 0
  self.pet_grade = 0
  self.skin_id = 0
  self.board_pet = 0
end

CEventChoosePainting._proto = {
  [1] = {
    "pet_template_id",
    "int"
  },
  [2] = {"pet_grade", "int"},
  [3] = {"skin_id", "int"},
  [4] = {"board_pet", "int"}
}
_class("CEventChoosePaintingResult", CCallReplyEvent)
CEventChoosePaintingResult = CEventChoosePaintingResult

function CEventChoosePaintingResult:Constructor()
  self.ret = 0
end

CEventChoosePaintingResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventAmendRoleName_Req", CCallRequestEvent)
CEventAmendRoleName_Req = CEventAmendRoleName_Req

function CEventAmendRoleName_Req:Constructor()
  self.m_stRoleName = ""
end

CEventAmendRoleName_Req._proto = {
  [1] = {
    "m_stRoleName",
    "string"
  }
}
_class("CEventAmendRoleName_Asw", CCallReplyEvent)
CEventAmendRoleName_Asw = CEventAmendRoleName_Asw

function CEventAmendRoleName_Asw:Constructor()
  self.ret = 0
end

CEventAmendRoleName_Asw._proto = {
  [1] = {"ret", "int"}
}
_class("CEventAmendSignText_Req", CCallRequestEvent)
CEventAmendSignText_Req = CEventAmendSignText_Req

function CEventAmendSignText_Req:Constructor()
  self.m_stSignText = ""
end

CEventAmendSignText_Req._proto = {
  [1] = {
    "m_stSignText",
    "string"
  }
}
_class("CEventAmendSignText_Asw", CCallReplyEvent)
CEventAmendSignText_Asw = CEventAmendSignText_Asw

function CEventAmendSignText_Asw:Constructor()
  self.ret = 0
end

CEventAmendSignText_Asw._proto = {
  [1] = {"ret", "int"}
}
_class("CEventAmendHeadImage_Req", CCallRequestEvent)
CEventAmendHeadImage_Req = CEventAmendHeadImage_Req

function CEventAmendHeadImage_Req:Constructor()
  self.m_nImageID = 0
  self.m_nColorID = 0
  self.m_nFrameID = 0
end

CEventAmendHeadImage_Req._proto = {
  [1] = {"m_nImageID", "int"},
  [2] = {"m_nColorID", "int"},
  [3] = {"m_nFrameID", "int"}
}
_class("CEventAmendHeadImage_Asw", CCallReplyEvent)
CEventAmendHeadImage_Asw = CEventAmendHeadImage_Asw

function CEventAmendHeadImage_Asw:Constructor()
  self.ret = 0
end

CEventAmendHeadImage_Asw._proto = {
  [1] = {"ret", "int"}
}
_class("CEventClearHeadImageLock_Req", CCallRequestEvent)
CEventClearHeadImageLock_Req = CEventClearHeadImageLock_Req

function CEventClearHeadImageLock_Req:Constructor()
  self.m_nImageID = 0
end

CEventClearHeadImageLock_Req._proto = {
  [1] = {"m_nImageID", "int"}
}
_class("CEventClearHeadImageLock_Asw", CCallReplyEvent)
CEventClearHeadImageLock_Asw = CEventClearHeadImageLock_Asw

function CEventClearHeadImageLock_Asw:Constructor()
  self.ret = 0
end

CEventClearHeadImageLock_Asw._proto = {
  [1] = {"ret", "int"}
}
_class("CEventRoleInfo_Req", CCallRequestEvent)
CEventRoleInfo_Req = CEventRoleInfo_Req

function CEventRoleInfo_Req:Constructor()
  self.m_nPstID = 0
end

CEventRoleInfo_Req._proto = {
  [1] = {"m_nPstID", "int64"}
}
_class("CEventRoleInfo_Asw", CCallReplyEvent)
CEventRoleInfo_Asw = CEventRoleInfo_Asw

function CEventRoleInfo_Asw:Constructor()
  self.ret = 0
  self.m_nPstID = 0
  self.m_nHeadImageID = 0
  self.m_nHeadColorID = 0
  self.m_stRoleName = ""
  self.m_stSignText = ""
  self.m_mapImageData = {}
  self.m_vecCanUnlockImage = {}
  self.m_nHeadFrameID = 0
  self.m_mapImageFrame = {}
  self.m_vecCanUnlockFrame = {}
end

CEventRoleInfo_Asw._proto = {
  [1] = {"ret", "int"},
  [2] = {"m_nPstID", "int64"},
  [3] = {
    "m_nHeadImageID",
    "int"
  },
  [4] = {
    "m_nHeadColorID",
    "int"
  },
  [5] = {
    "m_stRoleName",
    "string"
  },
  [6] = {
    "m_stSignText",
    "string"
  },
  [7] = {
    "m_mapImageData",
    "map<int,int>"
  },
  [8] = {
    "m_vecCanUnlockImage",
    "list<int  >"
  },
  [9] = {
    "m_nHeadFrameID",
    "int"
  },
  [10] = {
    "m_mapImageFrame",
    "map<int,int>"
  },
  [11] = {
    "m_vecCanUnlockFrame",
    "list<int  >"
  }
}
_class("CEventRoleHeadImageLock_Req", CCallRequestEvent)
CEventRoleHeadImageLock_Req = CEventRoleHeadImageLock_Req

function CEventRoleHeadImageLock_Req:Constructor()
  self.m_nImageID = 0
end

CEventRoleHeadImageLock_Req._proto = {
  [1] = {"m_nImageID", "int"}
}
_class("CEventRoleHeadImageLock_Asw", CCallReplyEvent)
CEventRoleHeadImageLock_Asw = CEventRoleHeadImageLock_Asw

function CEventRoleHeadImageLock_Asw:Constructor()
  self.ret = 0
  self.m_nImageID = 0
  self.m_bLock = false
  self.m_vecLockCondition = {}
end

CEventRoleHeadImageLock_Asw._proto = {
  [1] = {"ret", "int"},
  [2] = {"m_nImageID", "int"},
  [3] = {"m_bLock", "bool"},
  [4] = {
    "m_vecLockCondition",
    "list<int>"
  }
}
_class("CEventTssReportData", CCliPushEvent)
CEventTssReportData = CEventTssReportData

function CEventTssReportData:Constructor()
  self.pst_ID = 0
  self.report_data = ""
end

function CEventTssReportData:Reliable()
  return false
end

CEventTssReportData._proto = {
  [1] = {"pst_ID", "int64"},
  [2] = {
    "report_data",
    "string"
  }
}
_class("CEventStoryAffinity", CCallRequestEvent)
CEventStoryAffinity = CEventStoryAffinity

function CEventStoryAffinity:Constructor()
end

CEventStoryAffinity._proto = {}
_class("CEventStoryAffinityResult", CCallReplyEvent)
CEventStoryAffinityResult = CEventStoryAffinityResult

function CEventStoryAffinityResult:Constructor()
  self.ret = 0
  self.ids = {}
end

CEventStoryAffinityResult._proto = {
  [1] = {"ret", "int"},
  [2] = {"ids", "list<int>"}
}
_class("CEventAddStoryAffinity", CCallRequestEvent)
CEventAddStoryAffinity = CEventAddStoryAffinity

function CEventAddStoryAffinity:Constructor()
  self.id = 0
end

CEventAddStoryAffinity._proto = {
  [1] = {"id", "int"}
}
_class("CEventAddStoryAffinityResult", CCallReplyEvent)
CEventAddStoryAffinityResult = CEventAddStoryAffinityResult

function CEventAddStoryAffinityResult:Constructor()
  self.ret = 0
  self.id = 0
end

CEventAddStoryAffinityResult._proto = {
  [1] = {"ret", "int"},
  [2] = {"id", "int"}
}
_class("CEventClientSaveLog", CCliPushEvent)
CEventClientSaveLog = CEventClientSaveLog

function CEventClientSaveLog:Constructor()
  self.m_stKey = ""
  self.m_stValue = ""
end

CEventClientSaveLog._proto = {
  [1] = {"m_stKey", "string"},
  [2] = {"m_stValue", "string"}
}
_class("CEventPrepareAll", CCallRequestEvent)
CEventPrepareAll = CEventPrepareAll

function CEventPrepareAll:Constructor()
end

CEventPrepareAll._proto = {}
_class("CEventPrepareAllResult", CCallReplyEvent)
CEventPrepareAllResult = CEventPrepareAllResult

function CEventPrepareAllResult:Constructor()
  self.ret = 0
end

CEventPrepareAllResult._proto = {
  [1] = {"ret", "int"}
}
local EnumPrepareWorkType = {
  E_PrepareWork_No = 0,
  E_PrepareWork_UnlockModule = 1,
  E_PrepareWork_PassMission = 2,
  E_PrepareWork_AddPetAll = 3,
  E_PrepareWork_SetPetData = 4,
  E_PrepareWork_AddItemAll = 5,
  E_PrepareWork_AddServerTime = 6,
  E_PrepareWork_Campaign_LvReward_UnlockAdvance = 7,
  E_PrepareWork_Campaign_LvReward_UnlockLuxury = 8,
  E_PrepareWork_Campaign_LvReward_UnlockAdditional = 9,
  E_PrepareWork_Campaign_PassLineMission = 10,
  E_PrepareWork_Campaign_PassTreeMission = 11,
  E_PrepareWork_Campaign_PassSummerIIMission = 12,
  E_PrepareWork_Campaign_PassMission = 13,
  E_PrepareWork_Campaign_ResetAccumulateLogin = 14,
  E_PrepareWork_Campaign_ResetPersonProgress = 15,
  E_PrepareWork_UnlockAllAircraftRooms = 16,
  E_PrepareWork_UnlockMazeRoom = 17,
  E_PrepareWork_HomeLand_Event = 18,
  E_PrepareWork_HomeLand_SetLevel = 19,
  E_PrepareWork_PointProgress = 20,
  E_PrepareWork_CompleteCondition = 21,
  E_PrepareWork_IDOLAddValue = 22,
  E_PrepareWork_READONEMAILBYID = 23,
  E_PrepareWork_SkipShakeCheck = 24,
  E_PrepareWork_EquipRefine = 25,
  E_PrepareWork_Campaign_PassSeasonMission = 26
}
_enum("EnumPrepareWorkType", EnumPrepareWorkType)
_class("CEventPrepareWork", CCallRequestEvent)
CEventPrepareWork = CEventPrepareWork

function CEventPrepareWork:Constructor()
  self.m_mapWrok = {}
  self.int_param = 0
  self.str_param = ""
end

CEventPrepareWork._proto = {
  [1] = {
    "m_mapWrok",
    "map<int,int>"
  },
  [2] = {"int_param", "int"},
  [3] = {"str_param", "string"}
}
_class("CEventPrepareWorkResult", CCallReplyEvent)
CEventPrepareWorkResult = CEventPrepareWorkResult

function CEventPrepareWorkResult:Constructor()
  self.ret = 0
end

CEventPrepareWorkResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventEraseAccount", CCallRequestEvent)
CEventEraseAccount = CEventEraseAccount

function CEventEraseAccount:Constructor()
end

CEventEraseAccount._proto = {}
_class("CEventEraseAccountResult", CCallReplyEvent)
CEventEraseAccountResult = CEventEraseAccountResult

function CEventEraseAccountResult:Constructor()
  self.ret = 0
end

CEventEraseAccountResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventAppHome", CCliPushEvent)
CEventAppHome = CEventAppHome

function CEventAppHome:Constructor()
  self.log_data = ""
end

function CEventAppHome:Reliable()
  return false
end

CEventAppHome._proto = {
  [1] = {"log_data", "string"}
}
_class("CEventAppResume", CCliPushEvent)
CEventAppResume = CEventAppResume

function CEventAppResume:Constructor()
  self.log_data = ""
end

function CEventAppResume:Reliable()
  return false
end

CEventAppResume._proto = {
  [1] = {"log_data", "string"}
}
_class("CEventMobileSettingInfo", CCliPushEvent)
CEventMobileSettingInfo = CEventMobileSettingInfo

function CEventMobileSettingInfo:Constructor()
  self.bgmVolume = 0.0
  self.soundVolume = 0.0
  self.voiceVolume = 0.0
  self.bgmMute = false
  self.soundMute = false
  self.voiceMute = false
  self.GraphicsLevel = 0
  self.skillAnmiIndex = 0
  self.BangWidth = 0.0
  self.danSwitch = false
end

CEventMobileSettingInfo._proto = {
  [1] = {"bgmVolume", "float"},
  [2] = {
    "soundVolume",
    "float"
  },
  [3] = {
    "voiceVolume",
    "float"
  },
  [4] = {"bgmMute", "bool"},
  [5] = {"soundMute", "bool"},
  [6] = {"voiceMute", "bool"},
  [7] = {
    "GraphicsLevel",
    "int"
  },
  [8] = {
    "skillAnmiIndex",
    "int"
  },
  [9] = {"BangWidth", "float"},
  [10] = {"danSwitch", "bool"}
}
_class("CEventAmendHeadFrame_Req", CCallRequestEvent)
CEventAmendHeadFrame_Req = CEventAmendHeadFrame_Req

function CEventAmendHeadFrame_Req:Constructor()
  self.m_nFrameID = 0
end

CEventAmendHeadFrame_Req._proto = {
  [1] = {"m_nFrameID", "int"}
}
_class("CEventAmendHeadFrame_Asw", CCallReplyEvent)
CEventAmendHeadFrame_Asw = CEventAmendHeadFrame_Asw

function CEventAmendHeadFrame_Asw:Constructor()
  self.ret = 0
end

CEventAmendHeadFrame_Asw._proto = {
  [1] = {"ret", "int"}
}
_class("CEventClearHeadFrameLock_Req", CCallRequestEvent)
CEventClearHeadFrameLock_Req = CEventClearHeadFrameLock_Req

function CEventClearHeadFrameLock_Req:Constructor()
  self.m_nFrameID = 0
end

CEventClearHeadFrameLock_Req._proto = {
  [1] = {"m_nFrameID", "int"}
}
_class("CEventClearHeadFrameLock_Asw", CCallReplyEvent)
CEventClearHeadFrameLock_Asw = CEventClearHeadFrameLock_Asw

function CEventClearHeadFrameLock_Asw:Constructor()
  self.ret = 0
end

CEventClearHeadFrameLock_Asw._proto = {
  [1] = {"ret", "int"}
}
_class("CEventRoleHeadFrameLock_Req", CCallRequestEvent)
CEventRoleHeadFrameLock_Req = CEventRoleHeadFrameLock_Req

function CEventRoleHeadFrameLock_Req:Constructor()
  self.m_nFrameID = 0
end

CEventRoleHeadFrameLock_Req._proto = {
  [1] = {"m_nFrameID", "int"}
}
_class("CEventRoleHeadFrameLock_Asw", CCallReplyEvent)
CEventRoleHeadFrameLock_Asw = CEventRoleHeadFrameLock_Asw

function CEventRoleHeadFrameLock_Asw:Constructor()
  self.ret = 0
  self.m_nFrameID = 0
  self.m_bLock = false
  self.m_vecLockCondition = {}
end

CEventRoleHeadFrameLock_Asw._proto = {
  [1] = {"ret", "int"},
  [2] = {"m_nFrameID", "int"},
  [3] = {"m_bLock", "bool"},
  [4] = {
    "m_vecLockCondition",
    "list<int>"
  }
}
_class("CEventChooseBackImage", CCallRequestEvent)
CEventChooseBackImage = CEventChooseBackImage

function CEventChooseBackImage:Constructor()
  self.m_nBackImageID = 0
  self.m_background_type = 1
  self.m_background_x = 0
  self.m_background_y = 0
  self.m_background_scale = 0
  self.is_hand_operate = false
  self.spine_id = 0
end

CEventChooseBackImage._proto = {
  [1] = {
    "m_nBackImageID",
    "int"
  },
  [2] = {
    "m_background_type",
    "int"
  },
  [3] = {
    "m_background_x",
    "float"
  },
  [4] = {
    "m_background_y",
    "float"
  },
  [5] = {
    "m_background_scale",
    "float"
  },
  [6] = {
    "is_hand_operate",
    "bool"
  },
  [7] = {"spine_id", "int"}
}
_class("CEventChooseBackImageResult", CCallReplyEvent)
CEventChooseBackImageResult = CEventChooseBackImageResult

function CEventChooseBackImageResult:Constructor()
  self.ret = 0
end

CEventChooseBackImageResult._proto = {
  [1] = {"ret", "int"}
}
local EnumBgmType = {
  E_Bgm_Main = 0,
  E_Bgm_AirCraft = 1,
  E_Bgm_Homeland = 2
}
_enum("EnumBgmType", EnumBgmType)
_class("CEventMinorChatResult", CSvrPushEvent)
CEventMinorChatResult = CEventMinorChatResult

function CEventMinorChatResult:Constructor()
  self.minor_chat_open = true
end

CEventMinorChatResult._proto = {
  [1] = {
    "minor_chat_open",
    "bool"
  }
}
_class("CEventChooseBgm", CCallRequestEvent)
CEventChooseBgm = CEventChooseBgm

function CEventChooseBgm:Constructor()
  self.m_nBgmType = 0
  self.m_nBgmID = 0
end

CEventChooseBgm._proto = {
  [1] = {"m_nBgmType", "int"},
  [2] = {"m_nBgmID", "int"}
}
_class("CEventChooseBgmResult", CCallReplyEvent)
CEventChooseBgmResult = CEventChooseBgmResult

function CEventChooseBgmResult:Constructor()
  self.ret = 0
end

CEventChooseBgmResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventChangeTitle", CCallRequestEvent)
CEventChangeTitle = CEventChangeTitle

function CEventChangeTitle:Constructor()
  self.type = 0
  self.id = 0
end

CEventChangeTitle._proto = {
  [1] = {"type", "int"},
  [2] = {"id", "int"}
}
_class("CEventChangeTitleResult", CCallReplyEvent)
CEventChangeTitleResult = CEventChangeTitleResult

function CEventChangeTitleResult:Constructor()
  self.type = 0
  self.ret = 0
end

CEventChangeTitleResult._proto = {
  [1] = {"type", "int"},
  [2] = {"ret", "int"}
}
_class("CEventChangeTitleInfoResult", CSvrPushEvent)
CEventChangeTitleInfoResult = CEventChangeTitleInfoResult

function CEventChangeTitleInfoResult:Constructor()
  self.title_used = 0
  self.fifure_used = 0
end

CEventChangeTitleInfoResult._proto = {
  [1] = {"title_used", "int"},
  [2] = {
    "fifure_used",
    "int"
  }
}
_class("CEventPushLoginComplete", CCliPushEvent)
CEventPushLoginComplete = CEventPushLoginComplete

function CEventPushLoginComplete:Constructor()
end

CEventPushLoginComplete._proto = {}
_class("CEventMobileBadgeInfo", CCliPushEvent)
CEventMobileBadgeInfo = CEventMobileBadgeInfo

function CEventMobileBadgeInfo:Constructor()
  self.badgeSwitch = false
end

CEventMobileBadgeInfo._proto = {
  [1] = {
    "badgeSwitch",
    "bool"
  }
}
_class("CEventSeasonStoryReq", CCallRequestEvent)
CEventSeasonStoryReq = CEventSeasonStoryReq

function CEventSeasonStoryReq:Constructor()
  self.mask = 0
end

CEventSeasonStoryReq._proto = {
  [1] = {"mask", "int"}
}
_class("CEventSeasonStoryResult", CCallReplyEvent)
CEventSeasonStoryResult = CEventSeasonStoryResult

function CEventSeasonStoryResult:Constructor()
  self.ret = 0
end

CEventSeasonStoryResult._proto = {
  [1] = {"ret", "int"}
}
