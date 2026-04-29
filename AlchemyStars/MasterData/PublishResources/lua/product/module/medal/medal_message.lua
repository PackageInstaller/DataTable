require("message_def")
local medalMessageDef = {
  CLSID_CEventApplySaveMedalBoardReq = 42000,
  CLSID_CEventApplySaveMedalBoardRes = 42001,
  CLSID_CEventTakeMedalRewardReq = 42002,
  CLSID_CEventTakeMedalRewardRes = 42003,
  CLSID_CEventPushUpdateMedal = 42004
}
table.append(MessageDef, medalMessageDef)
_class("CEventApplySaveMedalBoardReq", CCallRequestEvent)
CEventApplySaveMedalBoardReq = CEventApplySaveMedalBoardReq

function CEventApplySaveMedalBoardReq:Constructor()
  self.req_medal_board_info = medal_placement_info:New()
end

CEventApplySaveMedalBoardReq._proto = {
  [1] = {
    "req_medal_board_info",
    "medal_placement_info"
  }
}
_class("CEventApplySaveMedalBoardRes", CCallReplyEvent)
CEventApplySaveMedalBoardRes = CEventApplySaveMedalBoardRes

function CEventApplySaveMedalBoardRes:Constructor()
  self.n_ret = 0
end

CEventApplySaveMedalBoardRes._proto = {
  [1] = {"n_ret", "int"}
}
_class("CEventTakeMedalRewardReq", CCallRequestEvent)
CEventTakeMedalRewardReq = CEventTakeMedalRewardReq

function CEventTakeMedalRewardReq:Constructor()
  self.item_id = 0
end

CEventTakeMedalRewardReq._proto = {
  [1] = {"item_id", "int"}
}
_class("CEventTakeMedalRewardRes", CCallReplyEvent)
CEventTakeMedalRewardRes = CEventTakeMedalRewardRes

function CEventTakeMedalRewardRes:Constructor()
  self.n_ret = 0
  self.reward_info = client_medal:New()
end

CEventTakeMedalRewardRes._proto = {
  [1] = {"n_ret", "int"},
  [2] = {
    "reward_info",
    "client_medal"
  }
}
_class("CEventPushUpdateMedal", CSvrPushEvent)
CEventPushUpdateMedal = CEventPushUpdateMedal

function CEventPushUpdateMedal:Constructor()
  self.medal_list = {}
end

CEventPushUpdateMedal._proto = {
  [1] = {
    "medal_list",
    "list<client_medal>"
  }
}
