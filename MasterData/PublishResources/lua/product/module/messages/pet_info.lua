local ElementType = {
  ElementType_None = 0,
  ElementType_Blue = 1,
  ElementType_Red = 2,
  ElementType_Green = 3,
  ElementType_Yellow = 4,
  ElementType_Any = 5,
  ElementType_AnyNone = 6
}
_enum("ElementType", ElementType)
local PetProfType = {
  PetProf_Color = 2001,
  PetProf_Blood = 2002,
  PetProf_Attack = 2003,
  PetProf_Function = 2004
}
_enum("PetProfType", PetProfType)
local PetForceType = {
  PetForce_BaiYeCheng = 1001,
  PetForce_BaiYeXiaCheng = 1002,
  PetForce_QiGuang = 1003,
  PetForce_BeiJing = 1004,
  PetForce_HongYouBanShou = 1005,
  PetForce_TaiYangJiaoTuan = 1006,
  PetForce_YouMin = 1007,
  PetForce_RiShi = 1008
}
_enum("PetForceType", PetForceType)
local PetSkillType = {
  SkillType_Normal = 1,
  SkillType_ChainSkill = 2,
  SkillType_Active = 3,
  SkillType_Passive = 4
}
_enum("PetSkillType", PetSkillType)
local PetSkillSubType = {SkillType_Extra = 1}
_enum("PetSkillSubType", PetSkillSubType)
local PetTaskType = {
  PetTaskType_Gift = 1,
  PetTaskType_Mission = 2,
  PetTaskType_Max = 3
}
_enum("PetTaskType", PetTaskType)
local TaskMissionType = {
  MissionType_Main = 1,
  MissionType_Ext = 2,
  MissionType_Res = 3,
  MissionType_AnyMain = 4,
  MissionType_AnyRes = 5
}
_enum("TaskMissionType", TaskMissionType)
local PetTaskState = {
  PetTS_Active = 1,
  PetTS_Accept = 2,
  PetTS_Finish = 3,
  PetTS_Reward = 4
}
_enum("PetTaskState", PetTaskState)
local PetMaskState = {
  PMS_Story = 1,
  PMS_Work = 2,
  PMS_Dispatch = 4,
  PMS_Present = 8,
  PMS_HomelandDormitory = 32768,
  PMS_Treasure = 65536,
  PMS_Diary = 131072
}
_enum("PetMaskState", PetMaskState)
_class("PetTaskInfo", Object)
PetTaskInfo = PetTaskInfo

function PetTaskInfo:Constructor()
  self.task_id = 0
  self.uid = 0
  self.param1 = 0
  self.param2 = 0
  self.param3 = 0
  self.state = 0
  self.end_time = 0
end

PetTaskInfo._proto = {
  [1] = {"task_id", "int"},
  [2] = {"uid", "int64"},
  [3] = {"param1", "int"},
  [4] = {"param2", "int"},
  [5] = {"param3", "int"},
  [6] = {"state", "int"},
  [7] = {"end_time", "time"}
}
_class("pet_data", Object)
pet_data = pet_data

function pet_data:Constructor()
  self.pet_pstid = 0
  self.owner_pstid = 0
  self.template_id = 0
  self.level = 0
  self.exp = 0
  self.grade = 0
  self.awakening = 0
  self.affinity_level = 0
  self.affinity_exp = 0
  self.affinity_increase_count = 0
  self.triggered_task_id = 0
  self.story_finish_record = {}
  self.triggered_story_num = 0
  self.triggered_task_num = 0
  self.task_info = {}
  self.story_is_triggered = {}
  self.equip_lv = 0
  self.mask_state = 0
  self.equip_refine_lv = 0
  self.awake_lock = 0
  self.repet_get_times = 0
  self.b_pet_like = false
end

pet_data._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {
    "owner_pstid",
    "int64"
  },
  [3] = {
    "template_id",
    "int"
  },
  [4] = {"level", "int"},
  [5] = {"exp", "int"},
  [6] = {"grade", "int"},
  [7] = {"awakening", "int"},
  [8] = {
    "affinity_level",
    "int"
  },
  [9] = {
    "affinity_exp",
    "double"
  },
  [10] = {
    "affinity_increase_count",
    "int"
  },
  [11] = {
    "triggered_task_id",
    "int"
  },
  [12] = {
    "story_finish_record",
    "list<int>"
  },
  [13] = {
    "triggered_story_num",
    "int"
  },
  [14] = {
    "triggered_task_num",
    "int"
  },
  [15] = {
    "task_info",
    "list<PetTaskInfo>"
  },
  [16] = {
    "story_is_triggered",
    "map<int,time>"
  },
  [17] = {"equip_lv", "int"},
  [18] = {"mask_state", "int"},
  [19] = {
    "equip_refine_lv",
    "int"
  },
  [20] = {"awake_lock", "int"},
  [101] = {
    "repet_get_times",
    "int64"
  },
  [102] = {"b_pet_like", "bool"}
}
_class("PetSkinInfo", Object)
PetSkinInfo = PetSkinInfo

function PetSkinInfo:Constructor()
  self.skin_id = 0
  self.unlock_CG = 0
  self.gain_time = 0
end

PetSkinInfo._proto = {
  [1] = {"skin_id", "int"},
  [2] = {"unlock_CG", "int"},
  [3] = {"gain_time", "time"}
}
_class("pet_skin_data", Object)
pet_skin_data = pet_skin_data

function pet_skin_data:Constructor()
  self.pet_template_id = 0
  self.owner_pstid = 0
  self.skin_info = {}
  self.current_skin = 0
end

pet_skin_data._proto = {
  [1] = {
    "pet_template_id",
    "int"
  },
  [2] = {
    "owner_pstid",
    "int64"
  },
  [3] = {
    "skin_info",
    "list<PetSkinInfo>"
  },
  [4] = {
    "current_skin",
    "int"
  }
}
_class("NewPetList", Object)
NewPetList = NewPetList

function NewPetList:Constructor()
  self.new_pets = {}
end

NewPetList._proto = {
  [1] = {"new_pets", "list<int>"}
}
local PetSexType = {
  Male = 1,
  FaMale = 2,
  UnKnow = 3
}
_enum("PetSexType", PetSexType)
local DynamicAndStaticState = {
  None = 0,
  Static = 1,
  Dynamic = 2
}
_enum("DynamicAndStaticState", DynamicAndStaticState)
local AircraftEnterSortType = {WorkState = 1, Mood = 2}
_enum("AircraftEnterSortType", AircraftEnterSortType)
local AircraftEnterSortOrder = {UpToDown = 1, DownToUp = 2}
_enum("AircraftEnterSortOrder", AircraftEnterSortOrder)
local AircraftEnterChooseType = {
  None = 0,
  NotEnter = 1,
  MasterCtrl = 2,
  Power = 3,
  Replay = 4,
  Catch = 5,
  Puri = 6
}
_enum("AircraftEnterChooseType", AircraftEnterChooseType)
SortState = {
  None = 0,
  Up = 1,
  Down = 2
}
_enum("SortType", SortType)
FilterType = {
  Fire = 1,
  Sen = 2,
  Electro = 3,
  Water = 4,
  Attack = 5,
  Treatment = 6,
  Special = 7,
  Special1 = 8
}
_enum("FilterType", FilterType)
