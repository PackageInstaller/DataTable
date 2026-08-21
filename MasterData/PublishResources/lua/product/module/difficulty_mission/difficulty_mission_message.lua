require("message_def")
local difficulty_missionMessageDef = {
  CLSID_CEventApplyDifficultyMissionInfoReq = 39000,
  CLSID_CEventApplyDifficultyMissionInfoRes = 39001,
  CLSID_CEventApplyChangeFormationReq = 39002,
  CLSID_CEventApplyChangeFormationRes = 39003,
  CLSID_CEventResetSubMissionRecordReq = 39004,
  CLSID_CEventResetSubMissionRecordRes = 39005,
  CLSID_PushOneParentInfoChange = 39006,
  CLSID_PushCurFormationChange = 39007,
  CLSID_CEventApplyParentMissionPassDataReq = 39008,
  CLSID_CEventApplyParentMissionPassDataRes = 39009
}
table.append(MessageDef, difficulty_missionMessageDef)
_class("CEventApplyDifficultyMissionInfoReq", CCallRequestEvent)
CEventApplyDifficultyMissionInfoReq = CEventApplyDifficultyMissionInfoReq

function CEventApplyDifficultyMissionInfoReq:Constructor()
end

CEventApplyDifficultyMissionInfoReq._proto = {}
_class("CEventApplyDifficultyMissionInfoRes", CCallReplyEvent)
CEventApplyDifficultyMissionInfoRes = CEventApplyDifficultyMissionInfoRes

function CEventApplyDifficultyMissionInfoRes:Constructor()
  self.nRet = 0
  self.Data = ClientDifficultyMissionInfo:New()
end

CEventApplyDifficultyMissionInfoRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "Data",
    "ClientDifficultyMissionInfo"
  }
}
_class("CEventApplyChangeFormationReq", CCallRequestEvent)
CEventApplyChangeFormationReq = CEventApplyChangeFormationReq

function CEventApplyChangeFormationReq:Constructor()
  self.formation_pet_list = {}
  self.parent_mission_id = 0
  self.sub_mission_id = 0
end

CEventApplyChangeFormationReq._proto = {
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
_class("CEventApplyChangeFormationRes", CCallReplyEvent)
CEventApplyChangeFormationRes = CEventApplyChangeFormationRes

function CEventApplyChangeFormationRes:Constructor()
  self.nFormationRet = 0
end

CEventApplyChangeFormationRes._proto = {
  [1] = {
    "nFormationRet",
    "int"
  }
}
_class("CEventResetSubMissionRecordReq", CCallRequestEvent)
CEventResetSubMissionRecordReq = CEventResetSubMissionRecordReq

function CEventResetSubMissionRecordReq:Constructor()
  self.parent_mission_id = 0
  self.sub_mission_id = 0
end

CEventResetSubMissionRecordReq._proto = {
  [1] = {
    "parent_mission_id",
    "int"
  },
  [2] = {
    "sub_mission_id",
    "int"
  }
}
_class("CEventResetSubMissionRecordRes", CCallReplyEvent)
CEventResetSubMissionRecordRes = CEventResetSubMissionRecordRes

function CEventResetSubMissionRecordRes:Constructor()
  self.nRet = 0
end

CEventResetSubMissionRecordRes._proto = {
  [1] = {"nRet", "int"}
}
_class("PushOneParentInfoChange", CSvrPushEvent)
PushOneParentInfoChange = PushOneParentInfoChange

function PushOneParentInfoChange:Constructor()
  self.info = ParentMissionInfo:New()
  self.cur_mission_id = 0
end

PushOneParentInfoChange._proto = {
  [1] = {
    "info",
    "ParentMissionInfo"
  },
  [2] = {
    "cur_mission_id",
    "int"
  }
}
_class("PushCurFormationChange", CSvrPushEvent)
PushCurFormationChange = PushCurFormationChange

function PushCurFormationChange:Constructor()
  self.formation_pet_list = {}
end

PushCurFormationChange._proto = {
  [1] = {
    "formation_pet_list",
    "list<int64>"
  }
}
_class("CEventApplyParentMissionPassDataReq", CCallRequestEvent)
CEventApplyParentMissionPassDataReq = CEventApplyParentMissionPassDataReq

function CEventApplyParentMissionPassDataReq:Constructor()
  self.nMissionId = 0
end

CEventApplyParentMissionPassDataReq._proto = {
  [1] = {"nMissionId", "int"}
}
_class("CEventApplyParentMissionPassDataRes", CCallReplyEvent)
CEventApplyParentMissionPassDataRes = CEventApplyParentMissionPassDataRes

function CEventApplyParentMissionPassDataRes:Constructor()
  self.info = {}
end

CEventApplyParentMissionPassDataRes._proto = {
  [1] = {
    "info",
    "list<parent_mission_pass_info>"
  }
}
