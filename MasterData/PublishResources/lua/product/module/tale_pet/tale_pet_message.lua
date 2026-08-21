require("message_def")
local tale_petMessageDef = {
  CLSID_CEventNotifyTalePetChange = 31000,
  CLSID_CEventTaleFirstReq = 31001,
  CLSID_CEventTaleFirstResult = 31002,
  CLSID_CEventTaleChooseReq = 31003,
  CLSID_CEventTaleChooseResult = 31004,
  CLSID_CEventTaleTaskRewardReq = 31005,
  CLSID_CEventTaleTaskRewardResult = 31006,
  CLSID_CEventTalePetCallReq = 31007,
  CLSID_CEventTalePetCallResult = 31008,
  CLSID_CEventTalePetReq = 31009,
  CLSID_CEventTalePetResult = 31010,
  CLSID_CEventReqCurrentBuffInfo = 31011,
  CLSID_CEventReplyCurrentBuffInfo = 31012,
  CLSID_CEventReqPassedTaleMission = 31013,
  CLSID_CEventReplyPassedTaleMission = 31014,
  CLSID_CEventReqRewardStatus = 31015,
  CLSID_CEventReplyRewardStatus = 31016,
  CLSID_CEventReqAcceptStageReward = 31017,
  CLSID_CEventReplyAcceptStageReward = 31018,
  CLSID_CEventReqTaleletFormation = 31019,
  CLSID_CEventReplyTaleletFormation = 31020,
  CLSID_CEventRequestChangeTalepetFormation = 31021,
  CLSID_CEventReplyChangeTalepetFormation = 31022,
  CLSID_CEventPushNewBuffInfo = 31023,
  CLSID_CEventCaseFinishTaskReq = 31024,
  CLSID_CEventCaseFinishTaskResult = 31025
}
table.append(MessageDef, tale_petMessageDef)
_class("CEventNotifyTalePetChange", CSvrPushEvent)
CEventNotifyTalePetChange = CEventNotifyTalePetChange

function CEventNotifyTalePetChange:Constructor()
  self.datas = {}
end

CEventNotifyTalePetChange._proto = {
  [1] = {
    "datas",
    "map<int,tale_pet_msg>"
  }
}
_class("CEventTaleFirstReq", CCallRequestEvent)
CEventTaleFirstReq = CEventTaleFirstReq

function CEventTaleFirstReq:Constructor()
  self.types = 0
  self.cfg_id = 0
end

CEventTaleFirstReq._proto = {
  [1] = {"types", "int"},
  [2] = {"cfg_id", "int"}
}
_class("CEventTaleFirstResult", CCallReplyEvent)
CEventTaleFirstResult = CEventTaleFirstResult

function CEventTaleFirstResult:Constructor()
  self.ret = 0
end

CEventTaleFirstResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventTaleChooseReq", CCallRequestEvent)
CEventTaleChooseReq = CEventTaleChooseReq

function CEventTaleChooseReq:Constructor()
  self.cfg_id = 0
end

CEventTaleChooseReq._proto = {
  [1] = {"cfg_id", "int"}
}
_class("CEventTaleChooseResult", CCallReplyEvent)
CEventTaleChooseResult = CEventTaleChooseResult

function CEventTaleChooseResult:Constructor()
  self.ret = 0
end

CEventTaleChooseResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventTaleTaskRewardReq", CCallRequestEvent)
CEventTaleTaskRewardReq = CEventTaleTaskRewardReq

function CEventTaleTaskRewardReq:Constructor()
  self.cfg_id = 0
end

CEventTaleTaskRewardReq._proto = {
  [1] = {"cfg_id", "int"}
}
_class("CEventTaleTaskRewardResult", CCallReplyEvent)
CEventTaleTaskRewardResult = CEventTaleTaskRewardResult

function CEventTaleTaskRewardResult:Constructor()
  self.ret = 0
end

CEventTaleTaskRewardResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventTalePetCallReq", CCallRequestEvent)
CEventTalePetCallReq = CEventTalePetCallReq

function CEventTalePetCallReq:Constructor()
  self.cfg_id = 0
end

CEventTalePetCallReq._proto = {
  [1] = {"cfg_id", "int"}
}
_class("CEventTalePetCallResult", CCallReplyEvent)
CEventTalePetCallResult = CEventTalePetCallResult

function CEventTalePetCallResult:Constructor()
  self.ret = 0
end

CEventTalePetCallResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventTalePetReq", CCallRequestEvent)
CEventTalePetReq = CEventTalePetReq

function CEventTalePetReq:Constructor()
end

CEventTalePetReq._proto = {}
_class("CEventTalePetResult", CCallReplyEvent)
CEventTalePetResult = CEventTalePetResult

function CEventTalePetResult:Constructor()
  self.ret = 0
  self.first_enter = false
  self.first_buff = false
  self.datas = {}
  self.start_time = 0
  self.end_time = 0
  self.select_cfg_id = 0
end

CEventTalePetResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "first_enter",
    "bool"
  },
  [3] = {"first_buff", "bool"},
  [4] = {
    "datas",
    "list<tale_pet_msg>"
  },
  [5] = {"start_time", "int64"},
  [6] = {"end_time", "int64"},
  [7] = {
    "select_cfg_id",
    "int"
  }
}
_class("CEventReqCurrentBuffInfo", CCallRequestEvent)
CEventReqCurrentBuffInfo = CEventReqCurrentBuffInfo

function CEventReqCurrentBuffInfo:Constructor()
end

CEventReqCurrentBuffInfo._proto = {}
_class("CEventReplyCurrentBuffInfo", CCallReplyEvent)
CEventReplyCurrentBuffInfo = CEventReplyCurrentBuffInfo

function CEventReplyCurrentBuffInfo:Constructor()
  self.ret = 0
  self.TalePetBuff = {}
  self.NormalPetBuff = {}
  self.experience_value = 0
  self.trail_buff_level_id = 0
end

CEventReplyCurrentBuffInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "TalePetBuff",
    "list<int>"
  },
  [3] = {
    "NormalPetBuff",
    "list<int>"
  },
  [4] = {
    "experience_value",
    "int"
  },
  [5] = {
    "trail_buff_level_id",
    "int"
  }
}
_class("CEventReqPassedTaleMission", CCallRequestEvent)
CEventReqPassedTaleMission = CEventReqPassedTaleMission

function CEventReqPassedTaleMission:Constructor()
end

CEventReqPassedTaleMission._proto = {}
_class("CEventReplyPassedTaleMission", CCallReplyEvent)
CEventReplyPassedTaleMission = CEventReplyPassedTaleMission

function CEventReplyPassedTaleMission:Constructor()
  self.ret = 0
  self.tale_mission_list = {}
end

CEventReplyPassedTaleMission._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "tale_mission_list",
    "map<int,int>"
  }
}
_class("CEventReqRewardStatus", CCallRequestEvent)
CEventReqRewardStatus = CEventReqRewardStatus

function CEventReqRewardStatus:Constructor()
end

CEventReqRewardStatus._proto = {}
_class("CEventReplyRewardStatus", CCallReplyEvent)
CEventReplyRewardStatus = CEventReplyRewardStatus

function CEventReplyRewardStatus:Constructor()
  self.ret = 0
  self.accepted_stage_ids = {}
end

CEventReplyRewardStatus._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "accepted_stage_ids",
    "list<int>"
  }
}
_class("CEventReqAcceptStageReward", CCallRequestEvent)
CEventReqAcceptStageReward = CEventReqAcceptStageReward

function CEventReqAcceptStageReward:Constructor()
  self.stage_id = 0
end

CEventReqAcceptStageReward._proto = {
  [1] = {"stage_id", "int"}
}
_class("CEventReplyAcceptStageReward", CCallReplyEvent)
CEventReplyAcceptStageReward = CEventReplyAcceptStageReward

function CEventReplyAcceptStageReward:Constructor()
  self.ret = 0
end

CEventReplyAcceptStageReward._proto = {
  [1] = {"ret", "int"}
}
_class("CEventReqTaleletFormation", CCallRequestEvent)
CEventReqTaleletFormation = CEventReqTaleletFormation

function CEventReqTaleletFormation:Constructor()
end

CEventReqTaleletFormation._proto = {}
_class("CEventReplyTaleletFormation", CCallReplyEvent)
CEventReplyTaleletFormation = CEventReplyTaleletFormation

function CEventReplyTaleletFormation:Constructor()
  self.ret = 0
  self.formation_info = TalePetFormationInfo:New()
end

CEventReplyTaleletFormation._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "formation_info",
    "TalePetFormationInfo"
  }
}
_class("CEventRequestChangeTalepetFormation", CCallRequestEvent)
CEventRequestChangeTalepetFormation = CEventRequestChangeTalepetFormation

function CEventRequestChangeTalepetFormation:Constructor()
  self.m_formation_id = 0
  self.m_formation_name = ""
  self.m_formation_pet_list = {}
end

CEventRequestChangeTalepetFormation._proto = {
  [1] = {
    "m_formation_id",
    "int"
  },
  [2] = {
    "m_formation_name",
    "string"
  },
  [3] = {
    "m_formation_pet_list",
    "list<int64>"
  }
}
_class("CEventReplyChangeTalepetFormation", CCallReplyEvent)
CEventReplyChangeTalepetFormation = CEventReplyChangeTalepetFormation

function CEventReplyChangeTalepetFormation:Constructor()
  self.ret = 0
  self.formation_info = TalePetFormationInfo:New()
end

CEventReplyChangeTalepetFormation._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "formation_info",
    "TalePetFormationInfo"
  }
}
_class("CEventPushNewBuffInfo", CSvrPushEvent)
CEventPushNewBuffInfo = CEventPushNewBuffInfo

function CEventPushNewBuffInfo:Constructor()
  self.trail_buff_level_id = 0
  self.experience_value = 0
end

CEventPushNewBuffInfo._proto = {
  [1] = {
    "trail_buff_level_id",
    "int"
  },
  [2] = {
    "experience_value",
    "int"
  }
}
_class("CEventCaseFinishTaskReq", CCallRequestEvent)
CEventCaseFinishTaskReq = CEventCaseFinishTaskReq

function CEventCaseFinishTaskReq:Constructor()
  self.cfg_id = 0
end

CEventCaseFinishTaskReq._proto = {
  [1] = {"cfg_id", "int"}
}
_class("CEventCaseFinishTaskResult", CCallReplyEvent)
CEventCaseFinishTaskResult = CEventCaseFinishTaskResult

function CEventCaseFinishTaskResult:Constructor()
  self.ret = 0
end

CEventCaseFinishTaskResult._proto = {
  [1] = {"ret", "int"}
}
