local WorldBossErrorType = {
  E_WORLDBOSS_ERROR_TYPE_SUCCESS = 0,
  E_WORLDBOSS_ERROR_TYPE_FAILURE = 1,
  E_WORLDBOSS_LOAD_ERROR = 2,
  E_WORLDBOSS_SAVE_ERROR = 3,
  E_WORLDBOSS_ERROR_UNLOCK = 4,
  E_WORLDBOSS_ERROR_RECORD_NOT_EXIST = 5,
  E_WORLDBOSS_CHOSE_RECORD_ERROR = 6,
  E_WORLDBOSS_FORMATION_INVALID_PET = 10,
  E_WORLDBOSS_FORMATION_INVALID_PETCOUNT = 11,
  E_WORLDBOSS_FORMATION_DUPLICATION_PET = 12,
  E_WORLDBOSS_FORMATION_DATA_INVALID = 13,
  E_WORLDBOSS_DAN_INVALID = 14,
  E_WORLDBOSS_FORMATION_SAME_BINDER = 15
}
_enum("WorldBossErrorType", WorldBossErrorType)
local WorldBossFormationPetPlaceType = {E_WORLDBOSS_FormationPetPlaceType_None = 0}
_enum("WorldBossFormationPetPlaceType", WorldBossFormationPetPlaceType)
_class("FormationRecord", Object)
FormationRecord = FormationRecord

function FormationRecord:Constructor()
  self.id = 0
  self.pet_list = {}
  self.formation_damage = 0
  self.detail_list = {}
end

FormationRecord._proto = {
  [1] = {"id", "int"},
  [2] = {
    "pet_list",
    "list<int64>"
  },
  [3] = {
    "formation_damage",
    "int64"
  },
  [4] = {
    "detail_list",
    "list<role_help_pet_info>"
  }
}
_class("WorldBossFormationInfo", Object)
WorldBossFormationInfo = WorldBossFormationInfo

function WorldBossFormationInfo:Constructor()
  self.formation_list = {}
  self.pet_list = {}
end

WorldBossFormationInfo._proto = {
  [1] = {
    "formation_list",
    "list<FormationRecord>"
  },
  [2] = {
    "pet_list",
    "list<int64>"
  }
}
_class("PlayerWorldBossInfo", Object)
PlayerWorldBossInfo = PlayerWorldBossInfo

function PlayerWorldBossInfo:Constructor()
  self.boss_mission_id = 0
  self.cur_dan = 0
  self.max_total_damage = 0
  self.formation_info = WorldBossFormationInfo:New()
  self.end_time = 0
  self.rank = 0
end

PlayerWorldBossInfo._proto = {
  [1] = {
    "boss_mission_id",
    "int"
  },
  [2] = {"cur_dan", "int"},
  [3] = {
    "max_total_damage",
    "int64"
  },
  [4] = {
    "formation_info",
    "WorldBossFormationInfo"
  },
  [5] = {"end_time", "time"},
  [6] = {"rank", "int"}
}
_class("DanInfo", Object)
DanInfo = DanInfo

function DanInfo:Constructor()
  self.cur_dan = 0
  self.total_damage = 0
  self.rank_first_damage = 0
  self.promote_one = 0
  self.my_rank = 0
end

DanInfo._proto = {
  [1] = {"cur_dan", "int"},
  [2] = {
    "total_damage",
    "int64"
  },
  [3] = {
    "rank_first_damage",
    "int64"
  },
  [4] = {
    "promote_one",
    "int64"
  },
  [5] = {"my_rank", "int"}
}
