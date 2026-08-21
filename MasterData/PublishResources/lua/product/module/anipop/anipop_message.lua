require("message_def")
local anipopMessageDef = {
  CLSID_CEventRequestAnipopInfo = 44000,
  CLSID_CEventReplyAnipopInfo = 44001,
  CLSID_CEventNotifyAnipopInfo = 44002,
  CLSID_CEventNotifyAnipopRoundInfo = 44003,
  CLSID_AnipopSelectHardReq = 44004,
  CLSID_AnipopSelectHardRep = 44005,
  CLSID_CEventApplyChangeAnipopFormationReq = 44006,
  CLSID_CEventApplyChangeAnipopFormationRes = 44007,
  CLSID_CEventRequestAnipopSelectRelic = 44008,
  CLSID_CEventReplyAnipopSelectRelic = 44009,
  CLSID_CEventRequestAnipopBalance = 44010,
  CLSID_CEventReplyAnipopBalance = 44011,
  CLSID_AnipopRewardReq = 44012,
  CLSID_AnipopRewardRep = 44013,
  CLSID_AnipopConvertRelicReq = 44014,
  CLSID_AnipopConvertRelicRep = 44015,
  CLSID_AnipopUseRelicReq = 44016,
  CLSID_AnipopUseRelicRep = 44017,
  CLSID_AnipopChangeSkillReq = 44018,
  CLSID_AnipopChangeSkillRep = 44019
}
table.append(MessageDef, anipopMessageDef)
local AnipopOpResCode = {
  ANIPOP_SUCCESS = 0,
  ANIPOP_FAIL = 1,
  ANIPOP_UNLOCK = 2,
  ANIPOP_HARD_NOTFOUND = 3,
  ANIPOP_BALANCED = 4,
  ANIPOP_REWARD_NOTFOUND = 5,
  ANIPOP_REWARD_GEDED = 6,
  ANIPOP_SCORE_LEAK = 7,
  ANIPOP_GROUP_ERROR = 8,
  ANIPOP_SKILL_ERROR = 9,
  ANIPOP_RELIC_COUNTER_ERROR = 10,
  ANIPOP_RELIC_TRIGGER_ERROR = 11,
  ANIPOP_RELIC_CONVERT_ERROR = 12
}
_enum("AnipopOpResCode", AnipopOpResCode)
_class("CEventRequestAnipopInfo", CCallRequestEvent)
CEventRequestAnipopInfo = CEventRequestAnipopInfo

function CEventRequestAnipopInfo:Constructor()
end

CEventRequestAnipopInfo._proto = {}
_class("CEventReplyAnipopInfo", CCallReplyEvent)
CEventReplyAnipopInfo = CEventReplyAnipopInfo

function CEventReplyAnipopInfo:Constructor()
  self.m_ret = 0
end

CEventReplyAnipopInfo._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventNotifyAnipopInfo", CSvrPushEvent)
CEventNotifyAnipopInfo = CEventNotifyAnipopInfo

function CEventNotifyAnipopInfo:Constructor()
  self.data = anipop_info:New()
  self.end_time = 0
end

CEventNotifyAnipopInfo._proto = {
  [1] = {
    "data",
    "anipop_info"
  },
  [2] = {"end_time", "time"}
}
_class("CEventNotifyAnipopRoundInfo", CSvrPushEvent)
CEventNotifyAnipopRoundInfo = CEventNotifyAnipopRoundInfo

function CEventNotifyAnipopRoundInfo:Constructor()
  self.data = AnipopRoundInfo:New()
  self.relic_info = RelicInfo:New()
end

CEventNotifyAnipopRoundInfo._proto = {
  [1] = {
    "data",
    "AnipopRoundInfo"
  },
  [2] = {"relic_info", "RelicInfo"}
}
_class("AnipopSelectHardReq", CCallRequestEvent)
AnipopSelectHardReq = AnipopSelectHardReq

function AnipopSelectHardReq:Constructor()
  self.hard_id = 0
end

AnipopSelectHardReq._proto = {
  [1] = {"hard_id", "int"}
}
_class("AnipopSelectHardRep", CCallReplyEvent)
AnipopSelectHardRep = AnipopSelectHardRep

function AnipopSelectHardRep:Constructor()
  self.ret = 0
  self.round_info = AnipopRoundInfo:New()
end

AnipopSelectHardRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "round_info",
    "AnipopRoundInfo"
  }
}
_class("CEventApplyChangeAnipopFormationReq", CCallRequestEvent)
CEventApplyChangeAnipopFormationReq = CEventApplyChangeAnipopFormationReq

function CEventApplyChangeAnipopFormationReq:Constructor()
  self.m_formation_id = 0
  self.m_formation_name = ""
  self.m_formation_pet_list = {}
end

CEventApplyChangeAnipopFormationReq._proto = {
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
_class("CEventApplyChangeAnipopFormationRes", CCallReplyEvent)
CEventApplyChangeAnipopFormationRes = CEventApplyChangeAnipopFormationRes

function CEventApplyChangeAnipopFormationRes:Constructor()
  self.m_result = 0
  self.m_formation_info = AnipopFormationInfo:New()
end

CEventApplyChangeAnipopFormationRes._proto = {
  [1] = {"m_result", "int"},
  [2] = {
    "m_formation_info",
    "AnipopFormationInfo"
  }
}
_class("CEventRequestAnipopSelectRelic", CCallRequestEvent)
CEventRequestAnipopSelectRelic = CEventRequestAnipopSelectRelic

function CEventRequestAnipopSelectRelic:Constructor()
  self.relic_id = 0
end

CEventRequestAnipopSelectRelic._proto = {
  [1] = {"relic_id", "int"}
}
_class("CEventReplyAnipopSelectRelic", CCallReplyEvent)
CEventReplyAnipopSelectRelic = CEventReplyAnipopSelectRelic

function CEventReplyAnipopSelectRelic:Constructor()
  self.m_ret = 0
  self.relic_info = RelicInfo:New()
  self.relics = {}
end

CEventReplyAnipopSelectRelic._proto = {
  [1] = {"m_ret", "int"},
  [2] = {"relic_info", "RelicInfo"},
  [3] = {
    "relics",
    "list<RoleAsset>"
  }
}
_class("CEventRequestAnipopBalance", CCallRequestEvent)
CEventRequestAnipopBalance = CEventRequestAnipopBalance

function CEventRequestAnipopBalance:Constructor()
end

CEventRequestAnipopBalance._proto = {}
_class("CEventReplyAnipopBalance", CCallReplyEvent)
CEventReplyAnipopBalance = CEventReplyAnipopBalance

function CEventReplyAnipopBalance:Constructor()
  self.ret = 0
  self.round_info = AnipopRoundInfo:New()
end

CEventReplyAnipopBalance._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "round_info",
    "AnipopRoundInfo"
  }
}
_class("AnipopRewardReq", CCallRequestEvent)
AnipopRewardReq = AnipopRewardReq

function AnipopRewardReq:Constructor()
  self.req_id = 0
end

AnipopRewardReq._proto = {
  [1] = {"req_id", "int"}
}
_class("AnipopRewardRep", CCallReplyEvent)
AnipopRewardRep = AnipopRewardRep

function AnipopRewardRep:Constructor()
  self.ret = 0
  self.week_info = AnipopWeekInfo:New()
  self.rewards = {}
end

AnipopRewardRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "week_info",
    "AnipopWeekInfo"
  },
  [3] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("AnipopConvertRelicReq", CCallRequestEvent)
AnipopConvertRelicReq = AnipopConvertRelicReq

function AnipopConvertRelicReq:Constructor()
end

AnipopConvertRelicReq._proto = {}
_class("AnipopConvertRelicRep", CCallReplyEvent)
AnipopConvertRelicRep = AnipopConvertRelicRep

function AnipopConvertRelicRep:Constructor()
  self.ret = 0
  self.relics = {}
  self.relic_info = RelicInfo:New()
end

AnipopConvertRelicRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "relics",
    "list<RoleAsset>"
  },
  [3] = {"relic_info", "RelicInfo"}
}
_class("AnipopUseRelicReq", CCallRequestEvent)
AnipopUseRelicReq = AnipopUseRelicReq

function AnipopUseRelicReq:Constructor()
  self.relic_id = 0
end

AnipopUseRelicReq._proto = {
  [1] = {"relic_id", "int"}
}
_class("AnipopUseRelicRep", CCallReplyEvent)
AnipopUseRelicRep = AnipopUseRelicRep

function AnipopUseRelicRep:Constructor()
  self.ret = 0
  self.relics = {}
  self.relic_info = RelicInfo:New()
end

AnipopUseRelicRep._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "relics",
    "list<RoleAsset>"
  },
  [3] = {"relic_info", "RelicInfo"}
}
_class("AnipopChangeSkillReq", CCallRequestEvent)
AnipopChangeSkillReq = AnipopChangeSkillReq

function AnipopChangeSkillReq:Constructor()
  self.skill_relic_id = 0
end

AnipopChangeSkillReq._proto = {
  [1] = {
    "skill_relic_id",
    "int"
  }
}
_class("AnipopChangeSkillRep", CCallReplyEvent)
AnipopChangeSkillRep = AnipopChangeSkillRep

function AnipopChangeSkillRep:Constructor()
  self.ret = 0
  self.relic_info = RelicInfo:New()
end

AnipopChangeSkillRep._proto = {
  [1] = {"ret", "int"},
  [2] = {"relic_info", "RelicInfo"}
}
