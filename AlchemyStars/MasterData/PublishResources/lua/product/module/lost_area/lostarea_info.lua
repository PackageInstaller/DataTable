local LOST_AREA_RESULT_CODE = {
  LOST_AREA_SUCCEED = 0,
  LOST_AREA_UNKNOWN = 1,
  LOST_AREA_ID_INVALID = 2,
  LOST_AREA_NOT_ONSHOW = 3,
  LOST_AREA_UNREACH_UNLOCK_COND = 4,
  LOST_AREA_GOT_NEW_DESIGN_TIME = 5,
  LOST_AREA_HAVENOT_UNLOCKED = 6,
  LOST_AREA_DESIGN_ID_NOT_CURRENT_ID = 7,
  LOST_AREA_ALREADY_UNLOCKED = 8,
  LOST_AREA_HAVENT_CLIENT_CREATE_INFO = 9,
  LOST_AREA_LEVEL_ID_ERROR = 101
}
_enum("LOST_AREA_RESULT_CODE", LOST_AREA_RESULT_CODE)
local DifficultyStatus = {
  DS_AlreadyUnlocked = 1,
  DS_CannotUnlock = 2,
  DS_WaitingUnlock = 3,
  DS_ThisWeekChoosed = 4
}
_enum("DifficultyStatus", DifficultyStatus)
local PetFilterCondType = {
  RFCT_Color = 1,
  RFCT_Force = 2,
  RFCT_Prof = 3
}
_enum("PetFilterCondType", PetFilterCondType)
_class("MissionInfo", Object)
MissionInfo = MissionInfo

function MissionInfo:Constructor()
  self.pass_time = 0
  self.recommend_reward_num = 0
  self.level_id = 0
  self.wordd_id = 0
end

MissionInfo._proto = {
  [1] = {"pass_time", "int"},
  [2] = {
    "recommend_reward_num",
    "int"
  },
  [3] = {"level_id", "int"},
  [4] = {"wordd_id", "int"}
}
_class("lost_area", Object)
lost_area = lost_area

function lost_area:Constructor()
  self.owner_pstid = 0
  self.unlocked_difficulty = 0
  self.last_enter_time = 0
  self.choosed_design_id = 0
  self.difficult_mission_info = {}
  self.red_dot = 0
end

lost_area._proto = {
  [1] = {
    "owner_pstid",
    "int64"
  },
  [2] = {
    "unlocked_difficulty",
    "int"
  },
  [3] = {
    "last_enter_time",
    "time"
  },
  [4] = {
    "choosed_design_id",
    "int"
  },
  [5] = {
    "difficult_mission_info",
    "map<int,MissionInfo>"
  },
  [6] = {"red_dot", "int"}
}
_class("RecommendCond", Object)
RecommendCond = RecommendCond

function RecommendCond:Constructor()
  self.cond1 = 0
  self.cond2 = 0
end

RecommendCond._proto = {
  [1] = {"cond1", "int"},
  [2] = {"cond2", "int"}
}
_class("LostAreaDesignConfig", Object)
LostAreaDesignConfig = LostAreaDesignConfig

function LostAreaDesignConfig:Constructor()
  self.id = 0
  self.difficulty = 0
  self.level_group_id = 0
  self.seed = 0
  self.start_time = 0
  self.end_time = 0
  self.recommend_level = 0
  self.recommend_awake = 0
  self.unlock_condition = {}
  self.recommend_cond = {}
  self.recommend_reward = RoleAsset:New()
end

LostAreaDesignConfig._proto = {
  [1] = {"id", "int"},
  [2] = {"difficulty", "int"},
  [3] = {
    "level_group_id",
    "int"
  },
  [4] = {"seed", "int"},
  [5] = {"start_time", "time"},
  [6] = {"end_time", "time"},
  [7] = {
    "recommend_level",
    "int"
  },
  [8] = {
    "recommend_awake",
    "int"
  },
  [9] = {
    "unlock_condition",
    "list<int>"
  },
  [10] = {
    "recommend_cond",
    "list<RecommendCond>"
  },
  [11] = {
    "recommend_reward",
    "RoleAsset"
  }
}
_class("LostAreaLevelGroupConfig", Object)
LostAreaLevelGroupConfig = LostAreaLevelGroupConfig

function LostAreaLevelGroupConfig:Constructor()
  self.id = 0
  self.group_id = 0
  self.difficulty = 0
  self.group_seq_id = 0
  self.seq_in_group = 0
  self.level_type = 0
  self.fight_level_pool = {}
  self.award = {}
  self.words = {}
  self.words_weight = {}
end

LostAreaLevelGroupConfig._proto = {
  [1] = {"id", "int"},
  [2] = {"group_id", "int"},
  [3] = {"difficulty", "int"},
  [4] = {
    "group_seq_id",
    "int"
  },
  [5] = {
    "seq_in_group",
    "int"
  },
  [6] = {"level_type", "int"},
  [7] = {
    "fight_level_pool",
    "list<int>"
  },
  [8] = {
    "award",
    "list<RoleAsset>"
  },
  [9] = {"words", "list<int>"},
  [10] = {
    "words_weight",
    "list<int>"
  }
}
_class("LostAreaUnitGroupConfig", Object)
LostAreaUnitGroupConfig = LostAreaUnitGroupConfig

function LostAreaUnitGroupConfig:Constructor()
  self.id = 0
  self.group_id = 0
  self.seq_in_group = 0
  self.level_ids = {}
end

LostAreaUnitGroupConfig._proto = {
  [1] = {"id", "int"},
  [2] = {"group_id", "int"},
  [3] = {
    "seq_in_group",
    "int"
  },
  [4] = {"level_ids", "list<int>"}
}
