require("message_def")
local rankMessageDef = {
  CLSID_CEventRankDatum = 30000,
  CLSID_CEventRankDatumLevel = 30001,
  CLSID_CEventRankDatumActive = 30002,
  CLSID_CEventRankDatumConsume = 30003,
  CLSID_CEventRankDatumTest = 30004,
  CLSID_CEventRankRequestEvent = 30005,
  CLSID_CEventRankReplyEvent = 30006,
  CLSID_CEventRankRoleRequestPage = 30007,
  CLSID_CEventRankRoleReplyPage = 30008,
  CLSID_CEventRankRoleRequestTotal = 30009,
  CLSID_CEventRankRoleReplyTotal = 30010,
  CLSID_CEventRankRoleRequestUpdate = 30011,
  CLSID_CEventRankRoleReplyUpdate = 30012,
  CLSID_CEventRankRoleRequestDelete = 30013,
  CLSID_CEventRankRoleReplyDelete = 30014
}
table.append(MessageDef, rankMessageDef)
local RankRoleProcRet = {
  RP_SUCCESS = 0,
  RP_NOT_IN_USE = 1,
  RP_ARGS_ERR = 2,
  RP_CANT_IN_RANK = 3,
  RP_NOT_ENOUGH = 4,
  RP_NOT_IN_RANK = 5,
  RP_PROC_FAIL = 6,
  RP_UP_SAME = 7,
  RP_TYPE_ERR = 8
}
_enum("RankRoleProcRet", RankRoleProcRet)
_class("CEventRankRequestEvent", CCallRequestEvent)
CEventRankRequestEvent = CEventRankRequestEvent

function CEventRankRequestEvent:Constructor()
  self.m_rank_type = RANK_TYPE.RANK_TYPE_INVALID
end

CEventRankRequestEvent._proto = {
  [1] = {
    "m_rank_type",
    "int"
  }
}
_class("CEventRankReplyEvent", CCallReplyEvent)
CEventRankReplyEvent = CEventRankReplyEvent

function CEventRankReplyEvent:Constructor()
  self.m_ret = RANK_SER_RET_NO.TR_RANK_TYPE_ERR
end

CEventRankReplyEvent._proto = {
  [1] = {"m_ret", "int"}
}
_class("CEventRankRoleRequestPage", CEventRankRequestEvent)
CEventRankRoleRequestPage = CEventRankRoleRequestPage

function CEventRankRoleRequestPage:Constructor()
  self.m_index = 0
  self.m_count = 0
end

CEventRankRoleRequestPage._proto = {
  [1] = {"m_index", "int"},
  [2] = {"m_count", "int"}
}
_class("CEventRankRoleReplyPage", CEventRankReplyEvent)
CEventRankRoleReplyPage = CEventRankRoleReplyPage

function CEventRankRoleReplyPage:Constructor()
  self.m_index = 0
  self.m_count = 0
  self.m_rank_data = {}
end

CEventRankRoleReplyPage._proto = {
  [1] = {"m_index", "int"},
  [2] = {"m_count", "int"},
  [3] = {
    "m_rank_data",
    "list<buffer>"
  }
}
_class("CEventRankRoleRequestTotal", CEventRankRequestEvent)
CEventRankRoleRequestTotal = CEventRankRoleRequestTotal

function CEventRankRoleRequestTotal:Constructor()
end

CEventRankRoleRequestTotal._proto = {}
_class("CEventRankRoleReplyTotal", CEventRankReplyEvent)
CEventRankRoleReplyTotal = CEventRankRoleReplyTotal

function CEventRankRoleReplyTotal:Constructor()
  self.m_rank_data = {}
end

CEventRankRoleReplyTotal._proto = {
  [1] = {
    "m_rank_data",
    "list<buffer>"
  }
}
_class("CEventRankRoleRequestUpdate", CEventRankRequestEvent)
CEventRankRoleRequestUpdate = CEventRankRoleRequestUpdate

function CEventRankRoleRequestUpdate:Constructor()
  self.m_pstid = 0
  self.m_value = 0
end

CEventRankRoleRequestUpdate._proto = {
  [1] = {"m_pstid", "int64"},
  [2] = {"m_value", "int64"}
}
_class("CEventRankRoleReplyUpdate", CEventRankReplyEvent)
CEventRankRoleReplyUpdate = CEventRankRoleReplyUpdate

function CEventRankRoleReplyUpdate:Constructor()
  self.m_pstid = 0
  self.m_value = 0
end

CEventRankRoleReplyUpdate._proto = {
  [1] = {"m_pstid", "int64"},
  [2] = {"m_value", "int64"}
}
_class("CEventRankRoleRequestDelete", CEventRankRequestEvent)
CEventRankRoleRequestDelete = CEventRankRoleRequestDelete

function CEventRankRoleRequestDelete:Constructor()
  self.m_pstid = 0
end

CEventRankRoleRequestDelete._proto = {
  [1] = {"m_pstid", "int64"}
}
_class("CEventRankRoleReplyDelete", CEventRankReplyEvent)
CEventRankRoleReplyDelete = CEventRankRoleReplyDelete

function CEventRankRoleReplyDelete:Constructor()
  self.m_pstid = 0
end

CEventRankRoleReplyDelete._proto = {
  [1] = {"m_pstid", "int64"}
}
