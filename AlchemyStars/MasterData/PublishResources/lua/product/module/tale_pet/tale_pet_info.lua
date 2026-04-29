local TALE_PET_RESULT_CODE = {
  TALE_PET_SUCCEED = 0,
  TALE_PET_UNKNOWN = 1,
  TALE_PET_CFG_ERROR = 2,
  TALE_PET_STATUS_ERROR = 3,
  TALE_PET_COND_ERROR = 4,
  TALE_PET_SAME_ERROR = 5,
  TALE_PET_TASKCFG_ERROR = 6,
  TALE_PET_TASKCFG_DONE = 7,
  TALE_PET_TASKPHASE_ERROR = 8,
  TALE_PET_NOHAVE_ERROR = 9,
  TALE_PET_PRE_CONDITION_NOT_ENOUGH = 10,
  TP_REWARD_STAGE_ID_ERROR = 31,
  TP_COMPLATE_TOO_FEW_MISSION = 32,
  TP_ALREADY_ACCEPT = 33,
  TP_FORMATIONID_ERROR = 34
}
_enum("TALE_PET_RESULT_CODE", TALE_PET_RESULT_CODE)
local TaleType = {TT_TrainMission = 1, TT_FightMission = 2}
_enum("TaleType", TaleType)
local UnlockType = {
  UT_DonnotLock = 0,
  UT_HaveAnyone = 1,
  UT_HaveAll = 2
}
_enum("UnlockType", UnlockType)
local TalePetCallType = {
  TPCT_Invalid = 0,
  TPCT_Doing = 1,
  TPCT_Pause = 2,
  TPCT_Can_Do = 3,
  TPCT_Done = 4
}
_enum("TalePetCallType", TalePetCallType)
local TaleFirstType = {
  TFT_Enter = 0,
  TFT_Buff = 1,
  TFT_Story = 2
}
_enum("TaleFirstType", TaleFirstType)
local TalePetDBFirstType = {TPDBFT_Story = 0}
_enum("TalePetDBFirstType", TalePetDBFirstType)
_class("tale_pet_task_msg", Object)
tale_pet_task_msg = tale_pet_task_msg

function tale_pet_task_msg:Constructor()
  self.status = false
  self.cur = 0
  self.total = 0
  self.item_cfg_id = 0
end

tale_pet_task_msg._proto = {
  [1] = {"status", "bool"},
  [2] = {"cur", "int"},
  [3] = {"total", "int"},
  [4] = {
    "item_cfg_id",
    "int"
  }
}
_class("tale_pet_msg", Object)
tale_pet_msg = tale_pet_msg

function tale_pet_msg:Constructor()
  self.pet_cfg_id = 0
  self.pet_status = 0
  self.task_phase = 0
  self.task_phase_reward = {}
  self.datas = {}
  self.first_status = 0
end

tale_pet_msg._proto = {
  [2] = {"pet_cfg_id", "int"},
  [3] = {"pet_status", "int"},
  [4] = {"task_phase", "int"},
  [5] = {
    "task_phase_reward",
    "list<int>"
  },
  [6] = {
    "datas",
    "map<int,tale_pet_task_msg>"
  },
  [7] = {
    "first_status",
    "int"
  }
}
_class("CCAP_Task", Object)
CCAP_Task = CCAP_Task

function CCAP_Task:Constructor()
  self.status = false
  self.cond_status = ""
end

CCAP_Task._proto = {
  [1] = {"status", "bool"},
  [2] = {
    "cond_status",
    "buffer"
  }
}
_class("tale_pet", Object)
tale_pet = tale_pet

function tale_pet:Constructor()
  self.owner_pstid = 0
  self.pet_cfg_id = 0
  self.pet_status = 0
  self.task_phase = 0
  self.task_phase_reward = {}
  self.task_data = {}
  self.first_status = 0
  self.task_data_ext = {}
end

tale_pet._proto = {
  [1] = {
    "owner_pstid",
    "int64"
  },
  [2] = {"pet_cfg_id", "int"},
  [3] = {"pet_status", "int"},
  [4] = {"task_phase", "int"},
  [5] = {
    "task_phase_reward",
    "list<int>"
  },
  [6] = {
    "task_data",
    "map<int,CCAP_Task>"
  },
  [7] = {
    "first_status",
    "int"
  },
  [8] = {
    "task_data_ext",
    "map<int,CCAP_Task>"
  }
}
_class("tale_stage_data", Object)
tale_stage_data = tale_stage_data

function tale_stage_data:Constructor()
  self.pstid = 0
  self.stage_id = 0
  self.count = 0
end

tale_stage_data._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"stage_id", "int"},
  [3] = {"count", "int"}
}
_class("AcceptStage", Object)
AcceptStage = AcceptStage

function AcceptStage:Constructor()
  self.accepted_stage_ids = {}
end

AcceptStage._proto = {
  [1] = {
    "accepted_stage_ids",
    "list<int>"
  }
}
_class("tale_formation_info", Object)
tale_formation_info = tale_formation_info

function tale_formation_info:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

tale_formation_info._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("TalePetFormationInfo", Object)
TalePetFormationInfo = TalePetFormationInfo

function TalePetFormationInfo:Constructor()
  self.formation_list = {}
end

TalePetFormationInfo._proto = {
  [1] = {
    "formation_list",
    "list<tale_formation_info>"
  }
}
