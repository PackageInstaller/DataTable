local EFirstPassCanIgnorPowerMission = {
  EFirstPassCanIgnorPowerMission_1_1 = 4001010,
  EFirstPassCanIgnorPowerMission_1_2 = 4001020,
  EFirstPassCanIgnorPowerMission_1_3 = 4001030
}
_enum("EFirstPassCanIgnorPowerMission", EFirstPassCanIgnorPowerMission)
local MissionType = {
  MissionType_None = 0,
  MissionType_Fight_Normal = 1,
  MissionType_Fight_Boss = 2,
  MissionType_Story = 3,
  MissionType_Chat = 4
}
_enum("MissionType", MissionType)
local FormationPetPlaceType = {FormationPetPlaceType_None = 0}
_enum("FormationPetPlaceType", FormationPetPlaceType)
local WayPointType = {
  WayPointType_None = 0,
  WayPointType_Main = 1,
  WayPointType_Branch = 2,
  WayPointType_Guide = 3,
  WayPointType_S = 4
}
_enum("WayPointType", WayPointType)
local BonusObjectiveType = {
  NoAdditional = 0,
  Health = 1,
  LastWaveRoundNum = 2,
  SuperChainCount = 3,
  ActiveSkillCount = 4,
  AllElementTeam = 5,
  SelectElement = 6,
  MatchNum = 7,
  TrapAttackTimes = 8,
  TrapAttackDammage = 9,
  TrapAttackTotalTimes = 10,
  TrapAttackTotalDamage = 11,
  SmashTrapCount = 12,
  SmashTrapTotalCount = 13,
  TotalMatchPropertyNum = 14,
  OnceMatchPropertyNum = 15,
  OnceMatchNorAttTimes = 16,
  ColorSkillCount = 17,
  AuroraTimeCount = 18,
  PlayerBeHitCount = 19,
  CompelHelpPet = 20,
  ForbidHelpPet = 21,
  KillMonstersInLimitedRound = 22,
  KillMonstersWithBuff = 23,
  CollectItems = 24,
  UIChangeTeamLeaderCount = 25,
  HitBySkill = 26,
  ChessDeadPlayerPawnCount = 27,
  MonsterEscapeLessThan = 28,
  PopStarNumber = 29,
  BossHealth = 30
}
_enum("BonusObjectiveType", BonusObjectiveType)
local ActiveStoryType = {
  ActiveStoryType_None = 0,
  ActiveStoryType_BeforeBattle = 1,
  ActiveStoryType_AfterBattle = 2
}
_enum("ActiveStoryType", ActiveStoryType)
_class("mission_drop_item", Object)
mission_drop_item = mission_drop_item

function mission_drop_item:Constructor()
  self.item_id = 0
  self.item_count = 0
end

mission_drop_item._proto = {
  [1] = {"item_id", "int"},
  [2] = {"item_count", "int"}
}
_class("mission_info", Object)
mission_info = mission_info

function mission_info:Constructor()
  self.id = 0
  self.type = 0
  self.waypoint_type = 0
  self.star = 0
  self.pass_without_help = 0
end

mission_info._proto = {
  [1] = {"id", "int"},
  [2] = {"type", "int"},
  [3] = {
    "waypoint_type",
    "int"
  },
  [4] = {"star", "int"},
  [5] = {
    "pass_without_help",
    "int"
  }
}
_class("mission_data", Object)
mission_data = mission_data

function mission_data:Constructor()
  self.pstid = 0
  self.mission_id = 0
  self.pass_mission = {}
end

mission_data._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"mission_id", "int"},
  [3] = {
    "pass_mission",
    "list<mission_info>"
  }
}
_class("formation_info", Object)
formation_info = formation_info

function formation_info:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

formation_info._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("main_formation_infos", Object)
main_formation_infos = main_formation_infos

function main_formation_infos:Constructor()
  self.fromation_list = {}
end

main_formation_infos._proto = {
  [1] = {
    "fromation_list",
    "list<formation_info>"
  }
}
_class("already_return_power_mission_info", Object)
already_return_power_mission_info = already_return_power_mission_info

function already_return_power_mission_info:Constructor()
  self.mission_id_list = {}
end

already_return_power_mission_info._proto = {
  [1] = {
    "mission_id_list",
    "list<int>"
  }
}
_class("cam_mission_info", Object)
cam_mission_info = cam_mission_info

function cam_mission_info:Constructor()
  self.mission_id = 0
  self.star = 0
  self.pass_without_help = 0
end

cam_mission_info._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"star", "int"},
  [3] = {
    "pass_without_help",
    "int"
  }
}
_class("mission_story_info", Object)
mission_story_info = mission_story_info

function mission_story_info:Constructor()
  self.id = 0
  self.active_story_type = 0
end

mission_story_info._proto = {
  [1] = {"id", "int"},
  [2] = {
    "active_story_type",
    "int"
  }
}
_class("mission_story_data", Object)
mission_story_data = mission_story_data

function mission_story_data:Constructor()
  self.active_story_map = {}
end

mission_story_data._proto = {
  [1] = {
    "active_story_map",
    "map<int,mission_story_info>"
  }
}
_class("mission_chapter_award_info", Object)
mission_chapter_award_info = mission_chapter_award_info

function mission_chapter_award_info:Constructor()
  self.chapter_id = 0
  self.receive_star_award_list = {}
end

mission_chapter_award_info._proto = {
  [1] = {"chapter_id", "int"},
  [2] = {
    "receive_star_award_list",
    "list<int>"
  }
}
_class("mission_chapter_award_data", Object)
mission_chapter_award_data = mission_chapter_award_data

function mission_chapter_award_data:Constructor()
  self.receive_star_award_map = {}
end

mission_chapter_award_data._proto = {
  [1] = {
    "receive_star_award_map",
    "map<int,mission_chapter_award_info>"
  }
}
_class("mission_pass_pet_info", Object)
mission_pass_pet_info = mission_pass_pet_info

function mission_pass_pet_info:Constructor()
  self.template_id = 0
  self.level = 0
  self.grade = 0
  self.awakening = 0
  self.skin_id = 0
  self.equip_lv = 1
  self.equip_refine_lv = 0
  self.awake_lock = 0
end

mission_pass_pet_info._proto = {
  [1] = {
    "template_id",
    "int"
  },
  [2] = {"level", "int"},
  [3] = {"grade", "int"},
  [4] = {"awakening", "int"},
  [5] = {"skin_id", "int"},
  [6] = {"equip_lv", "int"},
  [7] = {
    "equip_refine_lv",
    "int"
  },
  [8] = {"awake_lock", "int"}
}
_class("mission_pass_info", Object)
mission_pass_info = mission_pass_info

function mission_pass_info:Constructor()
  self.pstid = 0
  self.mission_id = 0
  self.nick = ""
  self.head = 0
  self.head_bg = 0
  self.formation_info = {}
  self.pass_time = 0
  self.frame_id = 0
end

mission_pass_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"mission_id", "int"},
  [3] = {"nick", "string"},
  [4] = {"head", "int"},
  [5] = {"head_bg", "int"},
  [6] = {
    "formation_info",
    "list<mission_pass_pet_info>"
  },
  [7] = {"pass_time", "time"},
  [8] = {"frame_id", "int"}
}
local FormationPetLeaderSeat = {LeaderSeat = 1}
_enum("FormationPetLeaderSeat", FormationPetLeaderSeat)
local ChapterType = {
  ChapterType_None = 0,
  ChapterType_Main = 1,
  ChapterType_Branch = 2
}
_enum("ChapterType", ChapterType)
