require("message_def")
local sailing_missionMessageDef = {
  CLSID_CEventApplySailingMissionInfoReq = 41000,
  CLSID_CEventApplySailingMissionInfoRes = 41001,
  CLSID_CEventApplySMChangeFormationReq = 41002,
  CLSID_CEventApplySMChangeFormationRes = 41003,
  CLSID_CEventResetSailingMissionRecordReq = 41004,
  CLSID_CEventResetSailingMissionRecordRes = 41005,
  CLSID_SailingPushOneLayerInfoChange = 41006,
  CLSID_SailingPushCurFormationChange = 41007,
  CLSID_CEventReceiveRewardReq = 41008,
  CLSID_CEventReceiveRewardRes = 41009
}
table.append(MessageDef, sailing_missionMessageDef)
_class("CEventApplySailingMissionInfoReq", CCallRequestEvent)
CEventApplySailingMissionInfoReq = CEventApplySailingMissionInfoReq

function CEventApplySailingMissionInfoReq:Constructor()
end

CEventApplySailingMissionInfoReq._proto = {}
_class("CEventApplySailingMissionInfoRes", CCallReplyEvent)
CEventApplySailingMissionInfoRes = CEventApplySailingMissionInfoRes

function CEventApplySailingMissionInfoRes:Constructor()
  self.nRet = 0
  self.Data = ClientSailingMissionInfo:New()
end

CEventApplySailingMissionInfoRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "Data",
    "ClientSailingMissionInfo"
  }
}
_class("CEventApplySMChangeFormationReq", CCallRequestEvent)
CEventApplySMChangeFormationReq = CEventApplySMChangeFormationReq

function CEventApplySMChangeFormationReq:Constructor()
  self.formation_pet_list = {}
  self.layer_id = 0
  self.mission_id = 0
end

CEventApplySMChangeFormationReq._proto = {
  [1] = {
    "formation_pet_list",
    "list<int64>"
  },
  [2] = {"layer_id", "int"},
  [3] = {"mission_id", "int"}
}
_class("CEventApplySMChangeFormationRes", CCallReplyEvent)
CEventApplySMChangeFormationRes = CEventApplySMChangeFormationRes

function CEventApplySMChangeFormationRes:Constructor()
  self.nFormationRet = 0
end

CEventApplySMChangeFormationRes._proto = {
  [1] = {
    "nFormationRet",
    "int"
  }
}
_class("CEventResetSailingMissionRecordReq", CCallRequestEvent)
CEventResetSailingMissionRecordReq = CEventResetSailingMissionRecordReq

function CEventResetSailingMissionRecordReq:Constructor()
  self.layer_id = 0
  self.mission_id = 0
end

CEventResetSailingMissionRecordReq._proto = {
  [1] = {"layer_id", "int"},
  [2] = {"mission_id", "int"}
}
_class("CEventResetSailingMissionRecordRes", CCallReplyEvent)
CEventResetSailingMissionRecordRes = CEventResetSailingMissionRecordRes

function CEventResetSailingMissionRecordRes:Constructor()
  self.nRet = 0
end

CEventResetSailingMissionRecordRes._proto = {
  [1] = {"nRet", "int"}
}
_class("SailingPushOneLayerInfoChange", CSvrPushEvent)
SailingPushOneLayerInfoChange = SailingPushOneLayerInfoChange

function SailingPushOneLayerInfoChange:Constructor()
  self.info = SailingLayerInfo:New()
  self.max_layer_id = 0
  self.cur_exploration_progress = 0
  self.history_exploration_progress = 0
end

SailingPushOneLayerInfoChange._proto = {
  [1] = {
    "info",
    "SailingLayerInfo"
  },
  [2] = {
    "max_layer_id",
    "int"
  },
  [3] = {
    "cur_exploration_progress",
    "int"
  },
  [4] = {
    "history_exploration_progress",
    "int"
  }
}
_class("SailingPushCurFormationChange", CSvrPushEvent)
SailingPushCurFormationChange = SailingPushCurFormationChange

function SailingPushCurFormationChange:Constructor()
  self.team_cache = TeamCache:New()
end

SailingPushCurFormationChange._proto = {
  [1] = {"team_cache", "TeamCache"}
}
_class("CEventReceiveRewardReq", CCallRequestEvent)
CEventReceiveRewardReq = CEventReceiveRewardReq

function CEventReceiveRewardReq:Constructor()
  self.id_list = {}
end

CEventReceiveRewardReq._proto = {
  [1] = {"id_list", "list<int>"}
}
_class("CEventReceiveRewardRes", CCallReplyEvent)
CEventReceiveRewardRes = CEventReceiveRewardRes

function CEventReceiveRewardRes:Constructor()
  self.ret = 0
  self.rewards = {}
  self.received_exploration_reward = {}
end

CEventReceiveRewardRes._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  },
  [3] = {
    "received_exploration_reward",
    "list<int>"
  }
}
