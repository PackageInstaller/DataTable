require("message_def")
local season_taskMessageDef = {
  CLSID_CEventGetSeasonTaskInfoReq = 43000,
  CLSID_CEventGetSeasonTaskInfoRes = 43001,
  CLSID_CEventPushUpdateTaskNode = 43002,
  CLSID_CEventClientSubmitInfoReq = 43003,
  CLSID_CEventClientSubmitInfoRes = 43004,
  CLSID_CEventSeasonMiniGameInfoReq = 43005,
  CLSID_CEventSeasonMiniGameInfoRes = 43006,
  CLSID_CEventSeasonDebrisMissionReq = 43007,
  CLSID_CEventSeasonDebrisMissionRes = 43008,
  CLSID_CEventSeasonCastleReq = 43009,
  CLSID_CEventSeasonCastleRes = 43010,
  CLSID_CEventClientSubmitEventPointInfoReq = 43011,
  CLSID_CEventClientSubmitEventPointInfoRes = 43012
}
table.append(MessageDef, season_taskMessageDef)
_class("CEventGetSeasonTaskInfoReq", CCallRequestEvent)
CEventGetSeasonTaskInfoReq = CEventGetSeasonTaskInfoReq

function CEventGetSeasonTaskInfoReq:Constructor()
end

CEventGetSeasonTaskInfoReq._proto = {}
_class("CEventGetSeasonTaskInfoRes", CCallReplyEvent)
CEventGetSeasonTaskInfoRes = CEventGetSeasonTaskInfoRes

function CEventGetSeasonTaskInfoRes:Constructor()
  self.n_ret = 0
  self.cur_task_info = client_season_task_info:New()
  self.client_infos = ClientQuestProgressInfo:New()
end

CEventGetSeasonTaskInfoRes._proto = {
  [1] = {"n_ret", "int"},
  [2] = {
    "cur_task_info",
    "client_season_task_info"
  },
  [3] = {
    "client_infos",
    "ClientQuestProgressInfo"
  }
}
_class("CEventPushUpdateTaskNode", CSvrPushEvent)
CEventPushUpdateTaskNode = CEventPushUpdateTaskNode

function CEventPushUpdateTaskNode:Constructor()
  self.cur_task_info = client_season_task_info:New()
  self.is_cross_day = false
end

CEventPushUpdateTaskNode._proto = {
  [1] = {
    "cur_task_info",
    "client_season_task_info"
  },
  [2] = {
    "is_cross_day",
    "bool"
  }
}
_class("CEventClientSubmitInfoReq", CCallRequestEvent)
CEventClientSubmitInfoReq = CEventClientSubmitInfoReq

function CEventClientSubmitInfoReq:Constructor()
  self.info = QuestProgress:New()
end

CEventClientSubmitInfoReq._proto = {
  [1] = {
    "info",
    "QuestProgress"
  }
}
_class("CEventClientSubmitInfoRes", CCallReplyEvent)
CEventClientSubmitInfoRes = CEventClientSubmitInfoRes

function CEventClientSubmitInfoRes:Constructor()
  self.n_ret = 0
  self.info = QuestProgress:New()
end

CEventClientSubmitInfoRes._proto = {
  [1] = {"n_ret", "int"},
  [2] = {
    "info",
    "QuestProgress"
  }
}
_class("CEventSeasonMiniGameInfoReq", CCallRequestEvent)
CEventSeasonMiniGameInfoReq = CEventSeasonMiniGameInfoReq

function CEventSeasonMiniGameInfoReq:Constructor()
end

CEventSeasonMiniGameInfoReq._proto = {}
_class("CEventSeasonMiniGameInfoRes", CCallReplyEvent)
CEventSeasonMiniGameInfoRes = CEventSeasonMiniGameInfoRes

function CEventSeasonMiniGameInfoRes:Constructor()
  self.debris_mission = {}
  self.castle_lv = {}
end

CEventSeasonMiniGameInfoRes._proto = {
  [1] = {
    "debris_mission",
    "map<int,int>"
  },
  [2] = {
    "castle_lv",
    "map<int,int>"
  }
}
_class("CEventSeasonDebrisMissionReq", CCallRequestEvent)
CEventSeasonDebrisMissionReq = CEventSeasonDebrisMissionReq

function CEventSeasonDebrisMissionReq:Constructor()
  self.mission_id = 0
  self.score = 0
end

CEventSeasonDebrisMissionReq._proto = {
  [1] = {"mission_id", "int"},
  [2] = {"score", "int"}
}
_class("CEventSeasonDebrisMissionRes", CCallReplyEvent)
CEventSeasonDebrisMissionRes = CEventSeasonDebrisMissionRes

function CEventSeasonDebrisMissionRes:Constructor()
  self.ret = 0
end

CEventSeasonDebrisMissionRes._proto = {
  [1] = {"ret", "int"}
}
_class("CEventSeasonCastleReq", CCallRequestEvent)
CEventSeasonCastleReq = CEventSeasonCastleReq

function CEventSeasonCastleReq:Constructor()
  self.id = 0
end

CEventSeasonCastleReq._proto = {
  [1] = {"id", "int"}
}
_class("CEventSeasonCastleRes", CCallReplyEvent)
CEventSeasonCastleRes = CEventSeasonCastleRes

function CEventSeasonCastleRes:Constructor()
  self.ret = 0
end

CEventSeasonCastleRes._proto = {
  [1] = {"ret", "int"}
}
_class("CEventClientSubmitEventPointInfoReq", CCallRequestEvent)
CEventClientSubmitEventPointInfoReq = CEventClientSubmitEventPointInfoReq

function CEventClientSubmitEventPointInfoReq:Constructor()
  self.info = EvenPointInfo:New()
end

CEventClientSubmitEventPointInfoReq._proto = {
  [1] = {
    "info",
    "EvenPointInfo"
  }
}
_class("CEventClientSubmitEventPointInfoRes", CCallReplyEvent)
CEventClientSubmitEventPointInfoRes = CEventClientSubmitEventPointInfoRes

function CEventClientSubmitEventPointInfoRes:Constructor()
  self.n_ret = 0
  self.info = EvenPointInfo:New()
end

CEventClientSubmitEventPointInfoRes._proto = {
  [1] = {"n_ret", "int"},
  [2] = {
    "info",
    "EvenPointInfo"
  }
}
