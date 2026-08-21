require("message_def")
local sign_inMessageDef = {
  CLSID_CEventSignInReq = 34000,
  CLSID_CEventSignInRes = 34001,
  CLSID_CEventRecvTotalLoginRewardReq = 34002,
  CLSID_CEventRecvTotalLoginRewardRes = 34003,
  CLSID_CEventCurMonthSignDataReq = 34004,
  CLSID_CEventCurMonthSignDataRes = 34005,
  CLSID_CEventTotalLoginReq = 34006,
  CLSID_CEventTotalLoginRes = 34007,
  CLSID_CEventNewPlayerLoginStatusReq = 34008,
  CLSID_CEventNewPlayerLoginStatusReply = 34009,
  CLSID_CEventAcceptNewPlayerRewardReq = 34010,
  CLSID_CEventAcceptNewPlayerRewardReply = 34011,
  CLSID_CEventPredictionReq = 34012,
  CLSID_CEventPredictionResult = 34013,
  CLSID_CEventPredictionAwardReq = 34014,
  CLSID_CEventPredictionAwardResult = 34015,
  CLSID_CEventNotifyPrediction = 34016,
  CLSID_CEventNotifyPredictionData = 34017,
  CLSID_CEventGetMainDressUpReq = 34018,
  CLSID_CEventGetMainDressUpResult = 34019,
  CLSID_CEventSetMainDressUpReq = 34020,
  CLSID_CEventSetMainDressUpResult = 34021,
  CLSID_CEventCurMainDressUpReq = 34022,
  CLSID_CEventCurMainDressUpResult = 34023
}
table.append(MessageDef, sign_inMessageDef)
local SIGN_IN_RESULT_CODE = {
  SIGN_IN_SUCCEED = 0,
  SIGN_IN_INVALID = 1,
  SIGN_IN_MON_SIGN_DATA_INVALID = 2,
  SIGN_IN_TODAY_IS_SIGN = 3,
  SIGN_IN_FULL = 4,
  SIGN_IN_NOT_SIGN_CANT_RE_SIGN = 5,
  SIGN_IN_RE_SIGN_VIG_POINT = 6,
  SIGN_IN_TOTAL_LOGIN_DAYS_INVALID = 7,
  SIGN_IN_TOTAL_LOGIN_IS_RECVED = 8,
  SIGN_IN_TOTAL_LOGIN_NOT_ENOUGH = 9,
  SIGN_IN_IS_RE_SIGNED = 10,
  SIGN_DAY_NUM_ERROR = 11,
  SIGN_DAY_NUM_ACCEPTED = 12,
  SIGN_DAY_NUM_NOT_ENOUGH = 13
}
_enum("SIGN_IN_RESULT_CODE", SIGN_IN_RESULT_CODE)
_class("CEventSignInReq", CCallRequestEvent)
CEventSignInReq = CEventSignInReq

function CEventSignInReq:Constructor()
  self.bIsReSignIn = false
end

CEventSignInReq._proto = {
  [1] = {
    "bIsReSignIn",
    "bool"
  }
}
_class("CEventSignInRes", CCallReplyEvent)
CEventSignInRes = CEventSignInRes

function CEventSignInRes:Constructor()
  self.nRet = 0
  self.bIsReSignIn = false
  self.sign_in_base_info = SignInBaseInfo:New()
  self.act_assets = {}
end

CEventSignInRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "bIsReSignIn",
    "bool"
  },
  [3] = {
    "sign_in_base_info",
    "SignInBaseInfo"
  },
  [4] = {
    "act_assets",
    "list<RoleAsset>"
  }
}
_class("CEventRecvTotalLoginRewardReq", CCallRequestEvent)
CEventRecvTotalLoginRewardReq = CEventRecvTotalLoginRewardReq

function CEventRecvTotalLoginRewardReq:Constructor()
  self.nRecvDays = 0
end

CEventRecvTotalLoginRewardReq._proto = {
  [1] = {"nRecvDays", "int"}
}
_class("CEventRecvTotalLoginRewardRes", CCallReplyEvent)
CEventRecvTotalLoginRewardRes = CEventRecvTotalLoginRewardRes

function CEventRecvTotalLoginRewardRes:Constructor()
  self.nRet = 0
  self.nRecvDays = 0
  self.nTotalLoginDays = 0
end

CEventRecvTotalLoginRewardRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {"nRecvDays", "int"},
  [3] = {
    "nTotalLoginDays",
    "int"
  }
}
_class("CEventCurMonthSignDataReq", CCallRequestEvent)
CEventCurMonthSignDataReq = CEventCurMonthSignDataReq

function CEventCurMonthSignDataReq:Constructor()
end

CEventCurMonthSignDataReq._proto = {}
_class("CEventCurMonthSignDataRes", CCallReplyEvent)
CEventCurMonthSignDataRes = CEventCurMonthSignDataRes

function CEventCurMonthSignDataRes:Constructor()
  self.nRet = 0
  self.sign_in_base_info = SignInBaseInfo:New()
end

CEventCurMonthSignDataRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "sign_in_base_info",
    "SignInBaseInfo"
  }
}
_class("CEventTotalLoginReq", CCallRequestEvent)
CEventTotalLoginReq = CEventTotalLoginReq

function CEventTotalLoginReq:Constructor()
end

CEventTotalLoginReq._proto = {}
_class("CEventTotalLoginRes", CCallReplyEvent)
CEventTotalLoginRes = CEventTotalLoginRes

function CEventTotalLoginRes:Constructor()
  self.total_login_info = {}
  self.nTotalLoginDays = 0
  self.tmNextRefreshTime = 0
end

CEventTotalLoginRes._proto = {
  [1] = {
    "total_login_info",
    "map<int,TotalLoginInfo>"
  },
  [2] = {
    "nTotalLoginDays",
    "int"
  },
  [3] = {
    "tmNextRefreshTime",
    "time"
  }
}
_class("CEventNewPlayerLoginStatusReq", CCallRequestEvent)
CEventNewPlayerLoginStatusReq = CEventNewPlayerLoginStatusReq

function CEventNewPlayerLoginStatusReq:Constructor()
end

CEventNewPlayerLoginStatusReq._proto = {}
_class("CEventNewPlayerLoginStatusReply", CCallReplyEvent)
CEventNewPlayerLoginStatusReply = CEventNewPlayerLoginStatusReply

function CEventNewPlayerLoginStatusReply:Constructor()
  self.ret = 0
  self.accept_status = {}
  self.reward_cfg = {}
end

CEventNewPlayerLoginStatusReply._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "accept_status",
    "map<int,int>"
  },
  [3] = {
    "reward_cfg",
    "map<int,list<RoleAsset>>"
  }
}
_class("CEventAcceptNewPlayerRewardReq", CCallRequestEvent)
CEventAcceptNewPlayerRewardReq = CEventAcceptNewPlayerRewardReq

function CEventAcceptNewPlayerRewardReq:Constructor()
  self.day_num = 0
end

CEventAcceptNewPlayerRewardReq._proto = {
  [1] = {"day_num", "int"}
}
_class("CEventAcceptNewPlayerRewardReply", CCallReplyEvent)
CEventAcceptNewPlayerRewardReply = CEventAcceptNewPlayerRewardReply

function CEventAcceptNewPlayerRewardReply:Constructor()
  self.ret = 0
end

CEventAcceptNewPlayerRewardReply._proto = {
  [1] = {"ret", "int"}
}
_class("CEventPredictionReq", CCallRequestEvent)
CEventPredictionReq = CEventPredictionReq

function CEventPredictionReq:Constructor()
end

CEventPredictionReq._proto = {}
_class("CEventPredictionResult", CCallReplyEvent)
CEventPredictionResult = CEventPredictionResult

function CEventPredictionResult:Constructor()
  self.ret = 0
  self.info = PredictionMsgInfo:New()
end

CEventPredictionResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "info",
    "PredictionMsgInfo"
  }
}
_class("CEventPredictionAwardReq", CCallRequestEvent)
CEventPredictionAwardReq = CEventPredictionAwardReq

function CEventPredictionAwardReq:Constructor()
  self.day = 0
  self.id = 0
end

CEventPredictionAwardReq._proto = {
  [1] = {"day", "int"},
  [2] = {"id", "int"}
}
_class("CEventPredictionAwardResult", CCallReplyEvent)
CEventPredictionAwardResult = CEventPredictionAwardResult

function CEventPredictionAwardResult:Constructor()
  self.ret = 0
end

CEventPredictionAwardResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventNotifyPrediction", CSvrPushEvent)
CEventNotifyPrediction = CEventNotifyPrediction

function CEventNotifyPrediction:Constructor()
  self.index = 0
  self.status = 0
end

CEventNotifyPrediction._proto = {
  [1] = {"index", "int"},
  [2] = {"status", "int"}
}
_class("CEventNotifyPredictionData", CSvrPushEvent)
CEventNotifyPredictionData = CEventNotifyPredictionData

function CEventNotifyPredictionData:Constructor()
  self.info = PredictionMsgInfo:New()
end

CEventNotifyPredictionData._proto = {
  [1] = {
    "info",
    "PredictionMsgInfo"
  }
}
_class("CEventGetMainDressUpReq", CCallRequestEvent)
CEventGetMainDressUpReq = CEventGetMainDressUpReq

function CEventGetMainDressUpReq:Constructor()
end

CEventGetMainDressUpReq._proto = {}
_class("CEventGetMainDressUpResult", CCallReplyEvent)
CEventGetMainDressUpResult = CEventGetMainDressUpResult

function CEventGetMainDressUpResult:Constructor()
  self.info = MainDressUpMap:New()
end

CEventGetMainDressUpResult._proto = {
  [1] = {
    "info",
    "MainDressUpMap"
  }
}
_class("CEventSetMainDressUpReq", CCallRequestEvent)
CEventSetMainDressUpReq = CEventSetMainDressUpReq

function CEventSetMainDressUpReq:Constructor()
  self.info = {}
end

CEventSetMainDressUpReq._proto = {
  [1] = {
    "info",
    "map<int,MainDressUpInfo>"
  }
}
_class("CEventSetMainDressUpResult", CCallReplyEvent)
CEventSetMainDressUpResult = CEventSetMainDressUpResult

function CEventSetMainDressUpResult:Constructor()
  self.ret = 0
end

CEventSetMainDressUpResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventCurMainDressUpReq", CCallRequestEvent)
CEventCurMainDressUpReq = CEventCurMainDressUpReq

function CEventCurMainDressUpReq:Constructor()
  self.cur_index = 0
end

CEventCurMainDressUpReq._proto = {
  [1] = {"cur_index", "int"}
}
_class("CEventCurMainDressUpResult", CCallReplyEvent)
CEventCurMainDressUpResult = CEventCurMainDressUpResult

function CEventCurMainDressUpResult:Constructor()
  self.ret = 0
end

CEventCurMainDressUpResult._proto = {
  [1] = {"ret", "int"}
}
