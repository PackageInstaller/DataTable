require("message_def")
local matchMessageDef = {
  CLSID_CEventRequestCreateMatch = 11000,
  CLSID_CEventReplyCreateMatch = 11001,
  CLSID_CEventRequestJoinMatch = 11002,
  CLSID_CEventReplyJoinMatch = 11003,
  CLSID_CEventRequestEnterMatch = 11004,
  CLSID_CEventReplyEnterMatch = 11005,
  CLSID_CEventRequestLeaveMatch = 11006,
  CLSID_CEventReplyLeaveMatch = 11007,
  CLSID_CEventPushMatchEnd = 11008,
  CLSID_CEventPushJoinMatch = 11009,
  CLSID_CEventPushLeaveMatch = 11010,
  CLSID_CEventRequestEnterInnerGame = 11011,
  CLSID_CEventRequestExitInnerGame = 11012,
  CLSID_CEventMatchStartLoading = 11013,
  CLSID_CEventUpdateLoadingProgress = 11014,
  CLSID_CEventMatchStart = 11015,
  CLSID_CEventGameOver = 11016,
  CLSID_CEventBattleLog = 11017,
  CLSID_CEventLuaCommand = 11018,
  CLSID_CEventWaveEnd = 11019,
  CLSID_CEventCommandBase = 11020,
  CLSID_CEventAutoFightCommand = 11021,
  CLSID_CEventCancelChainSkillCommand = 11022,
  CLSID_CEventCastActiveSkillCommand = 11023,
  CLSID_CEventCastPickUpChainSkillCommand = 11024,
  CLSID_CEventCastPickUpActiveSkillCommand = 11025,
  CLSID_CEventChangeTeamLeaderCommand = 11026,
  CLSID_CEventGuideCommand = 11027,
  CLSID_CEventMovePathDoneCommand = 11028,
  CLSID_CEventCastChessPetMoveCommand = 11029,
  CLSID_CEventCastChessPetAttackCommand = 11030,
  CLSID_CEventCastChessPetEndTurnCommand = 11031,
  CLSID_CEventCastSelectTeamOrderPositionCommand = 11032,
  CLSID_CEventCastClearSelectedTeamOrderPositionCommand = 11033,
  CLSID_CEventClientExceptionReportCommand = 11034,
  CLSID_CEventScanFeatureCommand = 11035,
  CLSID_CEventChooseMiniMazeWaveAwardCommand = 11036,
  CLSID_CEventMiragePickUpCommand = 11037,
  CLSID_CEventMirageForceCloseCommand = 11038,
  CLSID_CEventSwitchPetEquipRefineUICommand = 11039,
  CLSID_CEventPopStarPickUpCommand = 11040,
  CLSID_CEventRequestSweepMatch = 11041,
  CLSID_CEventReplySweepMatch = 11042,
  CLSID_CEventSyncClientUnscaledCountDownCommand = 11043,
  CLSID_CEventCastSelectInfoActiveSkillCommand = 11044,
  CLSID_CEventTetrisFeatureCommand = 11045
}
table.append(MessageDef, matchMessageDef)
local MatchOpResCode = {
  MATCH_SUCCESS = 0,
  MATCH_FAIL = 1,
  MATCH_TIMEOUT = 2,
  MATCH_GROUP_ERROR = 3,
  MATCH_NO_SERVER = 4,
  MATCH_NO_MATCH = 5,
  MATCH_LIMIT = 6,
  MATCH_ALREADY_IN_MATCH = 7,
  MATCH_QUICK_MATCHING = 8,
  MATCH_WAITING = 9,
  MATCH_LEAVING = 10,
  MATCH_NOT_ENOUGH_PHY_POWER = 11,
  MATCH_INVALID_TEAM = 12,
  MATCH_INVALID_MISSION_ID = 13,
  MATCH_INVALID_ExtMissionID = 14,
  MATCH_INVALID_RoleLevel = 15,
  MATCH_INVALID_MissionLock = 16,
  MATCH_INVALID_ExtTaskLock = 17,
  MATCH_INVALID_ExtTaskID = 18,
  MATCH_INVALID_LowPower = 19,
  MATCH_INVALID_MAZE_ROOM_ID = 20,
  MATCH_NOT_ENOUGH_LIGHT = 21,
  MATCH_NO_BLOOD = 22,
  MATCH_DOUBLE_TICKET_NOTENOUGH = 23,
  MATCH_TOWER_IS_LOCKED = 24,
  MATCH_TOWER_CONFIG_INVALID = 25,
  MATCH_TOWER_ID_INVALID = 26,
  MATCH_TOWER_AFTER_LEVEL_NOT_PASS = 27,
  MATCH_TOWER_TYPE_INVALID = 28,
  MATCH_TOWER_PET_NUM_ERR = 29,
  MATCH_TOWER_PET_INVALID = 30,
  MATCH_TOWER_PET_REPEAT = 31,
  MATCH_ELEMENT_TYPE_ERR = 32,
  MATCH_TOWER_DROPID_INVALIED = 33,
  MATCH_PSTID_ERROR = 34,
  MATCH_TALEPET_STAGE_LOCK = 35,
  MATCH_CAMPAIGN_CAN_NOT_REPEAT_FIGHT = 36,
  MATCH_CAMPAIGN_CamNotOpen = 37,
  MATCH_CAMPAIGN_ComNotOpen = 38,
  MATCH_CAMPAIGN_NotOnOClock = 39,
  MATCH_CAMPAIGN_FORMATION_INVALID = 40,
  MATCH_NOT_ENOUGH_ACTIONPOINT = 41,
  MATCH_CAMPAIGN_MISSIOHN_CROSS_DAY = 42,
  MATCH_CAMPAIGN_MISSIOHN_ID_ERR = 43,
  MATCH_CAMPAIGN_COM_CFG_ERR = 44,
  MATCH_WORLD_BOSS_IS_LOCKED = 45,
  MATCH_WORLD_BOSS_FORMATION_INVALID = 46,
  MATCH_WORLD_BOSS_CONFIG_INVALID = 47,
  MATCH_WORLD_BOSS_MISSION_INVALID = 48,
  MATCH_ASSET_DOUBLE_ITEM_NOT_ENOUGH = 49,
  MATCH_DIFFICULTY_CONFIG_ERROR = 50,
  MATCH_DIFFICULTY_FORMATION_ERROR = 51,
  MATCH_DIFFICULTY_LOCKED = 52,
  MATCH_DIFFICULTY_PRE_LOCKED = 53,
  MATCH_DM_FORMATION_INVALID = 54,
  MATCH_DIFFICULTY_COMPONENT_CFG_ID = 55,
  MATCH_DIFFICULTY_OP_COMPONENT_ID = 56,
  MATCH_3STAR_NOT_COMPLETE = 57,
  MATCH_PASSED_ERROR_TIMES = 58,
  MATCH_SAILING_CONFIG_ERROR = 60,
  MATCH_SAILING_MOUDULE_LOCKED = 61,
  MATCH_SAILING_PRE_NOT_FINISH = 62,
  MATCH_SAILING_FORMATION_INVALID = 63,
  MATCH_BLOODSUCKER_PREMISSION_UNLOCK = 64,
  MATCH_EIGHT_PETS_FORMATION_INVALID = 65,
  MATCH_ANIPOP_HARD_ERROR = 66,
  MATCH_ANIPOP_BLOOD_ERROR = 67,
  MATCH_ANIPOP_SWEEP_ERROR = 68,
  MATCH_CAMPAIGN_PREMISSIONNOTPASS = 70
}
_enum("MatchOpResCode", MatchOpResCode)
local ChessTurnEndType = {Single = 1, All = 2}
_enum("ChessTurnEndType", ChessTurnEndType)
_class("CEventRequestCreateMatch", CCallRequestEvent)
CEventRequestCreateMatch = CEventRequestCreateMatch

function CEventRequestCreateMatch:Constructor()
  self.m_match_type = 0
  self.m_formation_id = 0
  self.m_client_create_info = ClientMatchCreateInfo:New()
  self.m_nHelpPetKey = 0
end

CEventRequestCreateMatch._proto = {
  [1] = {
    "m_match_type",
    "int"
  },
  [2] = {
    "m_formation_id",
    "int"
  },
  [3] = {
    "m_client_create_info",
    "ClientMatchCreateInfo"
  },
  [4] = {
    "m_nHelpPetKey",
    "int"
  }
}
_class("CEventReplyCreateMatch", CCallReplyEvent)
CEventReplyCreateMatch = CEventReplyCreateMatch

function CEventReplyCreateMatch:Constructor()
  self.m_ret = 0
  self.m_match_created = GroupToken:New()
  self.m_vkey = 0
end

CEventReplyCreateMatch._proto = {
  [1] = {"m_ret", "int"},
  [2] = {
    "m_match_created",
    "GroupToken"
  },
  [3] = {"m_vkey", "int"}
}
_class("CEventRequestJoinMatch", CCallRequestEvent)
CEventRequestJoinMatch = CEventRequestJoinMatch

function CEventRequestJoinMatch:Constructor()
  self.m_match_to_join = GroupToken:New()
end

CEventRequestJoinMatch._proto = {
  [1] = {
    "m_match_to_join",
    "GroupToken"
  }
}
_class("CEventReplyJoinMatch", CCallReplyEvent)
CEventReplyJoinMatch = CEventReplyJoinMatch

function CEventReplyJoinMatch:Constructor()
  self.m_ret = 0
  self.m_match_to_join = GroupToken:New()
  self.m_vkey = 0
end

CEventReplyJoinMatch._proto = {
  [1] = {"m_ret", "int"},
  [2] = {
    "m_match_to_join",
    "GroupToken"
  },
  [3] = {"m_vkey", "int"}
}
_class("CEventRequestEnterMatch", CCallRequestEvent)
CEventRequestEnterMatch = CEventRequestEnterMatch

function CEventRequestEnterMatch:Constructor()
  self.m_match_to_enter = GroupToken:New()
  self.m_player_id = 0
end

CEventRequestEnterMatch._proto = {
  [1] = {
    "m_match_to_enter",
    "GroupToken"
  },
  [2] = {
    "m_player_id",
    "int64"
  }
}
_class("CEventReplyEnterMatch", CCallReplyEvent)
CEventReplyEnterMatch = CEventReplyEnterMatch

function CEventReplyEnterMatch:Constructor()
  self.m_ret = 0
  self.create_info = MatchCreateInfo:New()
  self.player_list = {}
end

CEventReplyEnterMatch._proto = {
  [1] = {"m_ret", "int"},
  [2] = {
    "create_info",
    "MatchCreateInfo"
  },
  [3] = {
    "player_list",
    "map<int64,LuaMatchPlayerInfo>"
  }
}
_class("CEventRequestLeaveMatch", CCallRequestEvent)
CEventRequestLeaveMatch = CEventRequestLeaveMatch

function CEventRequestLeaveMatch:Constructor()
  self.m_restart = false
end

CEventRequestLeaveMatch._proto = {
  [1] = {"m_restart", "bool"}
}
_class("CEventReplyLeaveMatch", CCallReplyEvent)
CEventReplyLeaveMatch = CEventReplyLeaveMatch

function CEventReplyLeaveMatch:Constructor()
  self.m_ret = 0
  self.m_result = MatchLeaveResult:New()
  self.m_match_to_join = GroupToken:New()
end

CEventReplyLeaveMatch._proto = {
  [1] = {"m_ret", "int"},
  [2] = {
    "m_result",
    "MatchLeaveResult"
  },
  [3] = {
    "m_match_to_join",
    "GroupToken"
  }
}
_class("CEventPushMatchEnd", CSvrPushEvent)
CEventPushMatchEnd = CEventPushMatchEnd

function CEventPushMatchEnd:Constructor()
  self.match_token = GroupToken:New()
  self.match_type = 0
  self.m_result = MatchResult:New()
end

CEventPushMatchEnd._proto = {
  [1] = {
    "match_token",
    "GroupToken"
  },
  [2] = {"match_type", "int"},
  [3] = {
    "m_result",
    "MatchResult"
  }
}
_class("CEventPushJoinMatch", CSvrPushEvent)
CEventPushJoinMatch = CEventPushJoinMatch

function CEventPushJoinMatch:Constructor()
  self.m_match_to_join = GroupToken:New()
end

CEventPushJoinMatch._proto = {
  [1] = {
    "m_match_to_join",
    "GroupToken"
  }
}
_class("CEventPushLeaveMatch", CSvrPushEvent)
CEventPushLeaveMatch = CEventPushLeaveMatch

function CEventPushLeaveMatch:Constructor()
  self.m_result = MatchLeaveResult:New()
  self.m_match_to_join = GroupToken:New()
end

CEventPushLeaveMatch._proto = {
  [1] = {
    "m_result",
    "MatchLeaveResult"
  },
  [2] = {
    "m_match_to_join",
    "GroupToken"
  }
}
_class("CEventRequestEnterInnerGame", CCallRequestEvent)
CEventRequestEnterInnerGame = CEventRequestEnterInnerGame

function CEventRequestEnterInnerGame:Constructor()
end

CEventRequestEnterInnerGame._proto = {}
_class("CEventRequestExitInnerGame", CCallRequestEvent)
CEventRequestExitInnerGame = CEventRequestExitInnerGame

function CEventRequestExitInnerGame:Constructor()
end

CEventRequestExitInnerGame._proto = {}
_class("CEventMatchStartLoading", CMatchPushEvent)
CEventMatchStartLoading = CEventMatchStartLoading

function CEventMatchStartLoading:Constructor()
  self.match_type = 0
  self.level_id = 0
end

CEventMatchStartLoading._proto = {
  [1] = {"match_type", "int"},
  [2] = {"level_id", "int"}
}
_class("CEventUpdateLoadingProgress", CMatchPushEvent)
CEventUpdateLoadingProgress = CEventUpdateLoadingProgress

function CEventUpdateLoadingProgress:Constructor()
  self.m_progress = 0
end

CEventUpdateLoadingProgress._proto = {
  [1] = {"m_progress", "int"}
}
_class("CEventMatchStart", CMatchPushEvent)
CEventMatchStart = CEventMatchStart

function CEventMatchStart:Constructor()
  self.m_match_to_start = GroupToken:New()
end

CEventMatchStart._proto = {
  [1] = {
    "m_match_to_start",
    "GroupToken"
  }
}
_class("CEventGameOver", CMatchPushEvent)
CEventGameOver = CEventGameOver

function CEventGameOver:Constructor()
  self.m_player_pstid = 0
  self.m_result = MatchResult:New()
end

CEventGameOver._proto = {
  [1] = {
    "m_player_pstid",
    "int64"
  },
  [2] = {
    "m_result",
    "MatchResult"
  }
}
_class("CEventBattleLog", CMatchPushEvent)
CEventBattleLog = CEventBattleLog

function CEventBattleLog:Constructor()
  self.m_data_point_log = ""
end

CEventBattleLog._proto = {
  [1] = {
    "m_data_point_log",
    "string"
  }
}
_class("CEventLuaCommand", CMatchPushEvent)
CEventLuaCommand = CEventLuaCommand

function CEventLuaCommand:Constructor()
  self.cmd = ""
end

CEventLuaCommand._proto = {
  [1] = {"cmd", "string"}
}
_class("CEventWaveEnd", CMatchPushEvent)
CEventWaveEnd = CEventWaveEnd

function CEventWaveEnd:Constructor()
  self.wave_index = 0
end

CEventWaveEnd._proto = {
  [1] = {"wave_index", "int"}
}
_class("CEventCommandBase", CMatchPushEvent)
CEventCommandBase = CEventCommandBase

function CEventCommandBase:Constructor()
  self.EntityID = 0
  self.RoundCount = 0
  self.ClientWaitInput = 0
  self.IsAutoFight = false
  self.CmdIndex = 0
end

CEventCommandBase._proto = {
  [1] = {"EntityID", "int"},
  [2] = {"RoundCount", "int"},
  [3] = {
    "ClientWaitInput",
    "int"
  },
  [4] = {
    "IsAutoFight",
    "bool"
  },
  [5] = {"CmdIndex", "int"}
}
_class("CEventAutoFightCommand", CEventCommandBase)
CEventAutoFightCommand = CEventAutoFightCommand

function CEventAutoFightCommand:Constructor()
  self.EnableAutoFight = false
end

CEventAutoFightCommand._proto = {
  [1] = {
    "EnableAutoFight",
    "bool"
  }
}
_class("CEventCancelChainSkillCommand", CEventCommandBase)
CEventCancelChainSkillCommand = CEventCancelChainSkillCommand

function CEventCancelChainSkillCommand:Constructor()
end

CEventCancelChainSkillCommand._proto = {}
_class("CEventCastActiveSkillCommand", CEventCommandBase)
CEventCastActiveSkillCommand = CEventCastActiveSkillCommand

function CEventCastActiveSkillCommand:Constructor()
  self.ActiveSkillID = 0
  self.CasterPstID = 0
  self.CasterTrapEntityID = 0
end

CEventCastActiveSkillCommand._proto = {
  [1] = {
    "ActiveSkillID",
    "int"
  },
  [2] = {
    "CasterPstID",
    "int64"
  },
  [3] = {
    "CasterTrapEntityID",
    "int"
  }
}
_class("CEventCastPickUpChainSkillCommand", CEventCommandBase)
CEventCastPickUpChainSkillCommand = CEventCastPickUpChainSkillCommand

function CEventCastPickUpChainSkillCommand:Constructor()
  self.PickUpPos = 0
end

CEventCastPickUpChainSkillCommand._proto = {
  [1] = {"PickUpPos", "int"}
}
_class("CEventCastPickUpActiveSkillCommand", CEventCommandBase)
CEventCastPickUpActiveSkillCommand = CEventCastPickUpActiveSkillCommand

function CEventCastPickUpActiveSkillCommand:Constructor()
  self.ActiveSkillID = 0
  self.CasterPstID = 0
  self.PickUpPosList = {}
  self.PickUpDirList = {}
  self.LastPickUpDirection = 0
  self.DirectionPickUpPos = {}
  self.ReflectDir = 0
  self.CasterTrapEntityID = 0
  self.PickUpExtraParamList = {}
  self.PickUpPetPstID = 0
  self.TetrisDirIndex = 0
end

CEventCastPickUpActiveSkillCommand._proto = {
  [1] = {
    "ActiveSkillID",
    "int"
  },
  [2] = {
    "CasterPstID",
    "int64"
  },
  [3] = {
    "PickUpPosList",
    "list<int>"
  },
  [4] = {
    "PickUpDirList",
    "list<int>"
  },
  [5] = {
    "LastPickUpDirection",
    "int"
  },
  [6] = {
    "DirectionPickUpPos",
    "map<int,int>"
  },
  [7] = {"ReflectDir", "int"},
  [8] = {
    "CasterTrapEntityID",
    "int"
  },
  [9] = {
    "PickUpExtraParamList",
    "list<int>"
  },
  [10] = {
    "PickUpPetPstID",
    "int64"
  },
  [11] = {
    "TetrisDirIndex",
    "int"
  }
}
_class("CEventChangeTeamLeaderCommand", CEventCommandBase)
CEventChangeTeamLeaderCommand = CEventChangeTeamLeaderCommand

function CEventChangeTeamLeaderCommand:Constructor()
  self.OldLeaderPstID = 0
  self.NewLeaderPstID = 0
end

CEventChangeTeamLeaderCommand._proto = {
  [1] = {
    "OldLeaderPstID",
    "int64"
  },
  [2] = {
    "NewLeaderPstID",
    "int64"
  }
}
_class("CEventGuideCommand", CEventCommandBase)
CEventGuideCommand = CEventGuideCommand

function CEventGuideCommand:Constructor()
  self.PetPstID = 0
  self.GuideStepID = 0
end

CEventGuideCommand._proto = {
  [1] = {"PetPstID", "int64"},
  [2] = {
    "GuideStepID",
    "int"
  }
}
_class("CEventMovePathDoneCommand", CEventCommandBase)
CEventMovePathDoneCommand = CEventMovePathDoneCommand

function CEventMovePathDoneCommand:Constructor()
  self.ChainPath = {}
  self.ElementType = 0
  self.ActiveSkillID = 0
  self.CasterPstID = 0
end

CEventMovePathDoneCommand._proto = {
  [1] = {"ChainPath", "list<int>"},
  [2] = {
    "ElementType",
    "int"
  },
  [3] = {
    "ActiveSkillID",
    "int"
  },
  [4] = {
    "CasterPstID",
    "int64"
  }
}
_class("CEventCastChessPetMoveCommand", CEventCommandBase)
CEventCastChessPetMoveCommand = CEventCastChessPetMoveCommand

function CEventCastChessPetMoveCommand:Constructor()
  self.casterEntityID = 0
  self.chessPath = {}
end

CEventCastChessPetMoveCommand._proto = {
  [1] = {
    "casterEntityID",
    "int"
  },
  [2] = {"chessPath", "list<int>"}
}
_class("CEventCastChessPetAttackCommand", CEventCommandBase)
CEventCastChessPetAttackCommand = CEventCastChessPetAttackCommand

function CEventCastChessPetAttackCommand:Constructor()
  self.casterEntityID = 0
  self.targetEntityList = {}
  self.chessPath = {}
  self.pickUpPos = 0
end

CEventCastChessPetAttackCommand._proto = {
  [1] = {
    "casterEntityID",
    "int"
  },
  [2] = {
    "targetEntityList",
    "list<int>"
  },
  [3] = {"chessPath", "list<int>"},
  [4] = {"pickUpPos", "int"}
}
_class("CEventCastChessPetEndTurnCommand", CEventCommandBase)
CEventCastChessPetEndTurnCommand = CEventCastChessPetEndTurnCommand

function CEventCastChessPetEndTurnCommand:Constructor()
  self.turnType = 0
  self.turnEndEntityID = 0
end

CEventCastChessPetEndTurnCommand._proto = {
  [1] = {"turnType", "int"},
  [2] = {
    "turnEndEntityID",
    "int"
  }
}
_class("CEventCastSelectTeamOrderPositionCommand", CEventCommandBase)
CEventCastSelectTeamOrderPositionCommand = CEventCastSelectTeamOrderPositionCommand

function CEventCastSelectTeamOrderPositionCommand:Constructor()
  self.targetPos = 0
  self.casterPstID = 0
end

CEventCastSelectTeamOrderPositionCommand._proto = {
  [1] = {"targetPos", "int"},
  [2] = {
    "casterPstID",
    "int64"
  }
}
_class("CEventCastClearSelectedTeamOrderPositionCommand", CEventCommandBase)
CEventCastClearSelectedTeamOrderPositionCommand = CEventCastClearSelectedTeamOrderPositionCommand

function CEventCastClearSelectedTeamOrderPositionCommand:Constructor()
  self.targetPos = 0
  self.casterPstID = 0
end

CEventCastClearSelectedTeamOrderPositionCommand._proto = {
  [1] = {"targetPos", "int"},
  [2] = {
    "casterPstID",
    "int64"
  }
}
_class("CEventClientExceptionReportCommand", CEventCommandBase)
CEventClientExceptionReportCommand = CEventClientExceptionReportCommand

function CEventClientExceptionReportCommand:Constructor()
  self.reportType = 0
  self.msg = ""
  self.tag = ""
end

CEventClientExceptionReportCommand._proto = {
  [1] = {"reportType", "int"},
  [2] = {"msg", "string"},
  [3] = {"tag", "string"}
}
local ScanFeatureActiveSkillType = {
  SummonTrap = 1,
  ForceMovement = 2,
  SummonScanTrap = 3
}
_enum("ScanFeatureActiveSkillType", ScanFeatureActiveSkillType)
_class("CEventScanFeatureCommand", CEventCommandBase)
CEventScanFeatureCommand = CEventScanFeatureCommand

function CEventScanFeatureCommand:Constructor()
  self.EntityID = 0
  self.ActiveSkillType = 0
  self.TrapID = 0
end

CEventScanFeatureCommand._proto = {
  [1] = {"EntityID", "int"},
  [2] = {
    "ActiveSkillType",
    "int"
  },
  [3] = {"TrapID", "int"}
}
_class("CEventChooseMiniMazeWaveAwardCommand", CEventCommandBase)
CEventChooseMiniMazeWaveAwardCommand = CEventChooseMiniMazeWaveAwardCommand

function CEventChooseMiniMazeWaveAwardCommand:Constructor()
  self.relicID = 0
  self.partnerID = 0
  self.isBattleOpening = false
end

CEventChooseMiniMazeWaveAwardCommand._proto = {
  [1] = {"relicID", "int"},
  [2] = {"partnerID", "int"},
  [3] = {
    "isBattleOpening",
    "bool"
  }
}
_class("CEventMiragePickUpCommand", CEventCommandBase)
CEventMiragePickUpCommand = CEventMiragePickUpCommand

function CEventMiragePickUpCommand:Constructor()
  self.gridPos = 0
end

CEventMiragePickUpCommand._proto = {
  [1] = {"gridPos", "int"}
}
_class("CEventMirageForceCloseCommand", CEventCommandBase)
CEventMirageForceCloseCommand = CEventMirageForceCloseCommand

function CEventMirageForceCloseCommand:Constructor()
end

CEventMirageForceCloseCommand._proto = {}
_class("CEventSwitchPetEquipRefineUICommand", CEventCommandBase)
CEventSwitchPetEquipRefineUICommand = CEventSwitchPetEquipRefineUICommand

function CEventSwitchPetEquipRefineUICommand:Constructor()
  self.UIState = 0
  self.CasterPstID = 0
end

CEventSwitchPetEquipRefineUICommand._proto = {
  [1] = {"UIState", "int"},
  [2] = {
    "CasterPstID",
    "int64"
  }
}
_class("CEventPopStarPickUpCommand", CEventCommandBase)
CEventPopStarPickUpCommand = CEventPopStarPickUpCommand

function CEventPopStarPickUpCommand:Constructor()
  self.gridPos = 0
  self.connectPieces = {}
end

CEventPopStarPickUpCommand._proto = {
  [1] = {"gridPos", "int"},
  [2] = {
    "connectPieces",
    "list<int>"
  }
}
_class("CEventRequestSweepMatch", CCallRequestEvent)
CEventRequestSweepMatch = CEventRequestSweepMatch

function CEventRequestSweepMatch:Constructor()
  self.match_type = 0
  self.mission_id = 0
  self.times = 0
  self.component_id = 0
  self.CampaignMissionParams = {}
end

CEventRequestSweepMatch._proto = {
  [1] = {"match_type", "int"},
  [2] = {"mission_id", "int"},
  [3] = {"times", "int"},
  [4] = {
    "component_id",
    "int"
  },
  [5] = {
    "CampaignMissionParams",
    "map<int,int64>"
  }
}
_class("CEventReplySweepMatch", CCallReplyEvent)
CEventReplySweepMatch = CEventReplySweepMatch

function CEventReplySweepMatch:Constructor()
  self.m_ret = 0
  self.m_result = MatchResult:New()
end

CEventReplySweepMatch._proto = {
  [1] = {"m_ret", "int"},
  [2] = {
    "m_result",
    "MatchResult"
  }
}
_class("CEventSyncClientUnscaledCountDownCommand", CEventCommandBase)
CEventSyncClientUnscaledCountDownCommand = CEventSyncClientUnscaledCountDownCommand

function CEventSyncClientUnscaledCountDownCommand:Constructor()
  self.flagID = 0
  self.state = 0
end

CEventSyncClientUnscaledCountDownCommand._proto = {
  [1] = {"flagID", "int"},
  [2] = {"state", "int"}
}
_class("CEventCastSelectInfoActiveSkillCommand", CEventCommandBase)
CEventCastSelectInfoActiveSkillCommand = CEventCastSelectInfoActiveSkillCommand

function CEventCastSelectInfoActiveSkillCommand:Constructor()
  self.ActiveSkillID = 0
  self.CasterPstID = 0
  self.SelectInfoList = {}
end

CEventCastSelectInfoActiveSkillCommand._proto = {
  [1] = {
    "ActiveSkillID",
    "int"
  },
  [2] = {
    "CasterPstID",
    "int64"
  },
  [3] = {
    "SelectInfoList",
    "list<int>"
  }
}
_class("CEventTetrisFeatureCommand", CEventCommandBase)
CEventTetrisFeatureCommand = CEventTetrisFeatureCommand

function CEventTetrisFeatureCommand:Constructor()
  self.opType = 0
  self.opValue = false
end

CEventTetrisFeatureCommand._proto = {
  [1] = {"opType", "int"},
  [2] = {"opValue", "bool"}
}
