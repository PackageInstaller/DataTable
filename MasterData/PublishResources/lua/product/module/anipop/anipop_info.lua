local AnipopRelicOutGameTriggerType = {
  ARTOGTT_None = 0,
  ARTOGTT_GetRelic = 1,
  ARTOGTT_GameOver = 2,
  ARTOGTT_RestRoom = 3,
  ARTOGTT_HandUse = 4,
  ARTOGTT_InMatch = 5
}
_enum("AnipopRelicOutGameTriggerType", AnipopRelicOutGameTriggerType)
local AnipopRelicOutGameEffectType = {
  AnipopAddAttacker = 1,
  AnipopAddDefence = 2,
  AnipopAddMaxHP = 3,
  AnipopAddHP = 4,
  AnipopAddRestAddHP = 5,
  AnipopAddRestAddLight = 6,
  AnipopDropItem = 7,
  AnipopAddAfterDamage = 8,
  AnipopAddRestAddHPPetNum = 9,
  AnipopAddTurn = 10,
  AnipopResetCounters = 11,
  AnipopAddLostHP = 12,
  AnipopExtraRandRelic = 13,
  AnipopNextExtraRandRelic = 14,
  AnipopRandAgain = 15,
  AnipopEffect = 16
}
_enum("AnipopRelicOutGameEffectType", AnipopRelicOutGameEffectType)
local AnipopRelicType = {ART_Anipop_Relic = 0, ART_Anipop_Skill = 1}
_enum("AnipopRelicType", AnipopRelicType)
_class("AnipopLevelInfo", Object)
AnipopLevelInfo = AnipopLevelInfo

function AnipopLevelInfo:Constructor()
  self.level_id = 0
  self.word_ids = {}
  self.wave_randoms = {}
  self.rand_seed = 0
  self.battle_archive = ""
  self.has_archive = false
  self.main_mission_id = 0
end

AnipopLevelInfo._proto = {
  [1] = {"level_id", "int"},
  [2] = {"word_ids", "list<int>"},
  [3] = {
    "wave_randoms",
    "list<float>"
  },
  [4] = {"rand_seed", "uint"},
  [5] = {
    "battle_archive",
    "string"
  },
  [6] = {
    "has_archive",
    "bool"
  },
  [7] = {
    "main_mission_id",
    "int"
  }
}
_class("AnipopPetInfo", Object)
AnipopPetInfo = AnipopPetInfo

function AnipopPetInfo:Constructor()
  self.pet_pstid = 0
  self.power = 0
  self.after_damage = 0
  self.is_dead = false
end

AnipopPetInfo._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {"power", "int"},
  [3] = {
    "after_damage",
    "double"
  },
  [4] = {"is_dead", "bool"}
}
_class("AnipopRoundInfo", Object)
AnipopRoundInfo = AnipopRoundInfo

function AnipopRoundInfo:Constructor()
  self.select_hard_id = 0
  self.mission_index = 0
  self.team_blood = 1
  self.left_turn = 0
  self.is_over = false
  self.level_list = {}
  self.pet_info = {}
  self.total_use_turn = 0
  self.total_star_num = 0
  self.local_total_score = 0
  self.local_search_reward_num = 0
end

AnipopRoundInfo._proto = {
  [1] = {
    "select_hard_id",
    "int"
  },
  [2] = {
    "mission_index",
    "int"
  },
  [3] = {"team_blood", "double"},
  [4] = {"left_turn", "int"},
  [5] = {"is_over", "bool"},
  [6] = {
    "level_list",
    "list<AnipopLevelInfo>"
  },
  [7] = {
    "pet_info",
    "map<int64,AnipopPetInfo>"
  },
  [8] = {
    "total_use_turn",
    "int"
  },
  [9] = {
    "total_star_num",
    "int"
  },
  [10] = {
    "local_total_score",
    "int"
  },
  [11] = {
    "local_search_reward_num",
    "int"
  }
}
_class("AnipopRelicAddAttr", Object)
AnipopRelicAddAttr = AnipopRelicAddAttr

function AnipopRelicAddAttr:Constructor()
  self.attack_mul = {}
  self.defense_mul = {}
  self.maxhp_mul = {}
  self.add_relic_rand_num = 0
  self.next_add_relic_rand_num = 0
end

AnipopRelicAddAttr._proto = {
  [1] = {
    "attack_mul",
    "map<int,float>"
  },
  [2] = {
    "defense_mul",
    "map<int,float>"
  },
  [3] = {
    "maxhp_mul",
    "map<int,float>"
  },
  [4] = {
    "add_relic_rand_num",
    "int"
  },
  [5] = {
    "next_add_relic_rand_num",
    "int"
  }
}
_class("AnipopFormationDetail", Object)
AnipopFormationDetail = AnipopFormationDetail

function AnipopFormationDetail:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

AnipopFormationDetail._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("AnipopFormationInfo", Object)
AnipopFormationInfo = AnipopFormationInfo

function AnipopFormationInfo:Constructor()
  self.fromation_list = {}
end

AnipopFormationInfo._proto = {
  [1] = {
    "fromation_list",
    "list<AnipopFormationDetail>"
  }
}
_class("RelicInfo", Object)
RelicInfo = RelicInfo

function RelicInfo:Constructor()
  self.relics = {}
  self.dangling_relics = {}
  self.relic_counters = {}
  self.dropped_relics = {}
  self.relic_attrs = AnipopRelicAddAttr:New()
  self.tag_counters = {}
  self.skill_relics = {}
  self.skill_dangling_relics = {}
  self.init_skill_relic = 0
  self.dropped_relics_counters = {}
  self.match_skill_relic = 0
  self.feature_info_list = {}
end

RelicInfo._proto = {
  [1] = {"relics", "list<int>"},
  [2] = {
    "dangling_relics",
    "list<CommonOutput>"
  },
  [3] = {
    "relic_counters",
    "map<int,int>"
  },
  [4] = {
    "dropped_relics",
    "list<int>"
  },
  [5] = {
    "relic_attrs",
    "AnipopRelicAddAttr"
  },
  [6] = {
    "tag_counters",
    "map<string,int>"
  },
  [7] = {
    "skill_relics",
    "list<int>"
  },
  [8] = {
    "skill_dangling_relics",
    "list<CommonOutput>"
  },
  [9] = {
    "init_skill_relic",
    "int"
  },
  [10] = {
    "dropped_relics_counters",
    "map<int,int>"
  },
  [11] = {
    "match_skill_relic",
    "int"
  },
  [12] = {
    "feature_info_list",
    "map<int,int>"
  }
}
_class("AnipopWeekInfo", Object)
AnipopWeekInfo = AnipopWeekInfo

function AnipopWeekInfo:Constructor()
  self.total_score = 0
  self.score_received = {}
  self.search_reward_num = 0
  self.pass_hard_count = 0
  self.sweep_list = {}
  self.hard_id = 0
end

AnipopWeekInfo._proto = {
  [1] = {
    "total_score",
    "int"
  },
  [2] = {
    "score_received",
    "list<int>"
  },
  [3] = {
    "search_reward_num",
    "int"
  },
  [4] = {
    "pass_hard_count",
    "int"
  },
  [5] = {"sweep_list", "list<int>"},
  [6] = {"hard_id", "int"}
}
_class("anipop_info", Object)
anipop_info = anipop_info

function anipop_info:Constructor()
  self.owner_pstid = 0
  self.cur_season = 0
  self.last_refresh_time = 0
  self.cur_hard_id = 0
  self.next_hard_id = 0
  self.team_id = 0
  self.formation_info = AnipopFormationInfo:New()
  self.round_info = AnipopRoundInfo:New()
  self.relic_info = RelicInfo:New()
  self.week_info = AnipopWeekInfo:New()
end

anipop_info._proto = {
  [1] = {
    "owner_pstid",
    "int64"
  },
  [2] = {"cur_season", "int"},
  [3] = {
    "last_refresh_time",
    "time"
  },
  [4] = {
    "cur_hard_id",
    "int"
  },
  [5] = {
    "next_hard_id",
    "int"
  },
  [6] = {"team_id", "int"},
  [7] = {
    "formation_info",
    "AnipopFormationInfo"
  },
  [8] = {
    "round_info",
    "AnipopRoundInfo"
  },
  [9] = {"relic_info", "RelicInfo"},
  [10] = {
    "week_info",
    "AnipopWeekInfo"
  }
}
