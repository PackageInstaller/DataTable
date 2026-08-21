require("message_def")
local missionMessageDef = {
  CLSID_CEventMobileCompleteStoryMission = 14000,
  CLSID_CEventMobileCompleteStoryMissionResult = 14001,
  CLSID_CEventMobileReceiveChapterAward = 14002,
  CLSID_CEventMobileReceiveChapterAwardResult = 14003,
  CLSID_CEventMobilePushMissionInfoChange = 14004,
  CLSID_CEventPushOneMissionInfoChange = 14005,
  CLSID_CEventMobileGetMainAllFormationInfo = 14006,
  CLSID_CEventMobileGetMainAllFormationInfoResult = 14007,
  CLSID_CEventMobileChangeMainFormationInfo = 14008,
  CLSID_CEventMobileChangeMainFormationInfoResult = 14009,
  CLSID_CEventMobilePushAlreadyReturnPowerMissionInfoChange = 14010,
  CLSID_CEventMobilePushAlreadyReturnPowerCamMissionInfoChange = 14011,
  CLSID_CEventMobileSaveActiveStoryInfo = 14012,
  CLSID_CEventMobileSaveActiveStoryInfoResult = 14013,
  CLSID_CEventMobilePushMissionActiveStoryData = 14014,
  CLSID_CEventMobileCompleteAllMission = 14015,
  CLSID_CEventMobileCompleteAssignMission = 14016,
  CLSID_CEventApplyMissionPassDataReq = 14017,
  CLSID_CEventApplyMissionPassDataRes = 14018
}
table.append(MessageDef, missionMessageDef)
local MISSION_RESULT_CODE = {
  MISSION_SUCCEED = 0,
  MISSION_FAILED = 1,
  MISSION_INVALID_LEVEL = 2,
  MISSION_INVALID_POWER = 3,
  MISSION_NOT_EXIST = 4,
  MISSION_IS_LOCK = 5,
  MISSION_STORY_ALREADY_ACTIVE = 6,
  MISSION_INVALID_ID = 7,
  MISSION_STORY_INVALID_TYPE = 8,
  MISSION_INVALID_CHAPTER_AWARD = 9,
  MISSION_INVALID_CHAPTER_AWARD_INVALID_STAR = 10,
  MISSION_INVALID_CHAPTER_AWARD_RECEIVE = 11,
  MISSION_INVALID_CHAPTER_AWARD_CONFIG = 12
}
_enum("MISSION_RESULT_CODE", MISSION_RESULT_CODE)
local FORMATION_RESUTL_CODE = {
  FORMATION_SUCCEED = 0,
  FORMATION_INVALID_ID = 1001,
  FORMATION_INVALID_NAME = 1002,
  FORMATION_INVALID_PET = 1003,
  FORMATION_INVALID_PETCOUNT = 1004,
  FORMATION_DIRTY_NAME = 1005,
  FORMATION_DATA_INVALID = 1006,
  MAZE_FORMATION_PET_DEADED = 1007,
  FORMATION_NAME_BAN = 1008,
  FORMATION_TACTIC_FIGHT_LIMIT = 1009,
  FORMATION_SAME_BINDER = 1010
}
_enum("FORMATION_RESUTL_CODE", FORMATION_RESUTL_CODE)
_class("CEventMobileCompleteStoryMission", CCallRequestEvent)
CEventMobileCompleteStoryMission = CEventMobileCompleteStoryMission

function CEventMobileCompleteStoryMission:Constructor()
  self.m_mission_id = 0
end

CEventMobileCompleteStoryMission._proto = {
  [1] = {
    "m_mission_id",
    "int"
  }
}
_class("CEventMobileCompleteStoryMissionResult", CCallReplyEvent)
CEventMobileCompleteStoryMissionResult = CEventMobileCompleteStoryMissionResult

function CEventMobileCompleteStoryMissionResult:Constructor()
  self.m_result = 0
  self.reward = {}
end

CEventMobileCompleteStoryMissionResult._proto = {
  [1] = {"m_result", "int"},
  [2] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("CEventMobileReceiveChapterAward", CCallRequestEvent)
CEventMobileReceiveChapterAward = CEventMobileReceiveChapterAward

function CEventMobileReceiveChapterAward:Constructor()
  self.m_chapter_id = 0
  self.star_count = 0
end

CEventMobileReceiveChapterAward._proto = {
  [1] = {
    "m_chapter_id",
    "int"
  },
  [2] = {"star_count", "int"}
}
_class("CEventMobileReceiveChapterAwardResult", CCallReplyEvent)
CEventMobileReceiveChapterAwardResult = CEventMobileReceiveChapterAwardResult

function CEventMobileReceiveChapterAwardResult:Constructor()
  self.m_result = 0
  self.reward = {}
  self.already_receive_chapter_award = mission_chapter_award_data:New()
end

CEventMobileReceiveChapterAwardResult._proto = {
  [1] = {"m_result", "int"},
  [2] = {
    "reward",
    "list<RoleAsset>"
  },
  [3] = {
    "already_receive_chapter_award",
    "mission_chapter_award_data"
  }
}
_class("CEventMobilePushMissionInfoChange", CSvrPushEvent)
CEventMobilePushMissionInfoChange = CEventMobilePushMissionInfoChange

function CEventMobilePushMissionInfoChange:Constructor()
  self.m_cur_mission_id = 0
  self.m_change_pass_mission_list = {}
end

CEventMobilePushMissionInfoChange._proto = {
  [1] = {
    "m_cur_mission_id",
    "int"
  },
  [2] = {
    "m_change_pass_mission_list",
    "list<mission_info>"
  }
}
_class("CEventPushOneMissionInfoChange", CSvrPushEvent)
CEventPushOneMissionInfoChange = CEventPushOneMissionInfoChange

function CEventPushOneMissionInfoChange:Constructor()
  self.m_change_mission_info = mission_info:New()
end

CEventPushOneMissionInfoChange._proto = {
  [1] = {
    "m_change_mission_info",
    "mission_info"
  }
}
_class("CEventMobileGetMainAllFormationInfo", CCallRequestEvent)
CEventMobileGetMainAllFormationInfo = CEventMobileGetMainAllFormationInfo

function CEventMobileGetMainAllFormationInfo:Constructor()
  self.m_id = 0
end

CEventMobileGetMainAllFormationInfo._proto = {}
_class("CEventMobileGetMainAllFormationInfoResult", CCallReplyEvent)
CEventMobileGetMainAllFormationInfoResult = CEventMobileGetMainAllFormationInfoResult

function CEventMobileGetMainAllFormationInfoResult:Constructor()
  self.m_formation_info = {}
end

CEventMobileGetMainAllFormationInfoResult._proto = {
  [1] = {
    "m_formation_info",
    "list<formation_info>"
  }
}
_class("CEventMobileChangeMainFormationInfo", CCallRequestEvent)
CEventMobileChangeMainFormationInfo = CEventMobileChangeMainFormationInfo

function CEventMobileChangeMainFormationInfo:Constructor()
  self.m_formation_id = 0
  self.m_formation_name = ""
  self.m_formation_pet_list = {}
end

CEventMobileChangeMainFormationInfo._proto = {
  [1] = {
    "m_formation_id",
    "int"
  },
  [2] = {
    "m_formation_name",
    "string"
  },
  [3] = {
    "m_formation_pet_list",
    "list<int64>"
  }
}
_class("CEventMobileChangeMainFormationInfoResult", CCallReplyEvent)
CEventMobileChangeMainFormationInfoResult = CEventMobileChangeMainFormationInfoResult

function CEventMobileChangeMainFormationInfoResult:Constructor()
  self.m_result = 0
  self.m_formation_info = {}
end

CEventMobileChangeMainFormationInfoResult._proto = {
  [1] = {"m_result", "int"},
  [2] = {
    "m_formation_info",
    "list<formation_info>"
  }
}
_class("CEventMobilePushAlreadyReturnPowerMissionInfoChange", CSvrPushEvent)
CEventMobilePushAlreadyReturnPowerMissionInfoChange = CEventMobilePushAlreadyReturnPowerMissionInfoChange

function CEventMobilePushAlreadyReturnPowerMissionInfoChange:Constructor()
  self.m_already_return_power_mission_list = {}
end

CEventMobilePushAlreadyReturnPowerMissionInfoChange._proto = {
  [1] = {
    "m_already_return_power_mission_list",
    "list<int>"
  }
}
_class("CEventMobilePushAlreadyReturnPowerCamMissionInfoChange", CSvrPushEvent)
CEventMobilePushAlreadyReturnPowerCamMissionInfoChange = CEventMobilePushAlreadyReturnPowerCamMissionInfoChange

function CEventMobilePushAlreadyReturnPowerCamMissionInfoChange:Constructor()
  self.m_already_return_power_cam_mission_list = {}
end

CEventMobilePushAlreadyReturnPowerCamMissionInfoChange._proto = {
  [1] = {
    "m_already_return_power_cam_mission_list",
    "list<int>"
  }
}
_class("CEventMobileSaveActiveStoryInfo", CCallRequestEvent)
CEventMobileSaveActiveStoryInfo = CEventMobileSaveActiveStoryInfo

function CEventMobileSaveActiveStoryInfo:Constructor()
  self.m_mission_id = 0
  self.m_story_type = 0
end

CEventMobileSaveActiveStoryInfo._proto = {
  [1] = {
    "m_mission_id",
    "int"
  },
  [2] = {
    "m_story_type",
    "int"
  }
}
_class("CEventMobileSaveActiveStoryInfoResult", CCallReplyEvent)
CEventMobileSaveActiveStoryInfoResult = CEventMobileSaveActiveStoryInfoResult

function CEventMobileSaveActiveStoryInfoResult:Constructor()
  self.m_result = 0
end

CEventMobileSaveActiveStoryInfoResult._proto = {
  [1] = {"m_result", "int"}
}
_class("CEventMobilePushMissionActiveStoryData", CSvrPushEvent)
CEventMobilePushMissionActiveStoryData = CEventMobilePushMissionActiveStoryData

function CEventMobilePushMissionActiveStoryData:Constructor()
  self.active_story_data = mission_story_data:New()
end

CEventMobilePushMissionActiveStoryData._proto = {
  [1] = {
    "active_story_data",
    "mission_story_data"
  }
}
_class("CEventMobileCompleteAllMission", CCliPushEvent)
CEventMobileCompleteAllMission = CEventMobileCompleteAllMission

function CEventMobileCompleteAllMission:Constructor()
  self.id = 0
end

CEventMobileCompleteAllMission._proto = {
  [1] = {"id", "int"}
}
_class("CEventMobileCompleteAssignMission", CCliPushEvent)
CEventMobileCompleteAssignMission = CEventMobileCompleteAssignMission

function CEventMobileCompleteAssignMission:Constructor()
  self.mission_id = 0
end

CEventMobileCompleteAssignMission._proto = {
  [1] = {"mission_id", "int"}
}
_class("CEventApplyMissionPassDataReq", CCallRequestEvent)
CEventApplyMissionPassDataReq = CEventApplyMissionPassDataReq

function CEventApplyMissionPassDataReq:Constructor()
  self.nMissionId = 0
end

CEventApplyMissionPassDataReq._proto = {
  [1] = {"nMissionId", "int"}
}
_class("CEventApplyMissionPassDataRes", CCallReplyEvent)
CEventApplyMissionPassDataRes = CEventApplyMissionPassDataRes

function CEventApplyMissionPassDataRes:Constructor()
  self.info = {}
end

CEventApplyMissionPassDataRes._proto = {
  [1] = {
    "info",
    "list<mission_pass_info>"
  }
}
