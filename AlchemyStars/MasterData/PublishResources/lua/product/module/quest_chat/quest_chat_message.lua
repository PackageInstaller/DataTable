require("message_def")
local quest_chatMessageDef = {
  CLSID_CEventQuestChat_GetActiveReq = 29000,
  CLSID_CEventQuestChat_GetActiveAsw = 29001,
  CLSID_CEventQuestChat_SpeakerHistoryReq = 29002,
  CLSID_CEventQuestChat_SpeakerHistoryAsw = 29003,
  CLSID_CEventQuestChat_UpdateChatAnswerReq = 29004,
  CLSID_CEventQuestChat_UpdateChatAnswerAsw = 29005,
  CLSID_CEventQuestChat_SetTalkReadedReq = 29006,
  CLSID_CEventQuestChat_SetTalkReadedAsw = 29007,
  CLSID_CEventQuestChat_UpdateSpeakerNameReq = 29008,
  CLSID_CEventQuestChat_UpdateSpeakerNameAsw = 29009,
  CLSID_CEventQuestChat_TriggerRandomChatReq = 29010,
  CLSID_CEventQuestChat_TriggerRandomChatAsw = 29011,
  CLSID_CEventQuestChat_CompleteReq = 29012,
  CLSID_CEventQuestChat_CompleteAsw = 29013,
  CLSID_CEventQuestChat_PushSpeakerData = 29014,
  CLSID_CEventQuestChat_AllHistoryReq = 29015,
  CLSID_CEventQuestChat_AllHistoryAsw = 29016
}
table.append(MessageDef, quest_chatMessageDef)
local EnumErrorCode_QuestChat = {
  E_Error_QuestChat_Unknown = -1,
  E_Error_QuestChat_Succ = 0,
  E_Error_QuestChat_Fail = 1,
  E_Error_QuestChat_SpeakerID = 2,
  E_Error_QuestChat_ChatID = 3,
  E_Error_QuestChat_TalkID = 4,
  E_Error_QuestChat_AnswerID = 5,
  E_Error_QuestChat_RandomEmpty = 6,
  E_Error_QuestChat_RandomTime = 7,
  E_Error_QuestChat_RandomValid = 8,
  E_Error_QuestChat_ReadFlag = 9,
  E_Error_QuestChat_SpeakerName = 10,
  E_Error_QuestChat_SpeakerNameLen = 11,
  E_Error_QuestChat_SpeakerNameWord = 12,
  E_Error_QuestChat_ConditionEnable = 13
}
_enum("EnumErrorCode_QuestChat", EnumErrorCode_QuestChat)
_class("CEventQuestChat_GetActiveReq", CCallRequestEvent)
CEventQuestChat_GetActiveReq = CEventQuestChat_GetActiveReq

function CEventQuestChat_GetActiveReq:Constructor()
  self.m_nSpeakerID = 0
end

CEventQuestChat_GetActiveReq._proto = {
  [1] = {
    "m_nSpeakerID",
    "int"
  }
}
_class("CEventQuestChat_GetActiveAsw", CCallReplyEvent)
CEventQuestChat_GetActiveAsw = CEventQuestChat_GetActiveAsw

function CEventQuestChat_GetActiveAsw:Constructor()
  self.m_nResult = 0
  self.m_mapQuestChatData = {}
end

CEventQuestChat_GetActiveAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_mapQuestChatData",
    "map<int,DQuestChatData_Speaker>"
  }
}
_class("CEventQuestChat_SpeakerHistoryReq", CCallRequestEvent)
CEventQuestChat_SpeakerHistoryReq = CEventQuestChat_SpeakerHistoryReq

function CEventQuestChat_SpeakerHistoryReq:Constructor()
  self.m_nSpeakerID = 0
  self.m_nChatID = 0
end

CEventQuestChat_SpeakerHistoryReq._proto = {
  [1] = {
    "m_nSpeakerID",
    "int"
  },
  [2] = {"m_nChatID", "int"}
}
_class("CEventQuestChat_SpeakerHistoryAsw", CCallReplyEvent)
CEventQuestChat_SpeakerHistoryAsw = CEventQuestChat_SpeakerHistoryAsw

function CEventQuestChat_SpeakerHistoryAsw:Constructor()
  self.m_nResult = 0
  self.m_speakerChatData = DQuestChatData_Speaker:New()
end

CEventQuestChat_SpeakerHistoryAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_speakerChatData",
    "DQuestChatData_Speaker"
  }
}
_class("CEventQuestChat_UpdateChatAnswerReq", CCallRequestEvent)
CEventQuestChat_UpdateChatAnswerReq = CEventQuestChat_UpdateChatAnswerReq

function CEventQuestChat_UpdateChatAnswerReq:Constructor()
  self.m_nSpeakerID = 0
  self.m_nChatID = 0
  self.m_nQuestionID = 0
  self.m_nAnswerID = 0
end

CEventQuestChat_UpdateChatAnswerReq._proto = {
  [1] = {
    "m_nSpeakerID",
    "int"
  },
  [2] = {"m_nChatID", "int"},
  [3] = {
    "m_nQuestionID",
    "int"
  },
  [4] = {
    "m_nAnswerID",
    "int"
  }
}
_class("CEventQuestChat_UpdateChatAnswerAsw", CCallReplyEvent)
CEventQuestChat_UpdateChatAnswerAsw = CEventQuestChat_UpdateChatAnswerAsw

function CEventQuestChat_UpdateChatAnswerAsw:Constructor()
  self.m_nResult = 0
  self.m_nSpeakerID = 0
  self.m_nChatID = 0
  self.m_vecTalkID = {}
  self.m_nStatus = 0
end

CEventQuestChat_UpdateChatAnswerAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_nSpeakerID",
    "int"
  },
  [3] = {"m_nChatID", "int"},
  [4] = {
    "m_vecTalkID",
    "list<int>"
  },
  [5] = {"m_nStatus", "int"}
}
_class("CEventQuestChat_SetTalkReadedReq", CCallRequestEvent)
CEventQuestChat_SetTalkReadedReq = CEventQuestChat_SetTalkReadedReq

function CEventQuestChat_SetTalkReadedReq:Constructor()
  self.m_nSpeakerID = 0
  self.m_nChatID = 0
  self.m_nTalkID = 0
end

CEventQuestChat_SetTalkReadedReq._proto = {
  [1] = {
    "m_nSpeakerID",
    "int"
  },
  [2] = {"m_nChatID", "int"},
  [3] = {"m_nTalkID", "int"}
}
_class("CEventQuestChat_SetTalkReadedAsw", CCallReplyEvent)
CEventQuestChat_SetTalkReadedAsw = CEventQuestChat_SetTalkReadedAsw

function CEventQuestChat_SetTalkReadedAsw:Constructor()
  self.m_nResult = 0
  self.m_nStatus = 0
end

CEventQuestChat_SetTalkReadedAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {"m_nStatus", "int"}
}
_class("CEventQuestChat_UpdateSpeakerNameReq", CCallRequestEvent)
CEventQuestChat_UpdateSpeakerNameReq = CEventQuestChat_UpdateSpeakerNameReq

function CEventQuestChat_UpdateSpeakerNameReq:Constructor()
  self.m_nSpeakerID = 0
  self.m_stSpeakerName = ""
end

CEventQuestChat_UpdateSpeakerNameReq._proto = {
  [1] = {
    "m_nSpeakerID",
    "int"
  },
  [2] = {
    "m_stSpeakerName",
    "string"
  }
}
_class("CEventQuestChat_UpdateSpeakerNameAsw", CCallReplyEvent)
CEventQuestChat_UpdateSpeakerNameAsw = CEventQuestChat_UpdateSpeakerNameAsw

function CEventQuestChat_UpdateSpeakerNameAsw:Constructor()
  self.m_nResult = 0
end

CEventQuestChat_UpdateSpeakerNameAsw._proto = {
  [1] = {"m_nResult", "int"}
}
_class("CEventQuestChat_TriggerRandomChatReq", CCallRequestEvent)
CEventQuestChat_TriggerRandomChatReq = CEventQuestChat_TriggerRandomChatReq

function CEventQuestChat_TriggerRandomChatReq:Constructor()
  self.m_nSpeakerID = 0
end

CEventQuestChat_TriggerRandomChatReq._proto = {
  [1] = {
    "m_nSpeakerID",
    "int"
  }
}
_class("CEventQuestChat_TriggerRandomChatAsw", CCallReplyEvent)
CEventQuestChat_TriggerRandomChatAsw = CEventQuestChat_TriggerRandomChatAsw

function CEventQuestChat_TriggerRandomChatAsw:Constructor()
  self.m_nResult = 0
  self.m_speakerChatData = DQuestChatData_Speaker:New()
end

CEventQuestChat_TriggerRandomChatAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_speakerChatData",
    "DQuestChatData_Speaker"
  }
}
_class("CEventQuestChat_CompleteReq", CCallRequestEvent)
CEventQuestChat_CompleteReq = CEventQuestChat_CompleteReq

function CEventQuestChat_CompleteReq:Constructor()
  self.m_nChatID = 0
  self.m_nStatus = 0
end

CEventQuestChat_CompleteReq._proto = {
  [1] = {"m_nChatID", "int"},
  [2] = {"m_nStatus", "int"}
}
_class("CEventQuestChat_CompleteAsw", CCallReplyEvent)
CEventQuestChat_CompleteAsw = CEventQuestChat_CompleteAsw

function CEventQuestChat_CompleteAsw:Constructor()
  self.m_nResult = 0
end

CEventQuestChat_CompleteAsw._proto = {
  [1] = {"m_nResult", "int"}
}
_class("CEventQuestChat_PushSpeakerData", CSvrPushEvent)
CEventQuestChat_PushSpeakerData = CEventQuestChat_PushSpeakerData

function CEventQuestChat_PushSpeakerData:Constructor()
  self.m_nResult = 0
  self.m_bRandom = 0
  self.m_mapQuestChatData = {}
  self.m_persistid = 0
end

CEventQuestChat_PushSpeakerData._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {"m_bRandom", "int"},
  [3] = {
    "m_mapQuestChatData",
    "map<int,DQuestChatData_Speaker>"
  },
  [4] = {
    "m_persistid",
    "int64"
  }
}
_class("CEventQuestChat_AllHistoryReq", CCallRequestEvent)
CEventQuestChat_AllHistoryReq = CEventQuestChat_AllHistoryReq

function CEventQuestChat_AllHistoryReq:Constructor()
  self.m_nSpeakerID = 0
end

CEventQuestChat_AllHistoryReq._proto = {
  [1] = {
    "m_nSpeakerID",
    "int"
  }
}
_class("CEventQuestChat_AllHistoryAsw", CCallReplyEvent)
CEventQuestChat_AllHistoryAsw = CEventQuestChat_AllHistoryAsw

function CEventQuestChat_AllHistoryAsw:Constructor()
  self.m_nResult = 0
  self.m_mapQuestChatData = {}
end

CEventQuestChat_AllHistoryAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_mapQuestChatData",
    "map<int,DQuestChatData_Speaker>"
  }
}
