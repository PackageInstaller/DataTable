local SailingMissionErrorType = {
  E_SAILINGMISSION_ERROR_TYPE_SUCCESS = 0,
  E_SAILINGMISSION_ERROR_TYPE_FAILURE = 1,
  E_SAILINGMISSION_LOAD_ERROR = 2,
  E_SAILINGMISSION_SAVE_ERROR = 3,
  E_SAILINGMISSION_ERROR_UNLOCK = 4,
  E_SAILINGMISSION_ERROR_RECORD_NOT_EXIST = 5,
  E_SAILINGMISSION_CHOSE_RECORD_ERROR = 6,
  E_SAILINGMISSION_FORMATION_INVALID_PET = 10,
  E_SAILINGMISSION_FORMATION_INVALID_PETCOUNT = 11,
  E_SAILINGMISSION_FORMATION_DUPLICATION_PET = 12,
  E_SAILINGMISSION_FORMATION_DATA_INVALID = 13,
  E_SAILINGMISSION_FORMATION_SAME_BINDER = 14
}
_enum("SailingMissionErrorType", SailingMissionErrorType)
local SailingMissionFormationPetPlaceType = {E_SM_FormationPetPlaceType_None = 0}
_enum("SailingMissionFormationPetPlaceType", SailingMissionFormationPetPlaceType)
_class("SailingMissionInfo", Object)
SailingMissionInfo = SailingMissionInfo

function SailingMissionInfo:Constructor()
  self.mission_id = 0
  self.pet_list = {}
end

SailingMissionInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "pet_list",
    "list<int64>"
  }
}
_class("SailingLayerInfo", Object)
SailingLayerInfo = SailingLayerInfo

function SailingLayerInfo:Constructor()
  self.layer_id = 0
  self.mission_infos = {}
  self.status = 0
end

SailingLayerInfo._proto = {
  [1] = {"layer_id", "int"},
  [2] = {
    "mission_infos",
    "list<SailingMissionInfo>"
  },
  [4] = {"status", "int"}
}
_class("TeamCache", Object)
TeamCache = TeamCache

function TeamCache:Constructor()
  self.layer_id = 0
  self.mission_id = 0
  self.pet_list = {}
end

TeamCache._proto = {
  [1] = {"layer_id", "int"},
  [2] = {"mission_id", "int"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("ClientSailingMissionInfo", Object)
ClientSailingMissionInfo = ClientSailingMissionInfo

function ClientSailingMissionInfo:Constructor()
  self.max_layer_id = 0
  self.infos = {}
  self.team_cache = TeamCache:New()
  self.cur_exploration_progress = 0
  self.history_exploration_progress = 0
  self.received_exploration_reward = {}
end

ClientSailingMissionInfo._proto = {
  [1] = {
    "max_layer_id",
    "int"
  },
  [2] = {
    "infos",
    "map<int,SailingLayerInfo>"
  },
  [3] = {"team_cache", "TeamCache"},
  [4] = {
    "cur_exploration_progress",
    "int"
  },
  [5] = {
    "history_exploration_progress",
    "int"
  },
  [6] = {
    "received_exploration_reward",
    "list<int>"
  }
}
