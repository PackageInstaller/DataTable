require("message_def")
local world_bossMessageDef = {
  CLSID_CEventApplyWorldBossInfoReq = 38000,
  CLSID_CEventApplyWorldBossInfoRes = 38001,
  CLSID_CEventApplyChangeWorldBossFormationReq = 38002,
  CLSID_CEventApplyChangeWorldBossFormationRes = 38003,
  CLSID_CEventResetRecordReq = 38004,
  CLSID_CEventResetRecordRes = 38005,
  CLSID_CEventGetDanInfoReq = 38006,
  CLSID_CEventGetDanInfoRes = 38007,
  CLSID_CEventChoseRecordReq = 38008,
  CLSID_CEventChoseRecordRes = 38009,
  CLSID_CEventMobilePushWorldBossRefresh = 38010,
  CLSID_CEventCreateTeamDamageReq = 38011,
  CLSID_CEventCreateTeamDamageRes = 38012,
  CLSID_CEventGetRankDamageListReq = 38013,
  CLSID_CEventGetRankDamageListRes = 38014,
  CLSID_CEventGetRankTopNReq = 38015,
  CLSID_CEventGetRankTopNRes = 38016,
  CLSID_CEventRankOneDetailReq = 38017,
  CLSID_CEventRankOneDetailRes = 38018
}
table.append(MessageDef, world_bossMessageDef)
_class("CEventApplyWorldBossInfoReq", CCallRequestEvent)
CEventApplyWorldBossInfoReq = CEventApplyWorldBossInfoReq

function CEventApplyWorldBossInfoReq:Constructor()
end

CEventApplyWorldBossInfoReq._proto = {}
_class("CEventApplyWorldBossInfoRes", CCallReplyEvent)
CEventApplyWorldBossInfoRes = CEventApplyWorldBossInfoRes

function CEventApplyWorldBossInfoRes:Constructor()
  self.nRet = 0
  self.Data = PlayerWorldBossInfo:New()
end

CEventApplyWorldBossInfoRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "Data",
    "PlayerWorldBossInfo"
  }
}
_class("CEventApplyChangeWorldBossFormationReq", CCallRequestEvent)
CEventApplyChangeWorldBossFormationReq = CEventApplyChangeWorldBossFormationReq

function CEventApplyChangeWorldBossFormationReq:Constructor()
  self.nId = 0
  self.formation_pet_list = {}
end

CEventApplyChangeWorldBossFormationReq._proto = {
  [1] = {"nId", "int"},
  [2] = {
    "formation_pet_list",
    "list<int64>"
  }
}
_class("CEventApplyChangeWorldBossFormationRes", CCallReplyEvent)
CEventApplyChangeWorldBossFormationRes = CEventApplyChangeWorldBossFormationRes

function CEventApplyChangeWorldBossFormationRes:Constructor()
  self.nFormationRet = 0
end

CEventApplyChangeWorldBossFormationRes._proto = {
  [1] = {
    "nFormationRet",
    "int"
  }
}
_class("CEventResetRecordReq", CCallRequestEvent)
CEventResetRecordReq = CEventResetRecordReq

function CEventResetRecordReq:Constructor()
  self.nId = 0
end

CEventResetRecordReq._proto = {
  [1] = {"nId", "int"}
}
_class("CEventResetRecordRes", CCallReplyEvent)
CEventResetRecordRes = CEventResetRecordRes

function CEventResetRecordRes:Constructor()
  self.nRet = 0
end

CEventResetRecordRes._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventGetDanInfoReq", CCallRequestEvent)
CEventGetDanInfoReq = CEventGetDanInfoReq

function CEventGetDanInfoReq:Constructor()
end

CEventGetDanInfoReq._proto = {}
_class("CEventGetDanInfoRes", CCallReplyEvent)
CEventGetDanInfoRes = CEventGetDanInfoRes

function CEventGetDanInfoRes:Constructor()
  self.nRet = 0
  self.dan_info = DanInfo:New()
end

CEventGetDanInfoRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {"dan_info", "DanInfo"}
}
_class("CEventChoseRecordReq", CCallRequestEvent)
CEventChoseRecordReq = CEventChoseRecordReq

function CEventChoseRecordReq:Constructor()
  self.select_new = true
  self.nId = 0
end

CEventChoseRecordReq._proto = {
  [1] = {"select_new", "bool"},
  [2] = {"nId", "int"}
}
_class("CEventChoseRecordRes", CCallReplyEvent)
CEventChoseRecordRes = CEventChoseRecordRes

function CEventChoseRecordRes:Constructor()
  self.nRet = 0
end

CEventChoseRecordRes._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventMobilePushWorldBossRefresh", CSvrPushEvent)
CEventMobilePushWorldBossRefresh = CEventMobilePushWorldBossRefresh

function CEventMobilePushWorldBossRefresh:Constructor()
end

CEventMobilePushWorldBossRefresh._proto = {}
_class("CEventCreateTeamDamageReq", CCallRequestEvent)
CEventCreateTeamDamageReq = CEventCreateTeamDamageReq

function CEventCreateTeamDamageReq:Constructor()
  self.team_damage = 0
  self.id = 0
end

CEventCreateTeamDamageReq._proto = {
  [1] = {
    "team_damage",
    "int64"
  },
  [2] = {"id", "int"}
}
_class("CEventCreateTeamDamageRes", CCallReplyEvent)
CEventCreateTeamDamageRes = CEventCreateTeamDamageRes

function CEventCreateTeamDamageRes:Constructor()
  self.nRet = 0
  self.data = PlayerWorldBossInfo:New()
end

CEventCreateTeamDamageRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "data",
    "PlayerWorldBossInfo"
  }
}
_class("CEventGetRankDamageListReq", CCallRequestEvent)
CEventGetRankDamageListReq = CEventGetRankDamageListReq

function CEventGetRankDamageListReq:Constructor()
end

CEventGetRankDamageListReq._proto = {}
_class("CEventGetRankDamageListRes", CCallReplyEvent)
CEventGetRankDamageListRes = CEventGetRankDamageListRes

function CEventGetRankDamageListRes:Constructor()
  self.nRet = 0
  self.damage_list = {}
  self.rank_max_num = 0
end

CEventGetRankDamageListRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "damage_list",
    "list<int64>"
  },
  [3] = {
    "rank_max_num",
    "int"
  }
}
_class("CEventGetRankTopNReq", CCallRequestEvent)
CEventGetRankTopNReq = CEventGetRankTopNReq

function CEventGetRankTopNReq:Constructor()
  self.is_cur_rank = false
end

CEventGetRankTopNReq._proto = {
  [1] = {
    "is_cur_rank",
    "bool"
  }
}
_class("CEventGetRankTopNRes", CCallReplyEvent)
CEventGetRankTopNRes = CEventGetRankTopNRes

function CEventGetRankTopNRes:Constructor()
  self.nRet = 0
  self.show_list = RankShowSimpleInfo:New()
end

CEventGetRankTopNRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "show_list",
    "RankShowSimpleInfo"
  }
}
_class("CEventRankOneDetailReq", CCallRequestEvent)
CEventRankOneDetailReq = CEventRankOneDetailReq

function CEventRankOneDetailReq:Constructor()
  self.pstid = 0
end

CEventRankOneDetailReq._proto = {
  [1] = {"pstid", "int64"}
}
_class("CEventRankOneDetailRes", CCallReplyEvent)
CEventRankOneDetailRes = CEventRankOneDetailRes

function CEventRankOneDetailRes:Constructor()
  self.nRet = 0
  self.detail_info = RankDetailInfo:New()
end

CEventRankOneDetailRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "detail_info",
    "RankDetailInfo"
  }
}
