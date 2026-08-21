require("campaign_info")
_class("ICampaignComponentInfo", Object)
ICampaignComponentInfo = ICampaignComponentInfo

function ICampaignComponentInfo:Constructor()
  self.m_campaign_id = 0
  self.m_component_type = 0
  self.m_component_id = 0
  self.m_component_step = 0
  self.m_b_unlock = false
  self.m_unlock_time = 0
  self.m_unlock_items = {}
  self.m_open_time = 0
  self.m_close_time = 0
  self.m_need_mission_type = 0
  self.m_need_mission_id = 0
  self.m_first_story_id = 0
end

ICampaignComponentInfo._proto = {
  [1] = {
    "m_campaign_id",
    "int"
  },
  [2] = {
    "m_component_type",
    "int"
  },
  [3] = {
    "m_component_id",
    "int"
  },
  [4] = {
    "m_component_step",
    "int"
  },
  [5] = {"m_b_unlock", "bool"},
  [6] = {
    "m_unlock_time",
    "time"
  },
  [7] = {
    "m_unlock_items",
    "list<RoleAsset>"
  },
  [8] = {
    "m_open_time",
    "time"
  },
  [9] = {
    "m_close_time",
    "time"
  },
  [10] = {
    "m_need_mission_type",
    "int"
  },
  [11] = {
    "m_need_mission_id",
    "int"
  },
  [12] = {
    "m_first_story_id",
    "int"
  }
}
_class("ICampaignComRequest", Object)
ICampaignComRequest = ICampaignComRequest

function ICampaignComRequest:Constructor()
end

ICampaignComRequest._proto = {}
_class("ICampaignComResponse", Object)
ICampaignComResponse = ICampaignComResponse

function ICampaignComResponse:Constructor()
end

ICampaignComResponse._proto = {}
_class("CCommonBaseComponentDataInfo", ICampaignComponentDataInfo)
CCommonBaseComponentDataInfo = CCommonBaseComponentDataInfo

function CCommonBaseComponentDataInfo:Constructor()
end

CCommonBaseComponentDataInfo._proto = {}
_class("CommonBaseComponentInfo", ICampaignComponentInfo)
CommonBaseComponentInfo = CommonBaseComponentInfo

function CommonBaseComponentInfo:Constructor()
end

CommonBaseComponentInfo._proto = {}
_class("LineFormationItem", Object)
LineFormationItem = LineFormationItem

function LineFormationItem:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

LineFormationItem._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("CLineMissionComponentDataInfo", ICampaignComponentDataInfo)
CLineMissionComponentDataInfo = CLineMissionComponentDataInfo

function CLineMissionComponentDataInfo:Constructor()
  self.m_cur_mission = 0
  self.m_pass_mission_info = {}
  self.formation_list = {}
end

CLineMissionComponentDataInfo._proto = {
  [1] = {
    "m_cur_mission",
    "int"
  },
  [2] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [3] = {
    "formation_list",
    "list<LineFormationItem>"
  }
}
_class("LineMissionComponentInfo", ICampaignComponentInfo)
LineMissionComponentInfo = LineMissionComponentInfo

function LineMissionComponentInfo:Constructor()
  self.m_cur_mission = 0
  self.m_pass_mission_info = {}
  self.formation_list = {}
end

LineMissionComponentInfo._proto = {
  [1] = {
    "m_cur_mission",
    "int"
  },
  [2] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [3] = {
    "formation_list",
    "list<LineFormationItem>"
  }
}
_class("CompleteStoryMissionReq", ICampaignComRequest)
CompleteStoryMissionReq = CompleteStoryMissionReq

function CompleteStoryMissionReq:Constructor()
  self.m_create_info = CampaignMissionCreateInfo:New()
end

CompleteStoryMissionReq._proto = {
  [1] = {
    "m_create_info",
    "CampaignMissionCreateInfo"
  }
}
_class("CompleteStoryMissionRep", ICampaignComResponse)
CompleteStoryMissionRep = CompleteStoryMissionRep

function CompleteStoryMissionRep:Constructor()
  self.nErrorCode = 0
  self.reward = {}
end

CompleteStoryMissionRep._proto = {
  [1] = {"nErrorCode", "int"},
  [2] = {
    "reward",
    "list<RoleAsset>"
  }
}
local LineMissionComponentNotifyType = {LineMissionComponentNotifyType_InfoChanged = 1}
_enum("LineMissionComponentNotifyType", LineMissionComponentNotifyType)
_class("NotifyLineMissionComponentInfoChanged", Object)
NotifyLineMissionComponentInfoChanged = NotifyLineMissionComponentInfoChanged

function NotifyLineMissionComponentInfoChanged:Constructor()
  self.m_cur_mission = 0
  self.m_update_mission_info = {}
end

NotifyLineMissionComponentInfoChanged._proto = {
  [1] = {
    "m_cur_mission",
    "int"
  },
  [2] = {
    "m_update_mission_info",
    "map<int,cam_mission_info>"
  }
}
_class("CTreeMissionComponentDataInfo", ICampaignComponentDataInfo)
CTreeMissionComponentDataInfo = CTreeMissionComponentDataInfo

function CTreeMissionComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
end

CTreeMissionComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  }
}
_class("TreeMissionComponentInfo", ICampaignComponentInfo)
TreeMissionComponentInfo = TreeMissionComponentInfo

function TreeMissionComponentInfo:Constructor()
  self.m_pass_mission_info = {}
end

TreeMissionComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  }
}
local TreeMissionComponentNotifyType = {TreeMissionComponentNotifyType_InfoChanged = 1}
_enum("TreeMissionComponentNotifyType", TreeMissionComponentNotifyType)
_class("NotifyTreeMissionComponentInfoChanged", Object)
NotifyTreeMissionComponentInfoChanged = NotifyTreeMissionComponentInfoChanged

function NotifyTreeMissionComponentInfoChanged:Constructor()
  self.m_update_mission_info = {}
end

NotifyTreeMissionComponentInfoChanged._proto = {
  [1] = {
    "m_update_mission_info",
    "map<int,cam_mission_info>"
  }
}
_class("CompleteStoryTreeMissionReq", ICampaignComRequest)
CompleteStoryTreeMissionReq = CompleteStoryTreeMissionReq

function CompleteStoryTreeMissionReq:Constructor()
  self.m_create_info = CampaignMissionCreateInfo:New()
end

CompleteStoryTreeMissionReq._proto = {
  [1] = {
    "m_create_info",
    "CampaignMissionCreateInfo"
  }
}
_class("CompleteStoryTreeMissionRep", ICampaignComResponse)
CompleteStoryTreeMissionRep = CompleteStoryTreeMissionRep

function CompleteStoryTreeMissionRep:Constructor()
  self.nErrorCode = 0
  self.reward = {}
end

CompleteStoryTreeMissionRep._proto = {
  [1] = {"nErrorCode", "int"},
  [2] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("CCombatSimulatorComponentDataInfo", ICampaignComponentDataInfo)
CCombatSimulatorComponentDataInfo = CCombatSimulatorComponentDataInfo

function CCombatSimulatorComponentDataInfo:Constructor()
  self.cartridge_use_times = {}
  self.open_cartridge_gift_times = 0
  self.last_cartridge_reset_time = 0
  self.m_pass_mission_info = {}
end

CCombatSimulatorComponentDataInfo._proto = {
  [1] = {
    "cartridge_use_times",
    "map<int,int>"
  },
  [2] = {
    "open_cartridge_gift_times",
    "int"
  },
  [3] = {
    "last_cartridge_reset_time",
    "time"
  },
  [4] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  }
}
_class("CCombatSimulatorComponentInfo", ICampaignComponentInfo)
CCombatSimulatorComponentInfo = CCombatSimulatorComponentInfo

function CCombatSimulatorComponentInfo:Constructor()
  self.create_cartridge_tick_sec = 0
  self.cartridge_gift_template_id = 0
  self.max_cartridge_num = 0
  self.next_gift_time = 0
end

CCombatSimulatorComponentInfo._proto = {
  [1] = {
    "create_cartridge_tick_sec",
    "int"
  },
  [2] = {
    "cartridge_gift_template_id",
    "int"
  },
  [3] = {
    "max_cartridge_num",
    "int"
  },
  [4] = {
    "next_gift_time",
    "time"
  }
}
_class("CombatSimulatorComponentRefreshReq", ICampaignComRequest)
CombatSimulatorComponentRefreshReq = CombatSimulatorComponentRefreshReq

function CombatSimulatorComponentRefreshReq:Constructor()
end

CombatSimulatorComponentRefreshReq._proto = {}
_class("CombatSimulatorComponentRefreshRep", ICampaignComResponse)
CombatSimulatorComponentRefreshRep = CombatSimulatorComponentRefreshRep

function CombatSimulatorComponentRefreshRep:Constructor()
  self.next_gift_time = 0
end

CombatSimulatorComponentRefreshRep._proto = {
  [1] = {
    "next_gift_time",
    "time"
  }
}
_class("CombatSimulatorComponentOpenGiftReq", ICampaignComRequest)
CombatSimulatorComponentOpenGiftReq = CombatSimulatorComponentOpenGiftReq

function CombatSimulatorComponentOpenGiftReq:Constructor()
end

CombatSimulatorComponentOpenGiftReq._proto = {}
_class("CombatSimulatorComponentOpenGiftRep", ICampaignComResponse)
CombatSimulatorComponentOpenGiftRep = CombatSimulatorComponentOpenGiftRep

function CombatSimulatorComponentOpenGiftRep:Constructor()
  self.item_template_id = 0
end

CombatSimulatorComponentOpenGiftRep._proto = {
  [1] = {
    "item_template_id",
    "int"
  }
}
_class("CombatSimulatorComponentDelCartridgeReq", ICampaignComRequest)
CombatSimulatorComponentDelCartridgeReq = CombatSimulatorComponentDelCartridgeReq

function CombatSimulatorComponentDelCartridgeReq:Constructor()
  self.cartridge_pst_id = 0
end

CombatSimulatorComponentDelCartridgeReq._proto = {
  [1] = {
    "cartridge_pst_id",
    "int64"
  }
}
_class("CombatSimulatorComponentDelCartridgeRep", ICampaignComResponse)
CombatSimulatorComponentDelCartridgeRep = CombatSimulatorComponentDelCartridgeRep

function CombatSimulatorComponentDelCartridgeRep:Constructor()
end

CombatSimulatorComponentDelCartridgeRep._proto = {}
_class("CSummerIIMissionComponentDataInfo", ICampaignComponentDataInfo)
CSummerIIMissionComponentDataInfo = CSummerIIMissionComponentDataInfo

function CSummerIIMissionComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_formation_info = {}
  self.m_select_affix = {}
  self.m_pass_afix = {}
  self.m_select_hard = {}
  self.m_pass_hard = {}
end

CSummerIIMissionComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_formation_info",
    "map<int,list<int64>>"
  },
  [3] = {
    "m_select_affix",
    "map<int,list<int>>"
  },
  [4] = {
    "m_pass_afix",
    "map<int,list<int>>"
  },
  [5] = {
    "m_select_hard",
    "map<int,int>"
  },
  [6] = {
    "m_pass_hard",
    "map<int,int>"
  }
}
_class("SummerIIMissionComponentInfo", ICampaignComponentInfo)
SummerIIMissionComponentInfo = SummerIIMissionComponentInfo

function SummerIIMissionComponentInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_formation_info = {}
  self.m_select_affix = {}
  self.m_pass_afix = {}
  self.m_mission_unlock_time = {}
  self.m_select_hard = {}
  self.m_pass_hard = {}
end

SummerIIMissionComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_formation_info",
    "map<int,list<int64>>"
  },
  [3] = {
    "m_select_affix",
    "map<int,list<int>>"
  },
  [4] = {
    "m_pass_afix",
    "map<int,list<int>>"
  },
  [5] = {
    "m_mission_unlock_time",
    "map<int,time>"
  },
  [6] = {
    "m_select_hard",
    "map<int,int>"
  },
  [7] = {
    "m_pass_hard",
    "map<int,int>"
  }
}
local ESummerIIMissionElementType = {
  ESummerIIMissionElementType_None = 0,
  ESummerIIMissionElementType_Blue = 1,
  ESummerIIMissionElementType_Red = 2,
  ESummerIIMissionElementType_Green = 3,
  ESummerIIMissionElementType_Yellow = 4,
  ESummerIIMissionElementType_Boss = 5
}
_enum("ESummerIIMissionElementType", ESummerIIMissionElementType)
local SummerIIMissionComponentNotifyType = {SummerIIMissionComponentNotifyType_InfoChanged = 1}
_enum("SummerIIMissionComponentNotifyType", SummerIIMissionComponentNotifyType)
_class("NotifySummerIIMissionComponentInfoChanged", Object)
NotifySummerIIMissionComponentInfoChanged = NotifySummerIIMissionComponentInfoChanged

function NotifySummerIIMissionComponentInfoChanged:Constructor()
  self.m_update_mission_info = {}
  self.m_update_pass_afix = {}
  self.m_update_pass_hard = {}
end

NotifySummerIIMissionComponentInfoChanged._proto = {
  [1] = {
    "m_update_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_update_pass_afix",
    "map<int,list<int>>"
  },
  [3] = {
    "m_update_pass_hard",
    "map<int,int>"
  }
}
_class("CompleteStorySummerIIMissionReq", ICampaignComRequest)
CompleteStorySummerIIMissionReq = CompleteStorySummerIIMissionReq

function CompleteStorySummerIIMissionReq:Constructor()
  self.m_create_info = CampaignMissionCreateInfo:New()
end

CompleteStorySummerIIMissionReq._proto = {
  [1] = {
    "m_create_info",
    "CampaignMissionCreateInfo"
  }
}
_class("CompleteStorySummerIIMissionRep", ICampaignComResponse)
CompleteStorySummerIIMissionRep = CompleteStorySummerIIMissionRep

function CompleteStorySummerIIMissionRep:Constructor()
  self.nErrorCode = 0
  self.reward = {}
end

CompleteStorySummerIIMissionRep._proto = {
  [1] = {"nErrorCode", "int"},
  [2] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("SummerIISelectAffixReq", ICampaignComRequest)
SummerIISelectAffixReq = SummerIISelectAffixReq

function SummerIISelectAffixReq:Constructor()
  self.nCampaignMissionId = 0
  self.SelectAffixIdArray = {}
  self.nHardId = 0
end

SummerIISelectAffixReq._proto = {
  [1] = {
    "nCampaignMissionId",
    "int"
  },
  [2] = {
    "SelectAffixIdArray",
    "list<int>"
  },
  [3] = {"nHardId", "int"}
}
_class("SummerIISelectAffixRep", ICampaignComResponse)
SummerIISelectAffixRep = SummerIISelectAffixRep

function SummerIISelectAffixRep:Constructor()
end

SummerIISelectAffixRep._proto = {}
_class("SummerIIChangeFormationReq", ICampaignComRequest)
SummerIIChangeFormationReq = SummerIIChangeFormationReq

function SummerIIChangeFormationReq:Constructor()
  self.nElementType = 0
  self.formation_pet_list = {}
end

SummerIIChangeFormationReq._proto = {
  [1] = {
    "nElementType",
    "int"
  },
  [2] = {
    "formation_pet_list",
    "list<int64>"
  }
}
_class("SummerIIChangeFormationRep", ICampaignComResponse)
SummerIIChangeFormationRep = SummerIIChangeFormationRep

function SummerIIChangeFormationRep:Constructor()
  self.nFormationRet = 0
end

SummerIIChangeFormationRep._proto = {
  [1] = {
    "nFormationRet",
    "int"
  }
}
local CamQuestComponentNotifyType = {CamQuestComponentNotify_DailyReset = 1, QuestListComponentNotifyScore = 2}
_enum("CamQuestComponentNotifyType", CamQuestComponentNotifyType)
_class("QuestTimeParamInfo", Object)
QuestTimeParamInfo = QuestTimeParamInfo

function QuestTimeParamInfo:Constructor()
  self.m_open_time = 0
  self.m_end_time = 0
  self.m_need_daily_reset = false
end

QuestTimeParamInfo._proto = {
  [1] = {
    "m_open_time",
    "time"
  },
  [2] = {"m_end_time", "time"},
  [3] = {
    "m_need_daily_reset",
    "bool"
  }
}
_class("CamQuestComponentInfo", ICampaignComponentInfo)
CamQuestComponentInfo = CamQuestComponentInfo

function CamQuestComponentInfo:Constructor()
  self.m_accept_cam_quest_list = {}
  self.m_quest_time_param_map = {}
end

CamQuestComponentInfo._proto = {
  [1] = {
    "m_accept_cam_quest_list",
    "list<int>"
  },
  [2] = {
    "m_quest_time_param_map",
    "map<int,QuestTimeParamInfo>"
  }
}
_class("CamQuestTakeReq", ICampaignComRequest)
CamQuestTakeReq = CamQuestTakeReq

function CamQuestTakeReq:Constructor()
  self.id = 0
end

CamQuestTakeReq._proto = {
  [1] = {"id", "int"}
}
_class("CamQuestTakeRep", ICampaignComResponse)
CamQuestTakeRep = CamQuestTakeRep

function CamQuestTakeRep:Constructor()
  self.ret = 0
  self.rewards = {}
end

CamQuestTakeRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("CamOneKeyQuestTakeReq", ICampaignComRequest)
CamOneKeyQuestTakeReq = CamOneKeyQuestTakeReq

function CamOneKeyQuestTakeReq:Constructor()
end

CamOneKeyQuestTakeReq._proto = {}
_class("CamOneKeyQuestTakeRsp", ICampaignComResponse)
CamOneKeyQuestTakeRsp = CamOneKeyQuestTakeRsp

function CamOneKeyQuestTakeRsp:Constructor()
  self.ret = 0
  self.rewards = {}
end

CamOneKeyQuestTakeRsp._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("CamQuestDailyResetReq", ICampaignComRequest)
CamQuestDailyResetReq = CamQuestDailyResetReq

function CamQuestDailyResetReq:Constructor()
end

CamQuestDailyResetReq._proto = {}
_class("CamQuestDailyResetRep", ICampaignComResponse)
CamQuestDailyResetRep = CamQuestDailyResetRep

function CamQuestDailyResetRep:Constructor()
  self.m_reset_quest_map = {}
end

CamQuestDailyResetRep._proto = {
  [1] = {
    "m_reset_quest_map",
    "map<int,time>"
  }
}
_class("NotifyCamQuesetComponentDailyReset", Object)
NotifyCamQuesetComponentDailyReset = NotifyCamQuesetComponentDailyReset

function NotifyCamQuesetComponentDailyReset:Constructor()
  self.m_reset_quest_map = {}
end

NotifyCamQuesetComponentDailyReset._proto = {
  [1] = {
    "m_reset_quest_map",
    "map<int,time>"
  }
}
_class("DemoComponentDataInfo", ICampaignComponentDataInfo)
DemoComponentDataInfo = DemoComponentDataInfo

function DemoComponentDataInfo:Constructor()
  self.m_num = 1
  self.last_refresh_time = 0
end

DemoComponentDataInfo._proto = {
  [1] = {"m_num", "int"},
  [2] = {
    "last_refresh_time",
    "time"
  }
}
_class("DemoComponentInfo", ICampaignComponentInfo)
DemoComponentInfo = DemoComponentInfo

function DemoComponentInfo:Constructor()
  self.m_num = 0
end

DemoComponentInfo._proto = {
  [1] = {"m_num", "int"}
}
_class("DemoComponentReq", ICampaignComRequest)
DemoComponentReq = DemoComponentReq

function DemoComponentReq:Constructor()
  self.m_req = 0
end

DemoComponentReq._proto = {
  [1] = {"m_req", "int"}
}
_class("DemoComponentRep", ICampaignComResponse)
DemoComponentRep = DemoComponentRep

function DemoComponentRep:Constructor()
  self.m_rep = 0
end

DemoComponentRep._proto = {
  [1] = {"m_rep", "int"}
}
local ExchangeItemCountType = {ExchangeItemComponent_Infinity = -1}
_enum("ExchangeItemCountType", ExchangeItemCountType)
_class("CExchangeItemComponentDataInfo", ICampaignComponentDataInfo)
CExchangeItemComponentDataInfo = CExchangeItemComponentDataInfo

function CExchangeItemComponentDataInfo:Constructor()
  self.m_item_exchange_count = {}
  self.m_exchange_cost_coin = 0
end

CExchangeItemComponentDataInfo._proto = {
  [1] = {
    "m_item_exchange_count",
    "map<int,int>"
  },
  [2] = {
    "m_exchange_cost_coin",
    "int64"
  }
}
_class("ExchangeItemComponentItemInfo", Object)
ExchangeItemComponentItemInfo = ExchangeItemComponentItemInfo

function ExchangeItemComponentItemInfo:Constructor()
  self.m_id = 0
  self.m_unlock_time = 0
  self.m_reward = RoleAsset:New()
  self.m_exchange_limit_count = 0
  self.m_cost_item_id = 0
  self.m_cost_count = 0
  self.m_can_exchange_count = 0
  self.m_is_special = false
  self.m_is_show_red_point = false
  self.m_unlock_cost_item = {}
  self.m_add_baguum = false
end

ExchangeItemComponentItemInfo._proto = {
  [1] = {"m_id", "int"},
  [2] = {
    "m_unlock_time",
    "time"
  },
  [3] = {"m_reward", "RoleAsset"},
  [4] = {
    "m_exchange_limit_count",
    "int"
  },
  [5] = {
    "m_cost_item_id",
    "int"
  },
  [6] = {
    "m_cost_count",
    "int64"
  },
  [7] = {
    "m_can_exchange_count",
    "int"
  },
  [8] = {
    "m_is_special",
    "bool"
  },
  [9] = {
    "m_is_show_red_point",
    "bool"
  },
  [10] = {
    "m_unlock_cost_item",
    "map<int,int64>"
  },
  [11] = {
    "m_add_baguum",
    "bool"
  }
}
_class("ExchangeItemComponentInfo", ICampaignComponentInfo)
ExchangeItemComponentInfo = ExchangeItemComponentInfo

function ExchangeItemComponentInfo:Constructor()
  self.m_exchange_item_list = {}
end

ExchangeItemComponentInfo._proto = {
  [1] = {
    "m_exchange_item_list",
    "list<ExchangeItemComponentItemInfo>"
  }
}
_class("ExchangeItemComponentExchangeReq", ICampaignComRequest)
ExchangeItemComponentExchangeReq = ExchangeItemComponentExchangeReq

function ExchangeItemComponentExchangeReq:Constructor()
  self.m_exchange_item_id = 0
  self.m_exchange_count = 1
end

ExchangeItemComponentExchangeReq._proto = {
  [1] = {
    "m_exchange_item_id",
    "int"
  },
  [2] = {
    "m_exchange_count",
    "int"
  }
}
_class("ExchangeItemComponentExchangeRep", ICampaignComResponse)
ExchangeItemComponentExchangeRep = ExchangeItemComponentExchangeRep

function ExchangeItemComponentExchangeRep:Constructor()
  self.m_rewards = {}
  self.m_exchange_info = ExchangeItemComponentInfo:New()
  self.m_step = 0
end

ExchangeItemComponentExchangeRep._proto = {
  [1] = {
    "m_rewards",
    "list<RoleAsset>"
  },
  [2] = {
    "m_exchange_info",
    "ExchangeItemComponentInfo"
  },
  [3] = {"m_step", "int"}
}
local PersonProgressComponentNotifyType = {PersonProgressComponentNotify_StepChanged = 1}
_enum("PersonProgressComponentNotifyType", PersonProgressComponentNotifyType)
_class("CPersonProgressComponentDataInfo", ICampaignComponentDataInfo)
CPersonProgressComponentDataInfo = CPersonProgressComponentDataInfo

function CPersonProgressComponentDataInfo:Constructor()
  self.m_received_progress = {}
  self.m_progress = 0
  self.m_mark = 0
  self.m_mark_else = 0
end

CPersonProgressComponentDataInfo._proto = {
  [1] = {
    "m_received_progress",
    "list<int64>"
  },
  [2] = {"m_progress", "int"},
  [3] = {"m_mark", "int64"},
  [4] = {
    "m_mark_else",
    "int64"
  }
}
_class("PersonProgressComponentInfo", ICampaignComponentInfo)
PersonProgressComponentInfo = PersonProgressComponentInfo

function PersonProgressComponentInfo:Constructor()
  self.m_item_id = 0
  self.m_current_progress = 0
  self.m_received_progress = {}
  self.m_progress_rewards = {}
  self.m_special_rewards = {}
  self.m_lv_limit = 0
  self.m_progress = 0
  self.m_mark = 0
  self.m_mark_else = 0
end

PersonProgressComponentInfo._proto = {
  [1] = {"m_item_id", "int"},
  [2] = {
    "m_current_progress",
    "int64"
  },
  [3] = {
    "m_received_progress",
    "list<int64>"
  },
  [4] = {
    "m_progress_rewards",
    "map<int64,list<RoleAsset>>"
  },
  [5] = {
    "m_special_rewards",
    "map<int64,list<RoleAsset>>"
  },
  [6] = {"m_lv_limit", "int"},
  [7] = {"m_progress", "int"},
  [8] = {"m_mark", "int64"},
  [9] = {
    "m_mark_else",
    "int64"
  }
}
_class("PersonProgressComponentReceiveRewardReq", ICampaignComRequest)
PersonProgressComponentReceiveRewardReq = PersonProgressComponentReceiveRewardReq

function PersonProgressComponentReceiveRewardReq:Constructor()
  self.m_progress = 0
end

PersonProgressComponentReceiveRewardReq._proto = {
  [1] = {"m_progress", "int64"}
}
_class("PersonProgressComponentReceiveRewardRep", ICampaignComResponse)
PersonProgressComponentReceiveRewardRep = PersonProgressComponentReceiveRewardRep

function PersonProgressComponentReceiveRewardRep:Constructor()
  self.m_new_progress = 0
  self.m_rewards = {}
end

PersonProgressComponentReceiveRewardRep._proto = {
  [1] = {
    "m_new_progress",
    "int64"
  },
  [2] = {
    "m_rewards",
    "list<RoleAsset>"
  }
}
_class("PersonProgressComponentOneKeyReceiveRewardReq", ICampaignComRequest)
PersonProgressComponentOneKeyReceiveRewardReq = PersonProgressComponentOneKeyReceiveRewardReq

function PersonProgressComponentOneKeyReceiveRewardReq:Constructor()
end

PersonProgressComponentOneKeyReceiveRewardReq._proto = {}
_class("PersonProgressComponentOneKeyReceiveRewardRep", ICampaignComResponse)
PersonProgressComponentOneKeyReceiveRewardRep = PersonProgressComponentOneKeyReceiveRewardRep

function PersonProgressComponentOneKeyReceiveRewardRep:Constructor()
  self.m_new_progress = 0
  self.m_rewards = {}
end

PersonProgressComponentOneKeyReceiveRewardRep._proto = {
  [1] = {
    "m_new_progress",
    "int64"
  },
  [2] = {
    "m_rewards",
    "list<RoleAsset>"
  }
}
_class("NotifyPresonProgressComponentItemCountChanged", Object)
NotifyPresonProgressComponentItemCountChanged = NotifyPresonProgressComponentItemCountChanged

function NotifyPresonProgressComponentItemCountChanged:Constructor()
  self.m_item_count = 0
end

NotifyPresonProgressComponentItemCountChanged._proto = {
  [1] = {
    "m_item_count",
    "int64"
  }
}
_class("PersonProgressComponentCollectReq", ICampaignComRequest)
PersonProgressComponentCollectReq = PersonProgressComponentCollectReq

function PersonProgressComponentCollectReq:Constructor()
  self.m_item_num = 0
  self.m_mark = 0
  self.m_mark_else = 0
end

PersonProgressComponentCollectReq._proto = {
  [1] = {"m_item_num", "int"},
  [2] = {"m_mark", "int64"},
  [3] = {
    "m_mark_else",
    "int64"
  }
}
_class("PersonProgressComponentCollectRep", ICampaignComResponse)
PersonProgressComponentCollectRep = PersonProgressComponentCollectRep

function PersonProgressComponentCollectRep:Constructor()
  self.ret = 0
end

PersonProgressComponentCollectRep._proto = {
  [1] = {"ret", "int"}
}
local ECumulativeLoginRewardStatus = {
  E_CUMULATIVE_LOGIN_REWARD_UNKNOW = 0,
  E_CUMULATIVE_LOGIN_REWARD_CAN_RECV = 1,
  E_CUMULATIVE_LOGIN_REWARD_RECVED = 2,
  E_CUMULATIVE_LOGIN_REWARD_LOCK = 3,
  E_CUMULATIVE_LOGIN_REWARD_Expired = 4,
  E_CUMULATIVE_LOGIN_REWARD_Limit = 5
}
_enum("ECumulativeLoginRewardStatus", ECumulativeLoginRewardStatus)
_class("CCumulativeLoginComponentDataInfo", ICampaignComponentDataInfo)
CCumulativeLoginComponentDataInfo = CCumulativeLoginComponentDataInfo

function CCumulativeLoginComponentDataInfo:Constructor()
  self.m_login_days = 0
  self.m_last_refresh_time = 0
  self.m_recieved_days = {}
end

CCumulativeLoginComponentDataInfo._proto = {
  [1] = {
    "m_login_days",
    "int"
  },
  [2] = {
    "m_last_refresh_time",
    "time"
  },
  [3] = {
    "m_recieved_days",
    "list<int>"
  }
}
_class("CumulativeLoginRewardInfo", Object)
CumulativeLoginRewardInfo = CumulativeLoginRewardInfo

function CumulativeLoginRewardInfo:Constructor()
  self.m_login_days = 0
  self.m_login_unlock_time = 0
  self.m_is_special = false
  self.m_reward_status = 0
  self.m_rewards = {}
  self.m_expired_time = 0
end

CumulativeLoginRewardInfo._proto = {
  [1] = {
    "m_login_days",
    "int"
  },
  [2] = {
    "m_login_unlock_time",
    "time"
  },
  [3] = {
    "m_is_special",
    "bool"
  },
  [4] = {
    "m_reward_status",
    "int"
  },
  [5] = {
    "m_rewards",
    "list<RoleAsset>"
  },
  [6] = {
    "m_expired_time",
    "time"
  }
}
_class("CumulativeLoginComponentInfo", ICampaignComponentInfo)
CumulativeLoginComponentInfo = CumulativeLoginComponentInfo

function CumulativeLoginComponentInfo:Constructor()
  self.m_login_days = 0
  self.m_cumulative_info = {}
end

CumulativeLoginComponentInfo._proto = {
  [1] = {
    "m_login_days",
    "int"
  },
  [2] = {
    "m_cumulative_info",
    "map<int,CumulativeLoginRewardInfo>"
  }
}
_class("CumulativeLoginComponentReceiveRewardReq", ICampaignComRequest)
CumulativeLoginComponentReceiveRewardReq = CumulativeLoginComponentReceiveRewardReq

function CumulativeLoginComponentReceiveRewardReq:Constructor()
  self.m_reward_id = 0
end

CumulativeLoginComponentReceiveRewardReq._proto = {
  [1] = {
    "m_reward_id",
    "int"
  }
}
_class("CumulativeLoginComponentReceiveRewardRep", ICampaignComResponse)
CumulativeLoginComponentReceiveRewardRep = CumulativeLoginComponentReceiveRewardRep

function CumulativeLoginComponentReceiveRewardRep:Constructor()
  self.m_rewards = {}
end

CumulativeLoginComponentReceiveRewardRep._proto = {
  [1] = {
    "m_rewards",
    "list<RoleAsset>"
  }
}
local ECampaignStoryCondition = {
  E_UNLOCK = 0,
  E_CONDITION1_UNLOCK = 1,
  E_CONDITION2_UNLOCK = 2,
  E_CONDITION_ALL_LOCK = 3
}
_enum("ECampaignStoryCondition", ECampaignStoryCondition)
_class("CStoryComponentDataInfo", ICampaignComponentDataInfo)
CStoryComponentDataInfo = CStoryComponentDataInfo

function CStoryComponentDataInfo:Constructor()
  self.m_total_count = 0
  self.m_recieved_reward_story = {}
end

CStoryComponentDataInfo._proto = {
  [1] = {
    "m_total_count",
    "int64"
  },
  [2] = {
    "m_recieved_reward_story",
    "list<int>"
  }
}
_class("CStoryComponentInfo", ICampaignComponentInfo)
CStoryComponentInfo = CStoryComponentInfo

function CStoryComponentInfo:Constructor()
  self.m_total_count = 0
  self.m_recieved_reward_story = {}
  self.m_end_date_time = 0
end

CStoryComponentInfo._proto = {
  [1] = {
    "m_total_count",
    "int64"
  },
  [2] = {
    "m_recieved_reward_story",
    "list<int>"
  },
  [3] = {
    "m_end_date_time",
    "time"
  }
}
_class("StoryComponentRecvRewardReq", ICampaignComRequest)
StoryComponentRecvRewardReq = StoryComponentRecvRewardReq

function StoryComponentRecvRewardReq:Constructor()
  self.story_id = 0
end

StoryComponentRecvRewardReq._proto = {
  [1] = {"story_id", "int"}
}
_class("StoryComponentRecvRep", ICampaignComResponse)
StoryComponentRecvRep = StoryComponentRecvRep

function StoryComponentRecvRep:Constructor()
  self.rewards = {}
end

StoryComponentRecvRep._proto = {
  [1] = {
    "rewards",
    "list<RoleAsset>"
  }
}
local StoryComponentNotifyType = {StoryComponentNotifyType_PointChange = 1}
_enum("StoryComponentNotifyType", StoryComponentNotifyType)
_class("NotifyStoryComponentPointChanged", Object)
NotifyStoryComponentPointChanged = NotifyStoryComponentPointChanged

function NotifyStoryComponentPointChanged:Constructor()
  self.m_total_count = 0
end

NotifyStoryComponentPointChanged._proto = {
  [1] = {
    "m_total_count",
    "int64"
  }
}
local ECampaignLotteryType = {E_CLT_SINGLE = 0, E_CLT_MULTI = 1}
_enum("ECampaignLotteryType", ECampaignLotteryType)
local ECampaignLRType = {
  E_CLRT_common = 0,
  E_CLRT_big = 1,
  E_CLRT_rare = 2
}
_enum("ECampaignLRType", ECampaignLRType)
_class("RandomEvent", Object)
RandomEvent = RandomEvent

function RandomEvent:Constructor()
  self.event_id = 0
  self.lottery_times = 0
  self.is_unlock = false
end

RandomEvent._proto = {
  [1] = {"event_id", "int"},
  [2] = {
    "lottery_times",
    "int"
  },
  [3] = {"is_unlock", "bool"}
}
_class("AwardInfo", Object)
AwardInfo = AwardInfo

function AwardInfo:Constructor()
  self.m_award_id = 0
  self.m_item_id = 0
  self.m_count = 0
  self.m_lottery_count = 0
  self.m_weight = 0
  self.m_is_big_reward = false
  self.m_lottery_limit_count = 0
  self.m_reward_type = 0
end

AwardInfo._proto = {
  [1] = {"m_award_id", "int"},
  [2] = {"m_item_id", "int"},
  [3] = {"m_count", "int"},
  [4] = {
    "m_lottery_count",
    "int"
  },
  [5] = {"m_weight", "int"},
  [6] = {
    "m_is_big_reward",
    "bool"
  },
  [7] = {
    "m_lottery_limit_count",
    "int"
  },
  [8] = {
    "m_reward_type",
    "int"
  }
}
_class("LotteryAward", Object)
LotteryAward = LotteryAward

function LotteryAward:Constructor()
  self.m_item_id = 0
  self.m_count = 0
  self.m_is_big_reward = false
  self.m_awaid_id = 0
  self.m_reward_type = 0
end

LotteryAward._proto = {
  [1] = {"m_item_id", "int"},
  [2] = {"m_count", "int"},
  [3] = {
    "m_is_big_reward",
    "bool"
  },
  [4] = {"m_awaid_id", "int"},
  [5] = {
    "m_reward_type",
    "int"
  }
}
_class("CLotteryComponentDataInfo", ICampaignComponentDataInfo)
CLotteryComponentDataInfo = CLotteryComponentDataInfo

function CLotteryComponentDataInfo:Constructor()
  self.m_unlock_jackpots = {}
end

CLotteryComponentDataInfo._proto = {
  [1] = {
    "m_unlock_jackpots",
    "map<int,list<AwardInfo>>"
  }
}
_class("LotteryComponentInfo", ICampaignComponentInfo)
LotteryComponentInfo = LotteryComponentInfo

function LotteryComponentInfo:Constructor()
  self.m_cost_item_id = 0
  self.m_cost_count = 0
  self.m_multi_lottery = 0
  self.m_unlock_jackpots = {}
  self.m_jackpots = {}
end

LotteryComponentInfo._proto = {
  [1] = {
    "m_cost_item_id",
    "int"
  },
  [2] = {
    "m_cost_count",
    "int"
  },
  [3] = {
    "m_multi_lottery",
    "int"
  },
  [4] = {
    "m_unlock_jackpots",
    "list<int>"
  },
  [5] = {
    "m_jackpots",
    "map<int,list<AwardInfo>>"
  }
}
_class("LotteryComponentLotteryReq", ICampaignComRequest)
LotteryComponentLotteryReq = LotteryComponentLotteryReq

function LotteryComponentLotteryReq:Constructor()
  self.m_lottery_type = 0
  self.m_jackpot_index = 0
end

LotteryComponentLotteryReq._proto = {
  [1] = {
    "m_lottery_type",
    "int"
  },
  [2] = {
    "m_jackpot_index",
    "int"
  }
}
_class("LotteryComponentLotteryRep", ICampaignComResponse)
LotteryComponentLotteryRep = LotteryComponentLotteryRep

function LotteryComponentLotteryRep:Constructor()
  self.m_rewards = {}
  self.m_jackpot = {}
  self.m_is_open_new = false
  self.m_unlock_jackpot_index = 0
end

LotteryComponentLotteryRep._proto = {
  [1] = {
    "m_rewards",
    "list<LotteryAward>"
  },
  [2] = {
    "m_jackpot",
    "list<AwardInfo>"
  },
  [3] = {
    "m_is_open_new",
    "bool"
  },
  [4] = {
    "m_unlock_jackpot_index",
    "int"
  }
}
local MissionStoryType = {E_MISSION_BEGIN = 1, E_MISSION_END = 2}
_enum("MissionStoryType", MissionStoryType)
local MissionGradeType = {
  E_INVALID = 0,
  E_B = 1,
  E_A = 2,
  E_S = 4
}
_enum("MissionGradeType", MissionGradeType)
_class("MiniGameMissionInfo", Object)
MiniGameMissionInfo = MiniGameMissionInfo

function MiniGameMissionInfo:Constructor()
  self.max_score = 0
  self.story_mask = 0
  self.reward_mask = 0
  self.mission_grade = 0
end

MiniGameMissionInfo._proto = {
  [1] = {"max_score", "int"},
  [2] = {"story_mask", "int"},
  [3] = {
    "reward_mask",
    "int"
  },
  [4] = {
    "mission_grade",
    "int"
  }
}
_class("CMiniGameComponentDataInfo", ICampaignComponentDataInfo)
CMiniGameComponentDataInfo = CMiniGameComponentDataInfo

function CMiniGameComponentDataInfo:Constructor()
  self.m_mission_list = {}
end

CMiniGameComponentDataInfo._proto = {
  [1] = {
    "m_mission_list",
    "map<int,MiniGameMissionInfo>"
  }
}
_class("MiniGameInfo", Object)
MiniGameInfo = MiniGameInfo

function MiniGameInfo:Constructor()
  self.unlock_time = 0
  self.mission_info = MiniGameMissionInfo:New()
end

MiniGameInfo._proto = {
  [1] = {
    "unlock_time",
    "time"
  },
  [2] = {
    "mission_info",
    "MiniGameMissionInfo"
  }
}
_class("MiniGameComponentInfo", ICampaignComponentInfo)
MiniGameComponentInfo = MiniGameComponentInfo

function MiniGameComponentInfo:Constructor()
  self.mission_info_list = {}
end

MiniGameComponentInfo._proto = {
  [1] = {
    "mission_info_list",
    "map<int,MiniGameInfo>"
  }
}
_class("MiniGameComponentMissionStoryReq", ICampaignComRequest)
MiniGameComponentMissionStoryReq = MiniGameComponentMissionStoryReq

function MiniGameComponentMissionStoryReq:Constructor()
  self.mission_id = 0
  self.story_type = 0
end

MiniGameComponentMissionStoryReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"story_type", "int"}
}
_class("MiniGameComponentMissionStoryRep", ICampaignComResponse)
MiniGameComponentMissionStoryRep = MiniGameComponentMissionStoryRep

function MiniGameComponentMissionStoryRep:Constructor()
  self.mission_id = 0
  self.info = MiniGameInfo:New()
end

MiniGameComponentMissionStoryRep._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "info",
    "MiniGameInfo"
  }
}
_class("MiniGameComponentScoreReq", ICampaignComRequest)
MiniGameComponentScoreReq = MiniGameComponentScoreReq

function MiniGameComponentScoreReq:Constructor()
  self.mission_id = 0
  self.score = 0
end

MiniGameComponentScoreReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"score", "int"}
}
_class("MiniGameComponentScoreRep", ICampaignComResponse)
MiniGameComponentScoreRep = MiniGameComponentScoreRep

function MiniGameComponentScoreRep:Constructor()
  self.mission_id = 0
  self.info = MiniGameInfo:New()
end

MiniGameComponentScoreRep._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "info",
    "MiniGameInfo"
  }
}
_class("MiniGameComponentRecvRewardReq", ICampaignComRequest)
MiniGameComponentRecvRewardReq = MiniGameComponentRecvRewardReq

function MiniGameComponentRecvRewardReq:Constructor()
  self.mission_id = 0
  self.grade = 0
end

MiniGameComponentRecvRewardReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"grade", "int"}
}
_class("MiniGameComponentRecvRewardRep", ICampaignComResponse)
MiniGameComponentRecvRewardRep = MiniGameComponentRecvRewardRep

function MiniGameComponentRecvRewardRep:Constructor()
  self.rewards = {}
  self.mission_id = 0
  self.info = MiniGameInfo:New()
end

MiniGameComponentRecvRewardRep._proto = {
  [1] = {
    "rewards",
    "list<RoleAsset>"
  },
  [2] = {"mission_id", "int"},
  [3] = {
    "info",
    "MiniGameInfo"
  }
}
_class("MiniGameExploreComponentData", ICampaignComponentDataInfo)
MiniGameExploreComponentData = MiniGameExploreComponentData

function MiniGameExploreComponentData:Constructor()
  self.used_high_equip_num = 0
  self.used_low_equip_num = 0
  self.last_refresh_time = 0
  self.have_new_high_equip = false
  self.m_last_equip_id = 0
  self.real_used_high_equip_num = 0
  self.real_used_low_equip_num = 0
  self.have_deal_bug = false
end

MiniGameExploreComponentData._proto = {
  [1] = {
    "used_high_equip_num",
    "int"
  },
  [2] = {
    "used_low_equip_num",
    "int"
  },
  [3] = {
    "last_refresh_time",
    "time"
  },
  [4] = {
    "have_new_high_equip",
    "bool"
  },
  [5] = {
    "m_last_equip_id",
    "int"
  },
  [6] = {
    "real_used_high_equip_num",
    "int"
  },
  [7] = {
    "real_used_low_equip_num",
    "int"
  },
  [8] = {
    "have_deal_bug",
    "bool"
  }
}
_class("MiniGameExploreComponentLoadInfo", ICampaignComponentInfo)
MiniGameExploreComponentLoadInfo = MiniGameExploreComponentLoadInfo

function MiniGameExploreComponentLoadInfo:Constructor()
  self.used_high_equip_num = 0
  self.used_low_equip_num = 0
  self.next_refresh_time = 0
  self.have_new_high_equip = false
end

MiniGameExploreComponentLoadInfo._proto = {
  [1] = {
    "used_high_equip_num",
    "int"
  },
  [2] = {
    "used_low_equip_num",
    "int"
  },
  [3] = {
    "next_refresh_time",
    "time"
  },
  [4] = {
    "have_new_high_equip",
    "bool"
  }
}
_class("MiniGameExploreComponentRandomLocationReq", ICampaignComRequest)
MiniGameExploreComponentRandomLocationReq = MiniGameExploreComponentRandomLocationReq

function MiniGameExploreComponentRandomLocationReq:Constructor()
end

MiniGameExploreComponentRandomLocationReq._proto = {}
_class("MiniGameExploreComponentRandomPostionReply", ICampaignComResponse)
MiniGameExploreComponentRandomPostionReply = MiniGameExploreComponentRandomPostionReply

function MiniGameExploreComponentRandomPostionReply:Constructor()
  self.postion_id = 0
end

MiniGameExploreComponentRandomPostionReply._proto = {
  [1] = {"postion_id", "int"}
}
_class("MiniGameExploreComponentRecvRewardReq", ICampaignComRequest)
MiniGameExploreComponentRecvRewardReq = MiniGameExploreComponentRecvRewardReq

function MiniGameExploreComponentRecvRewardReq:Constructor()
end

MiniGameExploreComponentRecvRewardReq._proto = {}
_class("MiniGameExploreComponentRecvRewardReply", ICampaignComResponse)
MiniGameExploreComponentRecvRewardReply = MiniGameExploreComponentRecvRewardReply

function MiniGameExploreComponentRecvRewardReply:Constructor()
  self.rewards = {}
  self.used_high_equip_num = 0
  self.used_low_equip_num = 0
  self.next_refresh_time = 0
end

MiniGameExploreComponentRecvRewardReply._proto = {
  [1] = {
    "rewards",
    "list<RoleAsset>"
  },
  [2] = {
    "used_high_equip_num",
    "int"
  },
  [3] = {
    "used_low_equip_num",
    "int"
  },
  [4] = {
    "next_refresh_time",
    "time"
  }
}
_class("MiniGameExploreComponentClearNewEquipReq", ICampaignComRequest)
MiniGameExploreComponentClearNewEquipReq = MiniGameExploreComponentClearNewEquipReq

function MiniGameExploreComponentClearNewEquipReq:Constructor()
end

MiniGameExploreComponentClearNewEquipReq._proto = {}
_class("MiniGameExploreComponentClearNewEquipReply", ICampaignComResponse)
MiniGameExploreComponentClearNewEquipReply = MiniGameExploreComponentClearNewEquipReply

function MiniGameExploreComponentClearNewEquipReply:Constructor()
end

MiniGameExploreComponentClearNewEquipReply._proto = {}
_class("MiniGameFishingChallengeComponentData", ICampaignComponentDataInfo)
MiniGameFishingChallengeComponentData = MiniGameFishingChallengeComponentData

function MiniGameFishingChallengeComponentData:Constructor()
  self.append_postions = {}
end

MiniGameFishingChallengeComponentData._proto = {
  [1] = {
    "append_postions",
    "list<int>"
  }
}
_class("MiniGameFishingChallengeComponentLoadInfo", ICampaignComponentInfo)
MiniGameFishingChallengeComponentLoadInfo = MiniGameFishingChallengeComponentLoadInfo

function MiniGameFishingChallengeComponentLoadInfo:Constructor()
  self.append_postions = {}
end

MiniGameFishingChallengeComponentLoadInfo._proto = {
  [1] = {
    "append_postions",
    "list<int>"
  }
}
local LVRewardComponentNotifyType = {LVRewardComponentNotify_LevelProgressChanged = 1, LVRewardComponentNotify_UnlockAdvanced = 2}
_enum("LVRewardComponentNotifyType", LVRewardComponentNotifyType)
_class("CLVRewardComponentDataInfo", ICampaignComponentDataInfo)
CLVRewardComponentDataInfo = CLVRewardComponentDataInfo

function CLVRewardComponentDataInfo:Constructor()
  self.m_received_normal_lv = {}
  self.m_received_advanced_lv = {}
  self.m_unlock_advanced = false
end

CLVRewardComponentDataInfo._proto = {
  [1] = {
    "m_received_normal_lv",
    "list<int>"
  },
  [2] = {
    "m_received_advanced_lv",
    "list<int>"
  },
  [3] = {
    "m_unlock_advanced",
    "bool"
  }
}
_class("LVRewardComponentInfo", ICampaignComponentInfo)
LVRewardComponentInfo = LVRewardComponentInfo

function LVRewardComponentInfo:Constructor()
  self.m_item_id = 0
  self.m_current_level = 1
  self.m_received_normal_lv = {}
  self.m_received_advanced_lv = {}
  self.m_normal_begin_reward_id = 0
  self.m_advanced_begin_reward_id = 0
  self.m_max_level = 1
  self.m_unlock_advanced_reward = false
  self.m_current_progress = 0
  self.m_level_max_progress = 0
end

LVRewardComponentInfo._proto = {
  [1] = {"m_item_id", "int"},
  [2] = {
    "m_current_level",
    "int"
  },
  [3] = {
    "m_received_normal_lv",
    "list<int>"
  },
  [4] = {
    "m_received_advanced_lv",
    "list<int>"
  },
  [5] = {
    "m_normal_begin_reward_id",
    "int"
  },
  [6] = {
    "m_advanced_begin_reward_id",
    "int"
  },
  [7] = {
    "m_max_level",
    "int"
  },
  [8] = {
    "m_unlock_advanced_reward",
    "bool"
  },
  [9] = {
    "m_current_progress",
    "int"
  },
  [10] = {
    "m_level_max_progress",
    "int"
  }
}
_class("LVRewardComponentReceiveRewardReq", ICampaignComRequest)
LVRewardComponentReceiveRewardReq = LVRewardComponentReceiveRewardReq

function LVRewardComponentReceiveRewardReq:Constructor()
  self.m_req_level = 0
  self.m_is_advanced = false
end

LVRewardComponentReceiveRewardReq._proto = {
  [1] = {
    "m_req_level",
    "int"
  },
  [2] = {
    "m_is_advanced",
    "bool"
  }
}
_class("LVRewardComponentReceiveRewardRep", ICampaignComResponse)
LVRewardComponentReceiveRewardRep = LVRewardComponentReceiveRewardRep

function LVRewardComponentReceiveRewardRep:Constructor()
  self.m_reward_info = RoleAsset:New()
end

LVRewardComponentReceiveRewardRep._proto = {
  [1] = {
    "m_reward_info",
    "RoleAsset"
  }
}
_class("LVRewardComponentOneKeyReceiveRewardReq", ICampaignComRequest)
LVRewardComponentOneKeyReceiveRewardReq = LVRewardComponentOneKeyReceiveRewardReq

function LVRewardComponentOneKeyReceiveRewardReq:Constructor()
end

LVRewardComponentOneKeyReceiveRewardReq._proto = {}
_class("LVRewardComponentOneKeyReceiveRewardRep", ICampaignComResponse)
LVRewardComponentOneKeyReceiveRewardRep = LVRewardComponentOneKeyReceiveRewardRep

function LVRewardComponentOneKeyReceiveRewardRep:Constructor()
  self.m_rewards = {}
  self.m_received_normal = {}
  self.m_received_advanced = {}
end

LVRewardComponentOneKeyReceiveRewardRep._proto = {
  [1] = {
    "m_rewards",
    "list<RoleAsset>"
  },
  [2] = {
    "m_received_normal",
    "list<int>"
  },
  [3] = {
    "m_received_advanced",
    "list<int>"
  }
}
_class("NotifyLVRewardComponentLevelProgressChanged", Object)
NotifyLVRewardComponentLevelProgressChanged = NotifyLVRewardComponentLevelProgressChanged

function NotifyLVRewardComponentLevelProgressChanged:Constructor()
  self.m_level = 0
  self.m_progress = 0
end

NotifyLVRewardComponentLevelProgressChanged._proto = {
  [1] = {"m_level", "int"},
  [2] = {"m_progress", "int"}
}
_class("NotifyLVRewardComponentUnlockAdvanced", Object)
NotifyLVRewardComponentUnlockAdvanced = NotifyLVRewardComponentUnlockAdvanced

function NotifyLVRewardComponentUnlockAdvanced:Constructor()
  self.m_unlock_advanced_reward = false
end

NotifyLVRewardComponentUnlockAdvanced._proto = {
  [1] = {
    "m_unlock_advanced_reward",
    "bool"
  }
}
local BuyGiftComponentNotifyType = {BuyGiftComponentNotify_BuyStateChanged = 1}
_enum("BuyGiftComponentNotifyType", BuyGiftComponentNotifyType)
local BuyGiftStateType = {
  EBGST_INIT = 0,
  EBGST_ADVANCED = 1,
  EBGST_LUXURY = 2
}
_enum("BuyGiftStateType", BuyGiftStateType)
local CampaignGiftType = {
  ECGT_ADVANCED = 0,
  ECGT_LUXURY = 1,
  ECGT_ADDITIONALBUY = 2,
  ECGT_BPLEVEL = 3,
  ECGT_BACK = 4,
  ECGT_SENIOR_SKIN = 5
}
_enum("CampaignGiftType", CampaignGiftType)
_class("CampaignGiftInfo", Object)
CampaignGiftInfo = CampaignGiftInfo

function CampaignGiftInfo:Constructor()
  self.m_gift_id = 0
  self.m_gift_type = 1
  self.m_midas_id = ""
  self.m_extra_award = {}
  self.m_raw_price = 0
  self.m_now_price = 0
end

CampaignGiftInfo._proto = {
  [1] = {"m_gift_id", "int"},
  [2] = {
    "m_gift_type",
    "int"
  },
  [3] = {"m_midas_id", "string"},
  [4] = {
    "m_extra_award",
    "list<RoleAsset>"
  },
  [5] = {
    "m_raw_price",
    "int"
  },
  [6] = {
    "m_now_price",
    "int"
  }
}
_class("CBuyGiftComponentDataInfo", ICampaignComponentDataInfo)
CBuyGiftComponentDataInfo = CBuyGiftComponentDataInfo

function CBuyGiftComponentDataInfo:Constructor()
  self.m_buy_state = 0
  self.m_buy_gift_map = {}
end

CBuyGiftComponentDataInfo._proto = {
  [1] = {
    "m_buy_state",
    "int"
  },
  [2] = {
    "m_buy_gift_map",
    "map<int,int>"
  }
}
_class("BuyGiftComponentInfo", ICampaignComponentInfo)
BuyGiftComponentInfo = BuyGiftComponentInfo

function BuyGiftComponentInfo:Constructor()
  self.m_buy_state = 0
  self.m_campaign_gift_list = {}
  self.m_buy_gift_map = {}
end

BuyGiftComponentInfo._proto = {
  [1] = {
    "m_buy_state",
    "int"
  },
  [2] = {
    "m_campaign_gift_list",
    "list<CampaignGiftInfo>"
  },
  [4] = {
    "m_buy_gift_map",
    "map<int,int>"
  }
}
_class("BuyGiftComponentApplyBuyReq", ICampaignComRequest)
BuyGiftComponentApplyBuyReq = BuyGiftComponentApplyBuyReq

function BuyGiftComponentApplyBuyReq:Constructor()
  self.m_gift_id = 0
  self.m_buy_count = 1
end

BuyGiftComponentApplyBuyReq._proto = {
  [1] = {"m_gift_id", "int"},
  [2] = {
    "m_buy_count",
    "int"
  }
}
_class("BuyGiftComponentApplyBuyRep", ICampaignComResponse)
BuyGiftComponentApplyBuyRep = BuyGiftComponentApplyBuyRep

function BuyGiftComponentApplyBuyRep:Constructor()
end

BuyGiftComponentApplyBuyRep._proto = {}
_class("NotifyBuyGiftComponentBuyStateChange", Object)
NotifyBuyGiftComponentBuyStateChange = NotifyBuyGiftComponentBuyStateChange

function NotifyBuyGiftComponentBuyStateChange:Constructor()
  self.m_buy_state = 0
  self.m_buy_gift_map = {}
end

NotifyBuyGiftComponentBuyStateChange._proto = {
  [1] = {
    "m_buy_state",
    "int"
  },
  [2] = {
    "m_buy_gift_map",
    "map<int,int>"
  }
}
local ActionPointStateType = {
  APST_INVALID = 0,
  APST_OPEN = 1,
  APST_CLOSE = 2
}
_enum("ActionPointStateType", ActionPointStateType)
_class("ActionPopintData", Object)
ActionPopintData = ActionPopintData

function ActionPopintData:Constructor()
  self.m_state = 0
  self.m_end_time = 0
end

ActionPopintData._proto = {
  [1] = {"m_state", "int"},
  [2] = {"m_end_time", "int64"}
}
_class("ActionPointComponentInfo", ICampaignComponentInfo)
ActionPointComponentInfo = ActionPointComponentInfo

function ActionPointComponentInfo:Constructor()
  self.m_info = {}
end

ActionPointComponentInfo._proto = {
  [1] = {
    "m_info",
    "map<int,ActionPopintData>"
  }
}
_class("CPlayerBackComponentDataInfo", ICampaignComponentDataInfo)
CPlayerBackComponentDataInfo = CPlayerBackComponentDataInfo

function CPlayerBackComponentDataInfo:Constructor()
  self.nTriggerTimes = 0
  self.tmTriggerTimeVec = {}
  self.tmEndTimeVec = {}
  self.bIsRecvRewardVec = {}
  self.BackRewardVec = {}
end

CPlayerBackComponentDataInfo._proto = {
  [1] = {
    "nTriggerTimes",
    "int"
  },
  [2] = {
    "tmTriggerTimeVec",
    "list<time>"
  },
  [3] = {
    "tmEndTimeVec",
    "list<time>"
  },
  [4] = {
    "bIsRecvRewardVec",
    "list<bool>"
  },
  [5] = {
    "BackRewardVec",
    "list<list<RoleAsset>>"
  }
}
_class("CPlayerBackComponentInfo", ICampaignComponentInfo)
CPlayerBackComponentInfo = CPlayerBackComponentInfo

function CPlayerBackComponentInfo:Constructor()
  self.tmTriggerTime = 0
  self.tmEndTime = 0
  self.BackRewardVec = {}
  self.bIsRecvReward = false
end

CPlayerBackComponentInfo._proto = {
  [1] = {
    "tmTriggerTime",
    "time"
  },
  [2] = {"tmEndTime", "time"},
  [3] = {
    "BackRewardVec",
    "list<RoleAsset>"
  },
  [4] = {
    "bIsRecvReward",
    "bool"
  }
}
_class("BackComponentRecvRewardReq", ICampaignComRequest)
BackComponentRecvRewardReq = BackComponentRecvRewardReq

function BackComponentRecvRewardReq:Constructor()
end

BackComponentRecvRewardReq._proto = {}
_class("BackComponentRecvRewardRep", ICampaignComResponse)
BackComponentRecvRewardRep = BackComponentRecvRewardRep

function BackComponentRecvRewardRep:Constructor()
  self.rewards = {}
end

BackComponentRecvRewardRep._proto = {
  [1] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("CResHelpComponentDataInfo", ICampaignComponentDataInfo)
CResHelpComponentDataInfo = CResHelpComponentDataInfo

function CResHelpComponentDataInfo:Constructor()
  self.nTodayHelpTimes = 0
  self.tmRefreshTimesTime = 0
end

CResHelpComponentDataInfo._proto = {
  [1] = {
    "nTodayHelpTimes",
    "int"
  },
  [2] = {
    "tmRefreshTimesTime",
    "time"
  }
}
_class("CResHelpComponentInfo", ICampaignComponentInfo)
CResHelpComponentInfo = CResHelpComponentInfo

function CResHelpComponentInfo:Constructor()
  self.nTodayHelpTimes = 0
  self.tmNextRefreshTimesTime = 0
  self.nHelpDayLimitTimes = 0
end

CResHelpComponentInfo._proto = {
  [1] = {
    "nTodayHelpTimes",
    "int"
  },
  [2] = {
    "tmNextRefreshTimesTime",
    "time"
  },
  [3] = {
    "nHelpDayLimitTimes",
    "int"
  }
}
local CResHelpComponentNotifyType = {CResHelpComponentNotifyType_ResHelpInfoChange = 1}
_enum("CResHelpComponentNotifyType", CResHelpComponentNotifyType)
_class("NotifyResHelpComponentInfoChange", Object)
NotifyResHelpComponentInfoChange = NotifyResHelpComponentInfoChange

function NotifyResHelpComponentInfoChange:Constructor()
  self.nTodayHelpTimes = 0
  self.tmNextRefreshTimesTime = 0
  self.nHelpDayLimitTimes = 0
end

NotifyResHelpComponentInfoChange._proto = {
  [1] = {
    "nTodayHelpTimes",
    "int"
  },
  [2] = {
    "tmNextRefreshTimesTime",
    "time"
  },
  [3] = {
    "nHelpDayLimitTimes",
    "int"
  }
}
local BattlefieldComponentNotifyType = {BattlefieldComponentNotify_DailyReset = 1, BattlefieldComponentNotify_MilitaryExploitChanged = 2}
_enum("BattlefieldComponentNotifyType", BattlefieldComponentNotifyType)
_class("MissionChallengeInfo", Object)
MissionChallengeInfo = MissionChallengeInfo

function MissionChallengeInfo:Constructor()
  self.mission_id = 0
  self.wave_index = 0
  self.military_exploit = 0
end

MissionChallengeInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"wave_index", "int"},
  [3] = {
    "military_exploit",
    "int"
  }
}
_class("CBattlefieldComponentDataInfo", ICampaignComponentDataInfo)
CBattlefieldComponentDataInfo = CBattlefieldComponentDataInfo

function CBattlefieldComponentDataInfo:Constructor()
  self.m_challenge_mission_info = {}
  self.m_accumulated_military_exploit = 0
  self.m_cur_max_military_exploit = 0
end

CBattlefieldComponentDataInfo._proto = {
  [1] = {
    "m_challenge_mission_info",
    "map<int,list<MissionChallengeInfo>>"
  },
  [2] = {
    "m_accumulated_military_exploit",
    "int"
  },
  [3] = {
    "m_cur_max_military_exploit",
    "int"
  }
}
_class("BattlefieldInfo", Object)
BattlefieldInfo = BattlefieldInfo

function BattlefieldInfo:Constructor()
  self.m_challenge_mission_info = {}
  self.m_accumulated_military_exploit = 0
  self.m_cur_max_military_exploit = 0
  self.m_next_reset_time = 0
  self.m_mission_level_wave_map = {}
  self.m_cur_index = 0
end

BattlefieldInfo._proto = {
  [1] = {
    "m_challenge_mission_info",
    "map<int,MissionChallengeInfo>"
  },
  [2] = {
    "m_accumulated_military_exploit",
    "int"
  },
  [3] = {
    "m_cur_max_military_exploit",
    "int"
  },
  [4] = {
    "m_next_reset_time",
    "time"
  },
  [5] = {
    "m_mission_level_wave_map",
    "map<int,list<int>>"
  },
  [6] = {
    "m_cur_index",
    "int"
  }
}
_class("BattlefieldComponentInfo", ICampaignComponentInfo)
BattlefieldComponentInfo = BattlefieldComponentInfo

function BattlefieldComponentInfo:Constructor()
  self.m_battlefield_info = BattlefieldInfo:New()
end

BattlefieldComponentInfo._proto = {
  [1] = {
    "m_battlefield_info",
    "BattlefieldInfo"
  }
}
_class("BattlefieldComponentDailyResetReq", ICampaignComRequest)
BattlefieldComponentDailyResetReq = BattlefieldComponentDailyResetReq

function BattlefieldComponentDailyResetReq:Constructor()
end

BattlefieldComponentDailyResetReq._proto = {}
_class("BattlefieldComponentDailyResetRep", ICampaignComResponse)
BattlefieldComponentDailyResetRep = BattlefieldComponentDailyResetRep

function BattlefieldComponentDailyResetRep:Constructor()
  self.m_battlefield_info = BattlefieldInfo:New()
end

BattlefieldComponentDailyResetRep._proto = {
  [1] = {
    "m_battlefield_info",
    "BattlefieldInfo"
  }
}
_class("NotifyBattlefieldComponentDailyReset", Object)
NotifyBattlefieldComponentDailyReset = NotifyBattlefieldComponentDailyReset

function NotifyBattlefieldComponentDailyReset:Constructor()
  self.m_battlefield_info = BattlefieldInfo:New()
end

NotifyBattlefieldComponentDailyReset._proto = {
  [1] = {
    "m_battlefield_info",
    "BattlefieldInfo"
  }
}
_class("NotifyBattlefieldComponentMilitaryExploitChanged", Object)
NotifyBattlefieldComponentMilitaryExploitChanged = NotifyBattlefieldComponentMilitaryExploitChanged

function NotifyBattlefieldComponentMilitaryExploitChanged:Constructor()
  self.m_challenge_mission_info = MissionChallengeInfo:New()
  self.m_accumulated_military_exploit = 0
  self.m_cur_max_military_exploit = 0
end

NotifyBattlefieldComponentMilitaryExploitChanged._proto = {
  [1] = {
    "m_challenge_mission_info",
    "MissionChallengeInfo"
  },
  [2] = {
    "m_accumulated_military_exploit",
    "int"
  },
  [3] = {
    "m_cur_max_military_exploit",
    "int"
  }
}
local BuildType = {
  BULIL_INVALID = 0,
  BUILD_CLEAN = 1,
  BUILD_REPAIR = 2,
  BUILD_DECORATE = 4,
  PICNIC_AREA = 1024
}
_enum("BuildType", BuildType)
local BuildStoryType = {
  STORY_INVILD = 0,
  STORY_DRAWING = 1,
  STORY_GENERAL_PLOT = 2,
  STORY_TERMINAL = 3
}
_enum("BuildStoryType", BuildStoryType)
local BuildComponentNotifyType = {BuildComponentNotify_EventRefresh = 1, BuildComponentNotify_TokenMoneyChanged = 2}
_enum("BuildComponentNotifyType", BuildComponentNotifyType)
_class("BuildItemInfo", Object)
BuildItemInfo = BuildItemInfo

function BuildItemInfo:Constructor()
  self.mask = 0
  self.story_mask = 0
  self.build_item_id = 0
end

BuildItemInfo._proto = {
  [1] = {"mask", "int"},
  [2] = {"story_mask", "int"},
  [3] = {
    "build_item_id",
    "int"
  }
}
_class("BuildEventInfo", Object)
BuildEventInfo = BuildEventInfo

function BuildEventInfo:Constructor()
  self.today_complete_event_num = 0
  self.today_refresh_num = 0
  self.cur_event_list = {}
  self.reset_time = 0
end

BuildEventInfo._proto = {
  [1] = {
    "today_complete_event_num",
    "int"
  },
  [2] = {
    "today_refresh_num",
    "int"
  },
  [3] = {
    "cur_event_list",
    "list<int>"
  },
  [4] = {"reset_time", "int64"}
}
_class("PicnicInfo", Object)
PicnicInfo = PicnicInfo

function PicnicInfo:Constructor()
  self.m_have_story = false
  self.m_next_food = {}
  self.m_times = 0
end

PicnicInfo._proto = {
  [1] = {
    "m_have_story",
    "bool"
  },
  [2] = {
    "m_next_food",
    "map<int,time>"
  },
  [3] = {"m_times", "int"}
}
_class("BuildComponentInfo", ICampaignComponentInfo)
BuildComponentInfo = BuildComponentInfo

function BuildComponentInfo:Constructor()
  self.event_info = BuildEventInfo:New()
  self.build_item_infos = {}
  self.item_count = 0
  self.m_picnic_info = PicnicInfo:New()
end

BuildComponentInfo._proto = {
  [1] = {
    "event_info",
    "BuildEventInfo"
  },
  [2] = {
    "build_item_infos",
    "map<int,BuildItemInfo>"
  },
  [3] = {"item_count", "int"},
  [4] = {
    "m_picnic_info",
    "PicnicInfo"
  }
}
_class("BuildComponentBuildReq", ICampaignComRequest)
BuildComponentBuildReq = BuildComponentBuildReq

function BuildComponentBuildReq:Constructor()
  self.item_id = 0
  self.build_type = 0
end

BuildComponentBuildReq._proto = {
  [1] = {"item_id", "int"},
  [2] = {"build_type", "int"}
}
_class("BuildComponentBuildRep", ICampaignComResponse)
BuildComponentBuildRep = BuildComponentBuildRep

function BuildComponentBuildRep:Constructor()
  self.build_info = BuildItemInfo:New()
  self.rewards = {}
end

BuildComponentBuildRep._proto = {
  [1] = {
    "build_info",
    "BuildItemInfo"
  },
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("BuildComponentStoryReq", ICampaignComRequest)
BuildComponentStoryReq = BuildComponentStoryReq

function BuildComponentStoryReq:Constructor()
  self.item_id = 0
  self.status = 0
end

BuildComponentStoryReq._proto = {
  [1] = {"item_id", "int"},
  [2] = {"status", "int"}
}
_class("BuildComponentStoryRep", ICampaignComResponse)
BuildComponentStoryRep = BuildComponentStoryRep

function BuildComponentStoryRep:Constructor()
  self.build_info = BuildItemInfo:New()
end

BuildComponentStoryRep._proto = {
  [1] = {
    "build_info",
    "BuildItemInfo"
  }
}
_class("BuildComponentCompleteEventReq", ICampaignComRequest)
BuildComponentCompleteEventReq = BuildComponentCompleteEventReq

function BuildComponentCompleteEventReq:Constructor()
  self.event_id = 0
end

BuildComponentCompleteEventReq._proto = {
  [1] = {"event_id", "int"}
}
_class("BuildComponentCompleteEventRep", ICampaignComResponse)
BuildComponentCompleteEventRep = BuildComponentCompleteEventRep

function BuildComponentCompleteEventRep:Constructor()
  self.build_event_info = BuildEventInfo:New()
  self.rewards = {}
end

BuildComponentCompleteEventRep._proto = {
  [1] = {
    "build_event_info",
    "BuildEventInfo"
  },
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("NotifyBuildComponentEventRefresh", Object)
NotifyBuildComponentEventRefresh = NotifyBuildComponentEventRefresh

function NotifyBuildComponentEventRefresh:Constructor()
  self.event_info = BuildEventInfo:New()
end

NotifyBuildComponentEventRefresh._proto = {
  [1] = {
    "event_info",
    "BuildEventInfo"
  }
}
_class("NotifyBuildComponentTokenMoneyChanged", Object)
NotifyBuildComponentTokenMoneyChanged = NotifyBuildComponentTokenMoneyChanged

function NotifyBuildComponentTokenMoneyChanged:Constructor()
  self.item_count = 0
end

NotifyBuildComponentTokenMoneyChanged._proto = {
  [3] = {"item_count", "int"}
}
_class("PicnicPutFoodReq", ICampaignComRequest)
PicnicPutFoodReq = PicnicPutFoodReq

function PicnicPutFoodReq:Constructor()
  self.area_id = 0
end

PicnicPutFoodReq._proto = {
  [1] = {"area_id", "int"}
}
_class("PicnicPutFoodRep", ICampaignComResponse)
PicnicPutFoodRep = PicnicPutFoodRep

function PicnicPutFoodRep:Constructor()
  self.nErrorCode = 0
  self.picnicInfo = PicnicInfo:New()
  self.reward = {}
end

PicnicPutFoodRep._proto = {
  [1] = {"nErrorCode", "int"},
  [2] = {"picnicInfo", "PicnicInfo"},
  [3] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("PicnicWatchStoryReq", ICampaignComRequest)
PicnicWatchStoryReq = PicnicWatchStoryReq

function PicnicWatchStoryReq:Constructor()
end

PicnicWatchStoryReq._proto = {}
_class("PicnicWatchStoryRep", ICampaignComResponse)
PicnicWatchStoryRep = PicnicWatchStoryRep

function PicnicWatchStoryRep:Constructor()
end

PicnicWatchStoryRep._proto = {}
local BlackfistComponentNotifyType = {BlackfistComponentNotify_ScoreChanged = 1}
_enum("BlackfistComponentNotifyType", BlackfistComponentNotifyType)
_class("BlackfistComponentInfo", ICampaignComponentInfo)
BlackfistComponentInfo = BlackfistComponentInfo

function BlackfistComponentInfo:Constructor()
  self.cur_day_index = 0
  self.score_infos = {}
  self.order_ids = {}
end

BlackfistComponentInfo._proto = {
  [1] = {
    "cur_day_index",
    "int"
  },
  [2] = {
    "score_infos",
    "map<int,map<int,int>>"
  },
  [3] = {
    "order_ids",
    "map<int,int>"
  }
}
_class("NotifyBlackfistScoreChanged", Object)
NotifyBlackfistScoreChanged = NotifyBlackfistScoreChanged

function NotifyBlackfistScoreChanged:Constructor()
  self.score = {}
end

NotifyBlackfistScoreChanged._proto = {
  [1] = {
    "score",
    "map<int,map<int,int>>"
  }
}
local SubjectOpenType = {SubjectOpenType_Auto = 1, SubjectOpenType_Time = 2}
_enum("SubjectOpenType", SubjectOpenType)
_class("SubjectComponentLevelRewardedInfo", Object)
SubjectComponentLevelRewardedInfo = SubjectComponentLevelRewardedInfo

function SubjectComponentLevelRewardedInfo:Constructor()
  self.level_id = 0
  self.grade = 0
end

SubjectComponentLevelRewardedInfo._proto = {
  [1] = {"level_id", "int"},
  [2] = {"grade", "int"}
}
_class("SubjectComponentLevelInfo", Object)
SubjectComponentLevelInfo = SubjectComponentLevelInfo

function SubjectComponentLevelInfo:Constructor()
  self.level_id = 0
  self.grade = 0
  self.opentype = 0
  self.opentime = 0
end

SubjectComponentLevelInfo._proto = {
  [1] = {"level_id", "int"},
  [2] = {"grade", "int"},
  [3] = {"opentype", "int"},
  [4] = {"opentime", "time"}
}
_class("SubjectComponentInfo", ICampaignComponentInfo)
SubjectComponentInfo = SubjectComponentInfo

function SubjectComponentInfo:Constructor()
  self.rewarded_levels = {}
  self.levels = {}
  self.test_score = 0
end

SubjectComponentInfo._proto = {
  [1] = {
    "rewarded_levels",
    "list<SubjectComponentLevelRewardedInfo>"
  },
  [2] = {
    "levels",
    "map<int,SubjectComponentLevelInfo>"
  },
  [3] = {"test_score", "int"}
}
_class("SubjectComponentRewardReq", ICampaignComRequest)
SubjectComponentRewardReq = SubjectComponentRewardReq

function SubjectComponentRewardReq:Constructor()
  self.level_id = 0
  self.grade = 0
end

SubjectComponentRewardReq._proto = {
  [1] = {"level_id", "int"},
  [2] = {"grade", "int"}
}
_class("SubjectComponentRewardRep", ICampaignComResponse)
SubjectComponentRewardRep = SubjectComponentRewardRep

function SubjectComponentRewardRep:Constructor()
  self.rewarded_levels = {}
end

SubjectComponentRewardRep._proto = {
  [1] = {
    "rewarded_levels",
    "list<SubjectComponentLevelRewardedInfo>"
  }
}
_class("SubjectComponentTestScoreReq", ICampaignComRequest)
SubjectComponentTestScoreReq = SubjectComponentTestScoreReq

function SubjectComponentTestScoreReq:Constructor()
  self.score = 0
end

SubjectComponentTestScoreReq._proto = {
  [1] = {"score", "int"}
}
_class("SubjectComponentTestScoreRep", ICampaignComResponse)
SubjectComponentTestScoreRep = SubjectComponentTestScoreRep

function SubjectComponentTestScoreRep:Constructor()
end

SubjectComponentTestScoreRep._proto = {}
_class("RewardDoubleComponentInfo", ICampaignComponentInfo)
RewardDoubleComponentInfo = RewardDoubleComponentInfo

function RewardDoubleComponentInfo:Constructor()
  self.ExRewardPercent = 0
end

RewardDoubleComponentInfo._proto = {
  [1] = {
    "ExRewardPercent",
    "int"
  }
}
local EntrustEventType = {
  EntrustEventType_Invalid = 0,
  EntrustEventType_Start = 1,
  EntrustEventType_End = 2,
  EntrustEventType_Fight = 3,
  EntrustEventType_Story = 4,
  EntrustEventType_MissionOccupy = 5,
  EntrustEventType_MissionSubmit = 6,
  EntrustEventType_Box = 7,
  EntrustEventType_Transfer = 8,
  EntrustEventType_Interact = 9
}
_enum("EntrustEventType", EntrustEventType)
local EntrustComponentNotifyType = {EntrustComponentNotifyType_EventsRefresh = 1}
_enum("EntrustComponentNotifyType", EntrustComponentNotifyType)
_class("EntrustMissionInfo", Object)
EntrustMissionInfo = EntrustMissionInfo

function EntrustMissionInfo:Constructor()
  self.passed = false
  self.team_events = {}
end

EntrustMissionInfo._proto = {
  [1] = {"passed", "bool"},
  [2] = {
    "team_events",
    "map<int,int>"
  }
}
_class("EntrustComponentInfo", ICampaignComponentInfo)
EntrustComponentInfo = EntrustComponentInfo

function EntrustComponentInfo:Constructor()
  self.rewarded_events = {}
  self.open_time = {}
  self.mission_infos = {}
end

EntrustComponentInfo._proto = {
  [1] = {
    "rewarded_events",
    "map<int,list<int>>"
  },
  [2] = {
    "open_time",
    "map<int,time>"
  },
  [3] = {
    "mission_infos",
    "map<int,EntrustMissionInfo>"
  }
}
_class("EntrustLevelData", Object)
EntrustLevelData = EntrustLevelData

function EntrustLevelData:Constructor()
  self.rewarded_events = {}
  self.open_lines = {}
  self.open_events = {}
  self.passed = false
  self.total_events = 0
  self.complete_events = 0
  self.total_box = 0
  self.opened_box = 0
  self.open_time = 0
  self.passed_rewards = {}
  self.box_rewards = {}
end

EntrustLevelData._proto = {
  [1] = {
    "rewarded_events",
    "list<int>"
  },
  [2] = {"open_lines", "list<int>"},
  [3] = {
    "open_events",
    "list<int>"
  },
  [4] = {"passed", "bool"},
  [5] = {
    "total_events",
    "int"
  },
  [6] = {
    "complete_events",
    "int"
  },
  [7] = {"total_box", "int"},
  [8] = {"opened_box", "int"},
  [9] = {"open_time", "time"},
  [10] = {
    "passed_rewards",
    "list<RoleAsset>"
  },
  [11] = {
    "box_rewards",
    "list<RoleAsset>"
  }
}
_class("EntrustComponetClientData", Object)
EntrustComponetClientData = EntrustComponetClientData

function EntrustComponetClientData:Constructor()
  self.datas = {}
end

EntrustComponetClientData._proto = {
  [1] = {
    "datas",
    "map<int,EntrustLevelData>"
  }
}
_class("EntrustComponentCompleteReq", ICampaignComRequest)
EntrustComponentCompleteReq = EntrustComponentCompleteReq

function EntrustComponentCompleteReq:Constructor()
  self.entrustid = 0
  self.eventid = 0
end

EntrustComponentCompleteReq._proto = {
  [1] = {"entrustid", "int"},
  [2] = {"eventid", "int"}
}
_class("EntrustComponentCompleteRep", ICampaignComResponse)
EntrustComponentCompleteRep = EntrustComponentCompleteRep

function EntrustComponentCompleteRep:Constructor()
  self.rewards = {}
end

EntrustComponentCompleteRep._proto = {
  [1] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("NotifyEntrustEventsRefresh", Object)
NotifyEntrustEventsRefresh = NotifyEntrustEventsRefresh

function NotifyEntrustEventsRefresh:Constructor()
  self.rewarded_events = {}
  self.mission_infos = {}
end

NotifyEntrustEventsRefresh._proto = {
  [1] = {
    "rewarded_events",
    "map<int,list<int>>"
  },
  [2] = {
    "mission_infos",
    "map<int,EntrustMissionInfo>"
  }
}
_class("EntrustComponentMoveEventReq", ICampaignComRequest)
EntrustComponentMoveEventReq = EntrustComponentMoveEventReq

function EntrustComponentMoveEventReq:Constructor()
  self.entrustid = 0
  self.team_events = {}
end

EntrustComponentMoveEventReq._proto = {
  [1] = {"entrustid", "int"},
  [2] = {
    "team_events",
    "map<int,int>"
  }
}
_class("EntrustComponentMoveEventRep", ICampaignComResponse)
EntrustComponentMoveEventRep = EntrustComponentMoveEventRep

function EntrustComponentMoveEventRep:Constructor()
  self.ret = 0
  self.mission_info = EntrustMissionInfo:New()
end

EntrustComponentMoveEventRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "mission_info",
    "EntrustMissionInfo"
  }
}
_class("DailyMissionComponentInfo", ICampaignComponentInfo)
DailyMissionComponentInfo = DailyMissionComponentInfo

function DailyMissionComponentInfo:Constructor()
  self.m_cur_day_index = 0
  self.m_daily_mission = {}
  self.m_daily_mission_reset_time = 0
  self.m_total_score = 0
  self.m_score_limit = 0
  self.m_today_score = 0
end

DailyMissionComponentInfo._proto = {
  [1] = {
    "m_cur_day_index",
    "int"
  },
  [2] = {
    "m_daily_mission",
    "list<int>"
  },
  [3] = {
    "m_daily_mission_reset_time",
    "time"
  },
  [4] = {
    "m_total_score",
    "int"
  },
  [5] = {
    "m_score_limit",
    "int"
  },
  [6] = {
    "m_today_score",
    "int"
  }
}
_class("CDailyMissionComponentDataInfo", ICampaignComponentDataInfo)
CDailyMissionComponentDataInfo = CDailyMissionComponentDataInfo

function CDailyMissionComponentDataInfo:Constructor()
  self.m_today_score = 0
  self.m_toal_score = 0
  self.m_cur_day_index = 0
  self.m_mission = {}
end

CDailyMissionComponentDataInfo._proto = {
  [1] = {
    "m_today_score",
    "int"
  },
  [2] = {
    "m_toal_score",
    "int"
  },
  [3] = {
    "m_cur_day_index",
    "int"
  },
  [4] = {
    "m_mission",
    "map<int,list<int>>"
  }
}
_class("ChallengeFormationItem", Object)
ChallengeFormationItem = ChallengeFormationItem

function ChallengeFormationItem:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

ChallengeFormationItem._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("ChallengeMissionComponentInfo", ICampaignComponentInfo)
ChallengeMissionComponentInfo = ChallengeMissionComponentInfo

function ChallengeMissionComponentInfo:Constructor()
  self.m_challenge_unlock_time = {}
  self.m_select_affix = {}
  self.m_max_score = {}
  self.formation_list = {}
  self.m_pass_mission_info = {}
  self.new_look_ids = {}
end

ChallengeMissionComponentInfo._proto = {
  [1] = {
    "m_challenge_unlock_time",
    "map<int,time>"
  },
  [2] = {
    "m_select_affix",
    "map<int,list<int>>"
  },
  [3] = {
    "m_max_score",
    "map<int,int>"
  },
  [4] = {
    "formation_list",
    "list<ChallengeFormationItem>"
  },
  [5] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [6] = {
    "new_look_ids",
    "list<int>"
  }
}
_class("CChallengeMissionComponentDataInfo", ICampaignComponentDataInfo)
CChallengeMissionComponentDataInfo = CChallengeMissionComponentDataInfo

function CChallengeMissionComponentDataInfo:Constructor()
  self.m_select_affix = {}
  self.m_max_score = {}
  self.formation_list = {}
  self.m_pass_mission_info = {}
  self.new_look_ids = {}
end

CChallengeMissionComponentDataInfo._proto = {
  [1] = {
    "m_select_affix",
    "map<int,list<int>>"
  },
  [2] = {
    "m_max_score",
    "map<int,int>"
  },
  [3] = {
    "formation_list",
    "list<ChallengeFormationItem>"
  },
  [4] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [5] = {
    "new_look_ids",
    "list<int>"
  }
}
_class("ChallengeSelectAffixReq", ICampaignComRequest)
ChallengeSelectAffixReq = ChallengeSelectAffixReq

function ChallengeSelectAffixReq:Constructor()
  self.nCampaignMissionId = 0
  self.selectAffixIdArray = {}
end

ChallengeSelectAffixReq._proto = {
  [1] = {
    "nCampaignMissionId",
    "int"
  },
  [2] = {
    "selectAffixIdArray",
    "list<int>"
  }
}
_class("ChallengeSelectAffixRep", ICampaignComResponse)
ChallengeSelectAffixRep = ChallengeSelectAffixRep

function ChallengeSelectAffixRep:Constructor()
end

ChallengeSelectAffixRep._proto = {}
_class("ChallengeClearAffixReq", ICampaignComRequest)
ChallengeClearAffixReq = ChallengeClearAffixReq

function ChallengeClearAffixReq:Constructor()
  self.nChallengeMissionId = 0
end

ChallengeClearAffixReq._proto = {
  [1] = {
    "nChallengeMissionId",
    "int"
  }
}
_class("ChallengeClearAffixRep", ICampaignComResponse)
ChallengeClearAffixRep = ChallengeClearAffixRep

function ChallengeClearAffixRep:Constructor()
end

ChallengeClearAffixRep._proto = {}
local ChallengeComponentNotifyType = {ChallengeComponentNotifyType_ScoreChange = 1}
_enum("ChallengeComponentNotifyType", ChallengeComponentNotifyType)
_class("NotifyChallengeMissionScoreChanged", Object)
NotifyChallengeMissionScoreChanged = NotifyChallengeMissionScoreChanged

function NotifyChallengeMissionScoreChanged:Constructor()
  self.m_group_id = 0
  self.m_total_score = 0
  self.m_last_score = 0
  self.m_missions = {}
end

NotifyChallengeMissionScoreChanged._proto = {
  [1] = {"m_group_id", "int"},
  [2] = {
    "m_total_score",
    "int"
  },
  [3] = {
    "m_last_score",
    "int"
  },
  [4] = {
    "m_missions",
    "list<cam_mission_info>"
  }
}
_class("Power2ItemComponentInfo", ICampaignComponentInfo)
Power2ItemComponentInfo = Power2ItemComponentInfo

function Power2ItemComponentInfo:Constructor()
  self.m_total_count = 0
end

Power2ItemComponentInfo._proto = {
  [1] = {
    "m_total_count",
    "int64"
  }
}
_class("CPower2ItemComponentDataInfo", ICampaignComponentDataInfo)
CPower2ItemComponentDataInfo = CPower2ItemComponentDataInfo

function CPower2ItemComponentDataInfo:Constructor()
  self.m_total_count = 0
end

CPower2ItemComponentDataInfo._proto = {
  [1] = {
    "m_total_count",
    "int64"
  }
}
_class("SeniorSkinComponentInfo", ICampaignComponentInfo)
SeniorSkinComponentInfo = SeniorSkinComponentInfo

function SeniorSkinComponentInfo:Constructor()
  self.shake_num = 0
  self.shake_win_ids = {}
  self.skin_gain_time = {}
end

SeniorSkinComponentInfo._proto = {
  [1] = {"shake_num", "int"},
  [2] = {
    "shake_win_ids",
    "list<int>"
  },
  [3] = {
    "skin_gain_time",
    "map<int,time>"
  }
}
_class("SeniorSkinComponentDataInfo", ICampaignComponentDataInfo)
SeniorSkinComponentDataInfo = SeniorSkinComponentDataInfo

function SeniorSkinComponentDataInfo:Constructor()
  self.shake_num = 0
  self.shake_win_ids = {}
end

SeniorSkinComponentDataInfo._proto = {
  [1] = {"shake_num", "int"},
  [2] = {
    "shake_win_ids",
    "list<int>"
  }
}
_class("SeniorSkinComponentApplyShake", ICampaignComRequest)
SeniorSkinComponentApplyShake = SeniorSkinComponentApplyShake

function SeniorSkinComponentApplyShake:Constructor()
end

SeniorSkinComponentApplyShake._proto = {}
_class("SeniorSkinComponentApplyShakeReplay", ICampaignComResponse)
SeniorSkinComponentApplyShakeReplay = SeniorSkinComponentApplyShakeReplay

function SeniorSkinComponentApplyShakeReplay:Constructor()
  self.id = 0
end

SeniorSkinComponentApplyShakeReplay._proto = {
  [1] = {"id", "int"}
}
_class("CycleQuestComponentInfo", ICampaignComponentInfo)
CycleQuestComponentInfo = CycleQuestComponentInfo

function CycleQuestComponentInfo:Constructor()
  self.cur_score = 0
  self.today_socre_max = 0
end

CycleQuestComponentInfo._proto = {
  [1] = {"cur_score", "int"},
  [2] = {
    "today_socre_max",
    "int"
  }
}
_class("CycleQuestComponentDataInfo", ICampaignComponentDataInfo)
CycleQuestComponentDataInfo = CycleQuestComponentDataInfo

function CycleQuestComponentDataInfo:Constructor()
  self.cur_score = 0
end

CycleQuestComponentDataInfo._proto = {
  [1] = {"cur_score", "int"}
}
_class("NotifyCycleQuesetComponentUpdateScore", Object)
NotifyCycleQuesetComponentUpdateScore = NotifyCycleQuesetComponentUpdateScore

function NotifyCycleQuesetComponentUpdateScore:Constructor()
  self.list_quest_id = 0
  self.cur_score = 0
  self.today_socre_max = 0
end

NotifyCycleQuesetComponentUpdateScore._proto = {
  [1] = {
    "list_quest_id",
    "int"
  },
  [2] = {"cur_score", "int"},
  [3] = {
    "today_socre_max",
    "int"
  }
}
local ChessComponentNotifyType = {ChessMissionComponentNotifyType_InfoChanged = 1}
_enum("ChessComponentNotifyType", ChessComponentNotifyType)
_class("NotifyChessComponentInfoChanged", Object)
NotifyChessComponentInfoChanged = NotifyChessComponentInfoChanged

function NotifyChessComponentInfoChanged:Constructor()
  self.m_update_mission_info = {}
end

NotifyChessComponentInfoChanged._proto = {
  [1] = {
    "m_update_mission_info",
    "map<int,cam_mission_info>"
  }
}
_class("ChessComponentInfo", ICampaignComponentInfo)
ChessComponentInfo = ChessComponentInfo

function ChessComponentInfo:Constructor()
  self.m_pass_mission_info = {}
end

ChessComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  }
}
_class("ChessComponentDataInfo", ICampaignComponentDataInfo)
ChessComponentDataInfo = ChessComponentDataInfo

function ChessComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_fight_mission = {}
end

ChessComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_fight_mission",
    "list<int>"
  }
}
_class("MissionDropComponentInfo", ICampaignComponentInfo)
MissionDropComponentInfo = MissionDropComponentInfo

function MissionDropComponentInfo:Constructor()
  self.m_total_count = 0
end

MissionDropComponentInfo._proto = {
  [1] = {
    "m_total_count",
    "int64"
  }
}
_class("MissionDropComponentDataInfo", ICampaignComponentDataInfo)
MissionDropComponentDataInfo = MissionDropComponentDataInfo

function MissionDropComponentDataInfo:Constructor()
  self.m_total_count = 0
end

MissionDropComponentDataInfo._proto = {
  [1] = {
    "m_total_count",
    "int64"
  }
}
local ETimeRewardRewardStatus = {
  E_TIME_REWARD_UNKNOW = 0,
  E_TIME_REWARD_CAN_RECV = 1,
  E_TIME_REWARD_RECVED = 2,
  E_TIME_REWARD_LOCK = 3
}
_enum("ETimeRewardRewardStatus", ETimeRewardRewardStatus)
_class("TimeRewardInfo", Object)
TimeRewardInfo = TimeRewardInfo

function TimeRewardInfo:Constructor()
  self.reward_id = 0
  self.unlock_time = 0
  self.rewards = {}
  self.rec_reward_status = ETimeRewardRewardStatus.E_TIME_REWARD_UNKNOW
end

TimeRewardInfo._proto = {
  [1] = {"reward_id", "int"},
  [2] = {
    "unlock_time",
    "time"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  },
  [4] = {
    "rec_reward_status",
    "int"
  }
}
_class("TimeRewardComponentInfo", ICampaignComponentInfo)
TimeRewardComponentInfo = TimeRewardComponentInfo

function TimeRewardComponentInfo:Constructor()
  self.m_reward_info = {}
end

TimeRewardComponentInfo._proto = {
  [1] = {
    "m_reward_info",
    "map<int,TimeRewardInfo>"
  }
}
_class("TimeRewardComponentDataInfo", ICampaignComponentDataInfo)
TimeRewardComponentDataInfo = TimeRewardComponentDataInfo

function TimeRewardComponentDataInfo:Constructor()
  self.m_rev_reward_id = {}
end

TimeRewardComponentDataInfo._proto = {
  [1] = {
    "m_rev_reward_id",
    "list<int>"
  }
}
_class("TakeRewardReq", ICampaignComRequest)
TakeRewardReq = TakeRewardReq

function TakeRewardReq:Constructor()
  self.reward_id = 0
end

TakeRewardReq._proto = {
  [1] = {"reward_id", "int"}
}
_class("TakeRewardRep", ICampaignComResponse)
TakeRewardRep = TakeRewardRep

function TakeRewardRep:Constructor()
  self.m_rewards = {}
end

TakeRewardRep._proto = {
  [1] = {
    "m_rewards",
    "list<RoleAsset>"
  }
}
_class("HomelandGroupTaskComponentInfo", ICampaignComponentInfo)
HomelandGroupTaskComponentInfo = HomelandGroupTaskComponentInfo

function HomelandGroupTaskComponentInfo:Constructor()
  self.task_group_id = {}
end

HomelandGroupTaskComponentInfo._proto = {
  [1] = {
    "task_group_id",
    "list<int>"
  }
}
_class("AVGStoryFormationInfo", Object)
AVGStoryFormationInfo = AVGStoryFormationInfo

function AVGStoryFormationInfo:Constructor()
  self.leader_hp = 0
  self.teammate_affinity = {}
  self.evidence = {}
end

AVGStoryFormationInfo._proto = {
  [1] = {"leader_hp", "int"},
  [2] = {
    "teammate_affinity",
    "list<int>"
  },
  [3] = {"evidence", "list<int>"}
}
_class("AVGStoryMissionInfo", Object)
AVGStoryMissionInfo = AVGStoryMissionInfo

function AVGStoryMissionInfo:Constructor()
  self.mission_id = 0
  self.end_formation_info = AVGStoryFormationInfo:New()
  self.update_time = 0
  self.new_mark = true
  self.from_nodes = {}
end

AVGStoryMissionInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "end_formation_info",
    "AVGStoryFormationInfo"
  },
  [3] = {
    "update_time",
    "time"
  },
  [4] = {"new_mark", "bool"},
  [5] = {"from_nodes", "list<int>"}
}
_class("AVGStoryComponentDataInfo", ICampaignComponentDataInfo)
AVGStoryComponentDataInfo = AVGStoryComponentDataInfo

function AVGStoryComponentDataInfo:Constructor()
  self.mission_datas = {}
  self.accepted_badge_rewards = {}
  self.choosed_manual_ids = {}
  self.conplated_ending_ids = {}
  self.conplated_node_ids = {}
  self.cur_node_id = 0
  self.showed_evidence = {}
  self.gained_evidence = {}
end

AVGStoryComponentDataInfo._proto = {
  [1] = {
    "mission_datas",
    "map<int,AVGStoryMissionInfo>"
  },
  [2] = {
    "accepted_badge_rewards",
    "list<int>"
  },
  [3] = {
    "choosed_manual_ids",
    "list<int>"
  },
  [4] = {
    "conplated_ending_ids",
    "list<int>"
  },
  [5] = {
    "conplated_node_ids",
    "list<int>"
  },
  [6] = {
    "cur_node_id",
    "int"
  },
  [7] = {
    "showed_evidence",
    "map<int,list<int>>"
  },
  [8] = {
    "gained_evidence",
    "list<int>"
  }
}
_class("AVGStoryComponentClientInfo", ICampaignComponentInfo)
AVGStoryComponentClientInfo = AVGStoryComponentClientInfo

function AVGStoryComponentClientInfo:Constructor()
  self.mission_datas = {}
  self.accepted_badge_rewards = {}
  self.choosed_manual_ids = {}
  self.conplated_ending_ids = {}
  self.conplated_node_ids = {}
  self.cur_node_id = 0
  self.showed_evidence = {}
  self.gained_evidence = {}
end

AVGStoryComponentClientInfo._proto = {
  [1] = {
    "mission_datas",
    "map<int,AVGStoryMissionInfo>"
  },
  [2] = {
    "accepted_badge_rewards",
    "list<int>"
  },
  [3] = {
    "choosed_manual_ids",
    "list<int>"
  },
  [4] = {
    "conplated_ending_ids",
    "list<int>"
  },
  [5] = {
    "conplated_node_ids",
    "list<int>"
  },
  [6] = {
    "cur_node_id",
    "int"
  },
  [7] = {
    "showed_evidence",
    "map<int,list<int>>"
  },
  [8] = {
    "gained_evidence",
    "list<int>"
  }
}
_class("AvgSetCurrentLocationReq", ICampaignComRequest)
AvgSetCurrentLocationReq = AvgSetCurrentLocationReq

function AvgSetCurrentLocationReq:Constructor()
  self.Node_id = 0
end

AvgSetCurrentLocationReq._proto = {
  [1] = {"Node_id", "int"}
}
_class("AvgSetCurrentLocationRsp", ICampaignComResponse)
AvgSetCurrentLocationRsp = AvgSetCurrentLocationRsp

function AvgSetCurrentLocationRsp:Constructor()
  self.ret = 0
end

AvgSetCurrentLocationRsp._proto = {
  [1] = {"ret", "int"}
}
_class("AvgUpdateNodeDataReq", ICampaignComRequest)
AvgUpdateNodeDataReq = AvgUpdateNodeDataReq

function AvgUpdateNodeDataReq:Constructor()
  self.data = AVGStoryMissionInfo:New()
  self.complate_mission_id = 0
end

AvgUpdateNodeDataReq._proto = {
  [1] = {
    "data",
    "AVGStoryMissionInfo"
  },
  [2] = {
    "complate_mission_id",
    "int"
  }
}
_class("AvgUpdateNodeDataRsp", ICampaignComResponse)
AvgUpdateNodeDataRsp = AvgUpdateNodeDataRsp

function AvgUpdateNodeDataRsp:Constructor()
  self.ret = 0
end

AvgUpdateNodeDataRsp._proto = {
  [1] = {"ret", "int"}
}
_class("AvgComplateEndingReq", ICampaignComRequest)
AvgComplateEndingReq = AvgComplateEndingReq

function AvgComplateEndingReq:Constructor()
  self.ending_id = 0
end

AvgComplateEndingReq._proto = {
  [1] = {"ending_id", "int"}
}
_class("AvgComplateEndingRsp", ICampaignComResponse)
AvgComplateEndingRsp = AvgComplateEndingRsp

function AvgComplateEndingRsp:Constructor()
  self.ret = 0
end

AvgComplateEndingRsp._proto = {
  [1] = {"ret", "int"}
}
_class("AvgManualChooseReq", ICampaignComRequest)
AvgManualChooseReq = AvgManualChooseReq

function AvgManualChooseReq:Constructor()
  self.manual_id = 0
end

AvgManualChooseReq._proto = {
  [1] = {"manual_id", "int"}
}
_class("AvgManualChooseRsp", ICampaignComResponse)
AvgManualChooseRsp = AvgManualChooseRsp

function AvgManualChooseRsp:Constructor()
  self.ret = 0
end

AvgManualChooseRsp._proto = {
  [1] = {"ret", "int"}
}
_class("AvgGainEvidenceReq", ICampaignComRequest)
AvgGainEvidenceReq = AvgGainEvidenceReq

function AvgGainEvidenceReq:Constructor()
  self.evidence_id = 0
end

AvgGainEvidenceReq._proto = {
  [1] = {
    "evidence_id",
    "int"
  }
}
_class("AvgGainEvidenceRsp", ICampaignComResponse)
AvgGainEvidenceRsp = AvgGainEvidenceRsp

function AvgGainEvidenceRsp:Constructor()
  self.ret = 0
end

AvgGainEvidenceRsp._proto = {
  [1] = {"ret", "int"}
}
_class("AvgShowEvidenceReq", ICampaignComRequest)
AvgShowEvidenceReq = AvgShowEvidenceReq

function AvgShowEvidenceReq:Constructor()
  self.evidence_manual_id = 0
  self.evidence_id = 0
end

AvgShowEvidenceReq._proto = {
  [1] = {
    "evidence_manual_id",
    "int"
  },
  [2] = {
    "evidence_id",
    "int"
  }
}
_class("AvgShowEvidenceRsp", ICampaignComResponse)
AvgShowEvidenceRsp = AvgShowEvidenceRsp

function AvgShowEvidenceRsp:Constructor()
  self.ret = 0
end

AvgShowEvidenceRsp._proto = {
  [1] = {"ret", "int"}
}
_class("AvgAcceptBadgeRewardReq", ICampaignComRequest)
AvgAcceptBadgeRewardReq = AvgAcceptBadgeRewardReq

function AvgAcceptBadgeRewardReq:Constructor()
  self.badge_reward_id = 0
end

AvgAcceptBadgeRewardReq._proto = {
  [1] = {
    "badge_reward_id",
    "int"
  }
}
_class("AvgAcceptBadgeRewardRsp", ICampaignComResponse)
AvgAcceptBadgeRewardRsp = AvgAcceptBadgeRewardRsp

function AvgAcceptBadgeRewardRsp:Constructor()
  self.ret = 0
end

AvgAcceptBadgeRewardRsp._proto = {
  [1] = {"ret", "int"}
}
local PointProgressComponentNotifyType = {PointProgressComponentNotify_StepChanged = 1}
_enum("PointProgressComponentNotifyType", PointProgressComponentNotifyType)
_class("CPointProgressComponentDataInfo", ICampaignComponentDataInfo)
CPointProgressComponentDataInfo = CPointProgressComponentDataInfo

function CPointProgressComponentDataInfo:Constructor()
  self.m_received_progress = {}
  self.m_cur_progress = 0
end

CPointProgressComponentDataInfo._proto = {
  [1] = {
    "m_received_progress",
    "list<int64>"
  },
  [2] = {
    "m_cur_progress",
    "int64"
  }
}
_class("PointProgressComponentInfo", ICampaignComponentInfo)
PointProgressComponentInfo = PointProgressComponentInfo

function PointProgressComponentInfo:Constructor()
  self.m_total_progress = 0
  self.m_current_progress = 0
  self.m_received_progress = {}
  self.m_progress_rewards = {}
  self.m_special_rewards = {}
end

PointProgressComponentInfo._proto = {
  [1] = {
    "m_total_progress",
    "int64"
  },
  [2] = {
    "m_current_progress",
    "int64"
  },
  [3] = {
    "m_received_progress",
    "list<int64>"
  },
  [4] = {
    "m_progress_rewards",
    "map<int64,list<RoleAsset>>"
  },
  [5] = {
    "m_special_rewards",
    "map<int64,list<RoleAsset>>"
  }
}
_class("PointProgressComponentReceiveRewardReq", ICampaignComRequest)
PointProgressComponentReceiveRewardReq = PointProgressComponentReceiveRewardReq

function PointProgressComponentReceiveRewardReq:Constructor()
  self.m_progress = 0
end

PointProgressComponentReceiveRewardReq._proto = {
  [1] = {"m_progress", "int64"}
}
_class("PointProgressComponentReceiveRewardRep", ICampaignComResponse)
PointProgressComponentReceiveRewardRep = PointProgressComponentReceiveRewardRep

function PointProgressComponentReceiveRewardRep:Constructor()
  self.m_rewards = {}
end

PointProgressComponentReceiveRewardRep._proto = {
  [1] = {
    "m_rewards",
    "list<RoleAsset>"
  }
}
_class("PointProgressComponentOneKeyReceiveRewardReq", ICampaignComRequest)
PointProgressComponentOneKeyReceiveRewardReq = PointProgressComponentOneKeyReceiveRewardReq

function PointProgressComponentOneKeyReceiveRewardReq:Constructor()
end

PointProgressComponentOneKeyReceiveRewardReq._proto = {}
_class("PointProgressComponentOneKeyReceiveRewardRep", ICampaignComResponse)
PointProgressComponentOneKeyReceiveRewardRep = PointProgressComponentOneKeyReceiveRewardRep

function PointProgressComponentOneKeyReceiveRewardRep:Constructor()
  self.m_rewards = {}
end

PointProgressComponentOneKeyReceiveRewardRep._proto = {
  [1] = {
    "m_rewards",
    "list<RoleAsset>"
  }
}
_class("NotifyPointProgressComponentItemCountChanged", Object)
NotifyPointProgressComponentItemCountChanged = NotifyPointProgressComponentItemCountChanged

function NotifyPointProgressComponentItemCountChanged:Constructor()
  self.m_cur_progress = 0
end

NotifyPointProgressComponentItemCountChanged._proto = {
  [1] = {
    "m_cur_progress",
    "int64"
  }
}
_class("HomlandTaskComponentGetReq", ICampaignComRequest)
HomlandTaskComponentGetReq = HomlandTaskComponentGetReq

function HomlandTaskComponentGetReq:Constructor()
  self.id = 0
end

HomlandTaskComponentGetReq._proto = {
  [1] = {"id", "int"}
}
_class("HomlandTaskComponentGetReply", ICampaignComResponse)
HomlandTaskComponentGetReply = HomlandTaskComponentGetReply

function HomlandTaskComponentGetReply:Constructor()
end

HomlandTaskComponentGetReply._proto = {}
_class("HomlandTaskComponentInfo", ICampaignComponentInfo)
HomlandTaskComponentInfo = HomlandTaskComponentInfo

function HomlandTaskComponentInfo:Constructor()
  self.m_id = {}
end

HomlandTaskComponentInfo._proto = {
  [1] = {"m_id", "list<int>"}
}
_class("ChallengeChangeFormationReq", ICampaignComRequest)
ChallengeChangeFormationReq = ChallengeChangeFormationReq

function ChallengeChangeFormationReq:Constructor()
  self.info = ChallengeFormationItem:New()
end

ChallengeChangeFormationReq._proto = {
  [1] = {
    "info",
    "ChallengeFormationItem"
  }
}
_class("ChallengeChangeFormationReply", ICampaignComResponse)
ChallengeChangeFormationReply = ChallengeChangeFormationReply

function ChallengeChangeFormationReply:Constructor()
  self.ret = 0
end

ChallengeChangeFormationReply._proto = {
  [1] = {"ret", "int"}
}
_class("ChallengeClearNewReq", ICampaignComRequest)
ChallengeClearNewReq = ChallengeClearNewReq

function ChallengeClearNewReq:Constructor()
  self.look_ids = {}
end

ChallengeClearNewReq._proto = {
  [1] = {"look_ids", "list<int>"}
}
_class("ChallengeClearNewRep", ICampaignComResponse)
ChallengeClearNewRep = ChallengeClearNewRep

function ChallengeClearNewRep:Constructor()
  self.new_look_ids = {}
end

ChallengeClearNewRep._proto = {
  [1] = {
    "new_look_ids",
    "list<int>"
  }
}
local BloodsuckerComponentNotifyType = {BloodsuckerComponentNotify_TalentTreeChange = 1}
_enum("BloodsuckerComponentNotifyType", BloodsuckerComponentNotifyType)
_class("BloodsuckerMissionInfo", Object)
BloodsuckerMissionInfo = BloodsuckerMissionInfo

function BloodsuckerMissionInfo:Constructor()
  self.mission_id = 0
  self.is_pass = 0
end

BloodsuckerMissionInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"is_pass", "int"}
}
_class("TalentTreeLayerInfo", Object)
TalentTreeLayerInfo = TalentTreeLayerInfo

function TalentTreeLayerInfo:Constructor()
  self.skill_nodes = {}
end

TalentTreeLayerInfo._proto = {
  [1] = {
    "skill_nodes",
    "map<int,TalentTreeSkillNode>"
  }
}
_class("TalentTreeInfo", Object)
TalentTreeInfo = TalentTreeInfo

function TalentTreeInfo:Constructor()
  self.cur_exp = 0
  self.cur_talent_point = 0
  self.talent_level = 0
  self.infos = {}
  self.select_row = 0
  self.select_index = 0
end

TalentTreeInfo._proto = {
  [1] = {"cur_exp", "uint"},
  [2] = {
    "cur_talent_point",
    "uint"
  },
  [3] = {
    "talent_level",
    "int"
  },
  [4] = {
    "infos",
    "map<int,TalentTreeLayerInfo>"
  },
  [5] = {"select_row", "int"},
  [6] = {
    "select_index",
    "int"
  }
}
_class("PetNodeInfo", Object)
PetNodeInfo = PetNodeInfo

function PetNodeInfo:Constructor()
  self.is_try = 0
  self.pet_id = 0
end

PetNodeInfo._proto = {
  [1] = {"is_try", "int"},
  [2] = {"pet_id", "int"}
}
_class("BloodsuckerComponentInfo", ICampaignComponentInfo)
BloodsuckerComponentInfo = BloodsuckerComponentInfo

function BloodsuckerComponentInfo:Constructor()
  self.mission_infos = {}
  self.talent_info = TalentTreeInfo:New()
  self.pass_pet_list = {}
  self.join_mission_list = {}
end

BloodsuckerComponentInfo._proto = {
  [1] = {
    "mission_infos",
    "map<int,BloodsuckerMissionInfo>"
  },
  [2] = {
    "talent_info",
    "TalentTreeInfo"
  },
  [3] = {
    "pass_pet_list",
    "list<int>"
  },
  [4] = {
    "join_mission_list",
    "list<int>"
  }
}
_class("BloodsuckerComponentUpgradeTalentPointReq", ICampaignComRequest)
BloodsuckerComponentUpgradeTalentPointReq = BloodsuckerComponentUpgradeTalentPointReq

function BloodsuckerComponentUpgradeTalentPointReq:Constructor()
  self.row = 0
  self.index = 0
end

BloodsuckerComponentUpgradeTalentPointReq._proto = {
  [1] = {"row", "int"},
  [2] = {"index", "int"}
}
_class("BloodsuckerComponentUpgradeTalentPointRes", ICampaignComResponse)
BloodsuckerComponentUpgradeTalentPointRes = BloodsuckerComponentUpgradeTalentPointRes

function BloodsuckerComponentUpgradeTalentPointRes:Constructor()
  self.ret = 0
end

BloodsuckerComponentUpgradeTalentPointRes._proto = {
  [1] = {"ret", "int"}
}
_class("NotifyBloodsuckerComponentTalentTreeChanged", Object)
NotifyBloodsuckerComponentTalentTreeChanged = NotifyBloodsuckerComponentTalentTreeChanged

function NotifyBloodsuckerComponentTalentTreeChanged:Constructor()
  self.tree_info = TalentTreeInfo:New()
end

NotifyBloodsuckerComponentTalentTreeChanged._proto = {
  [1] = {
    "tree_info",
    "TalentTreeInfo"
  }
}
_class("BloodsuckerComponentSelectSkillReq", ICampaignComRequest)
BloodsuckerComponentSelectSkillReq = BloodsuckerComponentSelectSkillReq

function BloodsuckerComponentSelectSkillReq:Constructor()
  self.row = 0
  self.index = 0
end

BloodsuckerComponentSelectSkillReq._proto = {
  [1] = {"row", "int"},
  [2] = {"index", "int"}
}
_class("BloodsuckerComponentSelectSkillRes", ICampaignComResponse)
BloodsuckerComponentSelectSkillRes = BloodsuckerComponentSelectSkillRes

function BloodsuckerComponentSelectSkillRes:Constructor()
  self.ret = 0
end

BloodsuckerComponentSelectSkillRes._proto = {
  [1] = {"ret", "int"}
}
_class("BloodsuckerComponentResetTalentTreeReq", ICampaignComRequest)
BloodsuckerComponentResetTalentTreeReq = BloodsuckerComponentResetTalentTreeReq

function BloodsuckerComponentResetTalentTreeReq:Constructor()
end

BloodsuckerComponentResetTalentTreeReq._proto = {}
_class("BloodsuckerComponentResetTalentTreeRes", ICampaignComResponse)
BloodsuckerComponentResetTalentTreeRes = BloodsuckerComponentResetTalentTreeRes

function BloodsuckerComponentResetTalentTreeRes:Constructor()
  self.ret = 0
end

BloodsuckerComponentResetTalentTreeRes._proto = {
  [1] = {"ret", "int"}
}
_class("BloodsuckerComponentChangeFormationReq", ICampaignComRequest)
BloodsuckerComponentChangeFormationReq = BloodsuckerComponentChangeFormationReq

function BloodsuckerComponentChangeFormationReq:Constructor()
  self.formation_pet_list = {}
end

BloodsuckerComponentChangeFormationReq._proto = {
  [1] = {
    "formation_pet_list",
    "list<PetNodeInfo>"
  }
}
_class("BloodsuckerComponentFormationRep", ICampaignComResponse)
BloodsuckerComponentFormationRep = BloodsuckerComponentFormationRep

function BloodsuckerComponentFormationRep:Constructor()
  self.nFormationRet = 0
end

BloodsuckerComponentFormationRep._proto = {
  [1] = {
    "nFormationRet",
    "int"
  }
}
local IdolTrainType = {
  IdolTrainType_None = 0,
  IdolTrainType_Music = 1,
  IdolTrainType_Dance = 2,
  IdolTrainType_Perform = 3
}
_enum("IdolTrainType", IdolTrainType)
local IdolEventType = {IdolEventType_Agree = 1, IdolEventType_Suddenly = 2}
_enum("IdolEventType", IdolEventType)
local IdolConstType = {
  IdolConstType_SuddenlyMax = 100,
  IdolConstType_MusicInit = 101,
  IdolConstType_DanceInit = 102,
  IdolConstType_PerformInit = 103,
  IdolConstType_FunsInit = 104,
  IdolConstType_MaxRound = 105
}
_enum("IdolConstType", IdolConstType)
local IdolRoundState = {
  IdolRoundState_None = 0,
  IdolRoundState_Begin = 1,
  IdolRoundState_Play = 2,
  IdolRoundState_End = 3
}
_enum("IdolRoundState", IdolRoundState)
local IdolWeekType = {
  IdolWeekType_First = 1,
  IdolWeekType_Second = 2,
  IdolWeekType_Third = 3,
  IdolWeekType_Forth = 4,
  IdolWeekType_Fifth = 5,
  IdolWeekType_Sixth = 6,
  IdolWeekType_Max = 7
}
_enum("IdolWeekType", IdolWeekType)
local IdolAchieveState = {IdolAchieveState_CanRecv = 0, IdolAchieveState_Recved = 1}
_enum("IdolAchieveState", IdolAchieveState)
local IdolProcessType = {
  IdolProcessType_None = 0,
  IdolProcessType_First = 1,
  IdolProcessType_Second = 2,
  IdolProcessType_Third = 3,
  IdolProcessType_Forth = 4,
  IdolProcessType_Fifth = 5
}
_enum("IdolProcessType", IdolProcessType)
local IdolStartType = {
  IdolStartType_None = 0,
  IdolStartType_New = 1,
  IdolStartType_Break = 2,
  IdolStartType_Process = 3
}
_enum("IdolStartType", IdolStartType)
local IdolOptionType = {
  IdolOptionType_None = 0,
  IdolOptionType_First = 1,
  IdolOptionType_Second = 2,
  IdolOptionType_Third = 3
}
_enum("IdolOptionType", IdolOptionType)
_class("IdolProgressInfo", Object)
IdolProgressInfo = IdolProgressInfo

function IdolProgressInfo:Constructor()
  self.round_index = 0
  self.round_state = 0
  self.train_type = 0
  self.note_time = 0
  self.train_data = {}
  self.funs_num = 0
  self.level = {}
  self.agree_events = {}
  self.suddenly_events = {}
  self.finish_activity = {}
  self.suddenly_events_id = {}
  self.train_num = {}
  self.local_ending = 0
  self.isConcertDone = false
end

IdolProgressInfo._proto = {
  [1] = {
    "round_index",
    "int"
  },
  [2] = {
    "round_state",
    "int"
  },
  [3] = {"train_type", "int"},
  [4] = {"note_time", "time"},
  [5] = {
    "train_data",
    "map<int,int>"
  },
  [6] = {"funs_num", "int"},
  [7] = {
    "level",
    "map<int,int>"
  },
  [8] = {
    "agree_events",
    "list<int>"
  },
  [9] = {
    "suddenly_events",
    "map<int,int>"
  },
  [10] = {
    "finish_activity",
    "list<int>"
  },
  [11] = {
    "suddenly_events_id",
    "list<int>"
  },
  [12] = {
    "train_num",
    "map<int,int>"
  },
  [13] = {
    "local_ending",
    "int"
  },
  [14] = {
    "isConcertDone",
    "bool"
  }
}
_class("IdolCollectinfo", Object)
IdolCollectinfo = IdolCollectinfo

function IdolCollectinfo:Constructor()
  self.ending_list = {}
  self.agree_events = {}
  self.achieve_list = {}
end

IdolCollectinfo._proto = {
  [1] = {
    "ending_list",
    "list<int>"
  },
  [2] = {
    "agree_events",
    "list<int>"
  },
  [3] = {
    "achieve_list",
    "map<int,int>"
  }
}
_class("IdolComponentDataInfo", ICampaignComponentDataInfo)
IdolComponentDataInfo = IdolComponentDataInfo

function IdolComponentDataInfo:Constructor()
  self.break_info = IdolProgressInfo:New()
  self.process_info = {}
  self.collect_info = IdolCollectinfo:New()
  self.play_times = 0
end

IdolComponentDataInfo._proto = {
  [1] = {
    "break_info",
    "IdolProgressInfo"
  },
  [2] = {
    "process_info",
    "map<int,IdolProgressInfo>"
  },
  [3] = {
    "collect_info",
    "IdolCollectinfo"
  },
  [4] = {"play_times", "int"}
}
_class("IdolProgressShowInfo", Object)
IdolProgressShowInfo = IdolProgressShowInfo

function IdolProgressShowInfo:Constructor()
  self.round_index = 0
  self.note_time = 0
  self.train_data = {}
  self.funs_num = 0
end

IdolProgressShowInfo._proto = {
  [1] = {
    "round_index",
    "int"
  },
  [2] = {"note_time", "time"},
  [3] = {
    "train_data",
    "map<int,int>"
  },
  [4] = {"funs_num", "int"}
}
_class("IdolComponentInfo", ICampaignComponentInfo)
IdolComponentInfo = IdolComponentInfo

function IdolComponentInfo:Constructor()
  self.break_info = IdolProgressInfo:New()
  self.process_info = {}
  self.collect_info = IdolCollectinfo:New()
  self.ending_list = {}
end

IdolComponentInfo._proto = {
  [1] = {
    "break_info",
    "IdolProgressInfo"
  },
  [2] = {
    "process_info",
    "map<int,IdolProgressShowInfo>"
  },
  [3] = {
    "collect_info",
    "IdolCollectinfo"
  },
  [4] = {
    "ending_list",
    "list<int>"
  }
}
_class("IdolStartPlayReq", ICampaignComRequest)
IdolStartPlayReq = IdolStartPlayReq

function IdolStartPlayReq:Constructor()
  self.start_type = 0
  self.process_type = 0
end

IdolStartPlayReq._proto = {
  [1] = {"start_type", "int"},
  [2] = {
    "process_type",
    "int"
  }
}
_class("IdolStartPlayRep", ICampaignComResponse)
IdolStartPlayRep = IdolStartPlayRep

function IdolStartPlayRep:Constructor()
  self.ret = 0
  self.break_info = IdolProgressInfo:New()
end

IdolStartPlayRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "break_info",
    "IdolProgressInfo"
  }
}
_class("IdolTrainReq", ICampaignComRequest)
IdolTrainReq = IdolTrainReq

function IdolTrainReq:Constructor()
  self.round_index = 0
  self.round_state = 0
  self.train_type = 0
end

IdolTrainReq._proto = {
  [1] = {
    "round_index",
    "int"
  },
  [2] = {
    "round_state",
    "int"
  },
  [3] = {"train_type", "int"}
}
_class("IdolTrainRep", ICampaignComResponse)
IdolTrainRep = IdolTrainRep

function IdolTrainRep:Constructor()
  self.ret = 0
  self.break_info = IdolProgressInfo:New()
end

IdolTrainRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "break_info",
    "IdolProgressInfo"
  }
}
_class("IdolCompleteEventReq", ICampaignComRequest)
IdolCompleteEventReq = IdolCompleteEventReq

function IdolCompleteEventReq:Constructor()
  self.event_type = 0
  self.option_type = 0
  self.event_id = 0
  self.train_type = 0
end

IdolCompleteEventReq._proto = {
  [1] = {"event_type", "int"},
  [2] = {
    "option_type",
    "int"
  },
  [3] = {"event_id", "int"},
  [4] = {"train_type", "int"}
}
_class("IdolCompleteEventRep", ICampaignComResponse)
IdolCompleteEventRep = IdolCompleteEventRep

function IdolCompleteEventRep:Constructor()
  self.ret = 0
  self.break_info = IdolProgressInfo:New()
end

IdolCompleteEventRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "break_info",
    "IdolProgressInfo"
  }
}
_class("IdolCompleteActivityReq", ICampaignComRequest)
IdolCompleteActivityReq = IdolCompleteActivityReq

function IdolCompleteActivityReq:Constructor()
  self.activity_id = 0
end

IdolCompleteActivityReq._proto = {
  [1] = {
    "activity_id",
    "int"
  }
}
_class("IdolCompleteActivityRep", ICampaignComResponse)
IdolCompleteActivityRep = IdolCompleteActivityRep

function IdolCompleteActivityRep:Constructor()
  self.ret = 0
  self.break_info = IdolProgressInfo:New()
end

IdolCompleteActivityRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "break_info",
    "IdolProgressInfo"
  }
}
_class("IdolGetAchieveRewardReq", ICampaignComRequest)
IdolGetAchieveRewardReq = IdolGetAchieveRewardReq

function IdolGetAchieveRewardReq:Constructor()
  self.achieve_id = 0
end

IdolGetAchieveRewardReq._proto = {
  [1] = {"achieve_id", "int"}
}
_class("IdolGetAchieveRewardRep", ICampaignComResponse)
IdolGetAchieveRewardRep = IdolGetAchieveRewardRep

function IdolGetAchieveRewardRep:Constructor()
  self.ret = 0
  self.collect_info = IdolCollectinfo:New()
end

IdolGetAchieveRewardRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "collect_info",
    "IdolCollectinfo"
  }
}
_class("IdolComplateEndingReq", ICampaignComRequest)
IdolComplateEndingReq = IdolComplateEndingReq

function IdolComplateEndingReq:Constructor()
  self.ending_id = 0
end

IdolComplateEndingReq._proto = {
  [1] = {"ending_id", "int"}
}
_class("IdolComplateEndingRep", ICampaignComResponse)
IdolComplateEndingRep = IdolComplateEndingRep

function IdolComplateEndingRep:Constructor()
  self.ret = 0
  self.ending_list = {}
end

IdolComplateEndingRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "ending_list",
    "list<int>"
  }
}
_class("IdolConcertFailReq", ICampaignComRequest)
IdolConcertFailReq = IdolConcertFailReq

function IdolConcertFailReq:Constructor()
  self.isSucess = false
end

IdolConcertFailReq._proto = {
  [1] = {"isSucess", "bool"}
}
_class("IdolConcertFailRep", ICampaignComResponse)
IdolConcertFailRep = IdolConcertFailRep

function IdolConcertFailRep:Constructor()
  self.ret = 0
end

IdolConcertFailRep._proto = {
  [1] = {"ret", "int"}
}
local NewYearDinner_Status = {
  E_NewYearDinner_Status_LOCK = 0,
  E_NewYearDinner_Status_UN_FINISH = 1,
  E_NewYearDinner_Status_CAN_RECV = 2,
  E_NewYearDinner_Status_RECVED = 3
}
_enum("NewYearDinner_Status", NewYearDinner_Status)
local NewYearDinner_Reward_Type = {
  E_NewYearDinner_Reward_Task = 0,
  E_NewYearDinner_Reward_Food = 1,
  E_NewYearDinner_Reward_Collect = 2
}
_enum("NewYearDinner_Reward_Type", NewYearDinner_Reward_Type)
_class("NewYearDinner_Task", Object)
NewYearDinner_Task = NewYearDinner_Task

function NewYearDinner_Task:Constructor()
  self.task_id = 0
  self.status = 0
  self.cur_progress = 0
  self.total_progress = 0
end

NewYearDinner_Task._proto = {
  [1] = {"task_id", "int"},
  [2] = {"status", "int"},
  [3] = {
    "cur_progress",
    "int"
  },
  [4] = {
    "total_progress",
    "int"
  }
}
_class("NewYearDinnerInfo", Object)
NewYearDinnerInfo = NewYearDinnerInfo

function NewYearDinnerInfo:Constructor()
  self.food_list = {}
  self.collect_list = {}
end

NewYearDinnerInfo._proto = {
  [1] = {
    "food_list",
    "map<int,int>"
  },
  [2] = {
    "collect_list",
    "map<int,int>"
  }
}
_class("NewYearDinnerComponentDataInfo", ICampaignComponentDataInfo)
NewYearDinnerComponentDataInfo = NewYearDinnerComponentDataInfo

function NewYearDinnerComponentDataInfo:Constructor()
  self.data_info = NewYearDinnerInfo:New()
  self.task_list = {}
  self.last_refresh_time = 0
end

NewYearDinnerComponentDataInfo._proto = {
  [1] = {
    "data_info",
    "NewYearDinnerInfo"
  },
  [2] = {
    "task_list",
    "map<int,int>"
  },
  [3] = {
    "last_refresh_time",
    "time"
  }
}
_class("NewYearDinnerComponentInfo", ICampaignComponentInfo)
NewYearDinnerComponentInfo = NewYearDinnerComponentInfo

function NewYearDinnerComponentInfo:Constructor()
  self.data_info = NewYearDinnerInfo:New()
  self.task_list = {}
end

NewYearDinnerComponentInfo._proto = {
  [1] = {
    "data_info",
    "NewYearDinnerInfo"
  },
  [2] = {
    "task_list",
    "map<int,NewYearDinner_Task>"
  }
}
_class("NewYearDinnerMakeFoodReq", ICampaignComRequest)
NewYearDinnerMakeFoodReq = NewYearDinnerMakeFoodReq

function NewYearDinnerMakeFoodReq:Constructor()
  self.food_id = 0
end

NewYearDinnerMakeFoodReq._proto = {
  [1] = {"food_id", "int"}
}
_class("NewYearDinnerMakeFoodRep", ICampaignComResponse)
NewYearDinnerMakeFoodRep = NewYearDinnerMakeFoodRep

function NewYearDinnerMakeFoodRep:Constructor()
  self.ret = 0
  self.data_info = NewYearDinnerInfo:New()
end

NewYearDinnerMakeFoodRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "data_info",
    "NewYearDinnerInfo"
  }
}
_class("NewYearDinnerRewardReq", ICampaignComRequest)
NewYearDinnerRewardReq = NewYearDinnerRewardReq

function NewYearDinnerRewardReq:Constructor()
  self.reward_type = 0
  self.req_id = 0
end

NewYearDinnerRewardReq._proto = {
  [1] = {
    "reward_type",
    "int"
  },
  [2] = {"req_id", "int"}
}
_class("NewYearDinnerRewardRep", ICampaignComResponse)
NewYearDinnerRewardRep = NewYearDinnerRewardRep

function NewYearDinnerRewardRep:Constructor()
  self.ret = 0
  self.component_info = NewYearDinnerComponentInfo:New()
  self.rewards = {}
end

NewYearDinnerRewardRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "component_info",
    "NewYearDinnerComponentInfo"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("PostStationMissionInfo", Object)
PostStationMissionInfo = PostStationMissionInfo

function PostStationMissionInfo:Constructor()
  self.mission_id = 0
  self.can_get_target_list = {}
  self.already_get_target_list = {}
  self.story_mask = 0
  self.suc = 0
end

PostStationMissionInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "can_get_target_list",
    "list<int>"
  },
  [3] = {
    "already_get_target_list",
    "list<int>"
  },
  [4] = {"story_mask", "int"},
  [5] = {"suc", "int"}
}
_class("MissionOrderInfo", Object)
MissionOrderInfo = MissionOrderInfo

function MissionOrderInfo:Constructor()
  self.order_id = 0
  self.item_id_num = {}
end

MissionOrderInfo._proto = {
  [1] = {"order_id", "int"},
  [2] = {
    "item_id_num",
    "map<int,int>"
  }
}
_class("PostStationComponentDataInfo", ICampaignComponentDataInfo)
PostStationComponentDataInfo = PostStationComponentDataInfo

function PostStationComponentDataInfo:Constructor()
  self.mission_infos = {}
  self.cur_order_list = {}
end

PostStationComponentDataInfo._proto = {
  [1] = {
    "mission_infos",
    "map<int,PostStationMissionInfo>"
  },
  [2] = {
    "cur_order_list",
    "map<int,MissionOrderInfo>"
  }
}
_class("PostStationComponentInfo", ICampaignComponentInfo)
PostStationComponentInfo = PostStationComponentInfo

function PostStationComponentInfo:Constructor()
  self.mission_infos = {}
end

PostStationComponentInfo._proto = {
  [1] = {
    "mission_infos",
    "map<int,PostStationMissionInfo>"
  }
}
_class("SubmitMissionInfoReq", ICampaignComRequest)
SubmitMissionInfoReq = SubmitMissionInfoReq

function SubmitMissionInfoReq:Constructor()
  self.mission_id = 0
  self.order_list = {}
end

SubmitMissionInfoReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "order_list",
    "map<int,MissionOrderInfo>"
  }
}
_class("SubmitMissionInfoRes", ICampaignComResponse)
SubmitMissionInfoRes = SubmitMissionInfoRes

function SubmitMissionInfoRes:Constructor()
  self.ret = 0
  self.suc = 0
  self.info = PostStationMissionInfo:New()
end

SubmitMissionInfoRes._proto = {
  [1] = {"ret", "int"},
  [2] = {"suc", "int"},
  [3] = {
    "info",
    "PostStationMissionInfo"
  }
}
_class("PostStationMissionStoryReq", ICampaignComRequest)
PostStationMissionStoryReq = PostStationMissionStoryReq

function PostStationMissionStoryReq:Constructor()
  self.mission_id = 0
  self.story_type = 0
end

PostStationMissionStoryReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"story_type", "int"}
}
_class("PostStationMissionStoryRes", ICampaignComResponse)
PostStationMissionStoryRes = PostStationMissionStoryRes

function PostStationMissionStoryRes:Constructor()
  self.ret = 0
  self.info = PostStationMissionInfo:New()
end

PostStationMissionStoryRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "PostStationMissionInfo"
  }
}
_class("PostStationGetTargetRewardReq", ICampaignComRequest)
PostStationGetTargetRewardReq = PostStationGetTargetRewardReq

function PostStationGetTargetRewardReq:Constructor()
  self.mission_id = 0
  self.target_id = 0
end

PostStationGetTargetRewardReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"target_id", "int"}
}
_class("PostStationGetTargetRewardRes", ICampaignComResponse)
PostStationGetTargetRewardRes = PostStationGetTargetRewardRes

function PostStationGetTargetRewardRes:Constructor()
  self.ret = 0
  self.info = PostStationMissionInfo:New()
  self.reward = {}
end

PostStationGetTargetRewardRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "PostStationMissionInfo"
  },
  [3] = {
    "reward",
    "list<RoleAsset>"
  }
}
local MiniMailStateType = {
  MMST_Invalid = 0,
  MMST_Unread = 2,
  MMST_Read = 3
}
_enum("MiniMailStateType", MiniMailStateType)
_class("MiniMailItemInfo", Object)
MiniMailItemInfo = MiniMailItemInfo

function MiniMailItemInfo:Constructor()
  self.id = 0
  self.unlock_time = 0
  self.state = 0
end

MiniMailItemInfo._proto = {
  [1] = {"id", "int"},
  [2] = {
    "unlock_time",
    "time"
  },
  [3] = {"state", "int"}
}
_class("HandleReadMiniMailReq", ICampaignComRequest)
HandleReadMiniMailReq = HandleReadMiniMailReq

function HandleReadMiniMailReq:Constructor()
  self.id = 0
end

HandleReadMiniMailReq._proto = {
  [1] = {"id", "int"}
}
_class("HandleReadMiniMailReply", ICampaignComResponse)
HandleReadMiniMailReply = HandleReadMiniMailReply

function HandleReadMiniMailReply:Constructor()
end

HandleReadMiniMailReply._proto = {}
_class("MiniMailComponentInfo", ICampaignComponentInfo)
MiniMailComponentInfo = MiniMailComponentInfo

function MiniMailComponentInfo:Constructor()
  self.infos = {}
end

MiniMailComponentInfo._proto = {
  [1] = {
    "infos",
    "map<int,MiniMailItemInfo>"
  }
}
local MiniMailComponentNotifyType = {MiniMailComponentNotifyType_Add = 1}
_enum("MiniMailComponentNotifyType", MiniMailComponentNotifyType)
_class("NotifyMiniMailAdd", Object)
NotifyMiniMailAdd = NotifyMiniMailAdd

function NotifyMiniMailAdd:Constructor()
  self.infos = MiniMailItemInfo:New()
end

NotifyMiniMailAdd._proto = {
  [1] = {
    "infos",
    "MiniMailItemInfo"
  }
}
_class("DifficultyMissionComponentInfo", ICampaignComponentDataInfo)
DifficultyMissionComponentInfo = DifficultyMissionComponentInfo

function DifficultyMissionComponentInfo:Constructor()
  self.difficulty_info = difficulty_mission_info:New()
end

DifficultyMissionComponentInfo._proto = {
  [1] = {
    "difficulty_info",
    "difficulty_mission_info"
  }
}
_class("ClientCampaignDifficultyMissionInfo", ICampaignComponentInfo)
ClientCampaignDifficultyMissionInfo = ClientCampaignDifficultyMissionInfo

function ClientCampaignDifficultyMissionInfo:Constructor()
  self.cur_parent_id = 0
  self.infos = {}
  self.pet_list = {}
end

ClientCampaignDifficultyMissionInfo._proto = {
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
_class("CCampaignEventApplyChangeFormationReq", ICampaignComRequest)
CCampaignEventApplyChangeFormationReq = CCampaignEventApplyChangeFormationReq

function CCampaignEventApplyChangeFormationReq:Constructor()
  self.formation_pet_list = {}
  self.parent_mission_id = 0
  self.sub_mission_id = 0
end

CCampaignEventApplyChangeFormationReq._proto = {
  [1] = {
    "formation_pet_list",
    "list<int64>"
  },
  [2] = {
    "parent_mission_id",
    "int"
  },
  [3] = {
    "sub_mission_id",
    "int"
  }
}
_class("CCampaignEventApplyChangeFormationRes", ICampaignComResponse)
CCampaignEventApplyChangeFormationRes = CCampaignEventApplyChangeFormationRes

function CCampaignEventApplyChangeFormationRes:Constructor()
  self.nFormationRet = 0
end

CCampaignEventApplyChangeFormationRes._proto = {
  [1] = {
    "nFormationRet",
    "int"
  }
}
_class("CCampaignEventResetSubMissionRecordReq", ICampaignComRequest)
CCampaignEventResetSubMissionRecordReq = CCampaignEventResetSubMissionRecordReq

function CCampaignEventResetSubMissionRecordReq:Constructor()
  self.parent_mission_id = 0
  self.sub_mission_id = 0
end

CCampaignEventResetSubMissionRecordReq._proto = {
  [1] = {
    "parent_mission_id",
    "int"
  },
  [2] = {
    "sub_mission_id",
    "int"
  }
}
_class("CCampaignEventResetSubMissionRecordRes", ICampaignComResponse)
CCampaignEventResetSubMissionRecordRes = CCampaignEventResetSubMissionRecordRes

function CCampaignEventResetSubMissionRecordRes:Constructor()
  self.nRet = 0
end

CCampaignEventResetSubMissionRecordRes._proto = {
  [1] = {"nRet", "int"}
}
local DifficultyMissionComponentNotifyType = {DifficultyMissionComponentNotifyType_Parent = 1, DifficultyMissionComponentNotifyType_CurFormation = 2}
_enum("DifficultyMissionComponentNotifyType", DifficultyMissionComponentNotifyType)
_class("NotifyDifficultyMissionComponentParentInfoChanged", Object)
NotifyDifficultyMissionComponentParentInfoChanged = NotifyDifficultyMissionComponentParentInfoChanged

function NotifyDifficultyMissionComponentParentInfoChanged:Constructor()
  self.info = ParentMissionInfo:New()
  self.cur_mission_id = 0
end

NotifyDifficultyMissionComponentParentInfoChanged._proto = {
  [1] = {
    "info",
    "ParentMissionInfo"
  },
  [2] = {
    "cur_mission_id",
    "int"
  }
}
_class("NotifyDifficultyMissionComponentCurFormationChanged", Object)
NotifyDifficultyMissionComponentCurFormationChanged = NotifyDifficultyMissionComponentCurFormationChanged

function NotifyDifficultyMissionComponentCurFormationChanged:Constructor()
  self.formation_pet_list = {}
end

NotifyDifficultyMissionComponentCurFormationChanged._proto = {
  [1] = {
    "formation_pet_list",
    "list<int64>"
  }
}
local BounceMission_Status = {
  E_BounceMission_Status_UN_FINISH = 0,
  E_BounceMission_Status_CAN_RECV = 1,
  E_BounceMission_Status_RECVED = 2
}
_enum("BounceMission_Status", BounceMission_Status)
_class("BounceMissionInfo", Object)
BounceMissionInfo = BounceMissionInfo

function BounceMissionInfo:Constructor()
  self.mission_id = 0
  self.enties_list = {}
  self.status = 0
  self.kill_num = 0
  self.kill_boss_num = 0
  self.max_record = 0
end

BounceMissionInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "enties_list",
    "map<int,int>"
  },
  [3] = {"status", "int"},
  [4] = {"kill_num", "int"},
  [5] = {
    "kill_boss_num",
    "int"
  },
  [6] = {"max_record", "int"}
}
_class("BounceMissionComponentDataInfo", ICampaignComponentDataInfo)
BounceMissionComponentDataInfo = BounceMissionComponentDataInfo

function BounceMissionComponentDataInfo:Constructor()
  self.m_cur_mission = 0
  self.m_pass_mission_info = {}
end

BounceMissionComponentDataInfo._proto = {
  [1] = {
    "m_cur_mission",
    "int"
  },
  [2] = {
    "m_pass_mission_info",
    "map<int,BounceMissionInfo>"
  }
}
_class("ClientBounceMissionComponentInfo", ICampaignComponentInfo)
ClientBounceMissionComponentInfo = ClientBounceMissionComponentInfo

function ClientBounceMissionComponentInfo:Constructor()
  self.m_cur_mission = 0
  self.m_pass_mission_info = {}
end

ClientBounceMissionComponentInfo._proto = {
  [1] = {
    "m_cur_mission",
    "int"
  },
  [2] = {
    "m_pass_mission_info",
    "map<int,BounceMissionInfo>"
  }
}
_class("BounceMissionSettleReq", ICampaignComRequest)
BounceMissionSettleReq = BounceMissionSettleReq

function BounceMissionSettleReq:Constructor()
  self.mission_id = 0
  self.kill_num = 0
  self.kill_boss_num = 0
  self.game_cost_time = 0
end

BounceMissionSettleReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"kill_num", "int"},
  [3] = {
    "kill_boss_num",
    "int"
  },
  [4] = {
    "game_cost_time",
    "int"
  }
}
_class("BounceMissionSettleRes", ICampaignComResponse)
BounceMissionSettleRes = BounceMissionSettleRes

function BounceMissionSettleRes:Constructor()
  self.ret = 0
  self.info = BounceMissionInfo:New()
end

BounceMissionSettleRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "BounceMissionInfo"
  }
}
_class("BounceMissionGetRewardReq", ICampaignComRequest)
BounceMissionGetRewardReq = BounceMissionGetRewardReq

function BounceMissionGetRewardReq:Constructor()
  self.mission_id = 0
  self.entie_id = 0
end

BounceMissionGetRewardReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"entie_id", "int"}
}
_class("BounceMissionGetRewardRes", ICampaignComResponse)
BounceMissionGetRewardRes = BounceMissionGetRewardRes

function BounceMissionGetRewardRes:Constructor()
  self.ret = 0
  self.info = BounceMissionInfo:New()
  self.reward = {}
end

BounceMissionGetRewardRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "BounceMissionInfo"
  },
  [3] = {
    "reward",
    "list<RoleAsset>"
  }
}
local ClueFromType = {Talk = 0, Suspicious = 1}
_enum("ClueFromType", ClueFromType)
_class("SubmitClueInfo", Object)
SubmitClueInfo = SubmitClueInfo

function SubmitClueInfo:Constructor()
  self.type = 0
  self.id = 0
end

SubmitClueInfo._proto = {
  [1] = {"type", "int"},
  [2] = {"id", "int"}
}
_class("CurDetectiveInfo", Object)
CurDetectiveInfo = CurDetectiveInfo

function CurDetectiveInfo:Constructor()
  self.clue_list = {}
  self.fragment_list = {}
  self.talk_list = {}
  self.pstid = 0
  self.cur_time = 0
end

CurDetectiveInfo._proto = {
  [1] = {"clue_list", "list<int>"},
  [2] = {
    "fragment_list",
    "list<int>"
  },
  [3] = {"talk_list", "list<int>"},
  [4] = {"pstid", "int64"},
  [5] = {"cur_time", "time"}
}
_class("DetectiveComponentDataInfo", ICampaignComponentDataInfo)
DetectiveComponentDataInfo = DetectiveComponentDataInfo

function DetectiveComponentDataInfo:Constructor()
  self.is_record = false
  self.cur_info = CurDetectiveInfo:New()
  self.cg_list = {}
  self.auto_save_record_time = 0
end

DetectiveComponentDataInfo._proto = {
  [1] = {"is_record", "bool"},
  [2] = {
    "cur_info",
    "CurDetectiveInfo"
  },
  [3] = {"cg_list", "list<int>"},
  [4] = {
    "auto_save_record_time",
    "time"
  }
}
_class("ClientDetectiveComponentInfo", ICampaignComponentInfo)
ClientDetectiveComponentInfo = ClientDetectiveComponentInfo

function ClientDetectiveComponentInfo:Constructor()
  self.is_record = false
  self.cur_info = CurDetectiveInfo:New()
  self.cg_list = {}
  self.auto_save_record_time = 0
end

ClientDetectiveComponentInfo._proto = {
  [1] = {"is_record", "bool"},
  [2] = {
    "cur_info",
    "CurDetectiveInfo"
  },
  [3] = {"cg_list", "list<int>"},
  [4] = {
    "auto_save_record_time",
    "time"
  }
}
_class("DetectiveSubmitItemReq", ICampaignComRequest)
DetectiveSubmitItemReq = DetectiveSubmitItemReq

function DetectiveSubmitItemReq:Constructor()
  self.stage = 0
  self.clue_list = {}
  self.fragment_list = {}
  self.talk_list = {}
end

DetectiveSubmitItemReq._proto = {
  [1] = {"stage", "int"},
  [2] = {
    "clue_list",
    "list<SubmitClueInfo>"
  },
  [3] = {
    "fragment_list",
    "list<int>"
  },
  [4] = {"talk_list", "list<int>"}
}
_class("DetectiveSubmitItemRes", ICampaignComResponse)
DetectiveSubmitItemRes = DetectiveSubmitItemRes

function DetectiveSubmitItemRes:Constructor()
  self.ret = 0
  self.cur_info = CurDetectiveInfo:New()
end

DetectiveSubmitItemRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "cur_info",
    "CurDetectiveInfo"
  }
}
_class("DetectiveSubmitEndingReq", ICampaignComRequest)
DetectiveSubmitEndingReq = DetectiveSubmitEndingReq

function DetectiveSubmitEndingReq:Constructor()
  self.ending_id = 0
end

DetectiveSubmitEndingReq._proto = {
  [1] = {"ending_id", "int"}
}
_class("DetectiveSubmitEndingRes", ICampaignComResponse)
DetectiveSubmitEndingRes = DetectiveSubmitEndingRes

function DetectiveSubmitEndingRes:Constructor()
  self.ret = 0
  self.cg_list = {}
end

DetectiveSubmitEndingRes._proto = {
  [1] = {"ret", "int"},
  [2] = {"cg_list", "list<int>"}
}
_class("DetectiveAutoSaveReq", ICampaignComRequest)
DetectiveAutoSaveReq = DetectiveAutoSaveReq

function DetectiveAutoSaveReq:Constructor()
end

DetectiveAutoSaveReq._proto = {}
_class("DetectiveAutoSaveRes", ICampaignComResponse)
DetectiveAutoSaveRes = DetectiveAutoSaveRes

function DetectiveAutoSaveRes:Constructor()
  self.ret = 0
  self.is_record = false
  self.auto_save_record_time = 0
end

DetectiveAutoSaveRes._proto = {
  [1] = {"ret", "int"},
  [2] = {"is_record", "bool"},
  [3] = {
    "auto_save_record_time",
    "time"
  }
}
_class("DetectiveReadRecordPlayReq", ICampaignComRequest)
DetectiveReadRecordPlayReq = DetectiveReadRecordPlayReq

function DetectiveReadRecordPlayReq:Constructor()
  self.cur_info = CurDetectiveInfo:New()
end

DetectiveReadRecordPlayReq._proto = {
  [1] = {
    "cur_info",
    "CurDetectiveInfo"
  }
}
_class("DetectiveReadRecordPlayRes", ICampaignComResponse)
DetectiveReadRecordPlayRes = DetectiveReadRecordPlayRes

function DetectiveReadRecordPlayRes:Constructor()
  self.ret = 0
  self.cur_info = CurDetectiveInfo:New()
end

DetectiveReadRecordPlayRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "cur_info",
    "CurDetectiveInfo"
  }
}
local PopStarComponentNotifyType = {PopStarMissionComponentNotifyType_InfoChanged = 1}
_enum("PopStarComponentNotifyType", PopStarComponentNotifyType)
local PopStarMissionType = {
  PopStarMissionType_None = 0,
  PopStarMissionType_Common = 1,
  PopStarMissionType_Challenge = 2
}
_enum("PopStarMissionType", PopStarMissionType)
_class("NotifyPopStarComponentInfoChanged", Object)
NotifyPopStarComponentInfoChanged = NotifyPopStarComponentInfoChanged

function NotifyPopStarComponentInfoChanged:Constructor()
  self.m_update_mission_info = {}
  self.m_received = {}
  self.m_max_score = 0
end

NotifyPopStarComponentInfoChanged._proto = {
  [1] = {
    "m_update_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {"m_received", "list<int>"},
  [3] = {
    "m_max_score",
    "int"
  }
}
_class("PopStarComponentDataInfo", ICampaignComponentDataInfo)
PopStarComponentDataInfo = PopStarComponentDataInfo

function PopStarComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_fight_mission = {}
  self.m_received = {}
  self.formation_pet_list = {}
  self.m_max_score = 0
end

PopStarComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_fight_mission",
    "list<int>"
  },
  [3] = {"m_received", "list<int>"},
  [4] = {
    "formation_pet_list",
    "list<int64>"
  },
  [5] = {
    "m_max_score",
    "int"
  }
}
_class("PopStarComponentInfo", ICampaignComponentInfo)
PopStarComponentInfo = PopStarComponentInfo

function PopStarComponentInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_received = {}
  self.formation_pet_list = {}
  self.m_max_score = 0
end

PopStarComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {"m_received", "list<int>"},
  [3] = {
    "formation_pet_list",
    "list<int64>"
  },
  [4] = {
    "m_max_score",
    "int"
  }
}
_class("PopStarChangeFormationReq", ICampaignComRequest)
PopStarChangeFormationReq = PopStarChangeFormationReq

function PopStarChangeFormationReq:Constructor()
  self.formation_pet_list = {}
end

PopStarChangeFormationReq._proto = {
  [1] = {
    "formation_pet_list",
    "list<int64>"
  }
}
_class("PopStarChangeFormationRep", ICampaignComResponse)
PopStarChangeFormationRep = PopStarChangeFormationRep

function PopStarChangeFormationRep:Constructor()
  self.nFormationRet = 0
end

PopStarChangeFormationRep._proto = {
  [1] = {
    "nFormationRet",
    "int"
  }
}
local GlobalbossComponentNotifyType = {GlobalbossComponentNotifyType_InfoChanged = 1}
_enum("GlobalbossComponentNotifyType", GlobalbossComponentNotifyType)
local RankType = {RealingRank = 1, PercentRank = 2}
_enum("RankType", RankType)
_class("CurRankInfo", Object)
CurRankInfo = CurRankInfo

function CurRankInfo:Constructor()
  self.type = 0
  self.value = 0
end

CurRankInfo._proto = {
  [1] = {"type", "int"},
  [2] = {"value", "int"}
}
_class("GlobalbossFormationRecord", Object)
GlobalbossFormationRecord = GlobalbossFormationRecord

function GlobalbossFormationRecord:Constructor()
  self.id = 0
  self.pet_list = {}
  self.formation_damage = 0
end

GlobalbossFormationRecord._proto = {
  [1] = {"id", "int"},
  [2] = {
    "pet_list",
    "list<int64>"
  },
  [3] = {
    "formation_damage",
    "int64"
  }
}
_class("RankShowSimpleOne", Object)
RankShowSimpleOne = RankShowSimpleOne

function RankShowSimpleOne:Constructor()
  self.pstid = 0
  self.head = 0
  self.damage = 0
  self.nick = ""
  self.head_bg = 0
  self.frame_id = 0
end

RankShowSimpleOne._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"head", "int"},
  [3] = {"damage", "int64"},
  [4] = {"nick", "string"},
  [5] = {"head_bg", "int"},
  [6] = {"frame_id", "int"}
}
_class("RankShowSimpleInfo", Object)
RankShowSimpleInfo = RankShowSimpleInfo

function RankShowSimpleInfo:Constructor()
  self.infos = {}
end

RankShowSimpleInfo._proto = {
  [1] = {
    "infos",
    "list<RankShowSimpleOne>"
  }
}
_class("GlobalbossFormationInfo", Object)
GlobalbossFormationInfo = GlobalbossFormationInfo

function GlobalbossFormationInfo:Constructor()
  self.formation_list = {}
  self.pet_list = {}
end

GlobalbossFormationInfo._proto = {
  [1] = {
    "formation_list",
    "list<GlobalbossFormationRecord>"
  },
  [2] = {
    "pet_list",
    "list<int64>"
  }
}
_class("GlobalbossComponentDataInfo", ICampaignComponentDataInfo)
GlobalbossComponentDataInfo = GlobalbossComponentDataInfo

function GlobalbossComponentDataInfo:Constructor()
  self.boss_mission_id = 0
  self.max_total_damage = 0
  self.formation_info = GlobalbossFormationInfo:New()
  self.is_send_reward = false
end

GlobalbossComponentDataInfo._proto = {
  [1] = {
    "boss_mission_id",
    "int"
  },
  [2] = {
    "max_total_damage",
    "int64"
  },
  [3] = {
    "formation_info",
    "GlobalbossFormationInfo"
  },
  [4] = {
    "is_send_reward",
    "bool"
  }
}
_class("GlobalbossComponentInfo", ICampaignComponentInfo)
GlobalbossComponentInfo = GlobalbossComponentInfo

function GlobalbossComponentInfo:Constructor()
  self.boss_mission_id = 0
  self.max_total_damage = 0
  self.formation_info = GlobalbossFormationInfo:New()
  self.rank_info = CurRankInfo:New()
  self.boss_progress = 0
end

GlobalbossComponentInfo._proto = {
  [1] = {
    "boss_mission_id",
    "int"
  },
  [2] = {
    "max_total_damage",
    "int64"
  },
  [3] = {
    "formation_info",
    "GlobalbossFormationInfo"
  },
  [4] = {
    "rank_info",
    "CurRankInfo"
  },
  [5] = {
    "boss_progress",
    "int"
  }
}
_class("GlobalbossChangeFormationReq", ICampaignComRequest)
GlobalbossChangeFormationReq = GlobalbossChangeFormationReq

function GlobalbossChangeFormationReq:Constructor()
  self.formation_pet_list = {}
  self.nId = 0
end

GlobalbossChangeFormationReq._proto = {
  [1] = {
    "formation_pet_list",
    "list<int64>"
  },
  [2] = {"nId", "int"}
}
_class("GlobalbossChangeFormationRep", ICampaignComResponse)
GlobalbossChangeFormationRep = GlobalbossChangeFormationRep

function GlobalbossChangeFormationRep:Constructor()
  self.nFormationRet = 0
end

GlobalbossChangeFormationRep._proto = {
  [1] = {
    "nFormationRet",
    "int"
  }
}
_class("GlobalbossResetRecordReq", ICampaignComRequest)
GlobalbossResetRecordReq = GlobalbossResetRecordReq

function GlobalbossResetRecordReq:Constructor()
  self.nId = 0
end

GlobalbossResetRecordReq._proto = {
  [1] = {"nId", "int"}
}
_class("GlobalbossRecordRes", ICampaignComResponse)
GlobalbossRecordRes = GlobalbossRecordRes

function GlobalbossRecordRes:Constructor()
  self.nRet = 0
end

GlobalbossRecordRes._proto = {
  [1] = {"nRet", "int"}
}
_class("GlobalbossChoseRecordReq", ICampaignComRequest)
GlobalbossChoseRecordReq = GlobalbossChoseRecordReq

function GlobalbossChoseRecordReq:Constructor()
  self.select_new = true
  self.nId = 0
end

GlobalbossChoseRecordReq._proto = {
  [1] = {"select_new", "bool"},
  [2] = {"nId", "int"}
}
_class("GlobalbossChoseRecordRes", ICampaignComResponse)
GlobalbossChoseRecordRes = GlobalbossChoseRecordRes

function GlobalbossChoseRecordRes:Constructor()
  self.nRet = 0
end

GlobalbossChoseRecordRes._proto = {
  [1] = {"nRet", "int"}
}
_class("GlobalbossGetRankListReq", ICampaignComRequest)
GlobalbossGetRankListReq = GlobalbossGetRankListReq

function GlobalbossGetRankListReq:Constructor()
end

GlobalbossGetRankListReq._proto = {}
_class("GlobalbossGetRankListRes", ICampaignComResponse)
GlobalbossGetRankListRes = GlobalbossGetRankListRes

function GlobalbossGetRankListRes:Constructor()
  self.nRet = 0
  self.show_list = RankShowSimpleInfo:New()
end

GlobalbossGetRankListRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "show_list",
    "RankShowSimpleInfo"
  }
}
_class("GlobalbossGetOneRankDetailReq", ICampaignComRequest)
GlobalbossGetOneRankDetailReq = GlobalbossGetOneRankDetailReq

function GlobalbossGetOneRankDetailReq:Constructor()
  self.pstid = 0
end

GlobalbossGetOneRankDetailReq._proto = {
  [1] = {"pstid", "int64"}
}
_class("GlobalbossGetOneRankDetailRes", ICampaignComResponse)
GlobalbossGetOneRankDetailRes = GlobalbossGetOneRankDetailRes

function GlobalbossGetOneRankDetailRes:Constructor()
  self.nRet = 0
  self.detail_info = RankDetailInfo:New()
end

GlobalbossGetOneRankDetailRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "detail_info",
    "RankDetailInfo"
  }
}
local TurnCardComponentNotifyType = {TurnCardComponentNotifyType_InfoChanged = 1}
_enum("TurnCardComponentNotifyType", TurnCardComponentNotifyType)
_class("MatrixItemInfo", Object)
MatrixItemInfo = MatrixItemInfo

function MatrixItemInfo:Constructor()
  self.m_id = 0
  self.m_is_turn = {}
end

MatrixItemInfo._proto = {
  [1] = {"m_id", "int"},
  [2] = {
    "m_is_turn",
    "map<int,bool>"
  }
}
_class("EachMatrixInfo", Object)
EachMatrixInfo = EachMatrixInfo

function EachMatrixInfo:Constructor()
  self.m_matrix_item = {}
  self.m_matrix_index = 0
end

EachMatrixInfo._proto = {
  [1] = {
    "m_matrix_item",
    "list<MatrixItemInfo>"
  },
  [2] = {
    "m_matrix_index",
    "int"
  }
}
_class("NotifyTurnCardComponentInfoChanged", Object)
NotifyTurnCardComponentInfoChanged = NotifyTurnCardComponentInfoChanged

function NotifyTurnCardComponentInfoChanged:Constructor()
  self.m_matrix = {}
  self.m_asset = {}
end

NotifyTurnCardComponentInfoChanged._proto = {
  [1] = {
    "m_matrix",
    "map<int,EachMatrixInfo>"
  },
  [2] = {
    "m_asset",
    "list<RoleAsset>"
  }
}
_class("TurnCardComponentDataInfo", ICampaignComponentDataInfo)
TurnCardComponentDataInfo = TurnCardComponentDataInfo

function TurnCardComponentDataInfo:Constructor()
  self.m_turn_card_info = {}
end

TurnCardComponentDataInfo._proto = {
  [1] = {
    "m_turn_card_info",
    "map<int,EachMatrixInfo>"
  }
}
_class("TurnCardComponentInfo", ICampaignComponentInfo)
TurnCardComponentInfo = TurnCardComponentInfo

function TurnCardComponentInfo:Constructor()
  self.m_matrix = {}
end

TurnCardComponentInfo._proto = {
  [1] = {
    "m_matrix",
    "map<int,EachMatrixInfo>"
  }
}
_class("TurnCardOperateReq", ICampaignComRequest)
TurnCardOperateReq = TurnCardOperateReq

function TurnCardOperateReq:Constructor()
  self.turn_card_id = 0
  self.index = 0
end

TurnCardOperateReq._proto = {
  [1] = {
    "turn_card_id",
    "int"
  },
  [2] = {"index", "int"}
}
_class("TurnCardOperateRep", ICampaignComResponse)
TurnCardOperateRep = TurnCardOperateRep

function TurnCardOperateRep:Constructor()
  self.reward = {}
end

TurnCardOperateRep._proto = {
  [1] = {
    "reward",
    "list<RoleAsset>"
  }
}
local MultiLineComponentNotifyType = {MultiLineComponentNotifyType_InfoChanged = 1}
_enum("MultiLineComponentNotifyType", MultiLineComponentNotifyType)
_class("NotifyMultiLineComponentInfoChanged", Object)
NotifyMultiLineComponentInfoChanged = NotifyMultiLineComponentInfoChanged

function NotifyMultiLineComponentInfoChanged:Constructor()
  self.m_pass_mission_info = {}
  self.m_pet_files = {}
end

NotifyMultiLineComponentInfoChanged._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_pet_files",
    "list<int>"
  }
}
_class("MultiLineComponentDataInfo", ICampaignComponentDataInfo)
MultiLineComponentDataInfo = MultiLineComponentDataInfo

function MultiLineComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_pet_files = {}
  self.m_files_received = {}
  self.m_mark = 0
end

MultiLineComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_pet_files",
    "list<int>"
  },
  [3] = {
    "m_files_received",
    "list<int>"
  },
  [4] = {"m_mark", "int"}
}
_class("MultiLineComponentInfo", ICampaignComponentInfo)
MultiLineComponentInfo = MultiLineComponentInfo

function MultiLineComponentInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_pet_files = {}
  self.m_files_received = {}
  self.m_mark = 0
end

MultiLineComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_pet_files",
    "list<int>"
  },
  [3] = {
    "m_files_received",
    "list<int>"
  },
  [4] = {"m_mark", "int"}
}
_class("CompleteMultiLineReq", ICampaignComRequest)
CompleteMultiLineReq = CompleteMultiLineReq

function CompleteMultiLineReq:Constructor()
  self.m_create_info = CampaignMissionCreateInfo:New()
end

CompleteMultiLineReq._proto = {
  [1] = {
    "m_create_info",
    "CampaignMissionCreateInfo"
  }
}
_class("CompleteMultiLineRep", ICampaignComResponse)
CompleteMultiLineRep = CompleteMultiLineRep

function CompleteMultiLineRep:Constructor()
  self.nErrorCode = 0
  self.reward = {}
  self.m_files_id = 0
end

CompleteMultiLineRep._proto = {
  [1] = {"nErrorCode", "int"},
  [2] = {
    "reward",
    "list<RoleAsset>"
  },
  [3] = {"m_files_id", "int"}
}
_class("MultiLineGetRewardReq", ICampaignComRequest)
MultiLineGetRewardReq = MultiLineGetRewardReq

function MultiLineGetRewardReq:Constructor()
  self.pet_id = 0
end

MultiLineGetRewardReq._proto = {
  [1] = {"pet_id", "int"}
}
_class("MultiLineGetRewardRes", ICampaignComResponse)
MultiLineGetRewardRes = MultiLineGetRewardRes

function MultiLineGetRewardRes:Constructor()
  self.ret = 0
  self.m_files_received = {}
  self.reward = {}
end

MultiLineGetRewardRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "m_files_received",
    "list<int>"
  },
  [3] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("MultiLineSetMarkReq", ICampaignComRequest)
MultiLineSetMarkReq = MultiLineSetMarkReq

function MultiLineSetMarkReq:Constructor()
  self.m_mark = 0
end

MultiLineSetMarkReq._proto = {
  [1] = {"m_mark", "int"}
}
_class("MultiLineSetMarkRes", ICampaignComResponse)
MultiLineSetMarkRes = MultiLineSetMarkRes

function MultiLineSetMarkRes:Constructor()
  self.ret = 0
end

MultiLineSetMarkRes._proto = {
  [1] = {"ret", "int"}
}
_class("CSmeltItemComponentDataInfo", ICampaignComponentDataInfo)
CSmeltItemComponentDataInfo = CSmeltItemComponentDataInfo

function CSmeltItemComponentDataInfo:Constructor()
  self.m_info = {}
end

CSmeltItemComponentDataInfo._proto = {
  [1] = {"m_info", "list<int>"}
}
_class("SmeltItemComponentInfo", ICampaignComponentInfo)
SmeltItemComponentInfo = SmeltItemComponentInfo

function SmeltItemComponentInfo:Constructor()
  self.m_info = {}
end

SmeltItemComponentInfo._proto = {
  [1] = {"m_info", "list<int>"}
}
_class("SmeltItemComponentReceiveRewardReq", ICampaignComRequest)
SmeltItemComponentReceiveRewardReq = SmeltItemComponentReceiveRewardReq

function SmeltItemComponentReceiveRewardReq:Constructor()
  self.m_cfg_id = 0
end

SmeltItemComponentReceiveRewardReq._proto = {
  [1] = {"m_cfg_id", "int"}
}
_class("SmeltItemComponentReceiveRewardRep", ICampaignComResponse)
SmeltItemComponentReceiveRewardRep = SmeltItemComponentReceiveRewardRep

function SmeltItemComponentReceiveRewardRep:Constructor()
  self.m_info = {}
end

SmeltItemComponentReceiveRewardRep._proto = {
  [1] = {"m_info", "list<int>"}
}
_class("ArchInfo", Object)
ArchInfo = ArchInfo

function ArchInfo:Constructor()
  self.arch_id = 0
  self.create_coin_time = 0
  self.level = 1
  self.coin_num = 0
  self.cd = 0
  self.default_coin = 0
end

ArchInfo._proto = {
  [1] = {"arch_id", "int"},
  [2] = {
    "create_coin_time",
    "time"
  },
  [3] = {"level", "int"},
  [4] = {"coin_num", "int"},
  [5] = {"cd", "time"},
  [6] = {
    "default_coin",
    "int"
  }
}
_class("SimulationOperationComponentDataInfo", ICampaignComponentDataInfo)
SimulationOperationComponentDataInfo = SimulationOperationComponentDataInfo

function SimulationOperationComponentDataInfo:Constructor()
  self.arch_infos = {}
  self.story_list = {}
  self.final_story = 0
end

SimulationOperationComponentDataInfo._proto = {
  [1] = {
    "arch_infos",
    "map<int,ArchInfo>"
  },
  [2] = {"story_list", "list<int>"},
  [3] = {
    "final_story",
    "int"
  }
}
_class("SimulationOperationComponentInfo", ICampaignComponentInfo)
SimulationOperationComponentInfo = SimulationOperationComponentInfo

function SimulationOperationComponentInfo:Constructor()
  self.arch_infos = {}
  self.story_list = {}
  self.final_story = 0
end

SimulationOperationComponentInfo._proto = {
  [1] = {
    "arch_infos",
    "map<int,ArchInfo>"
  },
  [2] = {"story_list", "list<int>"},
  [3] = {
    "final_story",
    "int"
  }
}
_class("PickUpComponentReq", ICampaignComRequest)
PickUpComponentReq = PickUpComponentReq

function PickUpComponentReq:Constructor()
  self.arch_id = 0
end

PickUpComponentReq._proto = {
  [1] = {"arch_id", "int"}
}
_class("PickUpComponentRep", ICampaignComResponse)
PickUpComponentRep = PickUpComponentRep

function PickUpComponentRep:Constructor()
  self.ret = 0
  self.info = ArchInfo:New()
end

PickUpComponentRep._proto = {
  [1] = {"ret", "int"},
  [2] = {"info", "ArchInfo"}
}
_class("SubmitStoryComponentReq", ICampaignComRequest)
SubmitStoryComponentReq = SubmitStoryComponentReq

function SubmitStoryComponentReq:Constructor()
  self.arch_id = 0
  self.story_id = 0
  self.final_story = false
end

SubmitStoryComponentReq._proto = {
  [1] = {"arch_id", "int"},
  [2] = {"story_id", "int"},
  [3] = {
    "final_story",
    "bool"
  }
}
_class("SubmitStoryComponentRep", ICampaignComResponse)
SubmitStoryComponentRep = SubmitStoryComponentRep

function SubmitStoryComponentRep:Constructor()
  self.ret = 0
  self.rewards = {}
  self.story_list = {}
  self.final_story = 0
end

SubmitStoryComponentRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  },
  [3] = {"story_list", "list<int>"},
  [4] = {
    "final_story",
    "int"
  }
}
_class("UpgradeComponentReq", ICampaignComRequest)
UpgradeComponentReq = UpgradeComponentReq

function UpgradeComponentReq:Constructor()
  self.arch_id = 0
end

UpgradeComponentReq._proto = {
  [1] = {"arch_id", "int"}
}
_class("UpgradeComponentRep", ICampaignComResponse)
UpgradeComponentRep = UpgradeComponentRep

function UpgradeComponentRep:Constructor()
  self.ret = 0
  self.rewards = {}
  self.info = ArchInfo:New()
end

UpgradeComponentRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  },
  [3] = {"info", "ArchInfo"}
}
_class("GetArchInfosComponentReq", ICampaignComRequest)
GetArchInfosComponentReq = GetArchInfosComponentReq

function GetArchInfosComponentReq:Constructor()
end

GetArchInfosComponentReq._proto = {}
_class("GetArchInfosComponentRep", ICampaignComResponse)
GetArchInfosComponentRep = GetArchInfosComponentRep

function GetArchInfosComponentRep:Constructor()
  self.ret = 0
  self.arch_infos = {}
end

GetArchInfosComponentRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "arch_infos",
    "map<int,ArchInfo>"
  }
}
local EightPetsMissionComponentNotifyType = {EightPetsMissionComponentNotifyType_InfoChanged = 1}
_enum("EightPetsMissionComponentNotifyType", EightPetsMissionComponentNotifyType)
_class("NotifyEightPetsMissionComponentInfoChanged", Object)
NotifyEightPetsMissionComponentInfoChanged = NotifyEightPetsMissionComponentInfoChanged

function NotifyEightPetsMissionComponentInfoChanged:Constructor()
  self.m_update_mission_info = {}
end

NotifyEightPetsMissionComponentInfoChanged._proto = {
  [1] = {
    "m_update_mission_info",
    "map<int,cam_mission_info>"
  }
}
_class("EightPetsFormationItem", Object)
EightPetsFormationItem = EightPetsFormationItem

function EightPetsFormationItem:Constructor()
  self.name = ""
  self.pet_list = {}
end

EightPetsFormationItem._proto = {
  [1] = {"name", "string"},
  [2] = {
    "pet_list",
    "list<int64>"
  }
}
_class("EightPetsComponentDataInfo", ICampaignComponentDataInfo)
EightPetsComponentDataInfo = EightPetsComponentDataInfo

function EightPetsComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_formation_info = {}
  self.m_match_team_index = 0
end

EightPetsComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_formation_info",
    "map<int,EightPetsFormationItem>"
  },
  [3] = {
    "m_match_team_index",
    "int"
  }
}
_class("EightPetsComponentInfo", ICampaignComponentInfo)
EightPetsComponentInfo = EightPetsComponentInfo

function EightPetsComponentInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_formation_info = {}
  self.m_cur_team_index = 0
end

EightPetsComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_formation_info",
    "map<int,EightPetsFormationItem>"
  },
  [3] = {
    "m_cur_team_index",
    "int"
  }
}
_class("EightPetsChangeFormationReq", ICampaignComRequest)
EightPetsChangeFormationReq = EightPetsChangeFormationReq

function EightPetsChangeFormationReq:Constructor()
  self.formation_index = 0
  self.formation_list = EightPetsFormationItem:New()
end

EightPetsChangeFormationReq._proto = {
  [1] = {
    "formation_index",
    "int"
  },
  [2] = {
    "formation_list",
    "EightPetsFormationItem"
  }
}
_class("EightPetsChangeFormationReply", ICampaignComResponse)
EightPetsChangeFormationReply = EightPetsChangeFormationReply

function EightPetsChangeFormationReply:Constructor()
  self.ret = 0
end

EightPetsChangeFormationReply._proto = {
  [1] = {"ret", "int"}
}
_class("SeasonMissionClientInfo", Object)
SeasonMissionClientInfo = SeasonMissionClientInfo

function SeasonMissionClientInfo:Constructor()
  self.m_x = 0
  self.m_y = 0
  self.m_z = 0
  self.ext = {}
end

SeasonMissionClientInfo._proto = {
  [1] = {"m_x", "float"},
  [2] = {"m_y", "float"},
  [3] = {"m_z", "float"},
  [4] = {
    "ext",
    "map<int,int>"
  }
}
_class("SeasonFormationItem", Object)
SeasonFormationItem = SeasonFormationItem

function SeasonFormationItem:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

SeasonFormationItem._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("SeasonDailyMissionInfo", Object)
SeasonDailyMissionInfo = SeasonDailyMissionInfo

function SeasonDailyMissionInfo:Constructor()
  self.m_progress = 1
  self.m_total_mission = 0
  self.m_save_info = {}
  self.last_refresh_time = 0
end

SeasonDailyMissionInfo._proto = {
  [1] = {"m_progress", "int"},
  [2] = {
    "m_total_mission",
    "int"
  },
  [3] = {
    "m_save_info",
    "map<int,int>"
  },
  [4] = {
    "last_refresh_time",
    "time"
  }
}
_class("CSeasonMissionComponentDataInfo", ICampaignComponentDataInfo)
CSeasonMissionComponentDataInfo = CSeasonMissionComponentDataInfo

function CSeasonMissionComponentDataInfo:Constructor()
  self.m_cur_mission = 0
  self.m_pass_mission_info = {}
  self.m_formation_list = {}
  self.m_client_info = SeasonMissionClientInfo:New()
  self.m_stage_info = {}
  self.m_daily_info = SeasonDailyMissionInfo:New()
end

CSeasonMissionComponentDataInfo._proto = {
  [1] = {
    "m_cur_mission",
    "int"
  },
  [2] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [3] = {
    "m_formation_list",
    "list<SeasonFormationItem>"
  },
  [4] = {
    "m_client_info",
    "SeasonMissionClientInfo"
  },
  [5] = {
    "m_stage_info",
    "map<int,int>"
  },
  [6] = {
    "m_daily_info",
    "SeasonDailyMissionInfo"
  }
}
_class("SeasonMissionComponentInfo", ICampaignComponentInfo)
SeasonMissionComponentInfo = SeasonMissionComponentInfo

function SeasonMissionComponentInfo:Constructor()
  self.m_cur_mission = 0
  self.m_pass_mission_info = {}
  self.m_formation_list = {}
  self.m_client_info = SeasonMissionClientInfo:New()
  self.m_stage_info = {}
  self.m_daily_info = SeasonDailyMissionInfo:New()
end

SeasonMissionComponentInfo._proto = {
  [1] = {
    "m_cur_mission",
    "int"
  },
  [2] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [3] = {
    "m_formation_list",
    "list<SeasonFormationItem>"
  },
  [4] = {
    "m_client_info",
    "SeasonMissionClientInfo"
  },
  [5] = {
    "m_stage_info",
    "map<int,int>"
  },
  [6] = {
    "m_daily_info",
    "SeasonDailyMissionInfo"
  }
}
_class("CompleteStorySeasonMissionReq", ICampaignComRequest)
CompleteStorySeasonMissionReq = CompleteStorySeasonMissionReq

function CompleteStorySeasonMissionReq:Constructor()
  self.m_create_info = CampaignMissionCreateInfo:New()
end

CompleteStorySeasonMissionReq._proto = {
  [1] = {
    "m_create_info",
    "CampaignMissionCreateInfo"
  }
}
_class("CompleteStorySeasonMissionRep", ICampaignComResponse)
CompleteStorySeasonMissionRep = CompleteStorySeasonMissionRep

function CompleteStorySeasonMissionRep:Constructor()
  self.reward = {}
end

CompleteStorySeasonMissionRep._proto = {
  [1] = {
    "reward",
    "list<RoleAsset>"
  }
}
local SeasonMissionComponentNotifyType = {SeasonMissionComponentNotifyType_InfoChanged = 1, SeasonMissionComponentNotifyTypeDaily_InfoChanged = 2}
_enum("SeasonMissionComponentNotifyType", SeasonMissionComponentNotifyType)
_class("NotifySeasonMissionComponentInfoChanged", Object)
NotifySeasonMissionComponentInfoChanged = NotifySeasonMissionComponentInfoChanged

function NotifySeasonMissionComponentInfoChanged:Constructor()
  self.m_cur_mission = 0
  self.m_update_mission_info = {}
end

NotifySeasonMissionComponentInfoChanged._proto = {
  [1] = {
    "m_cur_mission",
    "int"
  },
  [2] = {
    "m_update_mission_info",
    "map<int,cam_mission_info>"
  }
}
_class("NotifySeasonMissionDailyComponentInfoChanged", Object)
NotifySeasonMissionDailyComponentInfoChanged = NotifySeasonMissionDailyComponentInfoChanged

function NotifySeasonMissionDailyComponentInfoChanged:Constructor()
  self.m_daily_info = SeasonDailyMissionInfo:New()
  self.m_is_reset = false
end

NotifySeasonMissionDailyComponentInfoChanged._proto = {
  [1] = {
    "m_daily_info",
    "SeasonDailyMissionInfo"
  },
  [2] = {"m_is_reset", "bool"}
}
_class("SeasonChangeFormationReq", ICampaignComRequest)
SeasonChangeFormationReq = SeasonChangeFormationReq

function SeasonChangeFormationReq:Constructor()
  self.info = SeasonFormationItem:New()
end

SeasonChangeFormationReq._proto = {
  [1] = {
    "info",
    "SeasonFormationItem"
  }
}
_class("SeasonChangeFormationReply", ICampaignComResponse)
SeasonChangeFormationReply = SeasonChangeFormationReply

function SeasonChangeFormationReply:Constructor()
end

SeasonChangeFormationReply._proto = {}
_class("SeasonClientDataPointReq", ICampaignComRequest)
SeasonClientDataPointReq = SeasonClientDataPointReq

function SeasonClientDataPointReq:Constructor()
  self.m_x = 0
  self.m_y = 0
  self.m_z = 0
end

SeasonClientDataPointReq._proto = {
  [1] = {"m_x", "float"},
  [2] = {"m_y", "float"},
  [3] = {"m_z", "float"}
}
_class("SeasonClientDataPointReply", ICampaignComResponse)
SeasonClientDataPointReply = SeasonClientDataPointReply

function SeasonClientDataPointReply:Constructor()
end

SeasonClientDataPointReply._proto = {}
_class("SeasonClientStageDataReq", ICampaignComRequest)
SeasonClientStageDataReq = SeasonClientStageDataReq

function SeasonClientStageDataReq:Constructor()
  self.id = 0
  self.type = 0
end

SeasonClientStageDataReq._proto = {
  [1] = {"id", "int"},
  [2] = {"type", "int"}
}
_class("SeasonClientStageDataReply", ICampaignComResponse)
SeasonClientStageDataReply = SeasonClientStageDataReply

function SeasonClientStageDataReply:Constructor()
  self.reward = {}
end

SeasonClientStageDataReply._proto = {
  [1] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("SeasonPointClientDataReq", ICampaignComRequest)
SeasonPointClientDataReq = SeasonPointClientDataReq

function SeasonPointClientDataReq:Constructor()
  self.m_save_info = {}
end

SeasonPointClientDataReq._proto = {
  [1] = {
    "m_save_info",
    "map<int,int>"
  }
}
_class("SeasonPointClientDataReply", ICampaignComResponse)
SeasonPointClientDataReply = SeasonPointClientDataReply

function SeasonPointClientDataReply:Constructor()
end

SeasonPointClientDataReply._proto = {}
local ComDispatchStatus = {DISPATCHING = 1, COMPLETE = 2}
_enum("ComDispatchStatus", ComDispatchStatus)
_class("DispatchArchInfo", Object)
DispatchArchInfo = DispatchArchInfo

function DispatchArchInfo:Constructor()
  self.arch_id = 0
  self.end_time = 0
  self.status = ComDispatchStatus.DISPATCHING
end

DispatchArchInfo._proto = {
  [1] = {"arch_id", "int"},
  [2] = {"end_time", "time"},
  [3] = {"status", "int"}
}
_class("DispatchComponentDataInfo", ICampaignComponentDataInfo)
DispatchComponentDataInfo = DispatchComponentDataInfo

function DispatchComponentDataInfo:Constructor()
  self.dispatch_infos = {}
end

DispatchComponentDataInfo._proto = {
  [1] = {
    "dispatch_infos",
    "map<int,DispatchArchInfo>"
  }
}
_class("DispatchComponentInfo", ICampaignComponentInfo)
DispatchComponentInfo = DispatchComponentInfo

function DispatchComponentInfo:Constructor()
  self.dispatch_infos = {}
end

DispatchComponentInfo._proto = {
  [1] = {
    "dispatch_infos",
    "map<int,DispatchArchInfo>"
  }
}
_class("DispatchReq", ICampaignComRequest)
DispatchReq = DispatchReq

function DispatchReq:Constructor()
  self.arch_id = 0
end

DispatchReq._proto = {
  [1] = {"arch_id", "int"}
}
_class("DispatchReply", ICampaignComResponse)
DispatchReply = DispatchReply

function DispatchReply:Constructor()
  self.ret = 0
  self.info = DispatchArchInfo:New()
end

DispatchReply._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "DispatchArchInfo"
  }
}
_class("GetDispatchRewardsReq", ICampaignComRequest)
GetDispatchRewardsReq = GetDispatchRewardsReq

function GetDispatchRewardsReq:Constructor()
  self.arch_id = 0
end

GetDispatchRewardsReq._proto = {
  [1] = {"arch_id", "int"}
}
_class("GetDispatchRewardsReply", ICampaignComResponse)
GetDispatchRewardsReply = GetDispatchRewardsReply

function GetDispatchRewardsReply:Constructor()
  self.ret = 0
  self.info = DispatchArchInfo:New()
  self.rewards = {}
end

GetDispatchRewardsReply._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "DispatchArchInfo"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("SurveyInfo", Object)
SurveyInfo = SurveyInfo

function SurveyInfo:Constructor()
  self.cur_pet_id = 0
  self.tokens_get_time = 0
  self.tokens_get_num = 0
  self.pet_unlock = {}
end

SurveyInfo._proto = {
  [1] = {"cur_pet_id", "int"},
  [2] = {
    "tokens_get_time",
    "time"
  },
  [3] = {
    "tokens_get_num",
    "int"
  },
  [4] = {"pet_unlock", "list<int>"}
}
_class("SurveyComponentDataInfo", ICampaignComponentDataInfo)
SurveyComponentDataInfo = SurveyComponentDataInfo

function SurveyComponentDataInfo:Constructor()
  self.info = SurveyInfo:New()
end

SurveyComponentDataInfo._proto = {
  [1] = {"info", "SurveyInfo"}
}
_class("SurveyComponentInfo", ICampaignComponentInfo)
SurveyComponentInfo = SurveyComponentInfo

function SurveyComponentInfo:Constructor()
  self.info = SurveyInfo:New()
end

SurveyComponentInfo._proto = {
  [1] = {"info", "SurveyInfo"}
}
local SurveyOperateType = {
  SurveyOperateType_GetToken = 0,
  SurveyOperateType_Next = 1,
  SurveyOperateType_UnLock = 2
}
_enum("SurveyOperateType", SurveyOperateType)
_class("SurveyClientDataReq", ICampaignComRequest)
SurveyClientDataReq = SurveyClientDataReq

function SurveyClientDataReq:Constructor()
  self.op_type = 0
end

SurveyClientDataReq._proto = {
  [1] = {"op_type", "int"}
}
_class("SurveyClientDataReply", ICampaignComResponse)
SurveyClientDataReply = SurveyClientDataReply

function SurveyClientDataReply:Constructor()
  self.ret = 0
  self.info = SurveyInfo:New()
  self.reward = {}
end

SurveyClientDataReply._proto = {
  [1] = {"ret", "int"},
  [2] = {"info", "SurveyInfo"},
  [3] = {
    "reward",
    "list<RoleAsset>"
  }
}
_class("ActionPointDataReq", ICampaignComRequest)
ActionPointDataReq = ActionPointDataReq

function ActionPointDataReq:Constructor()
end

ActionPointDataReq._proto = {}
_class("ActionPointDataReply", ICampaignComResponse)
ActionPointDataReply = ActionPointDataReply

function ActionPointDataReply:Constructor()
  self.m_info = {}
end

ActionPointDataReply._proto = {
  [1] = {
    "m_info",
    "map<int,ActionPopintData>"
  }
}
local ETimeLoginRewardStatus = {
  E_TIME_LOGIN_REWARD_UNKNOW = 0,
  E_TIME_LOGIN_REWARD_LOCK = 1,
  E_TIME_LOGIN_REWARD_CAN_RECV = 2,
  E_TIME_LOGIN_REWARD_RECVED = 3,
  E_TIME_LOGIN_REWARD_EXPIRE_SHOW = 4,
  E_TIME_LOGIN_REWARD_EXPIRE_LOCK = 5,
  E_TIME_LOGIN_REWARD_EXPIRE_CAN = 6
}
_enum("ETimeLoginRewardStatus", ETimeLoginRewardStatus)
local TimeLoginComponentNotifyType = {TimeLoginComponentNotify_Changed = 1}
_enum("TimeLoginComponentNotifyType", TimeLoginComponentNotifyType)
_class("CTimeLoginComponentDataInfo", ICampaignComponentDataInfo)
CTimeLoginComponentDataInfo = CTimeLoginComponentDataInfo

function CTimeLoginComponentDataInfo:Constructor()
  self.m_count = 0
  self.m_info = {}
end

CTimeLoginComponentDataInfo._proto = {
  [1] = {"m_count", "int"},
  [2] = {
    "m_info",
    "map<int,int>"
  }
}
_class("TimeLoginComponentInfo", ICampaignComponentInfo)
TimeLoginComponentInfo = TimeLoginComponentInfo

function TimeLoginComponentInfo:Constructor()
  self.m_count = 0
  self.m_info = {}
end

TimeLoginComponentInfo._proto = {
  [1] = {"m_count", "int"},
  [2] = {
    "m_info",
    "map<int,int>"
  }
}
_class("TimeLoginComponentReceiveRewardReq", ICampaignComRequest)
TimeLoginComponentReceiveRewardReq = TimeLoginComponentReceiveRewardReq

function TimeLoginComponentReceiveRewardReq:Constructor()
  self.m_cfg_id = 0
end

TimeLoginComponentReceiveRewardReq._proto = {
  [1] = {"m_cfg_id", "int"}
}
_class("TimeLoginComponentReceiveRewardRep", ICampaignComResponse)
TimeLoginComponentReceiveRewardRep = TimeLoginComponentReceiveRewardRep

function TimeLoginComponentReceiveRewardRep:Constructor()
  self.m_rewards = {}
  self.m_info = {}
end

TimeLoginComponentReceiveRewardRep._proto = {
  [1] = {
    "m_rewards",
    "list<RoleAsset>"
  },
  [2] = {
    "m_info",
    "map<int,int>"
  }
}
_class("NotifyPointTimeLoginComponentChanged", Object)
NotifyPointTimeLoginComponentChanged = NotifyPointTimeLoginComponentChanged

function NotifyPointTimeLoginComponentChanged:Constructor()
  self.m_count = 0
  self.m_info = {}
end

NotifyPointTimeLoginComponentChanged._proto = {
  [1] = {"m_count", "int"},
  [2] = {
    "m_info",
    "map<int,int>"
  }
}
_class("SeasonMissionTeamRecordReq", ICampaignComRequest)
SeasonMissionTeamRecordReq = SeasonMissionTeamRecordReq

function SeasonMissionTeamRecordReq:Constructor()
  self.num = 0
  self.mission = 0
end

SeasonMissionTeamRecordReq._proto = {
  [1] = {"num", "int"},
  [2] = {"mission", "int"}
}
_class("SeasonMissionTeamRecordRes", ICampaignComResponse)
SeasonMissionTeamRecordRes = SeasonMissionTeamRecordRes

function SeasonMissionTeamRecordRes:Constructor()
  self.ret = 0
  self.info = {}
  self.next_num = 0
end

SeasonMissionTeamRecordRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "list<campaign_mtr_role>"
  },
  [3] = {"next_num", "int"}
}
_class("SeasonClientDataExtReq", ICampaignComRequest)
SeasonClientDataExtReq = SeasonClientDataExtReq

function SeasonClientDataExtReq:Constructor()
  self.ext = {}
end

SeasonClientDataExtReq._proto = {
  [1] = {
    "ext",
    "map<int,int>"
  }
}
_class("SeasonClientDataExtReply", ICampaignComResponse)
SeasonClientDataExtReply = SeasonClientDataExtReply

function SeasonClientDataExtReply:Constructor()
end

SeasonClientDataExtReply._proto = {}
_class("TacitTestMissionInfo", Object)
TacitTestMissionInfo = TacitTestMissionInfo

function TacitTestMissionInfo:Constructor()
  self.mission_id = 0
  self.star = 0
  self.answer_record = {}
end

TacitTestMissionInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"star", "int"},
  [3] = {
    "answer_record",
    "map<int,int>"
  }
}
_class("TacitTestComponentDataInfo", ICampaignComponentDataInfo)
TacitTestComponentDataInfo = TacitTestComponentDataInfo

function TacitTestComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
  self.last_refresh_time = 0
end

TacitTestComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,TacitTestMissionInfo>"
  },
  [2] = {
    "last_refresh_time",
    "time"
  }
}
_class("TacitTestComponentInfo", ICampaignComponentInfo)
TacitTestComponentInfo = TacitTestComponentInfo

function TacitTestComponentInfo:Constructor()
  self.m_pass_mission_info = {}
end

TacitTestComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,TacitTestMissionInfo>"
  }
}
_class("CompleteTacitTestMissionReq", ICampaignComRequest)
CompleteTacitTestMissionReq = CompleteTacitTestMissionReq

function CompleteTacitTestMissionReq:Constructor()
  self.mission_id = 0
  self.star = 0
end

function CompleteTacitTestMissionReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCompleteTacitTestMission
end

CompleteTacitTestMissionReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"star", "int"}
}
_class("CompleteTacitTestMissionRep", ICampaignComResponse)
CompleteTacitTestMissionRep = CompleteTacitTestMissionRep

function CompleteTacitTestMissionRep:Constructor()
  self.ret = 0
  self.reward = {}
  self.info = TacitTestMissionInfo:New()
end

CompleteTacitTestMissionRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "reward",
    "list<RoleAsset>"
  },
  [3] = {
    "info",
    "TacitTestMissionInfo"
  }
}
_class("UpdateTacitTestAnswerReq", ICampaignComRequest)
UpdateTacitTestAnswerReq = UpdateTacitTestAnswerReq

function UpdateTacitTestAnswerReq:Constructor()
  self.mission_id = 0
  self.answer_record = {}
end

function UpdateTacitTestAnswerReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleUpdateTacitTestAnswer
end

UpdateTacitTestAnswerReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {
    "answer_record",
    "map<int,int>"
  }
}
_class("UpdateTacitTestAnswerRep", ICampaignComResponse)
UpdateTacitTestAnswerRep = UpdateTacitTestAnswerRep

function UpdateTacitTestAnswerRep:Constructor()
  self.ret = 0
end

UpdateTacitTestAnswerRep._proto = {
  [1] = {"ret", "int"}
}
local LinePopStarComponentNotifyType = {LinePopStarMissionComponentNotifyType_InfoChanged = 1}
_enum("LinePopStarComponentNotifyType", LinePopStarComponentNotifyType)
_class("NotifyLinePopStarComponentInfoChanged", Object)
NotifyLinePopStarComponentInfoChanged = NotifyLinePopStarComponentInfoChanged

function NotifyLinePopStarComponentInfoChanged:Constructor()
  self.m_update_mission_info = {}
end

NotifyLinePopStarComponentInfoChanged._proto = {
  [1] = {
    "m_update_mission_info",
    "map<int,cam_mission_info>"
  }
}
_class("LinePopStarFormationItem", Object)
LinePopStarFormationItem = LinePopStarFormationItem

function LinePopStarFormationItem:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

LinePopStarFormationItem._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {
    "pet_list",
    "list<int64>"
  }
}
_class("LinePopStarComponentDataInfo", ICampaignComponentDataInfo)
LinePopStarComponentDataInfo = LinePopStarComponentDataInfo

function LinePopStarComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_fight_mission = {}
  self.formation_pet_list = {}
  self.last_refresh_time = 0
end

LinePopStarComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_fight_mission",
    "list<int>"
  },
  [3] = {
    "formation_pet_list",
    "list<LinePopStarFormationItem>"
  },
  [4] = {
    "last_refresh_time",
    "time"
  }
}
_class("LinePopStarComponentInfo", ICampaignComponentInfo)
LinePopStarComponentInfo = LinePopStarComponentInfo

function LinePopStarComponentInfo:Constructor()
  self.m_pass_mission_info = {}
  self.formation_pet_list = {}
end

LinePopStarComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "formation_pet_list",
    "list<LinePopStarFormationItem>"
  }
}
_class("LinePopStarChangeFormationReq", ICampaignComRequest)
LinePopStarChangeFormationReq = LinePopStarChangeFormationReq

function LinePopStarChangeFormationReq:Constructor()
  self.info = LinePopStarFormationItem:New()
end

LinePopStarChangeFormationReq._proto = {
  [1] = {
    "info",
    "LinePopStarFormationItem"
  }
}
_class("LinePopStarChangeFormationRep", ICampaignComResponse)
LinePopStarChangeFormationRep = LinePopStarChangeFormationRep

function LinePopStarChangeFormationRep:Constructor()
  self.m_result = 0
end

LinePopStarChangeFormationRep._proto = {
  [1] = {"m_result", "int"}
}
_class("VoteComponentDataInfo", ICampaignComponentDataInfo)
VoteComponentDataInfo = VoteComponentDataInfo

function VoteComponentDataInfo:Constructor()
  self.pet2vote = {}
  self.init_item = false
end

VoteComponentDataInfo._proto = {
  [1] = {
    "pet2vote",
    "map<int,int>"
  },
  [2] = {"init_item", "bool"}
}
_class("VoteComponentInfo", ICampaignComponentInfo)
VoteComponentInfo = VoteComponentInfo

function VoteComponentInfo:Constructor()
  self.pet2vote = {}
  self.zone_pet2vote = {}
end

VoteComponentInfo._proto = {
  [1] = {
    "pet2vote",
    "map<int,int>"
  },
  [2] = {
    "zone_pet2vote",
    "map<int,int>"
  }
}
_class("DoVoteReq", ICampaignComRequest)
DoVoteReq = DoVoteReq

function DoVoteReq:Constructor()
  self.pet_id = 0
  self.num = 0
end

DoVoteReq._proto = {
  [1] = {"pet_id", "int"},
  [2] = {"num", "int"}
}
_class("DoVoteRep", ICampaignComResponse)
DoVoteRep = DoVoteRep

function DoVoteRep:Constructor()
  self.ret = 0
  self.pet_num = 0
  self.zone_pet_num = 0
end

DoVoteRep._proto = {
  [1] = {"ret", "int"},
  [2] = {"pet_num", "int"},
  [3] = {
    "zone_pet_num",
    "int"
  }
}
_class("GetZonePetVoteReq", ICampaignComRequest)
GetZonePetVoteReq = GetZonePetVoteReq

function GetZonePetVoteReq:Constructor()
end

GetZonePetVoteReq._proto = {}
_class("GetZonePetVoteRep", ICampaignComResponse)
GetZonePetVoteRep = GetZonePetVoteRep

function GetZonePetVoteRep:Constructor()
  self.ret = 0
  self.zone_pet2vote = {}
end

GetZonePetVoteRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "zone_pet2vote",
    "map<int,int>"
  }
}
local ASheepMissionType = {
  ASheepMissionType_None = 0,
  ASheepMissionType_Common = 1,
  ASheepMissionType_Challenge = 2
}
_enum("ASheepMissionType", ASheepMissionType)
_class("ASheepInfo", Object)
ASheepInfo = ASheepInfo

function ASheepInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_received = {}
  self.m_max_score = 0
end

ASheepInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {"m_received", "list<int>"},
  [3] = {
    "m_max_score",
    "int"
  }
}
_class("ASheepComponentDataInfo", ICampaignComponentDataInfo)
ASheepComponentDataInfo = ASheepComponentDataInfo

function ASheepComponentDataInfo:Constructor()
  self.m_info = ASheepInfo:New()
end

ASheepComponentDataInfo._proto = {
  [1] = {"m_info", "ASheepInfo"}
}
_class("ASheepComponentInfo", ICampaignComponentInfo)
ASheepComponentInfo = ASheepComponentInfo

function ASheepComponentInfo:Constructor()
  self.m_info = ASheepInfo:New()
end

ASheepComponentInfo._proto = {
  [1] = {"m_info", "ASheepInfo"}
}
_class("CompleteASheepMissionReq", ICampaignComRequest)
CompleteASheepMissionReq = CompleteASheepMissionReq

function CompleteASheepMissionReq:Constructor()
  self.mission_id = 0
  self.score = 0
end

function CompleteASheepMissionReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCompleteASheepMission
end

CompleteASheepMissionReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"score", "int"}
}
_class("CompleteASheepMissionRep", ICampaignComResponse)
CompleteASheepMissionRep = CompleteASheepMissionRep

function CompleteASheepMissionRep:Constructor()
  self.ret = 0
  self.reward = {}
  self.m_info = ASheepInfo:New()
end

CompleteASheepMissionRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "reward",
    "list<RoleAsset>"
  },
  [3] = {"m_info", "ASheepInfo"}
}
local RandomLotteryComponentNotifyType = {RandomLotteryComponentNotify_Clear = 1}
_enum("RandomLotteryComponentNotifyType", RandomLotteryComponentNotifyType)
_class("CRandomLotteryInfo", Object)
CRandomLotteryInfo = CRandomLotteryInfo

function CRandomLotteryInfo:Constructor()
  self.draw_cfg_id = 0
  self.random_type = 0
  self.pet_cfg_id = 0
  self.is_get = false
  self.m_rewards = {}
end

CRandomLotteryInfo._proto = {
  [1] = {
    "draw_cfg_id",
    "int"
  },
  [2] = {
    "random_type",
    "int"
  },
  [3] = {"pet_cfg_id", "int"},
  [4] = {"is_get", "bool"},
  [5] = {
    "m_rewards",
    "list<RoleAsset>"
  }
}
_class("CRandomLotteryComponentDataInfo", ICampaignComponentDataInfo)
CRandomLotteryComponentDataInfo = CRandomLotteryComponentDataInfo

function CRandomLotteryComponentDataInfo:Constructor()
  self.m_one_count = 0
  self.m_multi_count = 0
  self.m_draw = {}
  self.draw_refresh_time = 0
end

CRandomLotteryComponentDataInfo._proto = {
  [1] = {
    "m_one_count",
    "int"
  },
  [2] = {
    "m_multi_count",
    "int"
  },
  [3] = {
    "m_draw",
    "list<CRandomLotteryInfo>"
  },
  [4] = {
    "draw_refresh_time",
    "time"
  }
}
_class("RandomLotteryComponentInfo", ICampaignComponentInfo)
RandomLotteryComponentInfo = RandomLotteryComponentInfo

function RandomLotteryComponentInfo:Constructor()
  self.m_one_count = 0
  self.m_multi_count = 0
  self.m_draw = {}
  self.draw_refresh_time = 0
end

RandomLotteryComponentInfo._proto = {
  [1] = {
    "m_one_count",
    "int"
  },
  [2] = {
    "m_multi_count",
    "int"
  },
  [3] = {
    "m_draw",
    "list<CRandomLotteryInfo>"
  },
  [4] = {
    "draw_refresh_time",
    "time"
  }
}
_class("RandomLotteryComponentCostReq", ICampaignComRequest)
RandomLotteryComponentCostReq = RandomLotteryComponentCostReq

function RandomLotteryComponentCostReq:Constructor()
  self.cfg_id = 0
  self.is_one = true
end

RandomLotteryComponentCostReq._proto = {
  [1] = {"cfg_id", "int"},
  [2] = {"is_one", "bool"}
}
_class("RandomLotteryComponentCostRep", ICampaignComResponse)
RandomLotteryComponentCostRep = RandomLotteryComponentCostRep

function RandomLotteryComponentCostRep:Constructor()
  self.m_rewards = {}
  self.m_one_count = 0
  self.m_multi_count = 0
  self.m_fixed_reward = {}
end

RandomLotteryComponentCostRep._proto = {
  [1] = {
    "m_rewards",
    "list<RoleAsset>"
  },
  [2] = {
    "m_one_count",
    "int"
  },
  [3] = {
    "m_multi_count",
    "int"
  },
  [4] = {
    "m_fixed_reward",
    "list<RoleAsset>"
  }
}
_class("NotifyRandomLotteryComponentClear", Object)
NotifyRandomLotteryComponentClear = NotifyRandomLotteryComponentClear

function NotifyRandomLotteryComponentClear:Constructor()
  self.draw_refresh_time = 0
end

NotifyRandomLotteryComponentClear._proto = {
  [1] = {
    "draw_refresh_time",
    "time"
  }
}
local BusinessProType = {
  BPT_Command = 0,
  BPT_Sail = 1,
  BPT_Fix = 2,
  BPT_Max = 3
}
_enum("BusinessProType", BusinessProType)
_class("BusinessHarborInfo", Object)
BusinessHarborInfo = BusinessHarborInfo

function BusinessHarborInfo:Constructor()
  self.lv = 0
  self.cdEnd = 0
end

BusinessHarborInfo._proto = {
  [1] = {"lv", "int"},
  [2] = {"cdEnd", "time"}
}
_class("BusinessShipInfo", Object)
BusinessShipInfo = BusinessShipInfo

function BusinessShipInfo:Constructor()
  self.lv = 0
  self.seamans = {}
end

BusinessShipInfo._proto = {
  [1] = {"lv", "int"},
  [2] = {"seamans", "list<int>"}
}
_class("BusinessSeamanInfo", Object)
BusinessSeamanInfo = BusinessSeamanInfo

function BusinessSeamanInfo:Constructor()
  self.hire_time = 0
  self.work_id = 0
end

BusinessSeamanInfo._proto = {
  [1] = {"hire_time", "time"},
  [2] = {"work_id", "int"}
}
_class("BusinessGEInfo", Object)
BusinessGEInfo = BusinessGEInfo

function BusinessGEInfo:Constructor()
  self.first_time = 0
  self.num = 0
end

BusinessGEInfo._proto = {
  [1] = {"first_time", "time"},
  [2] = {"num", "int"}
}
_class("BusinessComponentDataInfo", ICampaignComponentDataInfo)
BusinessComponentDataInfo = BusinessComponentDataInfo

function BusinessComponentDataInfo:Constructor()
  self.harborInfo = {}
  self.shipInfo = {}
  self.globalInfo = {}
  self.eventInfo = {}
  self.seamanInfo = {}
  self.globalIdCom = {}
  self.globalId = 0
  self.globalNum = 0
  self.eventIdCom = {}
  self.harborId = 0
end

BusinessComponentDataInfo._proto = {
  [1] = {
    "harborInfo",
    "map<int,BusinessHarborInfo>"
  },
  [2] = {
    "shipInfo",
    "map<int,BusinessShipInfo>"
  },
  [3] = {
    "globalInfo",
    "map<int,BusinessGEInfo>"
  },
  [4] = {
    "eventInfo",
    "map<int,BusinessGEInfo>"
  },
  [5] = {
    "seamanInfo",
    "map<int,BusinessSeamanInfo>"
  },
  [6] = {
    "globalIdCom",
    "list<int>"
  },
  [7] = {"globalId", "int"},
  [8] = {"globalNum", "int"},
  [9] = {"eventIdCom", "list<int>"},
  [10] = {"harborId", "int"}
}
_class("BusinessComponentInfo", ICampaignComponentInfo)
BusinessComponentInfo = BusinessComponentInfo

function BusinessComponentInfo:Constructor()
  self.harborInfo = {}
  self.shipInfo = {}
  self.globalInfo = {}
  self.eventInfo = {}
  self.seamanInfo = {}
  self.globalId = 0
  self.globalNum = 0
  self.eventIdCom = {}
  self.harborId = 0
end

BusinessComponentInfo._proto = {
  [1] = {
    "harborInfo",
    "map<int,BusinessHarborInfo>"
  },
  [2] = {
    "shipInfo",
    "map<int,BusinessShipInfo>"
  },
  [3] = {
    "globalInfo",
    "map<int,BusinessGEInfo>"
  },
  [4] = {
    "eventInfo",
    "map<int,BusinessGEInfo>"
  },
  [5] = {
    "seamanInfo",
    "map<int,BusinessSeamanInfo>"
  },
  [7] = {"globalId", "int"},
  [8] = {"globalNum", "int"},
  [9] = {"eventIdCom", "list<int>"},
  [10] = {"harborId", "int"}
}
_class("BusinessSelectReq", ICampaignComRequest)
BusinessSelectReq = BusinessSelectReq

function BusinessSelectReq:Constructor()
  self.harbor_id = 0
end

BusinessSelectReq._proto = {
  [1] = {"harbor_id", "int"}
}
_class("BusinessSelectResult", ICampaignComResponse)
BusinessSelectResult = BusinessSelectResult

function BusinessSelectResult:Constructor()
  self.ret = 0
end

BusinessSelectResult._proto = {
  [1] = {"ret", "int"}
}
_class("BusinessHarborReq", ICampaignComRequest)
BusinessHarborReq = BusinessHarborReq

function BusinessHarborReq:Constructor()
  self.cfg_id = 0
end

BusinessHarborReq._proto = {
  [1] = {"cfg_id", "int"}
}
_class("BusinessHarborResult", ICampaignComResponse)
BusinessHarborResult = BusinessHarborResult

function BusinessHarborResult:Constructor()
  self.ret = 0
  self.info = {}
end

BusinessHarborResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "map<int,BusinessHarborInfo>"
  }
}
_class("BusinessShipReq", ICampaignComRequest)
BusinessShipReq = BusinessShipReq

function BusinessShipReq:Constructor()
  self.cfg_id = 0
end

BusinessShipReq._proto = {
  [1] = {"cfg_id", "int"}
}
_class("BusinessShipResult", ICampaignComResponse)
BusinessShipResult = BusinessShipResult

function BusinessShipResult:Constructor()
  self.ret = 0
  self.info = {}
end

BusinessShipResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "map<int,BusinessShipInfo>"
  }
}
_class("BusinessHireSeamanReq", ICampaignComRequest)
BusinessHireSeamanReq = BusinessHireSeamanReq

function BusinessHireSeamanReq:Constructor()
  self.cfg_id_harbor = 0
  self.cfg_id_seaman = 0
end

BusinessHireSeamanReq._proto = {
  [1] = {
    "cfg_id_harbor",
    "int"
  },
  [2] = {
    "cfg_id_seaman",
    "int"
  }
}
_class("BusinessHireSeamanResult", ICampaignComResponse)
BusinessHireSeamanResult = BusinessHireSeamanResult

function BusinessHireSeamanResult:Constructor()
  self.ret = 0
  self.info = {}
end

BusinessHireSeamanResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "map<int,BusinessSeamanInfo>"
  }
}
_class("BusinessWorkSeamanReq", ICampaignComRequest)
BusinessWorkSeamanReq = BusinessWorkSeamanReq

function BusinessWorkSeamanReq:Constructor()
  self.work_id = 0
  self.seamans = {}
end

BusinessWorkSeamanReq._proto = {
  [1] = {"work_id", "int"},
  [2] = {"seamans", "list<int>"}
}
_class("BusinessWorkSeamanResult", ICampaignComResponse)
BusinessWorkSeamanResult = BusinessWorkSeamanResult

function BusinessWorkSeamanResult:Constructor()
  self.ret = 0
  self.shipInfo = {}
  self.seamanInfo = {}
end

BusinessWorkSeamanResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "shipInfo",
    "map<int,BusinessShipInfo>"
  },
  [3] = {
    "seamanInfo",
    "map<int,BusinessSeamanInfo>"
  }
}
_class("BusinessSailingReq", ICampaignComRequest)
BusinessSailingReq = BusinessSailingReq

function BusinessSailingReq:Constructor()
  self.harbor_id = 0
  self.event_ids = {}
  self.event_op = {}
  self.income = 0
  self.cd_time = 0
end

BusinessSailingReq._proto = {
  [1] = {"harbor_id", "int"},
  [2] = {"event_ids", "list<int>"},
  [3] = {
    "event_op",
    "list<map<int,bool>>"
  },
  [4] = {"income", "int"},
  [5] = {"cd_time", "int"}
}
_class("BusinessSailingResult", ICampaignComResponse)
BusinessSailingResult = BusinessSailingResult

function BusinessSailingResult:Constructor()
  self.ret = 0
  self.harborInfo = {}
  self.globalInfo = {}
  self.eventInfo = {}
  self.globalId = 0
  self.globalNum = 0
  self.eventIdCom = {}
  self.income = 0
  self.cd_time = 0
end

BusinessSailingResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "harborInfo",
    "map<int,BusinessHarborInfo>"
  },
  [3] = {
    "globalInfo",
    "map<int,BusinessGEInfo>"
  },
  [4] = {
    "eventInfo",
    "map<int,BusinessGEInfo>"
  },
  [5] = {"globalId", "int"},
  [6] = {"globalNum", "int"},
  [7] = {"eventIdCom", "list<int>"},
  [8] = {"income", "int"},
  [9] = {"cd_time", "int"}
}
_class("PersonProgressProgressReq", ICampaignComRequest)
PersonProgressProgressReq = PersonProgressProgressReq

function PersonProgressProgressReq:Constructor()
  self.m_progress = 0
end

PersonProgressProgressReq._proto = {
  [1] = {"m_progress", "int"}
}
_class("PersonProgressProgressResult", ICampaignComResponse)
PersonProgressProgressResult = PersonProgressProgressResult

function PersonProgressProgressResult:Constructor()
  self.ret = 0
end

PersonProgressProgressResult._proto = {
  [1] = {"ret", "int"}
}
_class("RandomLotteryComponentDrawReq", ICampaignComRequest)
RandomLotteryComponentDrawReq = RandomLotteryComponentDrawReq

function RandomLotteryComponentDrawReq:Constructor()
  self.cfg_id = 0
end

RandomLotteryComponentDrawReq._proto = {
  [1] = {"cfg_id", "int"}
}
_class("RandomLotteryComponentDrawRep", ICampaignComResponse)
RandomLotteryComponentDrawRep = RandomLotteryComponentDrawRep

function RandomLotteryComponentDrawRep:Constructor()
  self.m_draw = CRandomLotteryInfo:New()
  self.m_one_count = 0
  self.m_multi_count = 0
end

RandomLotteryComponentDrawRep._proto = {
  [1] = {
    "m_draw",
    "CRandomLotteryInfo"
  },
  [2] = {
    "m_one_count",
    "int"
  },
  [3] = {
    "m_multi_count",
    "int"
  }
}
_class("RandomLotteryComponentDrawRewardReq", ICampaignComRequest)
RandomLotteryComponentDrawRewardReq = RandomLotteryComponentDrawRewardReq

function RandomLotteryComponentDrawRewardReq:Constructor()
  self.index = 0
end

RandomLotteryComponentDrawRewardReq._proto = {
  [1] = {"index", "int"}
}
_class("RandomLotteryComponentDrawRewardRep", ICampaignComResponse)
RandomLotteryComponentDrawRewardRep = RandomLotteryComponentDrawRewardRep

function RandomLotteryComponentDrawRewardRep:Constructor()
  self.m_draw = CRandomLotteryInfo:New()
end

RandomLotteryComponentDrawRewardRep._proto = {
  [1] = {
    "m_draw",
    "CRandomLotteryInfo"
  }
}
local LuckLandMissionType = {
  LuckLandMissionType_None = 0,
  LuckLandMissionType_Study = 1,
  LuckLandMissionType_Common = 2,
  LuckLandMissionType_Rank = 3
}
_enum("LuckLandMissionType", LuckLandMissionType)
_class("LuckLandMissionInfo", Object)
LuckLandMissionInfo = LuckLandMissionInfo

function LuckLandMissionInfo:Constructor()
  self.mission_id = 0
  self.star = 0
  self.record_score = 0
  self.money = 0
  self.cur_hp = 0
  self.build_map = {}
  self.cur_star = 0
end

LuckLandMissionInfo._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"star", "int"},
  [3] = {
    "record_score",
    "int"
  },
  [4] = {"money", "int"},
  [5] = {"cur_hp", "int"},
  [6] = {
    "build_map",
    "map<int,int>"
  },
  [7] = {"cur_star", "int"}
}
_class("LuckLandResultInfo", Object)
LuckLandResultInfo = LuckLandResultInfo

function LuckLandResultInfo:Constructor()
  self.money_score = 0
  self.build_score = 0
  self.hp_prop = 0
  self.total_score = 0
end

LuckLandResultInfo._proto = {
  [1] = {
    "money_score",
    "int"
  },
  [2] = {
    "build_score",
    "int"
  },
  [3] = {"hp_prop", "int"},
  [4] = {
    "total_score",
    "int"
  }
}
_class("LuckLandComponentDataInfo", ICampaignComponentDataInfo)
LuckLandComponentDataInfo = LuckLandComponentDataInfo

function LuckLandComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
end

LuckLandComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,LuckLandMissionInfo>"
  }
}
_class("LuckLandComponentInfo", ICampaignComponentInfo)
LuckLandComponentInfo = LuckLandComponentInfo

function LuckLandComponentInfo:Constructor()
  self.m_pass_mission_info = {}
end

LuckLandComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,LuckLandMissionInfo>"
  }
}
_class("CompleteLuckLandMissionReq", ICampaignComRequest)
CompleteLuckLandMissionReq = CompleteLuckLandMissionReq

function CompleteLuckLandMissionReq:Constructor()
  self.mission_id = 0
  self.money = 0
  self.cur_hp = 0
  self.build_map = {}
end

function CompleteLuckLandMissionReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCompleteLuckLandMission
end

CompleteLuckLandMissionReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"money", "int"},
  [3] = {"cur_hp", "int"},
  [4] = {
    "build_map",
    "map<int,int>"
  }
}
_class("CompleteLuckLandMissionRep", ICampaignComResponse)
CompleteLuckLandMissionRep = CompleteLuckLandMissionRep

function CompleteLuckLandMissionRep:Constructor()
  self.ret = 0
  self.reward = {}
  self.m_info = LuckLandMissionInfo:New()
  self.m_result = LuckLandResultInfo:New()
  self.three_reward = {}
end

CompleteLuckLandMissionRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "reward",
    "list<RoleAsset>"
  },
  [3] = {
    "m_info",
    "LuckLandMissionInfo"
  },
  [4] = {
    "m_result",
    "LuckLandResultInfo"
  },
  [5] = {
    "three_reward",
    "list<RoleAsset>"
  }
}
_class("BalanceLuckLandMoneyReq", ICampaignComRequest)
BalanceLuckLandMoneyReq = BalanceLuckLandMoneyReq

function BalanceLuckLandMoneyReq:Constructor()
  self.round_id = 0
  self.money = 0
end

function BalanceLuckLandMoneyReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleBalanceLuckLandMoney
end

BalanceLuckLandMoneyReq._proto = {
  [1] = {"round_id", "int"},
  [2] = {"money", "int"}
}
_class("BalanceLuckLandMoneyRep", ICampaignComResponse)
BalanceLuckLandMoneyRep = BalanceLuckLandMoneyRep

function BalanceLuckLandMoneyRep:Constructor()
  self.ret = 0
  self.money = 0
end

BalanceLuckLandMoneyRep._proto = {
  [1] = {"ret", "int"},
  [2] = {"money", "int"}
}
_class("LuckLandGetRankListReq", ICampaignComRequest)
LuckLandGetRankListReq = LuckLandGetRankListReq

function LuckLandGetRankListReq:Constructor()
  self.mission_id = 0
end

function LuckLandGetRankListReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleLuckLandGetRankList
end

LuckLandGetRankListReq._proto = {
  [1] = {"mission_id", "int"}
}
_class("LuckLandGetRankListRes", ICampaignComResponse)
LuckLandGetRankListRes = LuckLandGetRankListRes

function LuckLandGetRankListRes:Constructor()
  self.nRet = 0
  self.show_list = RankShowSimpleInfo:New()
end

LuckLandGetRankListRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "show_list",
    "RankShowSimpleInfo"
  }
}
local TalentTreeSkillType = {
  TTST_Skill_None = 0,
  TTST_Skill_Main = 1,
  TTST_Skill_Common = 2,
  TTST_Skill_Pet = 1
}
_enum("TalentTreeSkillType", TalentTreeSkillType)
local OperateTalentTree = {
  OTT_Talent_Buy = 0,
  OTT_Talent_Upgrade = 1,
  OTT_Talent_Install = 2,
  OTT_Talent_UnInstall_all = 3
}
_enum("OperateTalentTree", OperateTalentTree)
_class("NewTalentTreeInfo", Object)
NewTalentTreeInfo = NewTalentTreeInfo

function NewTalentTreeInfo:Constructor()
  self.m_skill_list = {}
  self.m_skill_solt = {}
  self.m_skill_cost = {}
end

NewTalentTreeInfo._proto = {
  [1] = {
    "m_skill_list",
    "map<int,int>"
  },
  [2] = {
    "m_skill_solt",
    "map<int,int>"
  },
  [3] = {
    "m_skill_cost",
    "map<int,int>"
  }
}
_class("TalentTreeComponentDataInfo", ICampaignComponentDataInfo)
TalentTreeComponentDataInfo = TalentTreeComponentDataInfo

function TalentTreeComponentDataInfo:Constructor()
  self.m_talent_info = NewTalentTreeInfo:New()
end

TalentTreeComponentDataInfo._proto = {
  [1] = {
    "m_talent_info",
    "NewTalentTreeInfo"
  }
}
_class("TalentTreeComponentInfo", ICampaignComponentInfo)
TalentTreeComponentInfo = TalentTreeComponentInfo

function TalentTreeComponentInfo:Constructor()
  self.m_talent_info = NewTalentTreeInfo:New()
end

TalentTreeComponentInfo._proto = {
  [1] = {
    "m_talent_info",
    "NewTalentTreeInfo"
  }
}
_class("OperateTalentTreeSkillReq", ICampaignComRequest)
OperateTalentTreeSkillReq = OperateTalentTreeSkillReq

function OperateTalentTreeSkillReq:Constructor()
  self.operate_type = 0
  self.skill_type_id = 0
  self.skill_solt_id = 0
end

function OperateTalentTreeSkillReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleOperateTalentTreeSkill
end

OperateTalentTreeSkillReq._proto = {
  [1] = {
    "operate_type",
    "int"
  },
  [2] = {
    "skill_type_id",
    "int"
  },
  [3] = {
    "skill_solt_id",
    "int"
  }
}
_class("OperateTalentTreeSkillRep", ICampaignComResponse)
OperateTalentTreeSkillRep = OperateTalentTreeSkillRep

function OperateTalentTreeSkillRep:Constructor()
  self.ret = 0
  self.m_talent_info = NewTalentTreeInfo:New()
end

OperateTalentTreeSkillRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "m_talent_info",
    "NewTalentTreeInfo"
  }
}
local CollectCardComponentNotifyType = {CollectCardComponentNotifyType_InfoChanged = 1}
_enum("CollectCardComponentNotifyType", CollectCardComponentNotifyType)
local CardType = {Common = 1, Gold = 2}
_enum("CardType", CardType)
local DropCardType = {CommonDrop = 1, NewDrop = 2}
_enum("DropCardType", DropCardType)
local PoolType = {Type1 = 1, Type2 = 2}
_enum("PoolType", PoolType)
_class("ReceiveCardInfo", Object)
ReceiveCardInfo = ReceiveCardInfo

function ReceiveCardInfo:Constructor()
  self.player_name = ""
  self.card_id = 0
  self.openid = ""
end

ReceiveCardInfo._proto = {
  [1] = {
    "player_name",
    "string"
  },
  [2] = {"card_id", "int"},
  [3] = {"openid", "string"}
}
_class("NotifyCollectCardComponentInfoChanged", Object)
NotifyCollectCardComponentInfoChanged = NotifyCollectCardComponentInfoChanged

function NotifyCollectCardComponentInfoChanged:Constructor()
  self.add_cards = {}
  self.infos = {}
end

NotifyCollectCardComponentInfoChanged._proto = {
  [1] = {
    "add_cards",
    "map<int,int>"
  },
  [2] = {
    "infos",
    "list<ReceiveCardInfo>"
  }
}
_class("CollectCardComponentDataInfo", ICampaignComponentDataInfo)
CollectCardComponentDataInfo = CollectCardComponentDataInfo

function CollectCardComponentDataInfo:Constructor()
  self.received_rewards = {}
  self.send_card_info = {}
  self.card = {}
  self.pool_type = 0
  self.drop_card_num = 0
  self.last_refresh_time = 0
  self.gold_card_num = 0
  self.receive_cards = {}
end

CollectCardComponentDataInfo._proto = {
  [1] = {
    "received_rewards",
    "list<int>"
  },
  [2] = {
    "send_card_info",
    "map<int64,int>"
  },
  [3] = {
    "card",
    "map<int,int>"
  },
  [4] = {"pool_type", "int"},
  [5] = {
    "drop_card_num",
    "int"
  },
  [6] = {
    "last_refresh_time",
    "time"
  },
  [7] = {
    "gold_card_num",
    "int"
  },
  [8] = {
    "receive_cards",
    "list<ReceiveCardInfo>"
  }
}
_class("CollectCardComponentInfo", ICampaignComponentInfo)
CollectCardComponentInfo = CollectCardComponentInfo

function CollectCardComponentInfo:Constructor()
  self.received_rewards = {}
  self.send_card_info = {}
  self.card = {}
  self.receive_cards = {}
end

CollectCardComponentInfo._proto = {
  [1] = {
    "received_rewards",
    "list<int>"
  },
  [2] = {
    "send_card_info",
    "map<int64,int>"
  },
  [3] = {
    "card",
    "map<int,int>"
  },
  [4] = {
    "receive_cards",
    "list<ReceiveCardInfo>"
  }
}
_class("TakeCollectCardRewardReq", ICampaignComRequest)
TakeCollectCardRewardReq = TakeCollectCardRewardReq

function TakeCollectCardRewardReq:Constructor()
  self.reward_id = 0
end

TakeCollectCardRewardReq._proto = {
  [1] = {"reward_id", "int"}
}
_class("TakeCollectCardRewardRes", ICampaignComResponse)
TakeCollectCardRewardRes = TakeCollectCardRewardRes

function TakeCollectCardRewardRes:Constructor()
  self.ret = 0
  self.rewards = {}
end

TakeCollectCardRewardRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("DropCardsReq", ICampaignComRequest)
DropCardsReq = DropCardsReq

function DropCardsReq:Constructor()
  self.item1 = RoleAsset:New()
  self.item2 = RoleAsset:New()
end

DropCardsReq._proto = {
  [1] = {"item1", "RoleAsset"},
  [2] = {"item2", "RoleAsset"}
}
_class("DropCardsRes", ICampaignComResponse)
DropCardsRes = DropCardsRes

function DropCardsRes:Constructor()
  self.ret = 0
  self.add_cards = {}
end

DropCardsRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "add_cards",
    "map<int,int>"
  }
}
_class("SendCardReq", ICampaignComRequest)
SendCardReq = SendCardReq

function SendCardReq:Constructor()
  self.pstid = 0
  self.card_id = 0
end

SendCardReq._proto = {
  [2] = {"pstid", "int64"},
  [1] = {"card_id", "int"}
}
_class("SendCardRes", ICampaignComResponse)
SendCardRes = SendCardRes

function SendCardRes:Constructor()
  self.ret = 0
  self.send_card_info = {}
end

SendCardRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "send_card_info",
    "map<int64,int>"
  }
}
_class("ClearSendCardInfoReq", ICampaignComRequest)
ClearSendCardInfoReq = ClearSendCardInfoReq

function ClearSendCardInfoReq:Constructor()
end

ClearSendCardInfoReq._proto = {}
_class("ClearSendCardInfoRes", ICampaignComResponse)
ClearSendCardInfoRes = ClearSendCardInfoRes

function ClearSendCardInfoRes:Constructor()
  self.ret = 0
end

ClearSendCardInfoRes._proto = {
  [1] = {"ret", "int"}
}
_class("LineChangeFormationReq", ICampaignComRequest)
LineChangeFormationReq = LineChangeFormationReq

function LineChangeFormationReq:Constructor()
  self.info = LineFormationItem:New()
end

LineChangeFormationReq._proto = {
  [1] = {
    "info",
    "LineFormationItem"
  }
}
_class("LineChangeFormationReply", ICampaignComResponse)
LineChangeFormationReply = LineChangeFormationReply

function LineChangeFormationReply:Constructor()
end

LineChangeFormationReply._proto = {}
local SeasonMazeRoomType = {
  SMRT_Invalid = 0,
  SMRT_PVE = 1,
  SMRT_Random = 2,
  SMRT_Resource = 3,
  SMRT_Ore = 4,
  SMRT_Box = 5,
  SMRT_Round = 6,
  SMRT_Empty = 7,
  SMRT_Camp = 8,
  SMRT_Altar = 9,
  SMRT_Market = 10,
  SMRT_PetRecruit = 11,
  SMRT_Transfor = 12,
  SMRT_Shop = 13,
  SMRT_BeadShop = 14,
  SMRT_Max = 15
}
_enum("SeasonMazeRoomType", SeasonMazeRoomType)
local SeasonMazeActionState = {
  SMAS_Invalid = 0,
  SMAS_Init = 1,
  SMAS_RandomHand = 2,
  SMAS_ChooseHand = 3,
  SMAS_GoPoint = 4,
  SMAS_RoomOperate = 5,
  SMAS_Relic = 6,
  SMAS_BreakPet = 7,
  SMAS_NewHand = 8,
  SMAS_BossBattle = 9,
  SMAS_RoundEnd = 10,
  SMAS_HardClearing = 11,
  SMAS_HardVictory = 12
}
_enum("SeasonMazeActionState", SeasonMazeActionState)
local SeasonMazePointStateType = {
  SMPST_Invalid = 0,
  SMPST_Pass = 1,
  SMPST_Occupy = 2,
  SMPST_Choose = 3,
  SMPST_End = 4
}
_enum("SeasonMazePointStateType", SeasonMazePointStateType)
local SeasonMazeMarketRoleType = {
  SMMRT_Invalid = 0,
  SMMRT_Friend = 1,
  SMMRT_Gale = 2,
  SMMRT_Bot = 3
}
_enum("SeasonMazeMarketRoleType", SeasonMazeMarketRoleType)
local SeasonMazeRewardReason = {
  SMRR_Invalid = 0,
  SMRR_GM = 1,
  SMRR_Init = 2,
  SMRR_ChooseHand = 3,
  SMRR_GoPoint = 4,
  SMRR_RoomOperate = 5,
  SMRR_ChooseRelic = 6,
  SMRR_NewHand = 7,
  SMRR_BossBattle = 8,
  SMRR_HardClearing = 9,
  SMRR_RoomPVE = 10,
  SMRR_RoomRandom = 11,
  SMRR_RoomRes = 12,
  SMRR_RoomOre = 13,
  SMRR_RoomBox = 14,
  SMRR_RoomRound = 15,
  SMRR_RoomCamp = 16,
  SMRR_RoomAltar = 17,
  SMRR_RoomMarket = 18,
  SMRR_Recruit = 19,
  SMRR_Healthy = 20,
  SMRR_ResurrectPet = 21,
  SMRR_Slot = 22,
  SMRR_SaveLv = 23,
  SMRR_Once = 24,
  SMRR_RelicSuit = 25,
  SMRR_FullBreakPet = 26,
  SMRR_RoundEnd = 27,
  SMRR_RandomHand = 28,
  SMRR_UpLv = 29,
  SMRR_LayerClear = 30,
  SMRR_GAINUPADDGOLD = 31,
  SMRR_PassLastBossReset = 32,
  SMRR_BossRelicGold = 33
}
_enum("SeasonMazeRewardReason", SeasonMazeRewardReason)
_class("SeasonMazeRoomBaseOre", Object)
SeasonMazeRoomBaseOre = SeasonMazeRoomBaseOre

function SeasonMazeRoomBaseOre:Constructor()
  self.raw_round = 0
  self.residue_round = 0
  self.reward = SeasonMazeEffect:New()
end

SeasonMazeRoomBaseOre._proto = {
  [1] = {"raw_round", "int"},
  [2] = {
    "residue_round",
    "int"
  },
  [3] = {
    "reward",
    "SeasonMazeEffect"
  }
}
_class("SeasonMazeHardInfo", Object)
SeasonMazeHardInfo = SeasonMazeHardInfo

function SeasonMazeHardInfo:Constructor()
  self.vic_count = 0
  self.fail_info = {}
  self.new_flag = false
end

SeasonMazeHardInfo._proto = {
  [1] = {"vic_count", "int"},
  [2] = {"fail_info", "list<int>"},
  [3] = {"new_flag", "bool"}
}
_class("SeasonMazeHandInfo", Object)
SeasonMazeHandInfo = SeasonMazeHandInfo

function SeasonMazeHandInfo:Constructor()
  self.id = 0
  self.steps = 0
  self.effct = {}
  self.ori_id = 0
end

SeasonMazeHandInfo._proto = {
  [1] = {"id", "int"},
  [2] = {"steps", "int"},
  [3] = {
    "effct",
    "list<SeasonMazeEffect>"
  },
  [4] = {"ori_id", "int"}
}
_class("SeasonMazeWorldBossInfo", Object)
SeasonMazeWorldBossInfo = SeasonMazeWorldBossInfo

function SeasonMazeWorldBossInfo:Constructor()
  self.cfg_id = 0
  self.total_damage = 0
  self.word_ids = {}
end

SeasonMazeWorldBossInfo._proto = {
  [1] = {"cfg_id", "int"},
  [2] = {
    "total_damage",
    "int64"
  },
  [3] = {"word_ids", "list<int>"}
}
_class("SeasonMazeBossInfo", Object)
SeasonMazeBossInfo = SeasonMazeBossInfo

function SeasonMazeBossInfo:Constructor()
  self.cfg_id = 0
  self.cfg_wave = 0
  self.do_cnt = 0
  self.wave_randoms = {}
  self.word_ids = {}
end

SeasonMazeBossInfo._proto = {
  [1] = {"cfg_id", "int"},
  [2] = {"cfg_wave", "int"},
  [3] = {"do_cnt", "int"},
  [4] = {
    "wave_randoms",
    "list<float>"
  },
  [5] = {"word_ids", "list<int>"}
}
_class("SeasonMazeSaveInfo", Object)
SeasonMazeSaveInfo = SeasonMazeSaveInfo

function SeasonMazeSaveInfo:Constructor()
  self.lv = 0
  self.exp = 0
end

SeasonMazeSaveInfo._proto = {
  [1] = {"lv", "int"},
  [2] = {"exp", "int"}
}
_class("SeasonMazeSlotIndex", Object)
SeasonMazeSlotIndex = SeasonMazeSlotIndex

function SeasonMazeSlotIndex:Constructor()
  self.item = SeasonMazeEffect:New()
  self.ori_price = 0
  self.price = 0
  self.sellout = false
end

SeasonMazeSlotIndex._proto = {
  [1] = {
    "item",
    "SeasonMazeEffect"
  },
  [2] = {"ori_price", "int"},
  [3] = {"price", "int"},
  [4] = {"sellout", "bool"}
}
_class("SeasonMazeSlotInfo", Object)
SeasonMazeSlotInfo = SeasonMazeSlotInfo

function SeasonMazeSlotInfo:Constructor()
  self.items = {}
  self.reset_cnt = 0
  self.dis_index = 0
  self.lock_ids = {}
end

SeasonMazeSlotInfo._proto = {
  [1] = {
    "items",
    "map<int,SeasonMazeSlotIndex>"
  },
  [2] = {"reset_cnt", "int"},
  [3] = {"dis_index", "int"},
  [4] = {
    "lock_ids",
    "map<int,SeasonMazeSlotIndex>"
  }
}
_class("SeasonMazeRelicRandomInfo", Object)
SeasonMazeRelicRandomInfo = SeasonMazeRelicRandomInfo

function SeasonMazeRelicRandomInfo:Constructor()
  self.group_num = {}
  self.ids = {}
  self.reset_cnt = 0
  self.type_odds = {}
  self.hit_cnt = {}
end

SeasonMazeRelicRandomInfo._proto = {
  [1] = {
    "group_num",
    "list<RoleAsset>"
  },
  [2] = {"ids", "list<int>"},
  [3] = {"reset_cnt", "int"},
  [4] = {
    "type_odds",
    "map<int,int>"
  },
  [5] = {
    "hit_cnt",
    "map<int,int>"
  }
}
_class("SeasonMazeNewHandInfo", Object)
SeasonMazeNewHandInfo = SeasonMazeNewHandInfo

function SeasonMazeNewHandInfo:Constructor()
  self.ids = {}
  self.lv = {}
end

SeasonMazeNewHandInfo._proto = {
  [1] = {
    "ids",
    "map<int,list<int>>"
  },
  [2] = {
    "lv",
    "map<int,int>"
  }
}
_class("SeasonMazeMarketRoleInfo", Object)
SeasonMazeMarketRoleInfo = SeasonMazeMarketRoleInfo

function SeasonMazeMarketRoleInfo:Constructor()
  self.nick = ""
  self.head = 0
  self.head_bg = 0
  self.frame_id = 0
  self.level = 0
  self.type = 0
  self.bead_id = 0
  self.swap_bead_id = 0
end

SeasonMazeMarketRoleInfo._proto = {
  [1] = {"nick", "string"},
  [2] = {"head", "int"},
  [3] = {"head_bg", "int"},
  [4] = {"frame_id", "int"},
  [5] = {"level", "int"},
  [6] = {"type", "int"},
  [7] = {"bead_id", "int"},
  [8] = {
    "swap_bead_id",
    "int"
  }
}
_class("SeasonMazeRoomBase", Object)
SeasonMazeRoomBase = SeasonMazeRoomBase

function SeasonMazeRoomBase:Constructor()
  self.state = 0
  self.type = 0
  self.cfg_id = 0
  self.is_bomb = false
  self.var_param = 0
  self.rand_box = {}
  self.var_param_1 = 0
  self.market = {}
  self.wave_randoms = {}
  self.word_ids = {}
end

SeasonMazeRoomBase._proto = {
  [1] = {"state", "int"},
  [2] = {"type", "int"},
  [3] = {"cfg_id", "int"},
  [4] = {"is_bomb", "bool"},
  [5] = {"var_param", "int"},
  [6] = {
    "rand_box",
    "list<SeasonMazeEffect>"
  },
  [7] = {
    "var_param_1",
    "int"
  },
  [8] = {
    "market",
    "map<int64,SeasonMazeMarketRoleInfo>"
  },
  [9] = {
    "wave_randoms",
    "list<float>"
  },
  [10] = {"word_ids", "list<int>"}
}
local ESeasonMazePetStateType = {ESeasonMazePetStateType_Dead = 0, ESeasonMazePetStateType_Dispatch = 1}
_enum("ESeasonMazePetStateType", ESeasonMazePetStateType)
local ESeasonMazeAutoBeadType = {
  ESeasonMazeAutoBeadType_Skill = 0,
  ESeasonMazeAutoBeadType_Strong = 1,
  ESeasonMazeAutoBeadType_Energy = 2
}
_enum("ESeasonMazeAutoBeadType", ESeasonMazeAutoBeadType)
_class("SeasonMazeFormationItem", Object)
SeasonMazeFormationItem = SeasonMazeFormationItem

function SeasonMazeFormationItem:Constructor()
  self.id = 0
  self.name = ""
  self.pet_list = {}
end

SeasonMazeFormationItem._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {"pet_list", "list<int>"}
}
_class("SeasonMazePetInfo", Object)
SeasonMazePetInfo = SeasonMazePetInfo

function SeasonMazePetInfo:Constructor()
  self.petID = 0
  self.cur_blood_prcent = 1
  self.break_though_lv = 0
  self.state = 0
  self.pow = -1
  self.max_hp = 0
end

SeasonMazePetInfo._proto = {
  [1] = {"petID", "int"},
  [2] = {
    "cur_blood_prcent",
    "double"
  },
  [3] = {
    "break_though_lv",
    "int"
  },
  [4] = {"state", "int"},
  [5] = {"pow", "int"},
  [6] = {"max_hp", "int"}
}
_class("SeasonMazeRelicInfo", Object)
SeasonMazeRelicInfo = SeasonMazeRelicInfo

function SeasonMazeRelicInfo:Constructor()
  self.relicID = 0
  self.residueCnt = 0
end

SeasonMazeRelicInfo._proto = {
  [1] = {"relicID", "int"},
  [2] = {"residueCnt", "int"}
}
_class("SeasonMazeBagInfo", Object)
SeasonMazeBagInfo = SeasonMazeBagInfo

function SeasonMazeBagInfo:Constructor()
  self.pet_list = {}
  self.relic_list = {}
  self.card_list = {}
  self.once_item_list = {}
end

SeasonMazeBagInfo._proto = {
  [1] = {
    "pet_list",
    "map<int,SeasonMazePetInfo>"
  },
  [2] = {
    "relic_list",
    "map<int,SeasonMazeRelicInfo>"
  },
  [3] = {"card_list", "list<int>"},
  [4] = {
    "once_item_list",
    "map<int,int>"
  }
}
_class("SeasonMazeAutoBead", Object)
SeasonMazeAutoBead = SeasonMazeAutoBead

function SeasonMazeAutoBead:Constructor()
  self.unique_id = 1
  self.cfg_id = 0
  self.b_new = false
end

SeasonMazeAutoBead._proto = {
  [1] = {"unique_id", "int"},
  [2] = {"cfg_id", "int"},
  [3] = {"b_new", "bool"}
}
_class("SeasonMazeAutoBeadClient", Object)
SeasonMazeAutoBeadClient = SeasonMazeAutoBeadClient

function SeasonMazeAutoBeadClient:Constructor()
  self.bead_info = SeasonMazeAutoBead:New()
  self.incr_value = {}
end

SeasonMazeAutoBeadClient._proto = {
  [1] = {
    "bead_info",
    "SeasonMazeAutoBead"
  },
  [2] = {
    "incr_value",
    "map<int,int>"
  }
}
_class("SeasonMazeAutoBeadDB", Object)
SeasonMazeAutoBeadDB = SeasonMazeAutoBeadDB

function SeasonMazeAutoBeadDB:Constructor()
  self.m_auto_bead_map = {}
  self.m_auto_bead_fit_list = {}
  self.m_no_cnt = 0
end

SeasonMazeAutoBeadDB._proto = {
  [1] = {
    "m_auto_bead_map",
    "map<int,SeasonMazeAutoBead>"
  },
  [2] = {
    "m_auto_bead_fit_list",
    "list<int>"
  },
  [3] = {"m_no_cnt", "int"}
}
_class("SeasonRelicSuitInfo", Object)
SeasonRelicSuitInfo = SeasonRelicSuitInfo

function SeasonRelicSuitInfo:Constructor()
  self.suit_list = {}
  self.suit_relic_list = {}
end

SeasonRelicSuitInfo._proto = {
  [1] = {
    "suit_list",
    "map<int,int>"
  },
  [2] = {
    "suit_relic_list",
    "list<int>"
  }
}
_class("SeasonMazeCurRecruit", Object)
SeasonMazeCurRecruit = SeasonMazeCurRecruit

function SeasonMazeCurRecruit:Constructor()
  self.cur_pets = {}
  self.select_pet = 0
end

SeasonMazeCurRecruit._proto = {
  [1] = {"cur_pets", "list<int>"},
  [2] = {"select_pet", "int"}
}
_class("SeasonMazeRecruitInfo", Object)
SeasonMazeRecruitInfo = SeasonMazeRecruitInfo

function SeasonMazeRecruitInfo:Constructor()
  self.curRecruit = SeasonMazeCurRecruit:New()
  self.unselect_cnt = {}
  self.reset_cnt = {}
end

SeasonMazeRecruitInfo._proto = {
  [1] = {
    "curRecruit",
    "SeasonMazeCurRecruit"
  },
  [2] = {
    "unselect_cnt",
    "map<int,int>"
  },
  [3] = {
    "reset_cnt",
    "map<int,int>"
  }
}
_class("SeasonMazeRecruitRoomInfo", Object)
SeasonMazeRecruitRoomInfo = SeasonMazeRecruitRoomInfo

function SeasonMazeRecruitRoomInfo:Constructor()
  self.prop = 0
  self.cur_pets = {}
  self.reroll_cnt = 0
  self.unselect_cnt = {}
  self.reset_cnt = {}
end

SeasonMazeRecruitRoomInfo._proto = {
  [1] = {"prop", "int"},
  [2] = {"cur_pets", "list<int>"},
  [3] = {"reroll_cnt", "int"},
  [4] = {
    "unselect_cnt",
    "map<int,int>"
  },
  [5] = {
    "reset_cnt",
    "map<int,int>"
  }
}
_class("CSeasonMazeComponentDataInfo", ICampaignComponentDataInfo)
CSeasonMazeComponentDataInfo = CSeasonMazeComponentDataInfo

function CSeasonMazeComponentDataInfo:Constructor()
  self.enter_time = 0
  self.hard = 0
  self.rooms = {}
  self.wait_hands = {}
  self.fold_hands = {}
  self.rand_hands = {}
  self.boss_info = {}
  self.cur_hand = SeasonMazeHandInfo:New()
  self.past_hand = {}
  self.cur_point = 0
  self.do_layer_num = 0
  self.hard_num = {}
  self.tmp_point = {}
  self.occupy_ore = {}
  self.cur_state = 0
  self.save_info = SeasonMazeSaveInfo:New()
  self.slot_info = SeasonMazeSlotInfo:New()
  self.relic_random = SeasonMazeRelicRandomInfo:New()
  self.new_hands = SeasonMazeNewHandInfo:New()
  self.room_ids = {}
  self.round_num = {}
  self.suit_info = SeasonRelicSuitInfo:New()
  self.attr_list = {}
  self.m_formation_list = {}
  self.m_bag_info = SeasonMazeBagInfo:New()
  self.m_init_select = false
  self.m_auto_bead_db = SeasonMazeAutoBeadDB:New()
  self.m_recruit_info = SeasonMazeRecruitInfo:New()
  self.m_world_boss_info = SeasonMazeWorldBossInfo:New()
  self.m_recruit_room_info = SeasonMazeRecruitRoomInfo:New()
  self.manunl_ban_pets = {}
end

CSeasonMazeComponentDataInfo._proto = {
  [1] = {"enter_time", "time"},
  [2] = {"hard", "int"},
  [3] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [4] = {"wait_hands", "list<int>"},
  [5] = {"fold_hands", "list<int>"},
  [6] = {"rand_hands", "list<int>"},
  [7] = {
    "boss_info",
    "map<int,SeasonMazeBossInfo>"
  },
  [8] = {
    "cur_hand",
    "SeasonMazeHandInfo"
  },
  [9] = {
    "past_hand",
    "list<SeasonMazeHandInfo>"
  },
  [10] = {"cur_point", "int"},
  [11] = {
    "do_layer_num",
    "int"
  },
  [12] = {
    "hard_num",
    "map<int,SeasonMazeHardInfo>"
  },
  [13] = {"tmp_point", "list<int>"},
  [14] = {
    "occupy_ore",
    "map<int,SeasonMazeRoomBaseOre>"
  },
  [15] = {"cur_state", "int"},
  [16] = {
    "save_info",
    "SeasonMazeSaveInfo"
  },
  [17] = {
    "slot_info",
    "SeasonMazeSlotInfo"
  },
  [18] = {
    "relic_random",
    "SeasonMazeRelicRandomInfo"
  },
  [19] = {
    "new_hands",
    "SeasonMazeNewHandInfo"
  },
  [20] = {
    "room_ids",
    "map<int,list<int>>"
  },
  [21] = {
    "round_num",
    "map<int,int>"
  },
  [40] = {
    "suit_info",
    "SeasonRelicSuitInfo"
  },
  [41] = {
    "attr_list",
    "map<int,int>"
  },
  [51] = {
    "m_formation_list",
    "map<int,SeasonMazeFormationItem>"
  },
  [52] = {
    "m_bag_info",
    "SeasonMazeBagInfo"
  },
  [53] = {
    "m_init_select",
    "bool"
  },
  [54] = {
    "m_auto_bead_db",
    "SeasonMazeAutoBeadDB"
  },
  [55] = {
    "m_recruit_info",
    "SeasonMazeRecruitInfo"
  },
  [56] = {
    "m_world_boss_info",
    "SeasonMazeWorldBossInfo"
  },
  [57] = {
    "m_recruit_room_info",
    "SeasonMazeRecruitRoomInfo"
  },
  [58] = {
    "manunl_ban_pets",
    "list<int>"
  }
}
_class("SeasonMazeComponentInfo", ICampaignComponentInfo)
SeasonMazeComponentInfo = SeasonMazeComponentInfo

function SeasonMazeComponentInfo:Constructor()
  self.enter_time = 0
  self.hard = 0
  self.rooms = {}
  self.wait_hands = {}
  self.fold_hands = {}
  self.rand_hands = {}
  self.boss_info = {}
  self.cur_hand = SeasonMazeHandInfo:New()
  self.past_hand = {}
  self.cur_point = 0
  self.do_layer_num = 0
  self.hard_num = {}
  self.tmp_point = {}
  self.occupy_ore = {}
  self.cur_state = 0
  self.save_info = SeasonMazeSaveInfo:New()
  self.slot_info = SeasonMazeSlotInfo:New()
  self.relic_random = SeasonMazeRelicRandomInfo:New()
  self.new_hands = SeasonMazeNewHandInfo:New()
  self.round_num = {}
  self.suit_info = SeasonRelicSuitInfo:New()
  self.attr_list = {}
  self.m_formation_list = {}
  self.m_init_select = false
  self.m_auto_bead_map = {}
  self.m_auto_bead_fit_list = {}
  self.m_new_auto_bead_cnt = 0
  self.m_bag_info = SeasonMazeBagInfo:New()
  self.m_world_boss_info = SeasonMazeWorldBossInfo:New()
  self.m_recruit_room_pet_list = {}
  self.m_recruit_room_reflush_cnt = 0
  self.manunl_ban_pets = {}
end

SeasonMazeComponentInfo._proto = {
  [1] = {"enter_time", "time"},
  [2] = {"hard", "int"},
  [3] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [4] = {"wait_hands", "list<int>"},
  [5] = {"fold_hands", "list<int>"},
  [6] = {"rand_hands", "list<int>"},
  [7] = {
    "boss_info",
    "map<int,SeasonMazeBossInfo>"
  },
  [8] = {
    "cur_hand",
    "SeasonMazeHandInfo"
  },
  [9] = {
    "past_hand",
    "list<SeasonMazeHandInfo>"
  },
  [10] = {"cur_point", "int"},
  [11] = {
    "do_layer_num",
    "int"
  },
  [12] = {
    "hard_num",
    "map<int,SeasonMazeHardInfo>"
  },
  [13] = {"tmp_point", "list<int>"},
  [14] = {
    "occupy_ore",
    "map<int,SeasonMazeRoomBaseOre>"
  },
  [15] = {"cur_state", "int"},
  [16] = {
    "save_info",
    "SeasonMazeSaveInfo"
  },
  [17] = {
    "slot_info",
    "SeasonMazeSlotInfo"
  },
  [18] = {
    "relic_random",
    "SeasonMazeRelicRandomInfo"
  },
  [19] = {
    "new_hands",
    "SeasonMazeNewHandInfo"
  },
  [21] = {
    "round_num",
    "map<int,int>"
  },
  [40] = {
    "suit_info",
    "SeasonRelicSuitInfo"
  },
  [41] = {
    "attr_list",
    "map<int,int>"
  },
  [51] = {
    "m_formation_list",
    "map<int,SeasonMazeFormationItem>"
  },
  [52] = {
    "m_init_select",
    "bool"
  },
  [53] = {
    "m_auto_bead_map",
    "map<int,SeasonMazeAutoBeadClient>"
  },
  [54] = {
    "m_auto_bead_fit_list",
    "list<int>"
  },
  [55] = {
    "m_new_auto_bead_cnt",
    "int"
  },
  [56] = {
    "m_bag_info",
    "SeasonMazeBagInfo"
  },
  [57] = {
    "m_world_boss_info",
    "SeasonMazeWorldBossInfo"
  },
  [58] = {
    "m_recruit_room_pet_list",
    "list<int>"
  },
  [59] = {
    "m_recruit_room_reflush_cnt",
    "int"
  },
  [60] = {
    "manunl_ban_pets",
    "list<int>"
  }
}
_class("SeasonMazeManunlBanPetReq", ICampaignComRequest)
SeasonMazeManunlBanPetReq = SeasonMazeManunlBanPetReq

function SeasonMazeManunlBanPetReq:Constructor()
  self.ban_list = {}
end

SeasonMazeManunlBanPetReq._proto = {
  [1] = {"ban_list", "list<int>"}
}
_class("SeasonMazeManunlBanPetResult", ICampaignComResponse)
SeasonMazeManunlBanPetResult = SeasonMazeManunlBanPetResult

function SeasonMazeManunlBanPetResult:Constructor()
end

SeasonMazeManunlBanPetResult._proto = {}
_class("SeasonMazeRoomTransferReq", ICampaignComRequest)
SeasonMazeRoomTransferReq = SeasonMazeRoomTransferReq

function SeasonMazeRoomTransferReq:Constructor()
  self.point_id = 0
end

SeasonMazeRoomTransferReq._proto = {
  [1] = {"point_id", "int"}
}
_class("SeasonMazeRoomTransferResult", ICampaignComResponse)
SeasonMazeRoomTransferResult = SeasonMazeRoomTransferResult

function SeasonMazeRoomTransferResult:Constructor()
  self.rooms = {}
  self.cur_point = 0
end

SeasonMazeRoomTransferResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [2] = {"cur_point", "int"}
}
_class("SeasonMazeRecruitRoomSelectPropReq", ICampaignComRequest)
SeasonMazeRecruitRoomSelectPropReq = SeasonMazeRecruitRoomSelectPropReq

function SeasonMazeRecruitRoomSelectPropReq:Constructor()
  self.prop = 0
end

SeasonMazeRecruitRoomSelectPropReq._proto = {
  [1] = {"prop", "int"}
}
_class("SeasonMazeRecruitRoomSelectPropResult", ICampaignComResponse)
SeasonMazeRecruitRoomSelectPropResult = SeasonMazeRecruitRoomSelectPropResult

function SeasonMazeRecruitRoomSelectPropResult:Constructor()
  self.cur_pets = {}
end

SeasonMazeRecruitRoomSelectPropResult._proto = {
  [1] = {"cur_pets", "list<int>"}
}
_class("SeasonMazeRecruitRoomReflushReq", ICampaignComRequest)
SeasonMazeRecruitRoomReflushReq = SeasonMazeRecruitRoomReflushReq

function SeasonMazeRecruitRoomReflushReq:Constructor()
end

SeasonMazeRecruitRoomReflushReq._proto = {}
_class("SeasonMazeRecruitRoomReflushReply", ICampaignComResponse)
SeasonMazeRecruitRoomReflushReply = SeasonMazeRecruitRoomReflushReply

function SeasonMazeRecruitRoomReflushReply:Constructor()
  self.pet_list = {}
end

SeasonMazeRecruitRoomReflushReply._proto = {
  [1] = {"pet_list", "list<int>"}
}
_class("SeasonMazeRecruitRoomSelectReq", ICampaignComRequest)
SeasonMazeRecruitRoomSelectReq = SeasonMazeRecruitRoomSelectReq

function SeasonMazeRecruitRoomSelectReq:Constructor()
  self.pet_id = 0
end

SeasonMazeRecruitRoomSelectReq._proto = {
  [1] = {"pet_id", "int"}
}
_class("SeasonMazeRecruitRoomSelectReply", ICampaignComResponse)
SeasonMazeRecruitRoomSelectReply = SeasonMazeRecruitRoomSelectReply

function SeasonMazeRecruitRoomSelectReply:Constructor()
  self.rooms = {}
end

SeasonMazeRecruitRoomSelectReply._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  }
}
_class("SeasonMazeSelectHardReq", ICampaignComRequest)
SeasonMazeSelectHardReq = SeasonMazeSelectHardReq

function SeasonMazeSelectHardReq:Constructor()
  self.hard = 0
  self.pet_list = {}
end

SeasonMazeSelectHardReq._proto = {
  [1] = {"hard", "int"},
  [2] = {"pet_list", "list<int>"}
}
_class("SeasonMazeSelectHardResult", ICampaignComResponse)
SeasonMazeSelectHardResult = SeasonMazeSelectHardResult

function SeasonMazeSelectHardResult:Constructor()
  self.info = SeasonMazeComponentInfo:New()
end

SeasonMazeSelectHardResult._proto = {
  [1] = {
    "info",
    "SeasonMazeComponentInfo"
  }
}
_class("SeasonMazeRandomHandReq", ICampaignComRequest)
SeasonMazeRandomHandReq = SeasonMazeRandomHandReq

function SeasonMazeRandomHandReq:Constructor()
end

SeasonMazeRandomHandReq._proto = {}
_class("SeasonMazeRandomHandResult", ICampaignComResponse)
SeasonMazeRandomHandResult = SeasonMazeRandomHandResult

function SeasonMazeRandomHandResult:Constructor()
  self.wait_hands = {}
  self.fold_hands = {}
  self.rand_hands = {}
end

SeasonMazeRandomHandResult._proto = {
  [1] = {"wait_hands", "list<int>"},
  [2] = {"fold_hands", "list<int>"},
  [3] = {"rand_hands", "list<int>"}
}
_class("SeasonMazeChooseHandReq", ICampaignComRequest)
SeasonMazeChooseHandReq = SeasonMazeChooseHandReq

function SeasonMazeChooseHandReq:Constructor()
  self.id = 0
end

SeasonMazeChooseHandReq._proto = {
  [1] = {"id", "int"}
}
_class("SeasonMazeChooseHandResult", ICampaignComResponse)
SeasonMazeChooseHandResult = SeasonMazeChooseHandResult

function SeasonMazeChooseHandResult:Constructor()
  self.cur_hand = SeasonMazeHandInfo:New()
  self.wait_hands = {}
  self.fold_hands = {}
  self.rand_hands = {}
end

SeasonMazeChooseHandResult._proto = {
  [1] = {
    "cur_hand",
    "SeasonMazeHandInfo"
  },
  [2] = {"wait_hands", "list<int>"},
  [3] = {"fold_hands", "list<int>"},
  [4] = {"rand_hands", "list<int>"}
}
_class("SeasonMazeClearingReq", ICampaignComRequest)
SeasonMazeClearingReq = SeasonMazeClearingReq

function SeasonMazeClearingReq:Constructor()
  self.is_initiative = false
end

SeasonMazeClearingReq._proto = {
  [1] = {
    "is_initiative",
    "bool"
  }
}
_class("SeasonMazeClearingResult", ICampaignComResponse)
SeasonMazeClearingResult = SeasonMazeClearingResult

function SeasonMazeClearingResult:Constructor()
  self.info = SeasonMazeComponentInfo:New()
  self.old_info = SeasonMazeComponentInfo:New()
end

SeasonMazeClearingResult._proto = {
  [1] = {
    "info",
    "SeasonMazeComponentInfo"
  },
  [2] = {
    "old_info",
    "SeasonMazeComponentInfo"
  }
}
_class("SeasonMazeGoPointReq", ICampaignComRequest)
SeasonMazeGoPointReq = SeasonMazeGoPointReq

function SeasonMazeGoPointReq:Constructor()
  self.id = 0
  self.is_tmp = false
end

SeasonMazeGoPointReq._proto = {
  [1] = {"id", "int"},
  [2] = {"is_tmp", "bool"}
}
_class("SeasonMazeGoPointResult", ICampaignComResponse)
SeasonMazeGoPointResult = SeasonMazeGoPointResult

function SeasonMazeGoPointResult:Constructor()
  self.cur_hand = SeasonMazeHandInfo:New()
  self.rooms = {}
  self.past_hand = {}
  self.tmp_point = {}
  self.cur_point = 0
end

SeasonMazeGoPointResult._proto = {
  [1] = {
    "cur_hand",
    "SeasonMazeHandInfo"
  },
  [2] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [3] = {
    "past_hand",
    "list<SeasonMazeHandInfo>"
  },
  [4] = {"tmp_point", "list<int>"},
  [5] = {"cur_point", "int"}
}
_class("SeasonMazeRoomEndReq", ICampaignComRequest)
SeasonMazeRoomEndReq = SeasonMazeRoomEndReq

function SeasonMazeRoomEndReq:Constructor()
end

SeasonMazeRoomEndReq._proto = {}
_class("SeasonMazeRoomEndResult", ICampaignComResponse)
SeasonMazeRoomEndResult = SeasonMazeRoomEndResult

function SeasonMazeRoomEndResult:Constructor()
  self.rooms = {}
  self.info = SeasonMazeComponentInfo:New()
  self.cur_state = 0
end

SeasonMazeRoomEndResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [2] = {
    "info",
    "SeasonMazeComponentInfo"
  },
  [3] = {"cur_state", "int"}
}
_class("SeasonMazeBattleReq", ICampaignComRequest)
SeasonMazeBattleReq = SeasonMazeBattleReq

function SeasonMazeBattleReq:Constructor()
end

SeasonMazeBattleReq._proto = {}
_class("SeasonMazeBattleResult", ICampaignComResponse)
SeasonMazeBattleResult = SeasonMazeBattleResult

function SeasonMazeBattleResult:Constructor()
  self.rooms = {}
  self.reward = {}
end

SeasonMazeBattleResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [2] = {
    "reward",
    "list<SeasonMazeEffect>"
  }
}
_class("SeasonMazeEventReq", ICampaignComRequest)
SeasonMazeEventReq = SeasonMazeEventReq

function SeasonMazeEventReq:Constructor()
  self.cfg_id = 0
end

SeasonMazeEventReq._proto = {
  [1] = {"cfg_id", "int"}
}
_class("SeasonMazeEventResult", ICampaignComResponse)
SeasonMazeEventResult = SeasonMazeEventResult

function SeasonMazeEventResult:Constructor()
  self.rooms = {}
  self.reward = {}
  self.hands = {}
  self.extract = false
end

SeasonMazeEventResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [2] = {
    "reward",
    "list<SeasonMazeEffect>"
  },
  [3] = {
    "hands",
    "list<SeasonMazeHandInfo>"
  },
  [4] = {"extract", "bool"}
}
_class("SeasonMazeResourceReq", ICampaignComRequest)
SeasonMazeResourceReq = SeasonMazeResourceReq

function SeasonMazeResourceReq:Constructor()
end

SeasonMazeResourceReq._proto = {}
_class("SeasonMazeResourceResult", ICampaignComResponse)
SeasonMazeResourceResult = SeasonMazeResourceResult

function SeasonMazeResourceResult:Constructor()
  self.rooms = {}
  self.reward = {}
end

SeasonMazeResourceResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [2] = {
    "reward",
    "list<SeasonMazeEffect>"
  }
}
_class("SeasonMazeOreReq", ICampaignComRequest)
SeasonMazeOreReq = SeasonMazeOreReq

function SeasonMazeOreReq:Constructor()
  self.cfg_id = 0
  self.rd_index = 0
  self.is_do = false
end

SeasonMazeOreReq._proto = {
  [1] = {"cfg_id", "int"},
  [2] = {"rd_index", "int"},
  [3] = {"is_do", "bool"}
}
_class("SeasonMazeOreResult", ICampaignComResponse)
SeasonMazeOreResult = SeasonMazeOreResult

function SeasonMazeOreResult:Constructor()
  self.occupy_ore = {}
  self.reward = {}
  self.rooms = {}
end

SeasonMazeOreResult._proto = {
  [1] = {
    "occupy_ore",
    "map<int,SeasonMazeRoomBaseOre>"
  },
  [2] = {
    "reward",
    "list<SeasonMazeEffect>"
  },
  [3] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  }
}
_class("SeasonMazeBoxReq", ICampaignComRequest)
SeasonMazeBoxReq = SeasonMazeBoxReq

function SeasonMazeBoxReq:Constructor()
  self.index = 0
end

SeasonMazeBoxReq._proto = {
  [1] = {"index", "int"}
}
_class("SeasonMazeBoxResult", ICampaignComResponse)
SeasonMazeBoxResult = SeasonMazeBoxResult

function SeasonMazeBoxResult:Constructor()
  self.rooms = {}
  self.reward = {}
end

SeasonMazeBoxResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [2] = {
    "reward",
    "list<SeasonMazeEffect>"
  }
}
_class("SeasonMazeRoundReq", ICampaignComRequest)
SeasonMazeRoundReq = SeasonMazeRoundReq

function SeasonMazeRoundReq:Constructor()
end

SeasonMazeRoundReq._proto = {}
_class("SeasonMazeRoundResult", ICampaignComResponse)
SeasonMazeRoundResult = SeasonMazeRoundResult

function SeasonMazeRoundResult:Constructor()
  self.rooms = {}
  self.reward = {}
end

SeasonMazeRoundResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [2] = {
    "reward",
    "list<SeasonMazeEffect>"
  }
}
_class("SeasonMazeAltarReq", ICampaignComRequest)
SeasonMazeAltarReq = SeasonMazeAltarReq

function SeasonMazeAltarReq:Constructor()
  self.cfg_id = 0
  self.is_delet = false
  self.index = 0
end

SeasonMazeAltarReq._proto = {
  [1] = {"cfg_id", "int"},
  [2] = {"is_delet", "bool"},
  [3] = {"index", "int"}
}
_class("SeasonMazeAltarResult", ICampaignComResponse)
SeasonMazeAltarResult = SeasonMazeAltarResult

function SeasonMazeAltarResult:Constructor()
  self.cfg_id = 0
  self.rooms = {}
end

SeasonMazeAltarResult._proto = {
  [1] = {"cfg_id", "int"},
  [2] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  }
}
_class("SeasonMazeChooseRelicReq", ICampaignComRequest)
SeasonMazeChooseRelicReq = SeasonMazeChooseRelicReq

function SeasonMazeChooseRelicReq:Constructor()
  self.index = 0
  self.operate = 0
end

SeasonMazeChooseRelicReq._proto = {
  [1] = {"index", "int"},
  [2] = {"operate", "int"}
}
_class("SeasonMazeChooseRelicResult", ICampaignComResponse)
SeasonMazeChooseRelicResult = SeasonMazeChooseRelicResult

function SeasonMazeChooseRelicResult:Constructor()
  self.cur_state = 0
  self.relic_random = SeasonMazeRelicRandomInfo:New()
  self.reward = {}
end

SeasonMazeChooseRelicResult._proto = {
  [1] = {"cur_state", "int"},
  [2] = {
    "relic_random",
    "SeasonMazeRelicRandomInfo"
  },
  [3] = {
    "reward",
    "list<SeasonMazeEffect>"
  }
}
_class("SeasonMazeUseOnceReq", ICampaignComRequest)
SeasonMazeUseOnceReq = SeasonMazeUseOnceReq

function SeasonMazeUseOnceReq:Constructor()
  self.cfg_id = 0
  self.param = 0
end

SeasonMazeUseOnceReq._proto = {
  [1] = {"cfg_id", "int"},
  [2] = {"param", "int"}
}
_class("SeasonMazeUseOnceResult", ICampaignComResponse)
SeasonMazeUseOnceResult = SeasonMazeUseOnceResult

function SeasonMazeUseOnceResult:Constructor()
  self.rooms = {}
  self.reward = {}
  self.fold_hands = {}
  self.rand_hands = {}
  self.wait_hands = {}
  self.cur_point = 0
end

SeasonMazeUseOnceResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  },
  [2] = {
    "reward",
    "list<SeasonMazeEffect>"
  },
  [3] = {"fold_hands", "list<int>"},
  [4] = {"rand_hands", "list<int>"},
  [5] = {"wait_hands", "list<int>"},
  [6] = {"cur_point", "int"}
}
_class("SeasonMazeSaveLvReq", ICampaignComRequest)
SeasonMazeSaveLvReq = SeasonMazeSaveLvReq

function SeasonMazeSaveLvReq:Constructor()
  self.num = 0
end

SeasonMazeSaveLvReq._proto = {
  [1] = {"num", "int"}
}
_class("SeasonMazeSaveLvResult", ICampaignComResponse)
SeasonMazeSaveLvResult = SeasonMazeSaveLvResult

function SeasonMazeSaveLvResult:Constructor()
  self.save_info = SeasonMazeSaveInfo:New()
  self.reward = {}
end

SeasonMazeSaveLvResult._proto = {
  [1] = {
    "save_info",
    "SeasonMazeSaveInfo"
  },
  [2] = {
    "reward",
    "list<SeasonMazeEffect>"
  }
}
_class("SeasonMazeGetSlotReq", ICampaignComRequest)
SeasonMazeGetSlotReq = SeasonMazeGetSlotReq

function SeasonMazeGetSlotReq:Constructor()
end

SeasonMazeGetSlotReq._proto = {}
_class("SeasonMazeGetSlotResult", ICampaignComResponse)
SeasonMazeGetSlotResult = SeasonMazeGetSlotResult

function SeasonMazeGetSlotResult:Constructor()
  self.slot_info = SeasonMazeSlotInfo:New()
end

SeasonMazeGetSlotResult._proto = {
  [1] = {
    "slot_info",
    "SeasonMazeSlotInfo"
  }
}
_class("SeasonMazeOperaSlotReq", ICampaignComRequest)
SeasonMazeOperaSlotReq = SeasonMazeOperaSlotReq

function SeasonMazeOperaSlotReq:Constructor()
  self.index = 0
  self.is_re = false
end

SeasonMazeOperaSlotReq._proto = {
  [1] = {"index", "int"},
  [2] = {"is_re", "bool"}
}
_class("SeasonMazeOperaSlotResult", ICampaignComResponse)
SeasonMazeOperaSlotResult = SeasonMazeOperaSlotResult

function SeasonMazeOperaSlotResult:Constructor()
  self.slot_info = SeasonMazeSlotInfo:New()
  self.info = {}
  self.reward = {}
end

SeasonMazeOperaSlotResult._proto = {
  [1] = {
    "slot_info",
    "SeasonMazeSlotInfo"
  },
  [2] = {
    "info",
    "map<int,SeasonMazeSlotIndex>"
  },
  [3] = {
    "reward",
    "list<SeasonMazeEffect>"
  }
}
_class("SeasonMazeNewHandReq", ICampaignComRequest)
SeasonMazeNewHandReq = SeasonMazeNewHandReq

function SeasonMazeNewHandReq:Constructor()
  self.index = {}
end

SeasonMazeNewHandReq._proto = {
  [1] = {
    "index",
    "map<int,int>"
  }
}
_class("SeasonMazeNewHandResult", ICampaignComResponse)
SeasonMazeNewHandResult = SeasonMazeNewHandResult

function SeasonMazeNewHandResult:Constructor()
  self.cur_state = 0
  self.new_hands = SeasonMazeNewHandInfo:New()
  self.hands = {}
end

SeasonMazeNewHandResult._proto = {
  [1] = {"cur_state", "int"},
  [2] = {
    "new_hands",
    "SeasonMazeNewHandInfo"
  },
  [3] = {"hands", "list<int>"}
}
_class("SeasonMazeGetMarketReq", ICampaignComRequest)
SeasonMazeGetMarketReq = SeasonMazeGetMarketReq

function SeasonMazeGetMarketReq:Constructor()
end

SeasonMazeGetMarketReq._proto = {}
_class("SeasonMazeGetMarketResult", ICampaignComResponse)
SeasonMazeGetMarketResult = SeasonMazeGetMarketResult

function SeasonMazeGetMarketResult:Constructor()
  self.rooms = {}
end

SeasonMazeGetMarketResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  }
}
_class("SeasonMazeOperaMarketReq", ICampaignComRequest)
SeasonMazeOperaMarketReq = SeasonMazeOperaMarketReq

function SeasonMazeOperaMarketReq:Constructor()
  self.pst_id = 0
  self.unique_id = 0
end

SeasonMazeOperaMarketReq._proto = {
  [1] = {"pst_id", "int64"},
  [2] = {"unique_id", "int"}
}
_class("SeasonMazeOperaMarketResult", ICampaignComResponse)
SeasonMazeOperaMarketResult = SeasonMazeOperaMarketResult

function SeasonMazeOperaMarketResult:Constructor()
  self.rooms = {}
end

SeasonMazeOperaMarketResult._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  }
}
_class("SeasonMazeRoundEndReq", ICampaignComRequest)
SeasonMazeRoundEndReq = SeasonMazeRoundEndReq

function SeasonMazeRoundEndReq:Constructor()
end

SeasonMazeRoundEndReq._proto = {}
_class("SeasonMazeRoundEndResult", ICampaignComResponse)
SeasonMazeRoundEndResult = SeasonMazeRoundEndResult

function SeasonMazeRoundEndResult:Constructor()
end

SeasonMazeRoundEndResult._proto = {}
_class("SeasonMazeWhiteTestBattleReq", ICampaignComRequest)
SeasonMazeWhiteTestBattleReq = SeasonMazeWhiteTestBattleReq

function SeasonMazeWhiteTestBattleReq:Constructor()
end

SeasonMazeWhiteTestBattleReq._proto = {}
_class("SeasonMazeWhiteTestBattleResult", ICampaignComResponse)
SeasonMazeWhiteTestBattleResult = SeasonMazeWhiteTestBattleResult

function SeasonMazeWhiteTestBattleResult:Constructor()
end

SeasonMazeWhiteTestBattleResult._proto = {}
_class("SeasonMazeChangeFormationReq", ICampaignComRequest)
SeasonMazeChangeFormationReq = SeasonMazeChangeFormationReq

function SeasonMazeChangeFormationReq:Constructor()
  self.formation_index = 0
  self.info = SeasonMazeFormationItem:New()
end

SeasonMazeChangeFormationReq._proto = {
  [1] = {
    "formation_index",
    "int"
  },
  [2] = {
    "info",
    "SeasonMazeFormationItem"
  }
}
_class("SeasonMazeChangeFormationReply", ICampaignComResponse)
SeasonMazeChangeFormationReply = SeasonMazeChangeFormationReply

function SeasonMazeChangeFormationReply:Constructor()
end

SeasonMazeChangeFormationReply._proto = {}
_class("SeasonMazeInitSelectReq", ICampaignComRequest)
SeasonMazeInitSelectReq = SeasonMazeInitSelectReq

function SeasonMazeInitSelectReq:Constructor()
  self.pet_list = {}
end

SeasonMazeInitSelectReq._proto = {
  [1] = {"pet_list", "list<int>"}
}
_class("SeasonMazeInitSelectReply", ICampaignComResponse)
SeasonMazeInitSelectReply = SeasonMazeInitSelectReply

function SeasonMazeInitSelectReply:Constructor()
  self.pet_list = {}
  self.formation_list = {}
end

SeasonMazeInitSelectReply._proto = {
  [1] = {
    "pet_list",
    "map<int,SeasonMazePetInfo>"
  },
  [2] = {
    "formation_list",
    "map<int,SeasonMazeFormationItem>"
  }
}
_class("SeasonMazeFitAutoBeadReq", ICampaignComRequest)
SeasonMazeFitAutoBeadReq = SeasonMazeFitAutoBeadReq

function SeasonMazeFitAutoBeadReq:Constructor()
  self.fit_beads = {}
end

SeasonMazeFitAutoBeadReq._proto = {
  [1] = {"fit_beads", "list<int>"}
}
_class("SeasonMazeFitAutoBeadReply", ICampaignComResponse)
SeasonMazeFitAutoBeadReply = SeasonMazeFitAutoBeadReply

function SeasonMazeFitAutoBeadReply:Constructor()
  self.m_auto_bead_map = {}
  self.m_auto_bead_fit_list = {}
end

SeasonMazeFitAutoBeadReply._proto = {
  [1] = {
    "m_auto_bead_map",
    "map<int,SeasonMazeAutoBeadClient>"
  },
  [2] = {
    "m_auto_bead_fit_list",
    "list<int>"
  }
}
_class("SeasonMazeAutoBeadComposeReq", ICampaignComRequest)
SeasonMazeAutoBeadComposeReq = SeasonMazeAutoBeadComposeReq

function SeasonMazeAutoBeadComposeReq:Constructor()
  self.compose_list = {}
end

SeasonMazeAutoBeadComposeReq._proto = {
  [1] = {
    "compose_list",
    "list<list<int>>"
  }
}
_class("SeasonMazeAutoBeadComposeReply", ICampaignComResponse)
SeasonMazeAutoBeadComposeReply = SeasonMazeAutoBeadComposeReply

function SeasonMazeAutoBeadComposeReply:Constructor()
  self.m_auto_bead_map = {}
  self.m_auto_bead_fit_list = {}
  self.m_new_bead = {}
end

SeasonMazeAutoBeadComposeReply._proto = {
  [1] = {
    "m_auto_bead_map",
    "map<int,SeasonMazeAutoBeadClient>"
  },
  [2] = {
    "m_auto_bead_fit_list",
    "list<int>"
  },
  [3] = {"m_new_bead", "list<int>"}
}
_class("SeasonMazeHealthyReq", ICampaignComRequest)
SeasonMazeHealthyReq = SeasonMazeHealthyReq

function SeasonMazeHealthyReq:Constructor()
end

SeasonMazeHealthyReq._proto = {}
_class("SeasonMazeHealthyReply", ICampaignComResponse)
SeasonMazeHealthyReply = SeasonMazeHealthyReply

function SeasonMazeHealthyReply:Constructor()
  self.pet_list = {}
end

SeasonMazeHealthyReply._proto = {
  [1] = {
    "pet_list",
    "map<int,SeasonMazePetInfo>"
  }
}
_class("SeasonMazeResurrectPetReq", ICampaignComRequest)
SeasonMazeResurrectPetReq = SeasonMazeResurrectPetReq

function SeasonMazeResurrectPetReq:Constructor()
  self.pet_id = 0
end

SeasonMazeResurrectPetReq._proto = {
  [1] = {"pet_id", "int"}
}
_class("SeasonMazeResurrectPetReply", ICampaignComResponse)
SeasonMazeResurrectPetReply = SeasonMazeResurrectPetReply

function SeasonMazeResurrectPetReply:Constructor()
end

SeasonMazeResurrectPetReply._proto = {}
_class("SeasonMazePetRecruitListReq", ICampaignComRequest)
SeasonMazePetRecruitListReq = SeasonMazePetRecruitListReq

function SeasonMazePetRecruitListReq:Constructor()
end

SeasonMazePetRecruitListReq._proto = {}
_class("SeasonMazePetRecruitListReply", ICampaignComResponse)
SeasonMazePetRecruitListReply = SeasonMazePetRecruitListReply

function SeasonMazePetRecruitListReply:Constructor()
  self.pet_list = {}
  self.select_pet = 0
end

SeasonMazePetRecruitListReply._proto = {
  [1] = {"pet_list", "list<int>"},
  [2] = {"select_pet", "int"}
}
_class("SeasonMazePetRecruitSelectReq", ICampaignComRequest)
SeasonMazePetRecruitSelectReq = SeasonMazePetRecruitSelectReq

function SeasonMazePetRecruitSelectReq:Constructor()
  self.pet_id = 0
end

SeasonMazePetRecruitSelectReq._proto = {
  [1] = {"pet_id", "int"}
}
_class("SeasonMazePetRecruitSelectReply", ICampaignComResponse)
SeasonMazePetRecruitSelectReply = SeasonMazePetRecruitSelectReply

function SeasonMazePetRecruitSelectReply:Constructor()
end

SeasonMazePetRecruitSelectReply._proto = {}
_class("SeasonMazePetRecruitResetReq", ICampaignComRequest)
SeasonMazePetRecruitResetReq = SeasonMazePetRecruitResetReq

function SeasonMazePetRecruitResetReq:Constructor()
end

SeasonMazePetRecruitResetReq._proto = {}
_class("SeasonMazePetRecruitResetReply", ICampaignComResponse)
SeasonMazePetRecruitResetReply = SeasonMazePetRecruitResetReply

function SeasonMazePetRecruitResetReply:Constructor()
  self.pet_list = {}
end

SeasonMazePetRecruitResetReply._proto = {
  [1] = {"pet_list", "list<int>"}
}
_class("SeasonMazeSelectFullBreakPetReq", ICampaignComRequest)
SeasonMazeSelectFullBreakPetReq = SeasonMazeSelectFullBreakPetReq

function SeasonMazeSelectFullBreakPetReq:Constructor()
  self.pet_id = 0
end

SeasonMazeSelectFullBreakPetReq._proto = {
  [1] = {"pet_id", "int"}
}
_class("SeasonMazeSelectFullBreakPetReply", ICampaignComResponse)
SeasonMazeSelectFullBreakPetReply = SeasonMazeSelectFullBreakPetReply

function SeasonMazeSelectFullBreakPetReply:Constructor()
end

SeasonMazeSelectFullBreakPetReply._proto = {}
_class("SeasonMazeClearAllBeadNewReq", ICampaignComRequest)
SeasonMazeClearAllBeadNewReq = SeasonMazeClearAllBeadNewReq

function SeasonMazeClearAllBeadNewReq:Constructor()
end

SeasonMazeClearAllBeadNewReq._proto = {}
_class("SeasonMazeClearAllBeadNewReply", ICampaignComResponse)
SeasonMazeClearAllBeadNewReply = SeasonMazeClearAllBeadNewReply

function SeasonMazeClearAllBeadNewReply:Constructor()
end

SeasonMazeClearAllBeadNewReply._proto = {}
local SeasonMazeComponentNotifyType = {
  SeasonMazeComponentNotifyType_Effects = 1,
  SeasonMazeComponentNotifyType_CurState = 2,
  SeasonMazeComponentNotifyType_OnceItem = 3,
  SeasonMazeComponentNotifyType_Boss = 4,
  SeasonMazeComponentNotifyType_Room = 5,
  SeasonMazeComponentNotifyType_RandomRelic = 6,
  SeasonMazeComponentNotifyType_NewHand = 7,
  SeasonMazeComponentNotifyType_HandBag = 8,
  SeasonMazeComponentNotifyType_Extract = 9,
  SeasonMazeComponentNotifyType_Ore = 10,
  SeasonMazeComponentNotifyType_AutoBeadChange = 50,
  SeasonMazeComponentNotifyType_AutoBeadSlotUnLock = 51,
  SeasonMazeComponentNotifyType_AttrChange = 52,
  SeasonMazeComponentNotifyType_PetChange = 53,
  SeasonMazeComponentNotifyType_SuitInfo = 54,
  SeasonMazeComponentNotifyType_Relic = 55,
  SeasonMazeComonentNotifyFormationChange = 56,
  SeasonMazeComonentNotifyWorldBossTotalDamage = 57
}
_enum("SeasonMazeComponentNotifyType", SeasonMazeComponentNotifyType)
_class("SeasonMazeNotifyWorldBossDamaage", Object)
SeasonMazeNotifyWorldBossDamaage = SeasonMazeNotifyWorldBossDamaage

function SeasonMazeNotifyWorldBossDamaage:Constructor()
  self.total_damage = 0
end

SeasonMazeNotifyWorldBossDamaage._proto = {
  [1] = {
    "total_damage",
    "int64"
  }
}
_class("SeasonMazeNotifyOre", Object)
SeasonMazeNotifyOre = SeasonMazeNotifyOre

function SeasonMazeNotifyOre:Constructor()
  self.occupy_ore = {}
end

SeasonMazeNotifyOre._proto = {
  [1] = {
    "occupy_ore",
    "map<int,SeasonMazeRoomBaseOre>"
  }
}
_class("SeasonMazeNotifyEffects", Object)
SeasonMazeNotifyEffects = SeasonMazeNotifyEffects

function SeasonMazeNotifyEffects:Constructor()
  self.rewards = {}
end

SeasonMazeNotifyEffects._proto = {
  [1] = {
    "rewards",
    "list<SeasonMazeEffect>"
  }
}
_class("SeasonMazeNotifyCurState", Object)
SeasonMazeNotifyCurState = SeasonMazeNotifyCurState

function SeasonMazeNotifyCurState:Constructor()
  self.cur_state = 0
end

SeasonMazeNotifyCurState._proto = {
  [1] = {"cur_state", "int"}
}
_class("SeasonMazeNotifyOnceItem", Object)
SeasonMazeNotifyOnceItem = SeasonMazeNotifyOnceItem

function SeasonMazeNotifyOnceItem:Constructor()
  self.list = {}
end

SeasonMazeNotifyOnceItem._proto = {
  [1] = {
    "list",
    "map<int,int>"
  }
}
_class("SeasonMazeNotifyBoss", Object)
SeasonMazeNotifyBoss = SeasonMazeNotifyBoss

function SeasonMazeNotifyBoss:Constructor()
  self.boss_info = {}
end

SeasonMazeNotifyBoss._proto = {
  [1] = {
    "boss_info",
    "map<int,SeasonMazeBossInfo>"
  }
}
_class("SeasonMazeNotifyRoom", Object)
SeasonMazeNotifyRoom = SeasonMazeNotifyRoom

function SeasonMazeNotifyRoom:Constructor()
  self.rooms = {}
end

SeasonMazeNotifyRoom._proto = {
  [1] = {
    "rooms",
    "map<int,SeasonMazeRoomBase>"
  }
}
_class("SeasonMazeNotifyRandomRelic", Object)
SeasonMazeNotifyRandomRelic = SeasonMazeNotifyRandomRelic

function SeasonMazeNotifyRandomRelic:Constructor()
  self.relic_random = SeasonMazeRelicRandomInfo:New()
end

SeasonMazeNotifyRandomRelic._proto = {
  [1] = {
    "relic_random",
    "SeasonMazeRelicRandomInfo"
  }
}
_class("SeasonMazeNotifyNewHand", Object)
SeasonMazeNotifyNewHand = SeasonMazeNotifyNewHand

function SeasonMazeNotifyNewHand:Constructor()
  self.new_hands = SeasonMazeNewHandInfo:New()
  self.reward = {}
end

SeasonMazeNotifyNewHand._proto = {
  [1] = {
    "new_hands",
    "SeasonMazeNewHandInfo"
  },
  [2] = {
    "reward",
    "map<int,list<SeasonMazeEffect>>"
  }
}
_class("SeasonMazeNotifyHandBag", Object)
SeasonMazeNotifyHandBag = SeasonMazeNotifyHandBag

function SeasonMazeNotifyHandBag:Constructor()
  self.wait_hands = {}
  self.fold_hands = {}
  self.rand_hands = {}
end

SeasonMazeNotifyHandBag._proto = {
  [1] = {"wait_hands", "list<int>"},
  [2] = {"fold_hands", "list<int>"},
  [3] = {"rand_hands", "list<int>"}
}
_class("SeasonMazeNotifyExtract", Object)
SeasonMazeNotifyExtract = SeasonMazeNotifyExtract

function SeasonMazeNotifyExtract:Constructor()
  self.hands = {}
end

SeasonMazeNotifyExtract._proto = {
  [1] = {
    "hands",
    "list<SeasonMazeHandInfo>"
  }
}
_class("SeasonMazeNotifyAutoBeadChange", Object)
SeasonMazeNotifyAutoBeadChange = SeasonMazeNotifyAutoBeadChange

function SeasonMazeNotifyAutoBeadChange:Constructor()
  self.new_cnt = 0
  self.bead_map = {}
end

SeasonMazeNotifyAutoBeadChange._proto = {
  [1] = {"new_cnt", "int"},
  [2] = {
    "bead_map",
    "map<int,SeasonMazeAutoBeadClient>"
  }
}
_class("SeasonMazeNotifyAutoBeadSlotUnlock", Object)
SeasonMazeNotifyAutoBeadSlotUnlock = SeasonMazeNotifyAutoBeadSlotUnlock

function SeasonMazeNotifyAutoBeadSlotUnlock:Constructor()
  self.auto_bead_fit = {}
end

SeasonMazeNotifyAutoBeadSlotUnlock._proto = {
  [1] = {
    "auto_bead_fit",
    "list<int>"
  }
}
_class("SeasonMazeNotifyAttrChange", Object)
SeasonMazeNotifyAttrChange = SeasonMazeNotifyAttrChange

function SeasonMazeNotifyAttrChange:Constructor()
  self.attr_change = {}
  self.attr_reason = {}
end

SeasonMazeNotifyAttrChange._proto = {
  [1] = {
    "attr_change",
    "map<int,int>"
  },
  [2] = {
    "attr_reason",
    "map<int,int>"
  }
}
_class("SeasonMazeNotifyPetChange", Object)
SeasonMazeNotifyPetChange = SeasonMazeNotifyPetChange

function SeasonMazeNotifyPetChange:Constructor()
  self.pet_list = {}
end

SeasonMazeNotifyPetChange._proto = {
  [1] = {
    "pet_list",
    "map<int,SeasonMazePetInfo>"
  }
}
_class("SeasonMazeNotifySuitInfoChange", Object)
SeasonMazeNotifySuitInfoChange = SeasonMazeNotifySuitInfoChange

function SeasonMazeNotifySuitInfoChange:Constructor()
  self.info = SeasonRelicSuitInfo:New()
end

SeasonMazeNotifySuitInfoChange._proto = {
  [1] = {
    "info",
    "SeasonRelicSuitInfo"
  }
}
_class("SeasonMazeNotifyRelicChange", Object)
SeasonMazeNotifyRelicChange = SeasonMazeNotifyRelicChange

function SeasonMazeNotifyRelicChange:Constructor()
  self.relic_list = {}
end

SeasonMazeNotifyRelicChange._proto = {
  [1] = {
    "relic_list",
    "map<int,SeasonMazeRelicInfo>"
  }
}
_class("SeasonMazeNotifyFormationChange", Object)
SeasonMazeNotifyFormationChange = SeasonMazeNotifyFormationChange

function SeasonMazeNotifyFormationChange:Constructor()
  self.m_formation_list = {}
end

SeasonMazeNotifyFormationChange._proto = {
  [1] = {
    "m_formation_list",
    "map<int,SeasonMazeFormationItem>"
  }
}
_class("PerfectPuzzleComponentDataInfo", ICampaignComponentDataInfo)
PerfectPuzzleComponentDataInfo = PerfectPuzzleComponentDataInfo

function PerfectPuzzleComponentDataInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_unlock_missions = {}
end

PerfectPuzzleComponentDataInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_unlock_missions",
    "list<int>"
  }
}
_class("PerfectPuzzleComponentInfo", ICampaignComponentInfo)
PerfectPuzzleComponentInfo = PerfectPuzzleComponentInfo

function PerfectPuzzleComponentInfo:Constructor()
  self.m_pass_mission_info = {}
  self.m_unlock_missions = {}
end

PerfectPuzzleComponentInfo._proto = {
  [1] = {
    "m_pass_mission_info",
    "map<int,cam_mission_info>"
  },
  [2] = {
    "m_unlock_missions",
    "list<int>"
  }
}
_class("UnlockPerfectPuzzleReq", ICampaignComRequest)
UnlockPerfectPuzzleReq = UnlockPerfectPuzzleReq

function UnlockPerfectPuzzleReq:Constructor()
  self.mission_id = 0
end

function UnlockPerfectPuzzleReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleUnlockPerfectPuzzle
end

UnlockPerfectPuzzleReq._proto = {
  [1] = {"mission_id", "int"}
}
_class("UnlockPerfectPuzzleRep", ICampaignComResponse)
UnlockPerfectPuzzleRep = UnlockPerfectPuzzleRep

function UnlockPerfectPuzzleRep:Constructor()
  self.ret = 0
  self.m_unlock_missions = {}
end

UnlockPerfectPuzzleRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "m_unlock_missions",
    "list<int>"
  }
}
_class("CompletePerfectPuzzleReq", ICampaignComRequest)
CompletePerfectPuzzleReq = CompletePerfectPuzzleReq

function CompletePerfectPuzzleReq:Constructor()
  self.mission_id = 0
  self.score = 0
end

function CompletePerfectPuzzleReq:GetHandleCode()
  return ECampaignComHandle.ECCH_HandleCompletePerfectPuzzle
end

CompletePerfectPuzzleReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"score", "int"}
}
_class("CompletePerfectPuzzleRep", ICampaignComResponse)
CompletePerfectPuzzleRep = CompletePerfectPuzzleRep

function CompletePerfectPuzzleRep:Constructor()
  self.ret = 0
  self.info = cam_mission_info:New()
end

CompletePerfectPuzzleRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "cam_mission_info"
  }
}
local EAlchemyShopItemType = {
  EAlchemyShopItemType_BuyFormula = 1,
  EAlchemyShopItemType_TipBuff = 2,
  EAlchemyShopItemType_ExtraItem = 3
}
_enum("EAlchemyShopItemType", EAlchemyShopItemType)
_class("AlchemyComponentExtraRecord", Object)
AlchemyComponentExtraRecord = AlchemyComponentExtraRecord

function AlchemyComponentExtraRecord:Constructor()
  self.make_cnt = 0
  self.extra_cnt = 0
end

AlchemyComponentExtraRecord._proto = {
  [1] = {"make_cnt", "int"},
  [2] = {"extra_cnt", "int"}
}
_class("AlchemyComponentDataInfo", ICampaignComponentDataInfo)
AlchemyComponentDataInfo = AlchemyComponentDataInfo

function AlchemyComponentDataInfo:Constructor()
  self.cur_tip_buff_id = 0
  self.cur_extra_buff_id = 0
  self.makeup_cnt = {}
end

AlchemyComponentDataInfo._proto = {
  [1] = {
    "cur_tip_buff_id",
    "int"
  },
  [2] = {
    "cur_extra_buff_id",
    "int"
  },
  [3] = {
    "makeup_cnt",
    "map<int,AlchemyComponentExtraRecord>"
  }
}
_class("AlchemyComponentInfo", ICampaignComponentInfo)
AlchemyComponentInfo = AlchemyComponentInfo

function AlchemyComponentInfo:Constructor()
  self.show_tip_buff_id = 0
  self.show_extra_buff_id = 0
  self.tip_buff_finish = false
  self.extra_buff_finsih = false
end

AlchemyComponentInfo._proto = {
  [1] = {
    "show_tip_buff_id",
    "int"
  },
  [2] = {
    "show_extra_buff_id",
    "int"
  },
  [3] = {
    "tip_buff_finish",
    "bool"
  },
  [4] = {
    "extra_buff_finsih",
    "bool"
  }
}
_class("AlchemyComponentMakeupReq", ICampaignComRequest)
AlchemyComponentMakeupReq = AlchemyComponentMakeupReq

function AlchemyComponentMakeupReq:Constructor()
  self.item_id = 0
  self.num = 0
end

AlchemyComponentMakeupReq._proto = {
  [1] = {"item_id", "int"},
  [2] = {"num", "int"}
}
_class("AlchemyComponentMakeupRes", ICampaignComResponse)
AlchemyComponentMakeupRes = AlchemyComponentMakeupRes

function AlchemyComponentMakeupRes:Constructor()
  self.item_id = 0
  self.num = 0
  self.extra_cnt = 0
end

AlchemyComponentMakeupRes._proto = {
  [1] = {"item_id", "int"},
  [2] = {"num", "int"},
  [3] = {"extra_cnt", "int"}
}
_class("AlchemyComponentSellReq", ICampaignComRequest)
AlchemyComponentSellReq = AlchemyComponentSellReq

function AlchemyComponentSellReq:Constructor()
  self.items = {}
end

AlchemyComponentSellReq._proto = {
  [1] = {
    "items",
    "map<int,int>"
  }
}
_class("AlchemyComponentSellRes", ICampaignComResponse)
AlchemyComponentSellRes = AlchemyComponentSellRes

function AlchemyComponentSellRes:Constructor()
  self.item_earn = 0
  self.tip_earn = 0
  self.star_item = 0
end

AlchemyComponentSellRes._proto = {
  [1] = {"item_earn", "int"},
  [2] = {"tip_earn", "int"},
  [3] = {"star_item", "int"}
}
_class("AlchemyComponentBuyReq", ICampaignComRequest)
AlchemyComponentBuyReq = AlchemyComponentBuyReq

function AlchemyComponentBuyReq:Constructor()
  self.type = 0
  self.buy_id = 0
end

AlchemyComponentBuyReq._proto = {
  [1] = {"type", "int"},
  [2] = {"buy_id", "int"}
}
_class("AlchemyComponentBuyRes", ICampaignComResponse)
AlchemyComponentBuyRes = AlchemyComponentBuyRes

function AlchemyComponentBuyRes:Constructor()
  self.new_id = 0
  self.bfinish = false
end

AlchemyComponentBuyRes._proto = {
  [1] = {"new_id", "int"},
  [2] = {"bfinish", "bool"}
}
