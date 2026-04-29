require("message_def")
local ext_missionMessageDef = {
  CLSID_CEventExtMission_Summary = 5000,
  CLSID_CEventExtMission_FailCount = 5001,
  CLSID_CEventExtMission_SummaryReq = 5002,
  CLSID_CEventExtMission_SummaryAsw = 5003,
  CLSID_CEventExtMission_DetailReq = 5004,
  CLSID_CEventExtMission_DetailAsw = 5005,
  CLSID_CEventExtTask_DetailReq = 5006,
  CLSID_CEventExtTask_DetailAsw = 5007,
  CLSID_CEventExtMission_AwardReq = 5008,
  CLSID_CEventExtMission_AwardAsw = 5009,
  CLSID_CEventExtMission_StoryReq = 5010,
  CLSID_CEventExtMission_StoryAsw = 5011,
  CLSID_CEventExtMission_StoryData = 5012,
  CLSID_CEventExtMission_CompleteAllExtMission = 5013
}
table.append(MessageDef, ext_missionMessageDef)
local ENUM_ExtMission_ErrorCode = {
  E_ExtMission_Success = 0,
  E_ExtMission_Fail = 1,
  E_ExtMission_Level = 2,
  E_ExtMission_MissionID = 3,
  E_ExtMission_TaskID = 4,
  E_ExtMission_LowPower = 5,
  E_ExtMission_TaskLock = 6,
  E_ExtMission_InvalidStar = 7,
  E_ExtMission_MissionData = 8,
  E_ExtMission_AwardOver = 9,
  E_ExtMission_MissionLock = 10,
  E_ExtMission_StoryType = 11,
  E_ExtMission_Else = 64
}
_enum("ENUM_ExtMission_ErrorCode", ENUM_ExtMission_ErrorCode)
_class("CEventExtMission_Summary", CSvrPushEvent)
CEventExtMission_Summary = CEventExtMission_Summary

function CEventExtMission_Summary:Constructor()
  self.m_pstid = 0
  self.m_bOnlyNew = false
  self.m_nGuideData = 0
  self.m_vecExtMission = {}
end

CEventExtMission_Summary._proto = {
  [1] = {"m_pstid", "int64"},
  [2] = {"m_bOnlyNew", "bool"},
  [3] = {
    "m_nGuideData",
    "int"
  },
  [4] = {
    "m_vecExtMission",
    "list<DSummaryExtMission>"
  }
}
_class("CEventExtMission_FailCount", CSvrPushEvent)
CEventExtMission_FailCount = CEventExtMission_FailCount

function CEventExtMission_FailCount:Constructor()
  self.m_nExtMissionID = 0
  self.m_nExtTaskID = 0
  self.m_nFailCount = 0
end

CEventExtMission_FailCount._proto = {
  [1] = {
    "m_nExtMissionID",
    "int"
  },
  [2] = {
    "m_nExtTaskID",
    "int"
  },
  [3] = {
    "m_nFailCount",
    "int"
  }
}
_class("CEventExtMission_SummaryReq", CCallRequestEvent)
CEventExtMission_SummaryReq = CEventExtMission_SummaryReq

function CEventExtMission_SummaryReq:Constructor()
  self.m_nExtMissionID = 0
end

CEventExtMission_SummaryReq._proto = {
  [1] = {
    "m_nExtMissionID",
    "int"
  }
}
_class("CEventExtMission_SummaryAsw", CCallReplyEvent)
CEventExtMission_SummaryAsw = CEventExtMission_SummaryAsw

function CEventExtMission_SummaryAsw:Constructor()
  self.m_nResult = 0
  self.m_nGuideData = 0
  self.m_vecExtMission = {}
end

CEventExtMission_SummaryAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_nGuideData",
    "int"
  },
  [3] = {
    "m_vecExtMission",
    "list<DSummaryExtMission>"
  }
}
_class("CEventExtMission_DetailReq", CCallRequestEvent)
CEventExtMission_DetailReq = CEventExtMission_DetailReq

function CEventExtMission_DetailReq:Constructor()
  self.m_nExtMissionID = 0
end

CEventExtMission_DetailReq._proto = {
  [1] = {
    "m_nExtMissionID",
    "int"
  }
}
_class("CEventExtMission_DetailAsw", CCallReplyEvent)
CEventExtMission_DetailAsw = CEventExtMission_DetailAsw

function CEventExtMission_DetailAsw:Constructor()
  self.m_nResult = 0
  self.m_extMissionData = DDetailExtMission:New()
end

CEventExtMission_DetailAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_extMissionData",
    "DDetailExtMission"
  }
}
_class("CEventExtTask_DetailReq", CCallRequestEvent)
CEventExtTask_DetailReq = CEventExtTask_DetailReq

function CEventExtTask_DetailReq:Constructor()
  self.m_nExtMissionID = 0
  self.m_nExtTaskID = 0
end

CEventExtTask_DetailReq._proto = {
  [1] = {
    "m_nExtMissionID",
    "int"
  },
  [2] = {
    "m_nExtTaskID",
    "int"
  }
}
_class("CEventExtTask_DetailAsw", CCallReplyEvent)
CEventExtTask_DetailAsw = CEventExtTask_DetailAsw

function CEventExtTask_DetailAsw:Constructor()
  self.m_nResult = 0
  self.m_nExtMissionID = 0
  self.m_extTaskData = DDetailExtTask:New()
end

CEventExtTask_DetailAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_nExtMissionID",
    "int"
  },
  [3] = {
    "m_extTaskData",
    "DDetailExtTask"
  }
}
local ENUM_ExtMission_AwardType = {
  E_ExtMission_Award_No = 0,
  E_ExtMission_Award_TaskNormal = 1,
  E_ExtMission_Award_TaskPerfect = 2,
  E_ExtMission_Award_NormalStart = 10
}
_enum("ENUM_ExtMission_AwardType", ENUM_ExtMission_AwardType)
_class("CEventExtMission_AwardReq", CCallRequestEvent)
CEventExtMission_AwardReq = CEventExtMission_AwardReq

function CEventExtMission_AwardReq:Constructor()
  self.m_nExtMissionID = 0
  self.m_nExtTaskID = 0
  self.m_nStarCount = 0
end

CEventExtMission_AwardReq._proto = {
  [1] = {
    "m_nExtMissionID",
    "int"
  },
  [2] = {
    "m_nExtTaskID",
    "int"
  },
  [3] = {
    "m_nStarCount",
    "int"
  }
}
_class("CEventExtMission_AwardAsw", CCallReplyEvent)
CEventExtMission_AwardAsw = CEventExtMission_AwardAsw

function CEventExtMission_AwardAsw:Constructor()
  self.m_nResult = 0
  self.m_nExtMissionID = 0
  self.m_nExtTaskID = 0
  self.m_nStarCount = 0
  self.m_nAwardRecord = 0
end

CEventExtMission_AwardAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_nExtMissionID",
    "int"
  },
  [3] = {
    "m_nExtTaskID",
    "int"
  },
  [4] = {
    "m_nStarCount",
    "int"
  },
  [5] = {
    "m_nAwardRecord",
    "int"
  }
}
_class("CEventExtMission_StoryReq", CCallRequestEvent)
CEventExtMission_StoryReq = CEventExtMission_StoryReq

function CEventExtMission_StoryReq:Constructor()
  self.m_nExtTaskID = 0
  self.m_nExtStroyData = 0
end

CEventExtMission_StoryReq._proto = {
  [1] = {
    "m_nExtTaskID",
    "int"
  },
  [2] = {
    "m_nExtStroyData",
    "int"
  }
}
_class("CEventExtMission_StoryAsw", CCallReplyEvent)
CEventExtMission_StoryAsw = CEventExtMission_StoryAsw

function CEventExtMission_StoryAsw:Constructor()
  self.m_nResult = 0
  self.m_nExtTaskID = 0
  self.m_nExtStroyData = 0
end

CEventExtMission_StoryAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_nExtTaskID",
    "int"
  },
  [3] = {
    "m_nExtStroyData",
    "int"
  }
}
_class("CEventExtMission_StoryData", CSvrPushEvent)
CEventExtMission_StoryData = CEventExtMission_StoryData

function CEventExtMission_StoryData:Constructor()
  self.m_extStroy = DExtStoryDataList:New()
end

CEventExtMission_StoryData._proto = {
  [1] = {
    "m_extStroy",
    "DExtStoryDataList"
  }
}
_class("CEventExtMission_CompleteAllExtMission", CCliPushEvent)
CEventExtMission_CompleteAllExtMission = CEventExtMission_CompleteAllExtMission

function CEventExtMission_CompleteAllExtMission:Constructor()
  self.m_nExtID = 0
end

CEventExtMission_CompleteAllExtMission._proto = {
  [1] = {"m_nExtID", "int"}
}
