require("message_def")
local lostareaMessageDef = {
  CLSID_CEventLostAreaRedDotReq = 36000,
  CLSID_CEventLostAreaRedDotReqReply = 36001,
  CLSID_CEventLostAreadifficultyStatusReq = 36002,
  CLSID_CEventLostAreadifficultyStatusReply = 36003,
  CLSID_CeventLostAreaUnlockOnedifficultyReq = 36004,
  CLSID_CEventLostAreaUnlockOnedifficultyReply = 36005,
  CLSID_CeventLostAreaGetdifficultyMissionReq = 36006,
  CLSID_CeventLostAreaGetdifficultyMissionReply = 36007,
  CLSID_CeventLostAreaChooseWeekDifficultyReq = 36008,
  CLSID_CeventLostAreaChooseWeekDifficultyReply = 36009
}
table.append(MessageDef, lostareaMessageDef)
_class("CEventLostAreaRedDotReq", CCallRequestEvent)
CEventLostAreaRedDotReq = CEventLostAreaRedDotReq

function CEventLostAreaRedDotReq:Constructor()
end

CEventLostAreaRedDotReq._proto = {}
_class("CEventLostAreaRedDotReqReply", CCallReplyEvent)
CEventLostAreaRedDotReqReply = CEventLostAreaRedDotReqReply

function CEventLostAreaRedDotReqReply:Constructor()
  self.show = false
end

CEventLostAreaRedDotReqReply._proto = {
  [1] = {"show", "bool"}
}
_class("CEventLostAreadifficultyStatusReq", CCallRequestEvent)
CEventLostAreadifficultyStatusReq = CEventLostAreadifficultyStatusReq

function CEventLostAreadifficultyStatusReq:Constructor()
end

CEventLostAreadifficultyStatusReq._proto = {}
_class("CEventLostAreadifficultyStatusReply", CCallReplyEvent)
CEventLostAreadifficultyStatusReply = CEventLostAreadifficultyStatusReply

function CEventLostAreadifficultyStatusReply:Constructor()
  self.ret = 0
  self.next_refresh_time = 0
  self.status = {}
  self.area_design_cfg = {}
  self.area_level_group_cfg = {}
end

CEventLostAreadifficultyStatusReply._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "next_refresh_time",
    "time"
  },
  [3] = {
    "status",
    "map<int,int>"
  },
  [4] = {
    "area_design_cfg",
    "map<int,LostAreaDesignConfig>"
  },
  [5] = {
    "area_level_group_cfg",
    "map<int,LostAreaLevelGroupConfig>"
  }
}
_class("CeventLostAreaUnlockOnedifficultyReq", CCallRequestEvent)
CeventLostAreaUnlockOnedifficultyReq = CeventLostAreaUnlockOnedifficultyReq

function CeventLostAreaUnlockOnedifficultyReq:Constructor()
  self.id = 0
end

CeventLostAreaUnlockOnedifficultyReq._proto = {
  [1] = {"id", "int"}
}
_class("CEventLostAreaUnlockOnedifficultyReply", CCallReplyEvent)
CEventLostAreaUnlockOnedifficultyReply = CEventLostAreaUnlockOnedifficultyReply

function CEventLostAreaUnlockOnedifficultyReply:Constructor()
  self.ret = 0
  self.status = {}
end

CEventLostAreaUnlockOnedifficultyReply._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "status",
    "map<int,int>"
  }
}
_class("CeventLostAreaGetdifficultyMissionReq", CCallRequestEvent)
CeventLostAreaGetdifficultyMissionReq = CeventLostAreaGetdifficultyMissionReq

function CeventLostAreaGetdifficultyMissionReq:Constructor()
  self.ID = 0
end

CeventLostAreaGetdifficultyMissionReq._proto = {
  [1] = {"ID", "int"}
}
_class("CeventLostAreaGetdifficultyMissionReply", CCallReplyEvent)
CeventLostAreaGetdifficultyMissionReply = CeventLostAreaGetdifficultyMissionReply

function CeventLostAreaGetdifficultyMissionReply:Constructor()
  self.ret = 0
  self.difficult_mission_info = {}
end

CeventLostAreaGetdifficultyMissionReply._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "difficult_mission_info",
    "map<int,MissionInfo>"
  }
}
_class("CeventLostAreaChooseWeekDifficultyReq", CCallRequestEvent)
CeventLostAreaChooseWeekDifficultyReq = CeventLostAreaChooseWeekDifficultyReq

function CeventLostAreaChooseWeekDifficultyReq:Constructor()
  self.design_id = 0
end

CeventLostAreaChooseWeekDifficultyReq._proto = {
  [1] = {"design_id", "int"}
}
_class("CeventLostAreaChooseWeekDifficultyReply", CCallReplyEvent)
CeventLostAreaChooseWeekDifficultyReply = CeventLostAreaChooseWeekDifficultyReply

function CeventLostAreaChooseWeekDifficultyReply:Constructor()
  self.ret = 0
  self.difficult_mission_info = {}
end

CeventLostAreaChooseWeekDifficultyReply._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "difficult_mission_info",
    "map<int,MissionInfo>"
  }
}
