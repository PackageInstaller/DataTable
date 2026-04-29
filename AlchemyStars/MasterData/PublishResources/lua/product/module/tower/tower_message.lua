require("message_def")
local towerMessageDef = {
  CLSID_CEventApplyTowerInfoReq = 24000,
  CLSID_CEventApplyTowerInfoRes = 24001,
  CLSID_CEventPushTowerInfo = 24002,
  CLSID_CEventApplyTowerPassDataReq = 24003,
  CLSID_CEventApplyTowerPassDataRes = 24004,
  CLSID_CEventApplyChangeTowerFormationReq = 24005,
  CLSID_CEventApplyChangeTowerFormationRes = 24006
}
table.append(MessageDef, towerMessageDef)
local TOWER_RESULT_CODE = {
  TOWER_INVALID = -1,
  TOWER_SUCCEED = 0,
  TOWER_PlayerTowerNotOpen = 1,
  TOWER_INVALID_PET = 2,
  TOWER_FORMATION_INVALID_PETCOUNT = 3,
  TOWER_ID_INVALID = 4,
  TOWER_DB_LOAD_ERR = 5,
  TOWER_DB_SAVE_ERR = 6,
  TOWER_FORMATION_INVALID_PETTYPE = 7,
  TOWER_FORMATION_PET_REPEAT = 8,
  TOWER_TYPE_INVALID = 9,
  TOWER_FORMATION_ELEMENT_TYPE_ERR = 10,
  TOWER_INVALID_FORMATION_ID = 11,
  TOWER_FORMATION_SAME_BINDER = 12
}
_enum("TOWER_RESULT_CODE", TOWER_RESULT_CODE)
_class("CEventApplyTowerInfoReq", CCallRequestEvent)
CEventApplyTowerInfoReq = CEventApplyTowerInfoReq

function CEventApplyTowerInfoReq:Constructor()
end

CEventApplyTowerInfoReq._proto = {}
_class("CEventApplyTowerInfoRes", CCallReplyEvent)
CEventApplyTowerInfoRes = CEventApplyTowerInfoRes

function CEventApplyTowerInfoRes:Constructor()
  self.nRet = 0
  self.Data = player_tower_data:New()
end

CEventApplyTowerInfoRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "Data",
    "player_tower_data"
  }
}
_class("CEventPushTowerInfo", CSvrPushEvent)
CEventPushTowerInfo = CEventPushTowerInfo

function CEventPushTowerInfo:Constructor()
  self.Data = player_tower_data:New()
end

CEventPushTowerInfo._proto = {
  [1] = {
    "Data",
    "player_tower_data"
  }
}
_class("CEventApplyTowerPassDataReq", CCallRequestEvent)
CEventApplyTowerPassDataReq = CEventApplyTowerPassDataReq

function CEventApplyTowerPassDataReq:Constructor()
  self.nId = 0
end

CEventApplyTowerPassDataReq._proto = {
  [1] = {"nId", "int"}
}
_class("CEventApplyTowerPassDataRes", CCallReplyEvent)
CEventApplyTowerPassDataRes = CEventApplyTowerPassDataRes

function CEventApplyTowerPassDataRes:Constructor()
  self.info = {}
end

CEventApplyTowerPassDataRes._proto = {
  [1] = {
    "info",
    "list<tower_pass_info>"
  }
}
_class("CEventApplyChangeTowerFormationReq", CCallRequestEvent)
CEventApplyChangeTowerFormationReq = CEventApplyChangeTowerFormationReq

function CEventApplyChangeTowerFormationReq:Constructor()
  self.nId = 0
  self.formation_pet_list = {}
  self.formation_info = each_tower_formation_info:New()
end

CEventApplyChangeTowerFormationReq._proto = {
  [1] = {"nId", "int"},
  [2] = {
    "formation_pet_list",
    "list<int64>"
  },
  [3] = {
    "formation_info",
    "each_tower_formation_info"
  }
}
_class("CEventApplyChangeTowerFormationRes", CCallReplyEvent)
CEventApplyChangeTowerFormationRes = CEventApplyChangeTowerFormationRes

function CEventApplyChangeTowerFormationRes:Constructor()
  self.nRet = 0
  self.formation_info = tower_formation_info:New()
  self.mul_formations_info = mul_tower_formations:New()
end

CEventApplyChangeTowerFormationRes._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "formation_info",
    "tower_formation_info"
  },
  [3] = {
    "mul_formations_info",
    "mul_tower_formations"
  }
}
