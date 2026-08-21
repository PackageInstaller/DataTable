require("message_def")
local petMessageDef = {
  CLSID_CEventPetAddExp = 17000,
  CLSID_CEventPetAddExpResult = 17001,
  CLSID_CEventPetBreak = 17002,
  CLSID_CEventPetBreakResult = 17003,
  CLSID_CEventPetAwake = 17004,
  CLSID_CEventPetAwakeResult = 17005,
  CLSID_CEventPetEquip = 17006,
  CLSID_CEventPetEquipResult = 17007,
  CLSID_CEventEquipRefineLevelUp = 17008,
  CLSID_CEventEquipRefineLevelUpReply = 17009,
  CLSID_CEventDelNewpetMark = 17010,
  CLSID_CEventDelNewpetMarkResult = 17011,
  CLSID_CEventRequestPetAddAffinity = 17012,
  CLSID_CEventReplyPetAddAffinityResult = 17013,
  CLSID_CEventRequestPetViewTriggeredStory = 17014,
  CLSID_CEventReplyPetViewTriggeredStory = 17015,
  CLSID_CEventRequestPetFinishTriggeredStory = 17016,
  CLSID_CEventReplyPetFinishTriggeredStory = 17017,
  CLSID_CEventRequestPetViewTriggeredTask = 17018,
  CLSID_CEventReplyPetViewTriggeredTask = 17019,
  CLSID_CEventRequestPetAcceptTriggeredTask = 17020,
  CLSID_CEventReplyPetAcceptTriggeredTask = 17021,
  CLSID_CEventRequestGivePetPresent = 17022,
  CLSID_CEventReplyGivePetPresent = 17023,
  CLSID_CEventNotifyPetChange = 17024,
  CLSID_CEventNotifyAffinityAddCount = 17025,
  CLSID_CEventUpdateNewPetList = 17026,
  CLSID_CEventRequestPetTaskReward = 17027,
  CLSID_CEventReplyPetTaskReward = 17028,
  CLSID_CEventPetUnlockCG = 17029,
  CLSID_CEventPetUnlockCGResult = 17030,
  CLSID_CEventPetSkinChange = 17031,
  CLSID_CEventPetSkinChangeResult = 17032,
  CLSID_CEventNotifyPetSkinChange = 17033,
  CLSID_CEventClickPetEquipRefine = 17034,
  CLSID_CEventPropertyCultivateInfo = 17035,
  CLSID_CEventPropertyCultivateInfoResult = 17036,
  CLSID_CEventPropertyCultivateLv = 17037,
  CLSID_CEventPropertyCultivateLvResult = 17038,
  CLSID_CEventLockAwake = 17039,
  CLSID_CEventLockAwakeResult = 17040,
  CLSID_CEventPetLike = 17041,
  CLSID_CEventPetLikeReply = 17042
}
table.append(MessageDef, petMessageDef)
local PET_RESULT_CODE = {
  PET_SUCCEED = 0,
  PET_FAILED = 1,
  PET_NOT_EXIST = 2,
  PET_TEMPLATE_NOT_EXIST = 3,
  PET_AWAKE_CONDITION_ERR = 4,
  PET_AWAKE_MAX = 5,
  PET_GRADE_MAX = 6,
  PET_LEVEL_MAX = 7,
  PET_ADD_EXP_ONLY = 8,
  PET_UNSUPPORT_SUB_LEVEL = 9,
  PET_CFG_STAR_NOT_ENOUGH = 10,
  PET_CFG_GRADE_NOT_ENOUGH = 11,
  PET_CFG_LEVEL_NOT_ENOUGH = 12,
  PET_CFG_ITEM_NOT_ENOUGH = 13,
  PET_CFG_DEL_GOLD_ERR = 14,
  PET_GET_EXP_ERR = 15,
  PET_ITEM_NOT_FOUND = 16,
  PET_ADD_AFFINITY_COUNT_MAX = 17,
  PET_ADD_AFFINITY_TOTAL_COUNT_MAX = 18,
  PET_DID_NOT_TRIGGERED_STORY = 19,
  PET_TRIGGERED_STORY_INVALID = 20,
  PET_DID_NOT_TRIGGERED_TASK = 21,
  PET_TRIGGERED_TASK_INVALID = 22,
  PET_STORY_TASK_REWARD_FAIL = 23,
  PET_TASK_ACCEPT_FAIL = 24,
  PET_AFFINITY_LEVEL_MAX = 25,
  PET_GET_AFFINITY_EXP_ERROR = 26,
  PET_GET_TASK_REWARD_NONE = 27,
  PET_GET_TASK_REWARD_STATE_ERROR = 28,
  PET_GET_TASK_REWARD_TIME_ERROR = 29,
  PET_STORY_CHAT_NOT_COMPLATE = 30,
  PET_EQUIP_NOT_OPEN = 31,
  PET_EQUIP_NOT_CFG = 32,
  PET_EQUIP_ITEM_NOT_ENOUGH = 33,
  PET_EQUIP_LV_MAX = 34,
  PET_SKIN_NOT_EXIST = 35,
  PET_NOT_OWN_THIS_SKIN = 36,
  PET_SKIN_NOT_OWN = 37,
  PET_EQUIP_OPEN_COND_UNSATISFY = 38,
  PET_EQUIP_UNLOCK_COND_UNSATISFY = 39,
  PET_PROPERTY_CULTIVATE_ERROR_PROCUL_ID = 100,
  PET_PROPERTY_CULTIVATE_ERROR_PROCUL_LOCK = 101,
  PET_PROPERTY_CULTIVATE_ERROR_SMELT_ID = 102,
  PET_PROPERTY_CULTIVATE_ERROR_SMELT_NUM = 103,
  PET_PROPERTY_CULTIVATE_ERROR_SMELT_CONDITION = 104,
  PET_PROPERTY_CULTIVATE_ERROR_ITEM_FEW = 105,
  PET_PROPERTY_CULTIVATE_ERROR_LV = 106,
  PET_LOCK_AWAKE_UNCHANGED = 200,
  PET_LOCK_AWAKE_GREATER = 201
}
_enum("PET_RESULT_CODE", PET_RESULT_CODE)
_class("CEventPetAddExp", CCallRequestEvent)
CEventPetAddExp = CEventPetAddExp

function CEventPetAddExp:Constructor()
  self.pet_pstid = 0
  self.items = {}
end

CEventPetAddExp._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {
    "items",
    "list<ItemAsset>"
  }
}
_class("CEventPetAddExpResult", CCallReplyEvent)
CEventPetAddExpResult = CEventPetAddExpResult

function CEventPetAddExpResult:Constructor()
  self.nRet = 0
end

CEventPetAddExpResult._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventPetBreak", CCallRequestEvent)
CEventPetBreak = CEventPetBreak

function CEventPetBreak:Constructor()
  self.pet_pstid = 0
end

CEventPetBreak._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventPetBreakResult", CCallReplyEvent)
CEventPetBreakResult = CEventPetBreakResult

function CEventPetBreakResult:Constructor()
  self.nRet = 0
end

CEventPetBreakResult._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventPetAwake", CCallRequestEvent)
CEventPetAwake = CEventPetAwake

function CEventPetAwake:Constructor()
  self.pet_pstid = 0
  self.awakening = 0
end

CEventPetAwake._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {"awakening", "int"}
}
_class("CEventPetAwakeResult", CCallReplyEvent)
CEventPetAwakeResult = CEventPetAwakeResult

function CEventPetAwakeResult:Constructor()
  self.nRet = 0
end

CEventPetAwakeResult._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventPetEquip", CCallRequestEvent)
CEventPetEquip = CEventPetEquip

function CEventPetEquip:Constructor()
  self.pet_pstid = 0
end

CEventPetEquip._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventPetEquipResult", CCallReplyEvent)
CEventPetEquipResult = CEventPetEquipResult

function CEventPetEquipResult:Constructor()
  self.nRet = 0
end

CEventPetEquipResult._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventEquipRefineLevelUp", CCallRequestEvent)
CEventEquipRefineLevelUp = CEventEquipRefineLevelUp

function CEventEquipRefineLevelUp:Constructor()
  self.pet_pstid = 0
end

CEventEquipRefineLevelUp._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventEquipRefineLevelUpReply", CCallReplyEvent)
CEventEquipRefineLevelUpReply = CEventEquipRefineLevelUpReply

function CEventEquipRefineLevelUpReply:Constructor()
  self.nRet = 0
end

CEventEquipRefineLevelUpReply._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventDelNewpetMark", CCallRequestEvent)
CEventDelNewpetMark = CEventDelNewpetMark

function CEventDelNewpetMark:Constructor()
  self.template_id = 0
end

CEventDelNewpetMark._proto = {
  [1] = {
    "template_id",
    "int"
  }
}
_class("CEventDelNewpetMarkResult", CCallReplyEvent)
CEventDelNewpetMarkResult = CEventDelNewpetMarkResult

function CEventDelNewpetMarkResult:Constructor()
  self.ret = 0
  self.new_pet_list = {}
end

CEventDelNewpetMarkResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "new_pet_list",
    "list<int>"
  }
}
_class("CEventRequestPetAddAffinity", CCallRequestEvent)
CEventRequestPetAddAffinity = CEventRequestPetAddAffinity

function CEventRequestPetAddAffinity:Constructor()
  self.pet_pstid = 0
end

CEventRequestPetAddAffinity._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventReplyPetAddAffinityResult", CCallReplyEvent)
CEventReplyPetAddAffinityResult = CEventReplyPetAddAffinityResult

function CEventReplyPetAddAffinityResult:Constructor()
  self.m_result = 0
  self.m_aff_add_count = 0
end

CEventReplyPetAddAffinityResult._proto = {
  [1] = {"m_result", "int"},
  [2] = {
    "m_aff_add_count",
    "int"
  }
}
_class("CEventRequestPetViewTriggeredStory", CCallRequestEvent)
CEventRequestPetViewTriggeredStory = CEventRequestPetViewTriggeredStory

function CEventRequestPetViewTriggeredStory:Constructor()
  self.pet_pstid = 0
  self.story_event_type = 0
  self.story_event_id = 0
end

CEventRequestPetViewTriggeredStory._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {
    "story_event_type",
    "int"
  },
  [3] = {
    "story_event_id",
    "int"
  }
}
_class("CEventReplyPetViewTriggeredStory", CCallReplyEvent)
CEventReplyPetViewTriggeredStory = CEventReplyPetViewTriggeredStory

function CEventReplyPetViewTriggeredStory:Constructor()
  self.m_result = 0
  self.m_story_id = 0
end

CEventReplyPetViewTriggeredStory._proto = {
  [1] = {"m_result", "int"},
  [2] = {"m_story_id", "int"}
}
_class("CEventRequestPetFinishTriggeredStory", CCallRequestEvent)
CEventRequestPetFinishTriggeredStory = CEventRequestPetFinishTriggeredStory

function CEventRequestPetFinishTriggeredStory:Constructor()
  self.pet_pstid = 0
  self.story_event_type = 0
  self.story_event_id = 0
end

CEventRequestPetFinishTriggeredStory._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {
    "story_event_type",
    "int"
  },
  [3] = {
    "story_event_id",
    "int"
  }
}
_class("CEventReplyPetFinishTriggeredStory", CCallReplyEvent)
CEventReplyPetFinishTriggeredStory = CEventReplyPetFinishTriggeredStory

function CEventReplyPetFinishTriggeredStory:Constructor()
  self.m_result = 0
  self.affinity = 0
  self.reward = {}
end

CEventReplyPetFinishTriggeredStory._proto = {
  [1] = {"m_result", "int"},
  [2] = {"affinity", "int"},
  [3] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("CEventRequestPetViewTriggeredTask", CCallRequestEvent)
CEventRequestPetViewTriggeredTask = CEventRequestPetViewTriggeredTask

function CEventRequestPetViewTriggeredTask:Constructor()
  self.pet_pstid = 0
end

CEventRequestPetViewTriggeredTask._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventReplyPetViewTriggeredTask", CCallReplyEvent)
CEventReplyPetViewTriggeredTask = CEventReplyPetViewTriggeredTask

function CEventReplyPetViewTriggeredTask:Constructor()
  self.m_result = 0
  self.m_story_id = 0
end

CEventReplyPetViewTriggeredTask._proto = {
  [1] = {"m_result", "int"},
  [2] = {"m_story_id", "int"}
}
_class("CEventRequestPetAcceptTriggeredTask", CCallRequestEvent)
CEventRequestPetAcceptTriggeredTask = CEventRequestPetAcceptTriggeredTask

function CEventRequestPetAcceptTriggeredTask:Constructor()
  self.pet_pstid = 0
end

CEventRequestPetAcceptTriggeredTask._proto = {
  [1] = {"pet_pstid", "int64"}
}
_class("CEventReplyPetAcceptTriggeredTask", CCallReplyEvent)
CEventReplyPetAcceptTriggeredTask = CEventReplyPetAcceptTriggeredTask

function CEventReplyPetAcceptTriggeredTask:Constructor()
  self.m_result = 0
  self.task_id = 0
  self.affinity = 0
  self.m_pet_task_info = PetTaskInfo:New()
  self.reward = {}
end

CEventReplyPetAcceptTriggeredTask._proto = {
  [1] = {"m_result", "int"},
  [2] = {"task_id", "int"},
  [3] = {"affinity", "int"},
  [4] = {
    "m_pet_task_info",
    "PetTaskInfo"
  },
  [5] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("CEventRequestGivePetPresent", CCallRequestEvent)
CEventRequestGivePetPresent = CEventRequestGivePetPresent

function CEventRequestGivePetPresent:Constructor()
  self.pet_pstid = 0
  self.items = {}
end

CEventRequestGivePetPresent._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {
    "items",
    "list<ItemAsset>"
  }
}
_class("CEventReplyGivePetPresent", CCallReplyEvent)
CEventReplyGivePetPresent = CEventReplyGivePetPresent

function CEventReplyGivePetPresent:Constructor()
  self.m_result = 0
  self.m_task_ids = {}
  self.trigger_story_event_id = 0
end

CEventReplyGivePetPresent._proto = {
  [1] = {"m_result", "int"},
  [2] = {"m_task_ids", "list<int>"},
  [3] = {
    "trigger_story_event_id",
    "int"
  }
}
_class("CEventNotifyPetChange", CSvrPushEvent)
CEventNotifyPetChange = CEventNotifyPetChange

function CEventNotifyPetChange:Constructor()
  self.data = {}
end

CEventNotifyPetChange._proto = {
  [1] = {
    "data",
    "map<int64,pet_data>"
  }
}
_class("CEventNotifyAffinityAddCount", CSvrPushEvent)
CEventNotifyAffinityAddCount = CEventNotifyAffinityAddCount

function CEventNotifyAffinityAddCount:Constructor()
  self.left_count = 0
  self.max_count = 0
end

CEventNotifyAffinityAddCount._proto = {
  [1] = {"left_count", "int"},
  [2] = {"max_count", "int"}
}
_class("CEventUpdateNewPetList", CSvrPushEvent)
CEventUpdateNewPetList = CEventUpdateNewPetList

function CEventUpdateNewPetList:Constructor()
  self.new_pet_list = {}
end

CEventUpdateNewPetList._proto = {
  [1] = {
    "new_pet_list",
    "list<int>"
  }
}
_class("CEventRequestPetTaskReward", CCallRequestEvent)
CEventRequestPetTaskReward = CEventRequestPetTaskReward

function CEventRequestPetTaskReward:Constructor()
  self.pet_pstid = 0
  self.task_uid = 0
end

CEventRequestPetTaskReward._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {"task_uid", "int64"}
}
_class("CEventReplyPetTaskReward", CCallReplyEvent)
CEventReplyPetTaskReward = CEventReplyPetTaskReward

function CEventReplyPetTaskReward:Constructor()
  self.m_result = 0
  self.task_id = 0
  self.affinity = 0
  self.reward = {}
end

CEventReplyPetTaskReward._proto = {
  [1] = {"m_result", "int"},
  [2] = {"task_id", "int"},
  [3] = {"affinity", "int"},
  [4] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("CEventPetUnlockCG", CCallRequestEvent)
CEventPetUnlockCG = CEventPetUnlockCG

function CEventPetUnlockCG:Constructor()
  self.skin_id = 0
end

CEventPetUnlockCG._proto = {
  [1] = {"skin_id", "int"}
}
_class("CEventPetUnlockCGResult", CCallReplyEvent)
CEventPetUnlockCGResult = CEventPetUnlockCGResult

function CEventPetUnlockCGResult:Constructor()
  self.nRet = 0
  self.pet_template_id = 0
  self.pet_skin_id = 0
end

CEventPetUnlockCGResult._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "pet_template_id",
    "int"
  },
  [3] = {
    "pet_skin_id",
    "int"
  }
}
_class("CEventPetSkinChange", CCallRequestEvent)
CEventPetSkinChange = CEventPetSkinChange

function CEventPetSkinChange:Constructor()
  self.skin_id = 0
end

CEventPetSkinChange._proto = {
  [1] = {"skin_id", "int"}
}
_class("CEventPetSkinChangeResult", CCallReplyEvent)
CEventPetSkinChangeResult = CEventPetSkinChangeResult

function CEventPetSkinChangeResult:Constructor()
  self.nRet = 0
  self.pet_template_id = 0
  self.pet_current_skin_id = 0
end

CEventPetSkinChangeResult._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "pet_template_id",
    "int"
  },
  [3] = {
    "pet_current_skin_id",
    "int"
  }
}
_class("CEventNotifyPetSkinChange", CSvrPushEvent)
CEventNotifyPetSkinChange = CEventNotifyPetSkinChange

function CEventNotifyPetSkinChange:Constructor()
  self.data = {}
end

CEventNotifyPetSkinChange._proto = {
  [1] = {
    "data",
    "map<int,pet_skin_data>"
  }
}
_class("CEventClickPetEquipRefine", CCliPushEvent)
CEventClickPetEquipRefine = CEventClickPetEquipRefine

function CEventClickPetEquipRefine:Constructor()
end

CEventClickPetEquipRefine._proto = {}
_class("CEventPropertyCultivateInfo", CCallRequestEvent)
CEventPropertyCultivateInfo = CEventPropertyCultivateInfo

function CEventPropertyCultivateInfo:Constructor()
end

CEventPropertyCultivateInfo._proto = {}
_class("CEventPropertyCultivateInfoResult", CCallReplyEvent)
CEventPropertyCultivateInfoResult = CEventPropertyCultivateInfoResult

function CEventPropertyCultivateInfoResult:Constructor()
  self.info = property_cultivate_data:New()
end

CEventPropertyCultivateInfoResult._proto = {
  [1] = {
    "info",
    "property_cultivate_data"
  }
}
_class("CEventPropertyCultivateLv", CCallRequestEvent)
CEventPropertyCultivateLv = CEventPropertyCultivateLv

function CEventPropertyCultivateLv:Constructor()
  self.smelts = {}
  self.cfg_id = {}
end

CEventPropertyCultivateLv._proto = {
  [1] = {
    "smelts",
    "list<RoleAsset>"
  },
  [2] = {"cfg_id", "list<int>"}
}
_class("CEventPropertyCultivateLvResult", CCallReplyEvent)
CEventPropertyCultivateLvResult = CEventPropertyCultivateLvResult

function CEventPropertyCultivateLvResult:Constructor()
  self.ret = 0
  self.info = property_cultivate_data:New()
end

CEventPropertyCultivateLvResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "property_cultivate_data"
  }
}
_class("CEventLockAwake", CCallRequestEvent)
CEventLockAwake = CEventLockAwake

function CEventLockAwake:Constructor()
  self.pet_pstid = 0
  self.lv = 0
end

CEventLockAwake._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {"lv", "int"}
}
_class("CEventLockAwakeResult", CCallReplyEvent)
CEventLockAwakeResult = CEventLockAwakeResult

function CEventLockAwakeResult:Constructor()
  self.ret = 0
end

CEventLockAwakeResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventPetLike", CCallRequestEvent)
CEventPetLike = CEventPetLike

function CEventPetLike:Constructor()
  self.pet_pstid = 0
  self.b_like = false
end

CEventPetLike._proto = {
  [1] = {"pet_pstid", "int64"},
  [2] = {"b_like", "bool"}
}
_class("CEventPetLikeReply", CCallReplyEvent)
CEventPetLikeReply = CEventPetLikeReply

function CEventPetLikeReply:Constructor()
  self.nRet = 0
end

CEventPetLikeReply._proto = {
  [1] = {"nRet", "int"}
}
