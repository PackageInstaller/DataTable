local RoleAssetID = {
  RoleAssetNone = 0,
  RoleAssetPetBegin = 1000000,
  RoleAssetPetEnd = 1999999,
  RoleAssetItemBegin = 3000000,
  RoleAssetPhyPoint = 3000001,
  RoleAssetGold = 3000002,
  RoleAssetGlow = 3000003,
  RoleAssetExp = 3000004,
  RoleAssetFirefly = 3000005,
  RoleAssetLight = 3000006,
  RoleAssetMazeCoin = 3000007,
  RoleAssetVigorous = 3000008,
  RoleAssetAchPoint = 3000009,
  RoleAssetPetAffinity = 3000010,
  RoleAssetRelicDice = 3000011,
  RoleAssetDoubleRes = 3000012,
  RoleAssetAtom = 3000013,
  RoleAssetDiamond = 3000014,
  RoleAssetXingZuan = 3000015,
  RoleAssetHuiYao = 3000016,
  RoleAssetHongPiao = 3000019,
  RoleAssetActiveToken = 3000021,
  RoleAssetFurnitureCoin = 3000022,
  RoleAssetWeekVigorous = 3000024,
  RoleAssetBPPay = 3000029,
  RoleAssetBPFree = 3000030,
  RoleAssetBPSkin = 3000031,
  RoleAssetBPFurniture = 3000032,
  RoleAssetDrawCard100 = 3000100,
  RoleAssetDrawCard101 = 3000101,
  RoleAssetDrawCardSeniorSkin = 3000240,
  RoleAssetDrawCardSeniorSkinGL = 3000266,
  RoleAssetDrawCardSeniorSkinGL_Re2 = 3000342,
  RoleAssetDrawCardSeniorSkinKR = 3000275,
  RoleAssetDrawCardSeniorSkinKL_Re = 3000280,
  RoleAssetDrawCardSeniorSkinBLH = 3000288,
  RoleAssetDrawCardSeniorSkinBLH_Re = 3000329,
  RoleAssetDrawCardSeniorSkinGL_Re = 3000306,
  RoleAssetDrawCardSeniorSkinQT = 3000311,
  RoleAssetDrawCardSeniorSkinQT2 = 3000346,
  RoleAssetDrawCardSeniorSkinQT3 = 3000373,
  RoleAssetDrawCardSeniorSkinPLM = 3000330,
  RoleAssetWorldBossCoin = 3000025,
  RoleAssetWorldBossCoin2 = 3000026,
  RoleAssetDrawCardSeniorSkinKR_Re = 3000322,
  RoleAssetSimulationOperationCoin = 3000328,
  RoleAssetDrawCardSeniorSkinKL_ReRe = 3000339,
  RoleAssetDrawCardSeniorSkinBLH_ReRe = 3000350,
  RoleAssetHistory = 3001000,
  RoleAssetPayCurrency = 3999998,
  RoleAssetItemEnd = 3999999,
  RoleAssetPetSkinBegin = 4000000,
  RoleAssetPetSkinEnd = 4999999,
  RoleAssetRelicBegin = 9990000,
  RoleAssetRelicEnd = 9999999
}
_enum("RoleAssetID", RoleAssetID)
local GameModuleID = {
  MD_Role = 0,
  MD_Item = 1,
  MD_Pet = 2,
  MD_Mission = 3,
  MD_Aircraft = 4,
  MD_ResDungeon = 5,
  MD_Maze = 6,
  MD_ExtMission = 7,
  MD_Gamble = 8,
  MD_Shop = 9,
  MD_BuyPhyPoint = 10,
  MD_BuyGold = 11,
  MD_PetStory = 12,
  MD_QuestMain = 13,
  MD_QuestDaily = 14,
  MD_QuestAchieve = 15,
  MD_QuestGrowth = 16,
  MD_SpeedUp = 18,
  MD_Mail = 19,
  MD_Notify = 20,
  MD_Guild = 21,
  MD_HandBook = 22,
  MD_QuestEntry = 23,
  MD_Tower = 24,
  MD_WeChat = 25,
  MD_ChangeLeader = 26,
  MD_ResChangeLeader = 27,
  MD_HelpPet = 28,
  MD_Funiture = 29,
  MD_ForceGuideEnd = 30,
  MD_TalePet = 31,
  MD_LostLand = 32,
  MD_WorldBoss = 33,
  MD_HomeLand = 34,
  MD_DIFFICULTYMISSION = 35,
  MD_SAILINGMISSION = 37,
  MD_CAMPAIGNREVIEW = 38,
  MD_MEDAL = 39,
  MD_ANIPOP = 40,
  MD_PROCUL = 41,
  MD_Count = 42
}
_enum("GameModuleID", GameModuleID)
local RoleBoardType = {ON_LINE = 0, OFF_LINE = 1}
_enum("RoleBoardType", RoleBoardType)
_class("GuideInfo", Object)
GuideInfo = GuideInfo

function GuideInfo:Constructor()
  self.guide_id2count = {}
end

GuideInfo._proto = {
  [1] = {
    "guide_id2count",
    "map<int,int>"
  }
}
_class("base_char_info", Object)
base_char_info = base_char_info

function base_char_info:Constructor()
  self.pstid = 0
  self.nick = ""
  self.exp = 0
  self.sex = PlayerSex.SEX_Error
end

base_char_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"nick", "string"},
  [3] = {"exp", "int64"},
  [4] = {"sex", "byte"}
}
_class("RoleAsset", Object)
RoleAsset = RoleAsset

function RoleAsset:Constructor()
  self.assetid = 0
  self.count = 0
end

RoleAsset._proto = {
  [1] = {"assetid", "int"},
  [2] = {"count", "int64"}
}
_class("ItemAsset", Object)
ItemAsset = ItemAsset

function ItemAsset:Constructor()
  self.assetid = 0
  self.count = 0
end

ItemAsset._proto = {
  [1] = {"assetid", "int64"},
  [2] = {"count", "int"}
}
_class("SpecItemAsset", Object)
SpecItemAsset = SpecItemAsset

function SpecItemAsset:Constructor()
  self.assetid = 0
  self.count = 0
  self.pstid = 0
end

SpecItemAsset._proto = {
  [1] = {"assetid", "int"},
  [2] = {"count", "int64"},
  [3] = {"pstid", "int64"}
}
_class("MobileChoosePainting", Object)
MobileChoosePainting = MobileChoosePainting

function MobileChoosePainting:Constructor()
  self.pet_template_id = 0
  self.pet_grade = 0
  self.skin_id = 0
  self.back_id = 0
  self.bgm_main = 0
  self.bgm_aircraft = 0
  self.board_pet = 0
  self.bgm_homeland = 0
  self.background_type = 1
  self.background_x = 0
  self.background_y = 0
  self.background_scale = 0
  self.is_hand_operate = false
  self.spine_id = 0
end

MobileChoosePainting._proto = {
  [1] = {
    "pet_template_id",
    "int"
  },
  [2] = {"pet_grade", "int"},
  [3] = {"skin_id", "int"},
  [4] = {"back_id", "int"},
  [5] = {"bgm_main", "int"},
  [6] = {
    "bgm_aircraft",
    "int"
  },
  [7] = {"board_pet", "int"},
  [8] = {
    "bgm_homeland",
    "int"
  },
  [9] = {
    "background_type",
    "int"
  },
  [11] = {
    "background_x",
    "float"
  },
  [12] = {
    "background_y",
    "float"
  },
  [13] = {
    "background_scale",
    "float"
  },
  [14] = {
    "is_hand_operate",
    "bool"
  },
  [15] = {"spine_id", "int"}
}
_class("played_story_data", Object)
played_story_data = played_story_data

function played_story_data:Constructor()
  self.played_story_set = {}
end

played_story_data._proto = {
  [1] = {
    "played_story_set",
    "list<int>"
  }
}
_class("role_fight_info", Object)
role_fight_info = role_fight_info

function role_fight_info:Constructor()
  self.mission_id = 0
  self.pass_star_num = 0
  self.pet_num = 0
  self.achievement_num = 0
  self.tower_water = 0
  self.tower_fire = 0
  self.tower_wood = 0
  self.tower_thunder = 0
end

role_fight_info._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "pass_star_num",
    "int"
  },
  [3] = {"pet_num", "int"},
  [4] = {
    "achievement_num",
    "int"
  },
  [5] = {
    "tower_water",
    "int"
  },
  [6] = {"tower_fire", "int"},
  [7] = {"tower_wood", "int"},
  [8] = {
    "tower_thunder",
    "int"
  }
}
_class("role_help_pet_info", Object)
role_help_pet_info = role_help_pet_info

function role_help_pet_info:Constructor()
  self.pet_template_id = 0
  self.level = 0
  self.awake = 0
  self.grade = 0
  self.equip_level = 0
  self.skin_id = 0
  self.pet_pst_id = 0
  self.equip_refine_level = 0
  self.awake_lock = 0
end

role_help_pet_info._proto = {
  [1] = {
    "pet_template_id",
    "int"
  },
  [2] = {"level", "int"},
  [3] = {"awake", "int"},
  [4] = {"grade", "int"},
  [5] = {
    "equip_level",
    "int"
  },
  [6] = {"skin_id", "int"},
  [7] = {"pet_pst_id", "int64"},
  [8] = {
    "equip_refine_level",
    "int"
  },
  [9] = {"awake_lock", "int"}
}
_class("DanHeadSwitch", Object)
DanHeadSwitch = DanHeadSwitch

function DanHeadSwitch:Constructor()
  self.dan_switch = true
end

DanHeadSwitch._proto = {
  [1] = {"dan_switch", "bool"}
}
_class("CRoleWorldBossInfo", Object)
CRoleWorldBossInfo = CRoleWorldBossInfo

function CRoleWorldBossInfo:Constructor()
  self.dan = 0
  self.grading = 0
  self.max_record_level = 0
  self.damage = 0
end

CRoleWorldBossInfo._proto = {
  [1] = {"dan", "int"},
  [2] = {"grading", "int"},
  [3] = {
    "max_record_level",
    "int"
  },
  [4] = {"damage", "int64"}
}
_class("CRoleCardInfo", Object)
CRoleCardInfo = CRoleCardInfo

function CRoleCardInfo:Constructor()
  self.title_used = -1
  self.fifure_used = 0
end

CRoleCardInfo._proto = {
  [1] = {"title_used", "int"},
  [2] = {
    "fifure_used",
    "int"
  }
}
_class("HomelandSimpleInfo", Object)
HomelandSimpleInfo = HomelandSimpleInfo

function HomelandSimpleInfo:Constructor()
  self.unlock = false
  self.mask = 0
  self.exp = 0
  self.livable = 0
end

HomelandSimpleInfo._proto = {
  [1] = {"unlock", "bool"},
  [2] = {"mask", "int"},
  [3] = {"exp", "int64"},
  [4] = {"livable", "int64"}
}
_class("RankDetailInfo", Object)
RankDetailInfo = RankDetailInfo

function RankDetailInfo:Constructor()
  self.infos = {}
end

RankDetailInfo._proto = {
  [1] = {
    "infos",
    "map<int,list<role_help_pet_info>>"
  }
}
_class("role_simple_info", Object)
role_simple_info = role_simple_info

function role_simple_info:Constructor()
  self.pstid = 0
  self.nick = ""
  self.head = 0
  self.head_bg = 0
  self.level = 0
  self.is_online = false
  self.role_sign_text = ""
  self.create_time = 0
  self.logout_time = 0
  self.help_pet_arr = {}
  self.fight_info = role_fight_info:New()
  self.active = false
  self.frame_id = 0
  self.dan_head_switch = DanHeadSwitch:New()
  self.world_boss_info = CRoleWorldBossInfo:New()
  self.peak_score = 0
  self.homeland_info = HomelandSimpleInfo:New()
  self.is_homeland_shop_unlock = false
  self.difficulty_mission = 0
  self.sailing_mission = 0
  self.title_used = 0
  self.fifure_used = 0
  self.medal_placement = medal_placement_info:New()
  self.rank_detail_info = RankDetailInfo:New()
  self.choose_painting = MobileChoosePainting:New()
  self.card_infos = {}
  self.season_maze_bead = {}
end

role_simple_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"nick", "string"},
  [3] = {"head", "int"},
  [4] = {"head_bg", "int"},
  [5] = {"level", "int"},
  [6] = {"is_online", "bool"},
  [7] = {
    "role_sign_text",
    "string"
  },
  [8] = {
    "create_time",
    "time"
  },
  [9] = {
    "logout_time",
    "time"
  },
  [10] = {
    "help_pet_arr",
    "list<role_help_pet_info>"
  },
  [11] = {
    "fight_info",
    "role_fight_info"
  },
  [12] = {"active", "bool"},
  [13] = {"frame_id", "int"},
  [14] = {
    "dan_head_switch",
    "DanHeadSwitch"
  },
  [15] = {
    "world_boss_info",
    "CRoleWorldBossInfo"
  },
  [16] = {"peak_score", "int64"},
  [17] = {
    "homeland_info",
    "HomelandSimpleInfo"
  },
  [18] = {
    "is_homeland_shop_unlock",
    "bool"
  },
  [19] = {
    "difficulty_mission",
    "int"
  },
  [20] = {
    "sailing_mission",
    "int"
  },
  [21] = {"title_used", "int"},
  [22] = {
    "fifure_used",
    "int"
  },
  [23] = {
    "medal_placement",
    "medal_placement_info"
  },
  [24] = {
    "rank_detail_info",
    "RankDetailInfo"
  },
  [25] = {
    "choose_painting",
    "MobileChoosePainting"
  },
  [32] = {
    "card_infos",
    "map<int,map<int,int>>"
  },
  [33] = {
    "season_maze_bead",
    "map<int,int>"
  }
}
_class("role_simple_info_vec", Object)
role_simple_info_vec = role_simple_info_vec

function role_simple_info_vec:Constructor()
  self.info_vec = {}
end

role_simple_info_vec._proto = {
  [1] = {
    "info_vec",
    "list<role_simple_info>"
  }
}
_class("role_summary_info", Object)
role_summary_info = role_summary_info

function role_summary_info:Constructor()
  self.pstid = 0
  self.nick = ""
end

role_summary_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"nick", "string"}
}
_class("role_summary_info_vec", Object)
role_summary_info_vec = role_summary_info_vec

function role_summary_info_vec:Constructor()
  self.info_vec = {}
end

role_summary_info_vec._proto = {
  [1] = {
    "info_vec",
    "list<role_summary_info>"
  }
}
_class("MobileCharInfo", Object)
MobileCharInfo = MobileCharInfo

function MobileCharInfo:Constructor()
  self.pstid = 0
  self.nick = ""
  self.exp = 0
  self.level = 0
  self.chapter_id = 0
  self.tmServerBase = 0
  self.create_time = 0
  self.light = 0
  self.ext_flag = 0
  self.phy_point = 0
  self.phy_last_time = 0
  self.phy_point_max = 0
  self.phy_point_rate = 0
  self.growth_quest_days = 0
  self.unlock_modules = 0
  self.daily_vig_point = 0
  self.ach_point = 0
  self.vig_reward_state = 0
  self.ach_reward_state = 0
  self.double_res_num = 0
  self.m_nHeadImageID = 0
  self.m_nHeadColorID = 0
  self.guide_info = GuideInfo:New()
  self.m_nAmendNameCount = 0
  self.m_nHeadFrameID = 0
  self.m_nTotalLoginDays = 0
  self.m_nTotalChangeLoginDays = 0
  self.m_dan = 0
  self.m_grading = 0
  self.m_bBadgeSwitch = true
  self.active_token_num = 0
  self.active_token_accumulative = 0
  self.difficulty_mission = 0
  self.sailing_mission = 0
  self.title_used = 0
  self.fifure_used = 0
  self.damage = 0
end

MobileCharInfo._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"nick", "string"},
  [3] = {"exp", "int64"},
  [4] = {"level", "int"},
  [5] = {"chapter_id", "int"},
  [6] = {
    "tmServerBase",
    "time"
  },
  [7] = {
    "create_time",
    "time"
  },
  [8] = {"light", "int"},
  [9] = {"ext_flag", "uint64"},
  [11] = {"phy_point", "int"},
  [12] = {
    "phy_last_time",
    "time"
  },
  [13] = {
    "phy_point_max",
    "int"
  },
  [14] = {
    "phy_point_rate",
    "int"
  },
  [15] = {
    "growth_quest_days",
    "int"
  },
  [16] = {
    "unlock_modules",
    "int64"
  },
  [17] = {
    "daily_vig_point",
    "int64"
  },
  [18] = {"ach_point", "int64"},
  [19] = {
    "vig_reward_state",
    "int64"
  },
  [20] = {
    "ach_reward_state",
    "int64"
  },
  [21] = {
    "double_res_num",
    "int"
  },
  [22] = {
    "m_nHeadImageID",
    "int"
  },
  [23] = {
    "m_nHeadColorID",
    "int"
  },
  [24] = {"guide_info", "GuideInfo"},
  [25] = {
    "m_nAmendNameCount",
    "int"
  },
  [26] = {
    "m_nHeadFrameID",
    "int"
  },
  [27] = {
    "m_nTotalLoginDays",
    "int"
  },
  [28] = {
    "m_nTotalChangeLoginDays",
    "int"
  },
  [29] = {"m_dan", "int"},
  [30] = {"m_grading", "int"},
  [31] = {
    "m_bBadgeSwitch",
    "bool"
  },
  [32] = {
    "active_token_num",
    "int"
  },
  [33] = {
    "active_token_accumulative",
    "int"
  },
  [34] = {
    "difficulty_mission",
    "int"
  },
  [35] = {
    "sailing_mission",
    "int"
  },
  [36] = {"title_used", "int"},
  [37] = {
    "fifure_used",
    "int"
  },
  [38] = {"damage", "int64"}
}
_class("homeland_sametime_group", Object)
homeland_sametime_group = homeland_sametime_group

function homeland_sametime_group:Constructor()
  self.valid_time = 0
  self.task_group_list = {}
end

homeland_sametime_group._proto = {
  [1] = {"valid_time", "time"},
  [2] = {
    "task_group_list",
    "list<int>"
  }
}
_class("role_fix_item_info", Object)
role_fix_item_info = role_fix_item_info

function role_fix_item_info:Constructor()
  self.do_fix_info = {}
  self.not_enough = {}
end

role_fix_item_info._proto = {
  [1] = {
    "do_fix_info",
    "list<int>"
  },
  [2] = {
    "not_enough",
    "map<int,int64>"
  }
}
_class("season_ext_info", Object)
season_ext_info = season_ext_info

function season_ext_info:Constructor()
  self.mask = 0
end

season_ext_info._proto = {
  [1] = {"mask", "int"}
}
_class("season_mini_game_data", Object)
season_mini_game_data = season_mini_game_data

function season_mini_game_data:Constructor()
  self.debris_mission = {}
  self.castle_lv = {}
end

season_mini_game_data._proto = {
  [1] = {
    "debris_mission",
    "map<int,int>"
  },
  [2] = {
    "castle_lv",
    "map<int,int>"
  }
}
_class("property_cultivate", Object)
property_cultivate = property_cultivate

function property_cultivate:Constructor()
  self.phase = 0
  self.lv = 0
end

property_cultivate._proto = {
  [1] = {"phase", "int"},
  [2] = {"lv", "int"}
}
_class("property_cultivate_data", Object)
property_cultivate_data = property_cultivate_data

function property_cultivate_data:Constructor()
  self.type_lv = {}
end

property_cultivate_data._proto = {
  [1] = {
    "type_lv",
    "map<int,property_cultivate>"
  }
}
