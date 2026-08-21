require("message_def")
local help_petMessageDef = {
  CLSID_CEventHelpPet_InitData = 33000,
  CLSID_CEventHelpPet_SupportInfoReq = 33001,
  CLSID_CEventHelpPet_SupportInfoAsw = 33002,
  CLSID_CEventHelpPet_SupportSetReq = 33003,
  CLSID_CEventHelpPet_SupportSetAsw = 33004,
  CLSID_CEventHelpPet_HelpRefreshReq = 33005,
  CLSID_CEventHelpPet_HelpRefreshAsw = 33006,
  CLSID_CEventHelpPet_PushData = 33007,
  CLSID_CEventHelpPet_HelpListReq = 33008,
  CLSID_CEventHelpPet_HelpListAsw = 33009
}
table.append(MessageDef, help_petMessageDef)
local ErrorCode_HelpPet = {
  E_Error_HelpPet_Fail = -1,
  E_Error_HelpPet_Succ = 0,
  E_Error_HelpPet_Sql = 2,
  E_Error_HelpPet_DB = 3,
  E_Error_HelpPet_Pet = 4,
  E_Error_HelpPet_PetType = 5,
  E_Error_HelpPet_ModuleLock = 6,
  E_Error_HelpPet_RefreshLimit = 7
}
_enum("ErrorCode_HelpPet", ErrorCode_HelpPet)
_class("CEventHelpPet_InitData", CCliPushEvent)
CEventHelpPet_InitData = CEventHelpPet_InitData

function CEventHelpPet_InitData:Constructor()
  self.m_nData = 0
end

CEventHelpPet_InitData._proto = {
  [1] = {"m_nData", "int"}
}
_class("CEventHelpPet_SupportInfoReq", CCallRequestEvent)
CEventHelpPet_SupportInfoReq = CEventHelpPet_SupportInfoReq

function CEventHelpPet_SupportInfoReq:Constructor()
  self.m_nData = 0
end

CEventHelpPet_SupportInfoReq._proto = {
  [1] = {"m_nData", "int"}
}
_class("CEventHelpPet_SupportInfoAsw", CCallReplyEvent)
CEventHelpPet_SupportInfoAsw = CEventHelpPet_SupportInfoAsw

function CEventHelpPet_SupportInfoAsw:Constructor()
  self.m_nResult = 0
  self.m_mapPetSupport = {}
  self.m_listPetState = {}
  self.m_nFightTotal = 0
  self.m_nFightWeek = 0
end

CEventHelpPet_SupportInfoAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_mapPetSupport",
    "map<int,DHelpPet_PetData>"
  },
  [3] = {
    "m_listPetState",
    "list<DHelpPet_PetState>"
  },
  [4] = {
    "m_nFightTotal",
    "int"
  },
  [5] = {
    "m_nFightWeek",
    "int"
  }
}
_class("CEventHelpPet_SupportSetReq", CCallRequestEvent)
CEventHelpPet_SupportSetReq = CEventHelpPet_SupportSetReq

function CEventHelpPet_SupportSetReq:Constructor()
  self.m_nTemplateID = 0
  self.m_bAddSupport = 0
end

CEventHelpPet_SupportSetReq._proto = {
  [1] = {
    "m_nTemplateID",
    "int"
  },
  [2] = {
    "m_bAddSupport",
    "int"
  }
}
_class("CEventHelpPet_SupportSetAsw", CCallReplyEvent)
CEventHelpPet_SupportSetAsw = CEventHelpPet_SupportSetAsw

function CEventHelpPet_SupportSetAsw:Constructor()
  self.m_nResult = 0
  self.m_nPetType = 0
  self.m_supportPetData = DHelpPet_PetData:New()
end

CEventHelpPet_SupportSetAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {"m_nPetType", "int"},
  [3] = {
    "m_supportPetData",
    "DHelpPet_PetData"
  }
}
_class("CEventHelpPet_HelpRefreshReq", CCallRequestEvent)
CEventHelpPet_HelpRefreshReq = CEventHelpPet_HelpRefreshReq

function CEventHelpPet_HelpRefreshReq:Constructor()
  self.m_nPetType = 0
  self.m_nTeamID = 0
  self.m_nSelectHelpPet = 0
  self.m_from_battle_type = 1
  self.m_component_id = 0
  self.m_mission_component_id = 0
end

CEventHelpPet_HelpRefreshReq._proto = {
  [1] = {"m_nPetType", "int"},
  [2] = {"m_nTeamID", "int"},
  [3] = {
    "m_nSelectHelpPet",
    "int64"
  },
  [4] = {
    "m_from_battle_type",
    "int"
  },
  [5] = {
    "m_component_id",
    "int"
  },
  [6] = {
    "m_mission_component_id",
    "int"
  }
}
_class("CEventHelpPet_HelpRefreshAsw", CCallReplyEvent)
CEventHelpPet_HelpRefreshAsw = CEventHelpPet_HelpRefreshAsw

function CEventHelpPet_HelpRefreshAsw:Constructor()
  self.m_nResult = 0
  self.m_mapVecHelpData = {}
end

CEventHelpPet_HelpRefreshAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_mapVecHelpData",
    "map<int,list<DHelpPet_PetData>>"
  }
}
_class("CEventHelpPet_PushData", CSvrPushEvent)
CEventHelpPet_PushData = CEventHelpPet_PushData

function CEventHelpPet_PushData:Constructor()
  self.m_nResult = 0
end

CEventHelpPet_PushData._proto = {
  [1] = {"m_nResult", "int"}
}
_class("CEventHelpPet_HelpListReq", CCallRequestEvent)
CEventHelpPet_HelpListReq = CEventHelpPet_HelpListReq

function CEventHelpPet_HelpListReq:Constructor()
  self.m_nTeamID = 0
end

CEventHelpPet_HelpListReq._proto = {
  [1] = {"m_nTeamID", "int"}
}
_class("CEventHelpPet_HelpListAsw", CCallReplyEvent)
CEventHelpPet_HelpListAsw = CEventHelpPet_HelpListAsw

function CEventHelpPet_HelpListAsw:Constructor()
  self.m_nResult = 0
  self.m_mapVecHelpData = {}
end

CEventHelpPet_HelpListAsw._proto = {
  [1] = {"m_nResult", "int"},
  [2] = {
    "m_mapVecHelpData",
    "map<int,list<DHelpPet_PetData>>"
  }
}
