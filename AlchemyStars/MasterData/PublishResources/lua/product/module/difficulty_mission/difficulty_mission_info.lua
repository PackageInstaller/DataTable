local DifficultyMissionErrorType = {
  E_DIFFICULTYMISSION_ERROR_TYPE_SUCCESS = 0,
  E_DIFFICULTYMISSION_ERROR_TYPE_FAILURE = 1,
  E_DIFFICULTYMISSION_LOAD_ERROR = 2,
  E_DIFFICULTYMISSION_SAVE_ERROR = 3,
  E_DIFFICULTYMISSION_ERROR_UNLOCK = 4,
  E_DIFFICULTYMISSION_ERROR_RECORD_NOT_EXIST = 5,
  E_DIFFICULTYMISSION_CHOSE_RECORD_ERROR = 6,
  E_DIFFICULTYMISSION_FORMATION_INVALID_PET = 10,
  E_DIFFICULTYMISSION_FORMATION_INVALID_PETCOUNT = 11,
  E_DIFFICULTYMISSION_FORMATION_DUPLICATION_PET = 12,
  E_DIFFICULTYMISSION_FORMATION_DATA_INVALID = 13,
  E_DIFFICULTYMISSION_FORMATION_SAME_BINDER = 14
}
_enum("DifficultyMissionErrorType", DifficultyMissionErrorType)
local DifficultyMissionFormationPetPlaceType = {E_DM_FormationPetPlaceType_None = 0}
_enum("DifficultyMissionFormationPetPlaceType", DifficultyMissionFormationPetPlaceType)
_class("SubMissionInfo", Object)
SubMissionInfo = SubMissionInfo

function SubMissionInfo:Constructor()
  self.mission_id = 0
  self.pet_list = {}
  self.max_left_turn = 0
end

SubMissionInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "pet_list",
    "list<int64>"
  },
  [3] = {
    "max_left_turn",
    "int"
  }
}
_class("ParentMissionInfo", Object)
ParentMissionInfo = ParentMissionInfo

function ParentMissionInfo:Constructor()
  self.parent_mission_id = 0
  self.sub_mission_infos = {}
  self.complete_enties = {}
  self.status = 0
end

ParentMissionInfo._proto = {
  [1] = {
    "parent_mission_id",
    "int"
  },
  [2] = {
    "sub_mission_infos",
    "list<SubMissionInfo>"
  },
  [3] = {
    "complete_enties",
    "list<int>"
  },
  [4] = {"status", "int"}
}
_class("ClientDifficultyMissionInfo", Object)
ClientDifficultyMissionInfo = ClientDifficultyMissionInfo

function ClientDifficultyMissionInfo:Constructor()
  self.cur_parent_id = 0
  self.infos = {}
  self.pet_list = {}
end

ClientDifficultyMissionInfo._proto = {
  [1] = {
    "cur_parent_id",
    "int"
  },
  [2] = {
    "infos",
    "map<int,ParentMissionInfo>"
  },
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("parent_mission_pass_info", Object)
parent_mission_pass_info = parent_mission_pass_info

function parent_mission_pass_info:Constructor()
  self.pstid = 0
  self.mission_id = 0
  self.nick = ""
  self.head = 0
  self.head_bg = 0
  self.formation_info = {}
  self.pass_time = 0
  self.frame_id = 0
end

parent_mission_pass_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"mission_id", "int"},
  [3] = {"nick", "string"},
  [4] = {"head", "int"},
  [5] = {"head_bg", "int"},
  [6] = {
    "formation_info",
    "map<int,list<mission_pass_pet_info>>"
  },
  [7] = {"pass_time", "time"},
  [8] = {"frame_id", "int"}
}
