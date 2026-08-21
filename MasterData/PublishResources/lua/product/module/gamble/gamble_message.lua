require("message_def")
local gambleMessageDef = {
  CLSID_CEventApplyAllPoolInfo = 6000,
  CLSID_CEventApplyAllPoolInfoResult = 6001,
  CLSID_CEventShake = 6002,
  CLSID_CEventShakeResult = 6003
}
table.append(MessageDef, gambleMessageDef)
local GAMBLE_CODE = {
  GAMBLE_SERVER_NORESPONSE = -1,
  GAMBLE_SUCCESS = 0,
  GAMBLE_POOL_UNEXIST = 1,
  GAMBLE_COST_UNENOUGH = 2,
  GAMBLE_SHAKETYPE_ERROR = 3,
  GAMBLE_COST_ERROR = 4,
  GAMBLE_PRIORITIES_ERROR = 5,
  GAMBLE_LOAD_ERROR = 6,
  GAMBLE_NOT_OPTIONAL_PET = 7,
  GAMBLE_OPTIONAL_POOL_INVALID = 8,
  GAMBLE_RANDOM_NOT_FIND_OP_ID = 101,
  GAMBLE_RANDOM_OP_VEC_NUM_ERR = 102,
  GAMBLE_RANDOM_OP_VEC_EMPTY = 103,
  GAMBLE_RANDOM_OP_VEC_ID_INVALID = 104,
  GAMBLE_RANDOM_OP_INDEX_INVALID = 105
}
_enum("GAMBLE_CODE", GAMBLE_CODE)
local ShakeType = {SHAKE_ONCE = 0, SHAKE_MULTIPLE = 1}
_enum("ShakeType", ShakeType)
local PrizePoolType = {
  BEGINNER_POOL = 0,
  PERSIST_POOL = 1,
  PROMOTION_POOL = 2,
  OPTIONAL_POOL = 3,
  NEW_REGIST_POOL = 4,
  PLAYER_BACK_POOL = 5
}
_enum("PrizePoolType", PrizePoolType)
local PrizePoolOpenCloseType = {
  PLAY_TIMES_CONDITON = 0,
  PERMANENT = 1,
  TIME_CONDITON = 2
}
_enum("PrizePoolOpenCloseType", PrizePoolOpenCloseType)
_class("CEventApplyAllPoolInfo", CCallRequestEvent)
CEventApplyAllPoolInfo = CEventApplyAllPoolInfo

function CEventApplyAllPoolInfo:Constructor()
end

CEventApplyAllPoolInfo._proto = {}
_class("CEventApplyAllPoolInfoResult", CCallReplyEvent)
CEventApplyAllPoolInfoResult = CEventApplyAllPoolInfoResult

function CEventApplyAllPoolInfoResult:Constructor()
  self.ret = 0
  self.all_prize_pool = {}
  self.state_info = {}
  self.pool_extern_info = {}
end

CEventApplyAllPoolInfoResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "all_prize_pool",
    "list<PrizePoolInfo>"
  },
  [3] = {
    "state_info",
    "list<map<int,string>>"
  },
  [4] = {
    "pool_extern_info",
    "map<int,map<int,PrizePoolExternInfo>>"
  }
}
_class("CEventShake", CCallRequestEvent)
CEventShake = CEventShake

function CEventShake:Constructor()
  self.shake_type = 0
  self.prize_pool_id = 0
  self.cost_id = 0
  self.cost_count = 0
end

CEventShake._proto = {
  [1] = {"shake_type", "int"},
  [2] = {
    "prize_pool_id",
    "int"
  },
  [3] = {"cost_id", "int"},
  [4] = {"cost_count", "int"}
}
_class("CEventShakeResult", CCallReplyEvent)
CEventShakeResult = CEventShakeResult

function CEventShakeResult:Constructor()
  self.ret = 0
  self.award_cards = {}
  self.exchange_mark = {}
end

CEventShakeResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "award_cards",
    "list<int>"
  },
  [3] = {
    "exchange_mark",
    "list<int>"
  }
}
