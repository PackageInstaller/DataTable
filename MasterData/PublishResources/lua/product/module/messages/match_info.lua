local MatchStartCondition = {
  MSC_INVALID = 0,
  MSC_ALL_READY = 1,
  MSC_ON_ENTER = 2
}
_enum("MatchStartCondition", MatchStartCondition)
local MatchReleaseCondition = {
  MRC_INVALID = 0,
  MRC_NEVER = 1,
  MRC_ON_EMPTY = 2
}
_enum("MatchReleaseCondition", MatchReleaseCondition)
local MatchStatus = {
  MS_INIT = 0,
  MS_LOADING = 1,
  MS_PLAYING = 2,
  MS_OVER = 3
}
_enum("MatchStatus", MatchStatus)
local GamePlayerStatus = {
  PS_NONE = 0,
  PS_JOINED = 1,
  PS_LOADING = 2,
  PS_READY = 3,
  PS_PLAYING = 4,
  PS_AWAY = 5,
  PS_LEAVE = 6
}
_enum("GamePlayerStatus", GamePlayerStatus)
local MatchType = {
  MT_NONE = 0,
  MT_Mission = 1,
  MT_Incident = 2,
  MT_CatchEvil = 3,
  MT_Tower = 4,
  MT_ExtMission = 5,
  MT_Maze = 6,
  MT_ResDungeon = 7,
  MT_TalePet = 8,
  MT_Campaign = 9,
  MT_Conquest = 10,
  MT_LostArea = 11,
  MT_BlackFist = 12,
  MT_WorldBoss = 13,
  MT_Chess = 14,
  MT_DifficultyMission = 15,
  MT_SailingMission = 16,
  MT_MiniMaze = 17,
  MT_PopStar = 18,
  MT_Globalboss = 19,
  MT_EightPets = 20,
  MT_PopStarPro = 21,
  MT_SimpleBattleField = 22,
  MT_Season = 50,
  MT_Weekly = 51,
  MT_SeasonMaze = 52
}
_enum("MatchType", MatchType)
local CampaignSubMatchType = {
  CSMT_SUB_NONE = 0,
  CSMT_BLACKFIST = 1,
  CSMT_POPSTAR = 2,
  CSMT_TALENTTREE = 3
}
_enum("CampaignSubMatchType", CampaignSubMatchType)
local AutoFightEnableType = {
  Disable = 0,
  EnableIfUnlock = 1,
  EnableIfUnlockAndPassed = 2
}
_enum("AutoFightEnableType", AutoFightEnableType)
local SeasonMazeEffectType = {
  SMET_Invalid = 0,
  SMET_Pro = 1,
  SMET_Bead = 2,
  SMET_Relic = 3,
  SMET_Pet = 4,
  SMET_Once = 5,
  SMET_Hand = 6,
  SMET_RandomHandGold = 7,
  SMET_Once_Shoe = 8,
  SMET_HandStepRaiseReward = 9,
  SMET_RandomAutoBead = 10,
  SMET_Once_Sprint = 11,
  SMET_Once_Retrun = 12,
  SMET_Once_Bomb = 13,
  SMET_ChangeAllPetBlood = 14,
  SMET_ChangeAllPetMaxBlood = 15,
  SMET_GetRandomPet = 16,
  SMET_RandomDelHand = 17,
  SMET_BloodExchangeExp = 18,
  SMET_GoldExchangeExp = 19,
  SMET_UnlockBeadSlot = 20,
  SMET_Bead_LV = 21,
  SMET_RandomRelic = 23,
  SMET_RandomHandLv = 24
}
_enum("SeasonMazeEffectType", SeasonMazeEffectType)
local SeasonMazeAttrType = {
  SMAT_Invalid = 0,
  SMAT_Gold = 1,
  SMAT_Exp = 2,
  SMAT_Ms = 3,
  SMAT_Round = 4,
  SMAT_Lv = 5,
  SMAT_Gold_Round_Add = 6,
  SMAT_Exp_Percent = 7,
  SMAT_Goods_Price_Percent = 8,
  SMAT_Boss_Round_Add = 9,
  SMAT_Hand_Add = 10,
  SMAT_Next_Hand_Add = 11,
  SMAT_Gain_Bead_Lv_Fix = 12,
  SMAT_Round_Step_All = 14,
  SMAT_Boss_Gold_Interest = 15,
  SMAT_Lv_Up_Gold = 16,
  SMAT_Gain_Up_Gold = 17,
  SMAT_Fight_Room_Exp = 18,
  SMAT_Back_Start_Exp = 19,
  SMAT_Resource_Percent = 20,
  SMAT_Relic_Chose_Num_Fix = 21,
  SMAT_Free_Reroll_Num = 22,
  SMAT_Pet_Awakening_Value = 23,
  SMAT_Hand_Reward_Ratio = 24,
  SMAT_Fight_Sweep = 25,
  SMAT_Chest_All_Reward = 26,
  SMAT_Score = 27,
  SMAT_HealthyCnt = 28,
  SMAT_ResurrectCnt = 30,
  SMAT_PetResetCnt = 31,
  SMAT_AutoBeadEnergy = 32,
  SMAT_VictoryRecoverHP = 33,
  SMAT_RandomMaxBreakPet = 34,
  SMAT_OnceShoesCnt = 35,
  SMAT_AlgorithmUpEnergy = 36,
  SMAT_WorldBossTicket = 37,
  SMET_PetBanExtCnt = 38,
  SMET_PetAttackRatio = 200,
  SMET_PetDefRatio = 201,
  SMET_PetHpRatio = 202,
  SMET_PetAttackDamageRatio = 203,
  SMET_PetChainSkillDamageRatio = 204,
  SMET_PetActiveSkillDamageRatio = 205
}
_enum("SeasonMazeAttrType", SeasonMazeAttrType)
local MatchLogicFlags = {MLF_AutoFight = 0, MLF_SpeedUp = 1}
_enum("MatchLogicFlags", MatchLogicFlags)
_class("MatchPetInfo", Object)
MatchPetInfo = MatchPetInfo

function MatchPetInfo:Constructor()
  self.pet_pstid = 0
  self.pet_power = 0
  self.template_id = 0
  self.level = 0
  self.grade = 0
  self.awakening = 0
  self.affinity_level = 0
  self.team_slot = 0
  self.attack = 0
  self.defense = 0
  self.max_hp = 0
  self.cur_hp = 0
  self.after_damage = 0
  self.equip_lv = 0
  self.m_nHelpPetKey = 0
  self.current_skin = 0
  self.equip_refine_lv = 0
  self.awake_lock = 0
end

MatchPetInfo._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {"pet_power", "int"},
  [3] = {
    "template_id",
    "int"
  },
  [4] = {"level", "int"},
  [5] = {"grade", "int"},
  [6] = {"awakening", "int"},
  [7] = {
    "affinity_level",
    "int"
  },
  [8] = {"team_slot", "int"},
  [9] = {"attack", "double"},
  [10] = {"defense", "double"},
  [11] = {"max_hp", "double"},
  [12] = {"cur_hp", "double"},
  [13] = {
    "after_damage",
    "double"
  },
  [14] = {"equip_lv", "int"},
  [15] = {
    "m_nHelpPetKey",
    "int"
  },
  [16] = {
    "current_skin",
    "int"
  },
  [17] = {
    "equip_refine_lv",
    "int"
  },
  [18] = {"awake_lock", "int"}
}
_class("LuaMatchPlayerInfo", Object)
LuaMatchPlayerInfo = LuaMatchPlayerInfo

function LuaMatchPlayerInfo:Constructor()
  self.pstid = 0
  self.nick = ""
  self.blood = 0.0
  self.pet_list = {}
  self.nLevel = 0
end

LuaMatchPlayerInfo._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"nick", "string"},
  [3] = {"blood", "double"},
  [4] = {
    "pet_list",
    "list<MatchPetInfo>"
  },
  [5] = {"nLevel", "int"}
}
_class("MatchJoinInfo", Object)
MatchJoinInfo = MatchJoinInfo

function MatchJoinInfo:Constructor()
  self.player_id = 0
  self.game_token = 0
  self.nick = ""
  self.blood = 0.0
  self.pet_list = {}
  self.nLevel = 0
end

MatchJoinInfo._proto = {
  [1] = {"player_id", "int64"},
  [2] = {"game_token", "ushort"},
  [3] = {"nick", "string"},
  [4] = {"blood", "double"},
  [5] = {
    "pet_list",
    "list<MatchPetInfo>"
  },
  [6] = {"nLevel", "int"}
}
_class("MatchStartInfo", Object)
MatchStartInfo = MatchStartInfo

function MatchStartInfo:Constructor()
  self.sync_game_mode = 0
  self.level_id = 0
  self.invite_id = 0
end

MatchStartInfo._proto = {
  [1] = {
    "sync_game_mode",
    "int"
  },
  [2] = {"level_id", "int"},
  [3] = {"invite_id", "int64"}
}
_class("MatchSyncInfo", Object)
MatchSyncInfo = MatchSyncInfo

function MatchSyncInfo:Constructor()
  self.nick = ""
end

MatchSyncInfo._proto = {
  [1] = {"nick", "string"}
}
_class("QuickJoinMatchRequest", Object)
QuickJoinMatchRequest = QuickJoinMatchRequest

function QuickJoinMatchRequest:Constructor()
  self.player_ids = {}
  self.game_mode = 0
  self.level_id = 0
  self.game_token = 0
  self.match_token = GroupToken:New()
  self.serial = 0
end

QuickJoinMatchRequest._proto = {
  [1] = {
    "player_ids",
    "list<int64>"
  },
  [2] = {"game_mode", "int"},
  [3] = {"level_id", "int"},
  [4] = {"game_token", "ushort"},
  [5] = {
    "match_token",
    "GroupToken"
  },
  [6] = {"serial", "int64"}
}
_class("MatchPlayerResult", Object)
MatchPlayerResult = MatchPlayerResult

function MatchPlayerResult:Constructor()
  self.score = 0
  self.nick = ""
end

MatchPlayerResult._proto = {
  [1] = {"score", "int"},
  [2] = {"nick", "string"}
}
_class("MatchLeaveResult", Object)
MatchLeaveResult = MatchLeaveResult

function MatchLeaveResult:Constructor()
  self.match_token = GroupToken:New()
end

MatchLeaveResult._proto = {
  [1] = {
    "match_token",
    "GroupToken"
  }
}
_class("MissionCreateInfo", Object)
MissionCreateInfo = MissionCreateInfo

function MissionCreateInfo:Constructor()
  self.mission_id = 0
  self.asset_double_item_count = 0
end

MissionCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "asset_double_item_count",
    "int"
  }
}
_class("IncidentCreateInfo", Object)
IncidentCreateInfo = IncidentCreateInfo

function IncidentCreateInfo:Constructor()
  self.incident_id = 0
  self.incident_tid = 0
end

IncidentCreateInfo._proto = {
  [1] = {
    "incident_id",
    "int64"
  },
  [2] = {
    "incident_tid",
    "int"
  }
}
_class("ExtMissionCreateInfo", Object)
ExtMissionCreateInfo = ExtMissionCreateInfo

function ExtMissionCreateInfo:Constructor()
  self.m_nExtMissionID = 0
  self.m_nExtTaskID = 0
end

ExtMissionCreateInfo._proto = {
  [1] = {
    "m_nExtMissionID",
    "int"
  },
  [2] = {
    "m_nExtTaskID",
    "int"
  }
}
_class("MazeCreateInfo", Object)
MazeCreateInfo = MazeCreateInfo

function MazeCreateInfo:Constructor()
  self.maze_version = 0
  self.maze_layer = 0
  self.maze_room_index = 0
  self.maze_light = 0
  self.maze_room_id = 0
  self.maze_step = 0
  self.relics = {}
  self.relic_counters = {}
  self.wave_randoms = {}
  self.avg_pet_level = 0.0
  self.maze_rand_seed = 0
  self.battle_archive = ""
  self.has_archive = false
end

MazeCreateInfo._proto = {
  [1] = {
    "maze_version",
    "int"
  },
  [2] = {"maze_layer", "int"},
  [3] = {
    "maze_room_index",
    "int"
  },
  [4] = {"maze_light", "int"},
  [5] = {
    "maze_room_id",
    "int"
  },
  [6] = {"maze_step", "int"},
  [8] = {"relics", "list<int>"},
  [9] = {
    "relic_counters",
    "map<int,int>"
  },
  [10] = {
    "wave_randoms",
    "list<float>"
  },
  [11] = {
    "avg_pet_level",
    "float"
  },
  [12] = {
    "maze_rand_seed",
    "uint"
  },
  [13] = {
    "battle_archive",
    "string"
  },
  [14] = {
    "has_archive",
    "bool"
  }
}
_class("ResDungeonCreateInfo", Object)
ResDungeonCreateInfo = ResDungeonCreateInfo

function ResDungeonCreateInfo:Constructor()
  self.res_dungeon_id = 0
  self.asset_double_item_count = 0
end

ResDungeonCreateInfo._proto = {
  [1] = {
    "res_dungeon_id",
    "int"
  },
  [2] = {
    "asset_double_item_count",
    "int"
  }
}
_class("TowerCreateInfo", Object)
TowerCreateInfo = TowerCreateInfo

function TowerCreateInfo:Constructor()
  self.nId = 0
end

TowerCreateInfo._proto = {
  [1] = {"nId", "int"}
}
_class("TalePetCreateInfo", Object)
TalePetCreateInfo = TalePetCreateInfo

function TalePetCreateInfo:Constructor()
  self.nId = 0
end

TalePetCreateInfo._proto = {
  [1] = {"nId", "int"}
}
local ECampaignMissionComponentId = {
  ECampaignMissionComponentId_Begin = 1,
  ECampaignMissionComponentId_Line = 1,
  ECampaignMissionComponentId_Tree = 2,
  ECampaignMissionComponentId_SummerII = 3,
  ECampaignMissionComponentId_Blackfist = 4,
  ECampaignMissionComponentId_CamSimulator = 5,
  ECampaignMissionComponentId_AircraftNormal = 6,
  ECampaignMissionComponentId_SimulatorBlackfist = 7,
  ECampaignMissionComponentId_AircraftBlackfist = 8,
  ECampaignMissionComponentId_Entrust = 9,
  ECampaignMissionComponentId_DailyMission = 10,
  ECampaignMissionComponentId_ChallengeMission = 11,
  ECampaignMissionComponentId_ChessMission = 12,
  ECampaignMissionComponentId_Bloodsucker = 13,
  ECampaignMissionComponentId_PopStar = 14,
  ECampaignMissionComponentId_Globalboss = 15,
  ECampaignMissionComponentId_MultiLine = 16,
  ECampaignMissionComponentId_EightPets = 17,
  ECampaignMissionComponentId_SeasonMission = 18,
  ECampaignMissionComponentId_WeeklyMission = 19,
  ECampaignMissionComponentId_LinePopStar = 20,
  ECampaignMissionComponentId_SimpleBattleField = 21,
  ECampaignMissionComponentId_SeasonMaze = 22,
  ECampaignMissionComponentId_End = 23
}
_enum("ECampaignMissionComponentId", ECampaignMissionComponentId)
local ECampaignMissionParamKey = {
  ECampaignMissionParamKey_None = 0,
  ECampaignMissionParamKey_ComCfgId = 1,
  ECampaignMissionParamKey_BlackfistdayId = 2,
  ECampaignMissionParamKey_CartridgePstId = 3,
  ECampaignMissionParamKey_FormationID = 4,
  ECampaignMissionParamKey_HelpPetKey = 5,
  ECampaignMissionParamKey_CSHardId = 6,
  ECampaignMissionParamKey_TeamIndex = 7,
  ECampaignMissionParamKey_SeasonMazeHard = 8,
  ECampaignMissionParamKey_SeasonMazeRandom = 9
}
_enum("ECampaignMissionParamKey", ECampaignMissionParamKey)
local EDifficultyMissionComponentId = {EDifficultyMissionComponentId_General = 0, EDifficultyMissionComponentId_Campaign = 1}
_enum("EDifficultyMissionComponentId", EDifficultyMissionComponentId)
_class("CampaignMissionCreateInfo", Object)
CampaignMissionCreateInfo = CampaignMissionCreateInfo

function CampaignMissionCreateInfo:Constructor()
  self.nCampaignMissionId = 0
  self.nMissionComId = 0
  self.CampaignMissionParams = {}
  self.nSubMatchType = 0
  self.mTalentTreeSkills = {}
  self.mBlackTeamInfo = {}
end

CampaignMissionCreateInfo._proto = {
  [1] = {
    "nCampaignMissionId",
    "int"
  },
  [2] = {
    "nMissionComId",
    "int"
  },
  [3] = {
    "CampaignMissionParams",
    "map<int,int64>"
  },
  [4] = {
    "nSubMatchType",
    "int"
  },
  [5] = {
    "mTalentTreeSkills",
    "list<int>"
  },
  [6] = {
    "mBlackTeamInfo",
    "list<MatchPetInfo>"
  }
}
local EConquestMissionComponentType = {
  ECONMCT_BEGIN = 1,
  ECONMCT_BATTLEFIELD = 1,
  ECONMCT_END = 4
}
_enum("EConquestMissionComponentType", EConquestMissionComponentType)
_class("ConquestMissionCreateInfo", Object)
ConquestMissionCreateInfo = ConquestMissionCreateInfo

function ConquestMissionCreateInfo:Constructor()
  self.mission_id = 0
  self.component_type = 0
  self.component_cfg_id = 0
  self.random_index = 0
end

ConquestMissionCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "component_type",
    "int"
  },
  [3] = {
    "component_cfg_id",
    "int"
  },
  [4] = {
    "random_index",
    "int"
  }
}
_class("LostAreaCreateInfo", Object)
LostAreaCreateInfo = LostAreaCreateInfo

function LostAreaCreateInfo:Constructor()
  self.mission_id = 0
end

LostAreaCreateInfo._proto = {
  [1] = {"mission_id", "int"}
}
_class("BlackFistCreateInfo", Object)
BlackFistCreateInfo = BlackFistCreateInfo

function BlackFistCreateInfo:Constructor()
  self.mission_id = 0
  self.component_id = 0
  self.CampaignMissionParams = {}
  self.black_team_info = {}
end

BlackFistCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "component_id",
    "int"
  },
  [3] = {
    "CampaignMissionParams",
    "map<int,int64>"
  },
  [4] = {
    "black_team_info",
    "list<MatchPetInfo>"
  }
}
_class("WorldBossCreateInfo", Object)
WorldBossCreateInfo = WorldBossCreateInfo

function WorldBossCreateInfo:Constructor()
  self.mission_id = 0
  self.select_index = 0
end

WorldBossCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "select_index",
    "int"
  }
}
local EChessMissionComponentType = {
  ECONMCT_CHESS_BEGIN = 0,
  ECONMCT_CHESS = 1,
  ECONMCT_CHESS_END = 4
}
_enum("EChessMissionComponentType", EChessMissionComponentType)
_class("ChessMissionCreateInfo", Object)
ChessMissionCreateInfo = ChessMissionCreateInfo

function ChessMissionCreateInfo:Constructor()
  self.mission_id = 0
  self.component_id = 0
  self.CampaignMissionParams = {}
end

ChessMissionCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "component_id",
    "int"
  },
  [3] = {
    "CampaignMissionParams",
    "map<int,int64>"
  }
}
_class("DifficultyMissionCreateInfo", Object)
DifficultyMissionCreateInfo = DifficultyMissionCreateInfo

function DifficultyMissionCreateInfo:Constructor()
  self.parent_mission_id = 0
  self.sub_mission_id = 0
  self.mission_component_id = 0
  self.campaign_component_cfg_id = 0
end

DifficultyMissionCreateInfo._proto = {
  [1] = {
    "parent_mission_id",
    "int"
  },
  [2] = {
    "sub_mission_id",
    "int"
  },
  [3] = {
    "mission_component_id",
    "int"
  },
  [4] = {
    "campaign_component_cfg_id",
    "int"
  }
}
_class("SailingMissionCreateInfo", Object)
SailingMissionCreateInfo = SailingMissionCreateInfo

function SailingMissionCreateInfo:Constructor()
  self.layer_id = 0
  self.mission_id = 0
end

SailingMissionCreateInfo._proto = {
  [1] = {"layer_id", "int"},
  [2] = {"mission_id", "int"}
}
_class("TalentTreeSkillNode", Object)
TalentTreeSkillNode = TalentTreeSkillNode

function TalentTreeSkillNode:Constructor()
  self.index = 0
  self.level = 0
  self.skill_id = 0
  self.skill_type = 0
  self.select = 0
end

TalentTreeSkillNode._proto = {
  [1] = {"index", "int"},
  [2] = {"level", "int"},
  [3] = {"skill_id", "int"},
  [4] = {"skill_type", "int"},
  [5] = {"select", "int"}
}
_class("BloodsuckerMissionCreateInfo", Object)
BloodsuckerMissionCreateInfo = BloodsuckerMissionCreateInfo

function BloodsuckerMissionCreateInfo:Constructor()
  self.mission_id = 0
  self.component_type = 0
  self.component_cfg_id = 0
  self.relics = {}
  self.skill_info = {}
end

BloodsuckerMissionCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "component_type",
    "int"
  },
  [3] = {
    "component_cfg_id",
    "int"
  },
  [4] = {"relics", "list<int>"},
  [5] = {
    "skill_info",
    "list<TalentTreeSkillNode>"
  }
}
_class("PopStarMissionCreateInfo", Object)
PopStarMissionCreateInfo = PopStarMissionCreateInfo

function PopStarMissionCreateInfo:Constructor()
  self.mission_id = 0
  self.component_id = 0
  self.CampaignMissionParams = {}
  self.is_challenge = false
end

PopStarMissionCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "component_id",
    "int"
  },
  [3] = {
    "CampaignMissionParams",
    "map<int,int64>"
  },
  [4] = {
    "is_challenge",
    "bool"
  }
}
_class("GlobalbossMissionCreateInfo", Object)
GlobalbossMissionCreateInfo = GlobalbossMissionCreateInfo

function GlobalbossMissionCreateInfo:Constructor()
  self.mission_id = 0
  self.component_id = 0
  self.CampaignMissionParams = {}
end

GlobalbossMissionCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "component_id",
    "int"
  },
  [3] = {
    "CampaignMissionParams",
    "map<int,int64>"
  }
}
_class("SeasonMissionCreateInfo", Object)
SeasonMissionCreateInfo = SeasonMissionCreateInfo

function SeasonMissionCreateInfo:Constructor()
  self.mission_id = 0
  self.component_id = 0
  self.CampaignMissionParams = {}
end

SeasonMissionCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "component_id",
    "int"
  },
  [3] = {
    "CampaignMissionParams",
    "map<int,int64>"
  }
}
_class("EightPetsMissionCreateInfo", Object)
EightPetsMissionCreateInfo = EightPetsMissionCreateInfo

function EightPetsMissionCreateInfo:Constructor()
  self.mission_id = 0
  self.component_id = 0
  self.CampaignMissionParams = {}
end

EightPetsMissionCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "component_id",
    "int"
  },
  [3] = {
    "CampaignMissionParams",
    "map<int,int64>"
  }
}
local ESeasonMazeAutoBeadAttr = {
  ESeasonMazeAutoBeadAttr_Crit = 0,
  ESeasonMazeAutoBeadAttr_Hit = 1,
  ESeasonMazeAutoBeadAttr_Combo = 2,
  ESeasonMazeAutoBeadAttr_HurtFload = 3,
  ESeasonMazeAutoBeadAttr_Energy = 4,
  ESeasonMazeAutoBeadAttr_Hurt = 5,
  ESeasonMazeAutoBeadAttr_CritHurt = 6
}
_enum("ESeasonMazeAutoBeadAttr", ESeasonMazeAutoBeadAttr)
_class("SeasonMazeAutoBeadInfo", Object)
SeasonMazeAutoBeadInfo = SeasonMazeAutoBeadInfo

function SeasonMazeAutoBeadInfo:Constructor()
  self.unique_id = 0
  self.bead_id = 0
  self.att_info = {}
end

SeasonMazeAutoBeadInfo._proto = {
  [1] = {"unique_id", "int"},
  [2] = {"bead_id", "int"},
  [3] = {
    "att_info",
    "map<int,int>"
  }
}
_class("SeasonMazeMissionCreateInfo", Object)
SeasonMazeMissionCreateInfo = SeasonMazeMissionCreateInfo

function SeasonMazeMissionCreateInfo:Constructor()
  self.room_id = 0
  self.mission_id = 0
  self.component_id = 0
  self.CampaignMissionParams = {}
  self.relic_list = {}
  self.autobead_list = {}
  self.suit_relic_list = {}
  self.outside_attr = {}
  self.wave_randoms = {}
  self.match_sub_type = 0
  self.world_boss_round_cnt = 0
end

SeasonMazeMissionCreateInfo._proto = {
  [1] = {"room_id", "int"},
  [2] = {"mission_id", "int"},
  [3] = {
    "component_id",
    "int"
  },
  [4] = {
    "CampaignMissionParams",
    "map<int,int64>"
  },
  [5] = {
    "relic_list",
    "map<int,int>"
  },
  [6] = {
    "autobead_list",
    "list<SeasonMazeAutoBeadInfo>"
  },
  [7] = {
    "suit_relic_list",
    "list<int>"
  },
  [8] = {
    "outside_attr",
    "map<int,int>"
  },
  [9] = {
    "wave_randoms",
    "list<float>"
  },
  [10] = {
    "match_sub_type",
    "int"
  },
  [11] = {
    "world_boss_round_cnt",
    "int"
  }
}
_class("AnipopMissionCreateInfo", Object)
AnipopMissionCreateInfo = AnipopMissionCreateInfo

function AnipopMissionCreateInfo:Constructor()
  self.mission_id = 0
  self.mission_index = 0
  self.left_turn = 0
  self.relics = {}
  self.relic_counters = {}
  self.wave_randoms = {}
  self.rand_seed = 0
  self.team_blood = 100
  self.camp_id = 0
  self.fetters_id = 0
  self.feature_info_list = {}
  self.skill_relics = {}
end

AnipopMissionCreateInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "mission_index",
    "int"
  },
  [3] = {"left_turn", "int"},
  [4] = {"relics", "list<int>"},
  [5] = {
    "relic_counters",
    "map<int,int>"
  },
  [6] = {
    "wave_randoms",
    "list<float>"
  },
  [7] = {"rand_seed", "uint"},
  [8] = {"team_blood", "int"},
  [9] = {"camp_id", "int"},
  [10] = {"fetters_id", "int"},
  [11] = {
    "feature_info_list",
    "map<int,int>"
  },
  [12] = {
    "skill_relics",
    "list<int>"
  }
}
_class("ClientMatchCreateInfo", Object)
ClientMatchCreateInfo = ClientMatchCreateInfo

function ClientMatchCreateInfo:Constructor()
  self.mission_info = {}
  self.m_extMissionInfo = {}
  self.maze_info = {}
  self.resdungeon_info = {}
  self.tower_info = {}
  self.campaign_mission_info = {}
  self.tale_pet_info = {}
  self.conquest_mission_info = {}
  self.lost_area_mission_info = {}
  self.black_fist_info = {}
  self.world_boss_mission_info = {}
  self.chess_mission_info = {}
  self.difficulty_mission_info = {}
  self.sailing_mission_info = {}
  self.bloodsucker_mission_info = {}
  self.popstar_mission_info = {}
  self.globalboss_mission_info = {}
  self.season_mission_info = {}
  self.eight_pets_mission_info = {}
  self.anipop_mission_info = {}
  self.season_maze_mission_info = {}
end

ClientMatchCreateInfo._proto = {
  [1] = {
    "mission_info",
    "list<MissionCreateInfo>"
  },
  [3] = {
    "m_extMissionInfo",
    "list<ExtMissionCreateInfo>"
  },
  [4] = {
    "maze_info",
    "list<MazeCreateInfo>"
  },
  [5] = {
    "resdungeon_info",
    "list<ResDungeonCreateInfo>"
  },
  [6] = {
    "tower_info",
    "list<TowerCreateInfo>"
  },
  [7] = {
    "campaign_mission_info",
    "list<CampaignMissionCreateInfo>"
  },
  [8] = {
    "tale_pet_info",
    "list<TalePetCreateInfo>"
  },
  [9] = {
    "conquest_mission_info",
    "list<ConquestMissionCreateInfo>"
  },
  [10] = {
    "lost_area_mission_info",
    "list<LostAreaCreateInfo>"
  },
  [11] = {
    "black_fist_info",
    "list<BlackFistCreateInfo>"
  },
  [12] = {
    "world_boss_mission_info",
    "list<WorldBossCreateInfo>"
  },
  [13] = {
    "chess_mission_info",
    "list<ChessMissionCreateInfo>"
  },
  [14] = {
    "difficulty_mission_info",
    "list<DifficultyMissionCreateInfo>"
  },
  [15] = {
    "sailing_mission_info",
    "list<SailingMissionCreateInfo>"
  },
  [16] = {
    "bloodsucker_mission_info",
    "list<BloodsuckerMissionCreateInfo>"
  },
  [17] = {
    "popstar_mission_info",
    "list<PopStarMissionCreateInfo>"
  },
  [18] = {
    "globalboss_mission_info",
    "list<GlobalbossMissionCreateInfo>"
  },
  [19] = {
    "season_mission_info",
    "list<SeasonMissionCreateInfo>"
  },
  [20] = {
    "eight_pets_mission_info",
    "list<EightPetsMissionCreateInfo>"
  },
  [21] = {
    "anipop_mission_info",
    "list<AnipopMissionCreateInfo>"
  },
  [22] = {
    "season_maze_mission_info",
    "list<SeasonMazeMissionCreateInfo>"
  }
}
local ELinkLineType = {ELLT_LINE_Common = 0, ELLT_LINE_NoElementCostStep = 1}
_enum("ELinkLineType", ELinkLineType)
_class("MatchCreateInfo", Object)
MatchCreateInfo = MatchCreateInfo

function MatchCreateInfo:Constructor()
  self.match_type = 0
  self.creator_id = 0
  self.level_id = 0
  self.formation_id = 0
  self.seed = 0
  self.m_time = 0
  self.match_logic_flags = 0
  self.sync_mode = 0
  self.server_auto_fight = false
  self.guide_info = GuideInfo:New()
  self.word_ids = {}
  self.client_create_info = ClientMatchCreateInfo:New()
  self.level_is_pass = false
  self.assign_wave_refresh_probability = 0
  self.m_nHelpPetKey = 0
  self.tale_pet_buffs = {}
  self.normal_pet_buffs = {}
  self.trail_buff_level_id = 0
  self.double_resource_state = false
  self.affixList = {}
  self.hard_id = 0
  self.hard_pro_id = 0
  self.wave_id_list = {}
  self.broad_id_list = {}
  self.board_seed = 0
  self.cartridge_pst_id = 0
  self.pro_type_id = {}
  self.link_line_type = 0
  self.is_restart = false
end

MatchCreateInfo._proto = {
  [1] = {"match_type", "int"},
  [2] = {"creator_id", "int64"},
  [3] = {"level_id", "int"},
  [4] = {
    "formation_id",
    "int"
  },
  [5] = {"seed", "uint"},
  [6] = {"m_time", "time"},
  [7] = {
    "match_logic_flags",
    "uint64"
  },
  [8] = {"sync_mode", "int"},
  [9] = {
    "server_auto_fight",
    "bool"
  },
  [10] = {"guide_info", "GuideInfo"},
  [11] = {"word_ids", "list<int>"},
  [12] = {
    "client_create_info",
    "ClientMatchCreateInfo"
  },
  [13] = {
    "level_is_pass",
    "bool"
  },
  [14] = {
    "assign_wave_refresh_probability",
    "int"
  },
  [15] = {
    "m_nHelpPetKey",
    "int"
  },
  [16] = {
    "tale_pet_buffs",
    "list<int>"
  },
  [17] = {
    "normal_pet_buffs",
    "list<int>"
  },
  [18] = {
    "trail_buff_level_id",
    "int"
  },
  [19] = {
    "double_resource_state",
    "bool"
  },
  [20] = {"affixList", "list<int>"},
  [21] = {"hard_id", "int"},
  [22] = {
    "hard_pro_id",
    "int"
  },
  [23] = {
    "wave_id_list",
    "list<int>"
  },
  [24] = {
    "broad_id_list",
    "list<int>"
  },
  [25] = {"board_seed", "uint"},
  [26] = {
    "cartridge_pst_id",
    "int64"
  },
  [27] = {
    "pro_type_id",
    "map<int,int>"
  },
  [28] = {
    "link_line_type",
    "int"
  },
  [29] = {"is_restart", "bool"}
}
_class("BattleStatResult", Object)
BattleStatResult = BattleStatResult

function BattleStatResult:Constructor()
  self.UseTurn = 0
  self.LeftTurn = 0
  self.KillMonster = 0
  self.KillBoss = 0
  self.ActiveSkill = 0
  self.ChainSkill = 0
  self.SuperChain = 0
  self.ColorSkill = 0
  self.MaxChain = 0
  self.OneChainNormalAttack = 0
  self.OneChainKillMonster = 0
  self.OneActiveSkillKill = 0
  self.GainChest = 0
  self.Blood = 0
  self.AutoFight = 0
  self.DoubleSpeed = 0
  self.changeTeamLeaderNum = 0
  self.passivechangeLeaderNum = 0
  self.line_time = 0
  self.step_num = 0
  self.MazeAddLight = 0
  self.EraseSquare = {}
end

BattleStatResult._proto = {
  [1] = {"UseTurn", "int"},
  [2] = {"LeftTurn", "int"},
  [3] = {
    "KillMonster",
    "int"
  },
  [4] = {"KillBoss", "int"},
  [5] = {
    "ActiveSkill",
    "int"
  },
  [6] = {"ChainSkill", "int"},
  [7] = {"SuperChain", "int"},
  [8] = {"ColorSkill", "int"},
  [9] = {"MaxChain", "int"},
  [10] = {
    "OneChainNormalAttack",
    "int"
  },
  [11] = {
    "OneChainKillMonster",
    "int"
  },
  [12] = {
    "OneActiveSkillKill",
    "int"
  },
  [14] = {"GainChest", "int"},
  [15] = {"Blood", "double"},
  [16] = {"AutoFight", "int"},
  [17] = {
    "DoubleSpeed",
    "int"
  },
  [18] = {
    "changeTeamLeaderNum",
    "int"
  },
  [19] = {
    "passivechangeLeaderNum",
    "int"
  },
  [20] = {"line_time", "int"},
  [21] = {"step_num", "int"},
  [22] = {
    "MazeAddLight",
    "int"
  },
  [23] = {
    "EraseSquare",
    "map<int,int>"
  }
}
_class("MatchPetResult", Object)
MatchPetResult = MatchPetResult

function MatchPetResult:Constructor()
  self.pet_pstid = 0
  self.pet_power = 0
  self.pet_blood = 0
  self.pet_is_dead = false
end

MatchPetResult._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {"pet_power", "int"},
  [3] = {"pet_blood", "double"},
  [4] = {
    "pet_is_dead",
    "bool"
  }
}
_class("MatchResultRoleInfo", Object)
MatchResultRoleInfo = MatchResultRoleInfo

function MatchResultRoleInfo:Constructor()
  self.exp_before = 0
  self.max_phy_before = 0
  self.max_phy_after = 0
  self.phy_add = 0
end

MatchResultRoleInfo._proto = {
  [1] = {"exp_before", "int64"},
  [2] = {
    "max_phy_before",
    "int"
  },
  [3] = {
    "max_phy_after",
    "int"
  },
  [4] = {"phy_add", "int"}
}
_class("MissionResult", Object)
MissionResult = MissionResult

function MissionResult:Constructor()
  self.mission_id = 0
  self.star_condition = {}
  self.rewards = {}
  self.star_rewards = {}
  self.first_rewards = {}
  self.match_result_role_info = MatchResultRoleInfo:New()
end

MissionResult._proto = {
  [1] = {"mission_id", "int"},
  [3] = {
    "star_condition",
    "list<int>"
  },
  [4] = {
    "rewards",
    "list<RoleAsset>"
  },
  [5] = {
    "star_rewards",
    "list<RoleAsset>"
  },
  [6] = {
    "first_rewards",
    "list<RoleAsset>"
  },
  [7] = {
    "match_result_role_info",
    "MatchResultRoleInfo"
  }
}
_class("ExtMissionResult", Object)
ExtMissionResult = ExtMissionResult

function ExtMissionResult:Constructor()
  self.m_nExtMissionID = 0
  self.m_nExtTaskID = 0
  self.pass_without_help = 0
  self.m_vecCondition = {}
  self.m_vecAwardNormal = {}
  self.m_firstpass_award = {}
  self.m_vecAwardPerfect = {}
  self.match_result_role_info = MatchResultRoleInfo:New()
end

ExtMissionResult._proto = {
  [1] = {
    "m_nExtMissionID",
    "int"
  },
  [2] = {
    "m_nExtTaskID",
    "int"
  },
  [3] = {
    "pass_without_help",
    "int"
  },
  [4] = {
    "m_vecCondition",
    "list<int>"
  },
  [5] = {
    "m_vecAwardNormal",
    "list<RoleAsset>"
  },
  [6] = {
    "m_firstpass_award",
    "list<RoleAsset>"
  },
  [7] = {
    "m_vecAwardPerfect",
    "list<RoleAsset>"
  },
  [8] = {
    "match_result_role_info",
    "MatchResultRoleInfo"
  }
}
_class("MazeResult", Object)
MazeResult = MazeResult

function MazeResult:Constructor()
  self.maze_room_index = 0
  self.maze_room_id = 0
  self.pet_result = {}
  self.relics_counters = {}
  self.rewards = {}
  self.relics = {}
  self.drop_rewards = {}
  self.save_archive = false
  self.battle_archive = ""
end

MazeResult._proto = {
  [1] = {
    "maze_room_index",
    "int"
  },
  [2] = {
    "maze_room_id",
    "int"
  },
  [3] = {
    "pet_result",
    "list<MatchPetResult>"
  },
  [4] = {
    "relics_counters",
    "map<int,int>"
  },
  [5] = {
    "rewards",
    "list<RoleAsset>"
  },
  [6] = {
    "relics",
    "list<RoleAsset>"
  },
  [7] = {
    "drop_rewards",
    "list<RoleAsset>"
  },
  [8] = {
    "save_archive",
    "bool"
  },
  [9] = {
    "battle_archive",
    "string"
  }
}
_class("ResDungeonResult", Object)
ResDungeonResult = ResDungeonResult

function ResDungeonResult:Constructor()
  self.res_dungeon_id = 0
  self.rewards = {}
  self.match_result_role_info = MatchResultRoleInfo:New()
  self.ext_rewards = {}
  self.ext_rewards_no_double = {}
  self.double_ext_rewards = {}
  self.res_help_component_rewards = {}
end

ResDungeonResult._proto = {
  [1] = {
    "res_dungeon_id",
    "int"
  },
  [2] = {
    "rewards",
    "list<RoleAsset>"
  },
  [3] = {
    "match_result_role_info",
    "MatchResultRoleInfo"
  },
  [4] = {
    "ext_rewards",
    "list<RoleAsset>"
  },
  [5] = {
    "ext_rewards_no_double",
    "list<RoleAsset>"
  },
  [6] = {
    "double_ext_rewards",
    "list<RoleAsset>"
  },
  [7] = {
    "res_help_component_rewards",
    "list<RoleAsset>"
  }
}
_class("TowerResult", Object)
TowerResult = TowerResult

function TowerResult:Constructor()
  self.tower_id = 0
  self.rewards = {}
  self.match_result_role_info = MatchResultRoleInfo:New()
end

TowerResult._proto = {
  [1] = {"tower_id", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  },
  [3] = {
    "match_result_role_info",
    "MatchResultRoleInfo"
  }
}
_class("TalePetResult", Object)
TalePetResult = TalePetResult

function TalePetResult:Constructor()
  self.stage_id = 0
  self.rewards = {}
end

TalePetResult._proto = {
  [1] = {"stage_id", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("LostAreaResult", Object)
LostAreaResult = LostAreaResult

function LostAreaResult:Constructor()
  self.mission_id = 0
  self.first_pass_rewards = {}
  self.recommend_pet_rewards = {}
end

LostAreaResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "first_pass_rewards",
    "list<RoleAsset>"
  },
  [3] = {
    "recommend_pet_rewards",
    "list<RoleAsset>"
  }
}
_class("WorldBossResult", Object)
WorldBossResult = WorldBossResult

function WorldBossResult:Constructor()
  self.mission_id = 0
  self.total_damage = 0
end

WorldBossResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "total_damage",
    "int64"
  }
}
_class("CombatSimulatorResult", Object)
CombatSimulatorResult = CombatSimulatorResult

function CombatSimulatorResult:Constructor()
  self.cartridge_pst_id = 0
  self.cartridge_tpl_id = 0
  self.rewards = {}
  self.random_rewards = {}
  self.extra_rewards = {}
end

CombatSimulatorResult._proto = {
  [1] = {
    "cartridge_pst_id",
    "int64"
  },
  [2] = {
    "cartridge_tpl_id",
    "int"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  },
  [4] = {
    "random_rewards",
    "list<RoleAsset>"
  },
  [5] = {
    "extra_rewards",
    "list<RoleAsset>"
  }
}
_class("CampaignMissionResult", Object)
CampaignMissionResult = CampaignMissionResult

function CampaignMissionResult:Constructor()
  self.mission_id = 0
  self.star_condition = {}
  self.rewards = {}
  self.star_rewards = {}
  self.first_rewards = {}
  self.match_result_role_info = MatchResultRoleInfo:New()
  self.combat_simulator_result = CombatSimulatorResult:New()
  self.sub_type = 0
end

CampaignMissionResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "star_condition",
    "list<int>"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  },
  [4] = {
    "star_rewards",
    "list<RoleAsset>"
  },
  [5] = {
    "first_rewards",
    "list<RoleAsset>"
  },
  [6] = {
    "match_result_role_info",
    "MatchResultRoleInfo"
  },
  [7] = {
    "combat_simulator_result",
    "CombatSimulatorResult"
  },
  [8] = {"sub_type", "int"}
}
_class("ChessMissionResult", Object)
ChessMissionResult = ChessMissionResult

function ChessMissionResult:Constructor()
  self.mission_id = 0
  self.star_condition = {}
  self.rewards = {}
  self.star_rewards = {}
  self.first_rewards = {}
  self.match_result_role_info = MatchResultRoleInfo:New()
end

ChessMissionResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "star_condition",
    "list<int>"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  },
  [4] = {
    "star_rewards",
    "list<RoleAsset>"
  },
  [5] = {
    "first_rewards",
    "list<RoleAsset>"
  },
  [6] = {
    "match_result_role_info",
    "MatchResultRoleInfo"
  }
}
_class("ConquestMissionResult", Object)
ConquestMissionResult = ConquestMissionResult

function ConquestMissionResult:Constructor()
  self.mission_id = 0
  self.random_index = 0
  self.pass_wave_index = 0
  self.wave_award = RoleAsset:New()
end

ConquestMissionResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "random_index",
    "int"
  },
  [3] = {
    "pass_wave_index",
    "int"
  },
  [4] = {"wave_award", "RoleAsset"}
}
_class("BlackFistResult", Object)
BlackFistResult = BlackFistResult

function BlackFistResult:Constructor()
  self.mission_id = 0
  self.rewards = {}
  self.combat_simulator_result = CombatSimulatorResult:New()
end

BlackFistResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  },
  [3] = {
    "combat_simulator_result",
    "CombatSimulatorResult"
  }
}
_class("DifficultyMissionResult", Object)
DifficultyMissionResult = DifficultyMissionResult

function DifficultyMissionResult:Constructor()
  self.parent_mission_id = 0
  self.sub_mission_id = 0
  self.rewards = {}
  self.entries = {}
end

DifficultyMissionResult._proto = {
  [1] = {
    "parent_mission_id",
    "int"
  },
  [2] = {
    "sub_mission_id",
    "int"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  },
  [4] = {"entries", "list<int>"}
}
_class("SailingMissionResult", Object)
SailingMissionResult = SailingMissionResult

function SailingMissionResult:Constructor()
  self.layer_id = 0
  self.mission_id = 0
  self.layer_mission_num = 0
  self.cur_max_layer = 0
  self.history_exploration_progress = 0
end

SailingMissionResult._proto = {
  [1] = {"layer_id", "int"},
  [2] = {"mission_id", "int"},
  [3] = {
    "layer_mission_num",
    "int"
  },
  [4] = {
    "cur_max_layer",
    "int"
  },
  [5] = {
    "history_exploration_progress",
    "int"
  }
}
_class("BloodsuckerMissionResult", Object)
BloodsuckerMissionResult = BloodsuckerMissionResult

function BloodsuckerMissionResult:Constructor()
  self.mission_id = 0
  self.pass_wave_index = 0
  self.pass_pet_type_num = 0
  self.kill_monster_num = 0
  self.is_full_blood = 0
  self.first_rewards = {}
  self.select_pets = {}
  self.select_relics = {}
end

BloodsuckerMissionResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "pass_wave_index",
    "int"
  },
  [3] = {
    "pass_pet_type_num",
    "int"
  },
  [4] = {
    "kill_monster_num",
    "int"
  },
  [5] = {
    "is_full_blood",
    "int"
  },
  [6] = {
    "first_rewards",
    "list<RoleAsset>"
  },
  [7] = {
    "select_pets",
    "list<int>"
  },
  [8] = {
    "select_relics",
    "list<int>"
  }
}
_class("PopStarMissionResult", Object)
PopStarMissionResult = PopStarMissionResult

function PopStarMissionResult:Constructor()
  self.mission_id = 0
  self.star_condition = {}
  self.rewards = {}
  self.star_rewards = {}
  self.first_rewards = {}
  self.match_result_role_info = MatchResultRoleInfo:New()
  self.star_num = 0
end

PopStarMissionResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "star_condition",
    "list<int>"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  },
  [4] = {
    "star_rewards",
    "list<RoleAsset>"
  },
  [5] = {
    "first_rewards",
    "list<RoleAsset>"
  },
  [6] = {
    "match_result_role_info",
    "MatchResultRoleInfo"
  },
  [7] = {"star_num", "int"}
}
_class("GlobalbossMissionResult", Object)
GlobalbossMissionResult = GlobalbossMissionResult

function GlobalbossMissionResult:Constructor()
  self.mission_id = 0
  self.total_damage = 0
end

GlobalbossMissionResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "total_damage",
    "int64"
  }
}
_class("SeasonMissionResult", Object)
SeasonMissionResult = SeasonMissionResult

function SeasonMissionResult:Constructor()
  self.mission_id = 0
  self.star_condition = {}
  self.rewards = {}
  self.star_rewards = {}
  self.first_rewards = {}
  self.match_result_role_info = MatchResultRoleInfo:New()
  self.ext_star_rewards = {}
  self.ext_first_rewards = {}
  self.m_time = 0
end

SeasonMissionResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "star_condition",
    "list<int>"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  },
  [4] = {
    "star_rewards",
    "list<RoleAsset>"
  },
  [5] = {
    "first_rewards",
    "list<RoleAsset>"
  },
  [6] = {
    "match_result_role_info",
    "MatchResultRoleInfo"
  },
  [7] = {
    "ext_star_rewards",
    "map<int,list<RoleAsset>>"
  },
  [8] = {
    "ext_first_rewards",
    "map<int,list<RoleAsset>>"
  },
  [9] = {"m_time", "time"}
}
_class("EightPetsResult", Object)
EightPetsResult = EightPetsResult

function EightPetsResult:Constructor()
  self.mission_id = 0
  self.rewards = {}
  self.first_rewards = {}
  self.match_result_role_info = MatchResultRoleInfo:New()
end

EightPetsResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  },
  [3] = {
    "first_rewards",
    "list<RoleAsset>"
  },
  [4] = {
    "match_result_role_info",
    "MatchResultRoleInfo"
  }
}
_class("SeasonMazeEffect", Object)
SeasonMazeEffect = SeasonMazeEffect

function SeasonMazeEffect:Constructor()
  self.type = 0
  self.id = 0
  self.value_min = 0
  self.value_max = 0
end

SeasonMazeEffect._proto = {
  [1] = {"type", "int"},
  [2] = {"id", "int"},
  [3] = {"value_min", "int"},
  [4] = {"value_max", "int"}
}
_class("SeasonMazeResult", Object)
SeasonMazeResult = SeasonMazeResult

function SeasonMazeResult:Constructor()
  self.mission_id = 0
  self.rewards = {}
  self.pet_list = {}
  self.relic_list = {}
  self.outside_attr = {}
  self.total_damage = 0
  self.last_damage = 0
end

SeasonMazeResult._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "rewards",
    "list<SeasonMazeEffect>"
  },
  [3] = {
    "pet_list",
    "map<int,MatchPetResult>"
  },
  [4] = {
    "relic_list",
    "map<int,int>"
  },
  [5] = {
    "outside_attr",
    "map<int,int>"
  },
  [6] = {
    "total_damage",
    "int64"
  },
  [7] = {
    "last_damage",
    "int64"
  }
}
_class("AnipopMissionResult", Object)
AnipopMissionResult = AnipopMissionResult

function AnipopMissionResult:Constructor()
  self.mission_index = 0
  self.pet_result = {}
  self.relics_counters = {}
  self.rewards = {}
  self.relics = {}
  self.drop_rewards = {}
  self.m_time = 0
  self.star_num = 0
  self.feature_info_list = {}
  self.skill_relics = {}
end

AnipopMissionResult._proto = {
  [1] = {
    "mission_index",
    "int"
  },
  [2] = {
    "pet_result",
    "list<MatchPetResult>"
  },
  [3] = {
    "relics_counters",
    "map<int,int>"
  },
  [4] = {
    "rewards",
    "list<RoleAsset>"
  },
  [5] = {
    "relics",
    "list<RoleAsset>"
  },
  [6] = {
    "drop_rewards",
    "list<RoleAsset>"
  },
  [7] = {"m_time", "time"},
  [8] = {"star_num", "int"},
  [9] = {
    "feature_info_list",
    "map<int,int>"
  },
  [10] = {
    "skill_relics",
    "list<RoleAsset>"
  }
}
_class("MatchResult", Object)
MatchResult = MatchResult

function MatchResult:Constructor()
  self.mission_result = {}
  self.ext_mission_result = {}
  self.maze_result = {}
  self.res_dungeon_result = {}
  self.tower_result = {}
  self.campaign_result = {}
  self.sync_match = true
  self.victory = false
  self.battle_statistics = BattleStatResult:New()
  self.exception = false
  self.assign_wave_refresh_probability = 0
  self.exception_code = 0
  self.exception_msg = ""
  self.crash_state = false
  self.tale_pet_reward = {}
  self.first_fail = false
  self.campaign_reward = {}
  self.conquest_mission_result = {}
  self.lost_area_result = {}
  self.black_fist_result = {}
  self.world_boss_result = {}
  self.chess_mission_result = {}
  self.difficulty_mission_result = {}
  self.sailing_mission_result = {}
  self.bloodsucker_mission_result = {}
  self.popstar_mission_result = {}
  self.globalboss_mission_result = {}
  self.season_mission_result = {}
  self.eight_pets_mission_result = {}
  self.anipop_mission_result = {}
  self.season_maze_mission_result = {}
end

MatchResult._proto = {
  [1] = {
    "mission_result",
    "list<MissionResult>"
  },
  [2] = {
    "ext_mission_result",
    "list<ExtMissionResult>"
  },
  [3] = {
    "maze_result",
    "list<MazeResult>"
  },
  [4] = {
    "res_dungeon_result",
    "list<ResDungeonResult>"
  },
  [5] = {
    "tower_result",
    "list<TowerResult>"
  },
  [6] = {
    "campaign_result",
    "list<CampaignMissionResult>"
  },
  [7] = {"sync_match", "bool"},
  [8] = {"victory", "bool"},
  [9] = {
    "battle_statistics",
    "BattleStatResult"
  },
  [10] = {"exception", "bool"},
  [11] = {
    "assign_wave_refresh_probability",
    "int"
  },
  [12] = {
    "exception_code",
    "int"
  },
  [13] = {
    "exception_msg",
    "string"
  },
  [14] = {
    "crash_state",
    "bool"
  },
  [15] = {
    "tale_pet_reward",
    "list<TalePetResult>"
  },
  [16] = {"first_fail", "bool"},
  [17] = {
    "campaign_reward",
    "list<RoleAsset>"
  },
  [18] = {
    "conquest_mission_result",
    "list<ConquestMissionResult>"
  },
  [19] = {
    "lost_area_result",
    "list<LostAreaResult>"
  },
  [20] = {
    "black_fist_result",
    "list<BlackFistResult>"
  },
  [21] = {
    "world_boss_result",
    "list<WorldBossResult>"
  },
  [22] = {
    "chess_mission_result",
    "list<ChessMissionResult>"
  },
  [23] = {
    "difficulty_mission_result",
    "list<DifficultyMissionResult>"
  },
  [24] = {
    "sailing_mission_result",
    "list<SailingMissionResult>"
  },
  [25] = {
    "bloodsucker_mission_result",
    "list<BloodsuckerMissionResult>"
  },
  [26] = {
    "popstar_mission_result",
    "list<PopStarMissionResult>"
  },
  [27] = {
    "globalboss_mission_result",
    "list<GlobalbossMissionResult>"
  },
  [28] = {
    "season_mission_result",
    "list<SeasonMissionResult>"
  },
  [29] = {
    "eight_pets_mission_result",
    "list<EightPetsResult>"
  },
  [30] = {
    "anipop_mission_result",
    "list<AnipopMissionResult>"
  },
  [31] = {
    "season_maze_mission_result",
    "list<SeasonMazeResult>"
  }
}
