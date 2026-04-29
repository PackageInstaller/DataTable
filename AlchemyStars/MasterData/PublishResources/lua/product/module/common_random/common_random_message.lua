require("message_def")
local common_randomMessageDef = {
  CLSID_CEventPlayRule = 4000,
  CLSID_CEventPlayRuleResult = 4001,
  CLSID_CEventOptionalPoolReq = 4002,
  CLSID_CEventOptionalPoolRes = 4003
}
table.append(MessageDef, common_randomMessageDef)
local COMMON_RANDOM_CODE = {
  COMMON_RANDOM_EXCEED_GOTO_MAX = -1,
  COMMON_RANDOM_SUCCESS = 0,
  COMMON_RANDOM_NOT_FIND_OP_ID = 1,
  COMMON_RANDOM_OP_VEC_NUM_ERR = 2,
  COMMON_RANDOM_OP_VEC_EMPTY = 3,
  COMMON_RANDOM_OP_VEC_ID_INVALID = 4,
  COMMON_RANDOM_OP_INDEX_INVALID = 5
}
_enum("COMMON_RANDOM_CODE", COMMON_RANDOM_CODE)
_class("CEventPlayRule", CCallRequestEvent)
CEventPlayRule = CEventPlayRule

function CEventPlayRule:Constructor()
  self.rule_id = 0
  self.play_time = 0
end

CEventPlayRule._proto = {
  [1] = {"rule_id", "int"},
  [2] = {"play_time", "int"}
}
_class("CEventPlayRuleResult", CCallReplyEvent)
CEventPlayRuleResult = CEventPlayRuleResult

function CEventPlayRuleResult:Constructor()
  self.ret = 0
  self.award_ids = {}
  self.award_nums = {}
end

CEventPlayRuleResult._proto = {
  [1] = {"ret", "int"},
  [2] = {"award_ids", "list<int>"},
  [3] = {"award_nums", "list<int>"}
}
_class("CEventOptionalPoolReq", CCallRequestEvent)
CEventOptionalPoolReq = CEventOptionalPoolReq

function CEventOptionalPoolReq:Constructor()
  self.nIndex = 0
  self.nOptionalPoolId = 0
  self.nOptionalVec = {}
end

CEventOptionalPoolReq._proto = {
  [1] = {"nIndex", "int"},
  [2] = {
    "nOptionalPoolId",
    "int"
  },
  [3] = {
    "nOptionalVec",
    "list<int>"
  }
}
_class("CEventOptionalPoolRes", CCallReplyEvent)
CEventOptionalPoolRes = CEventOptionalPoolRes

function CEventOptionalPoolRes:Constructor()
  self.nRet = 0
end

CEventOptionalPoolRes._proto = {
  [1] = {"nRet", "int"}
}
