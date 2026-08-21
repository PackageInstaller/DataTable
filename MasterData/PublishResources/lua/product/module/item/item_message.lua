require("message_def")
local itemMessageDef = {
  CLSID_CEventTaskSubmitItem = 9000,
  CLSID_CEventTaskSubmitItemResult = 9001,
  CLSID_CEventMobileUseItem = 9002,
  CLSID_CEventMobileUseItemResult = 9003,
  CLSID_CEventMobileSellItem = 9004,
  CLSID_CEventMobileSellItemResult = 9005,
  CLSID_CEventChooseGift = 9006,
  CLSID_CEventChooseGiftResult = 9007,
  CLSID_CEventMobileNotifyItemInfoChange = 9008,
  CLSID_CEVentNotifyOpenGift = 9009,
  CLSID_CEventMobileNotifyItemConverChange = 9010,
  CLSID_CEventMobileItemObtainFlag = 9011,
  CLSID_CEventMobileItemObtainFlagResult = 9012,
  CLSID_CEventItemNewOverlayFlag = 9013,
  CLSID_CEventItemNewOverlayFlagResult = 9014,
  CLSID_CEventGetItemQuest = 9015,
  CLSID_CEventGetItemResult = 9016,
  CLSID_CEventItemUpgradeReq = 9017,
  CLSID_CEventItemUpgradeRes = 9018,
  CLSID_CEventItemDecomposeReq = 9019,
  CLSID_CEventItemDecomposeRes = 9020,
  CLSID_CEventCommonBreakThoughExchangeReq = 9021,
  CLSID_CEventCommonBreakThoughExchangeRes = 9022,
  CLSID_CEventMobileItemListClearFlag = 9023,
  CLSID_CEventMobileItemListClearFlagResult = 9024,
  CLSID_CEventChessItemReq = 9025,
  CLSID_CEventChessItemResult = 9026,
  CLSID_CEventChessDataReq = 9027,
  CLSID_CEventChessDataResult = 9028
}
table.append(MessageDef, itemMessageDef)
local ITEM_RESULT_CODE = {
  ITEM_SUCCEED = 0,
  ITEM_FAILED = 1,
  ITEM_NOT_EXIST = 2,
  ITEM_TEMPLATE_NOT_EXIST = 3,
  ITEM_CANNOT_USE = 4,
  ITEM_NOT_ENOUGH = 5,
  ITEM_INVALID_COUNT = 6,
  ITEM_CAN_NOT_SELL = 7,
  ITEM_CHOOSE_GIFT_ID = 8,
  ITEM_INVALID_EFFECT = 9,
  ITEM_MAX_LEVEL = 10,
  ITEM_CANNOT_DECOMPOSE = 11,
  ITEM_INVALID_USEFULE_TIME = 12
}
_enum("ITEM_RESULT_CODE", ITEM_RESULT_CODE)
_class("CEventTaskSubmitItem", CCallRequestEvent)
CEventTaskSubmitItem = CEventTaskSubmitItem

function CEventTaskSubmitItem:Constructor()
  self.items = {}
end

CEventTaskSubmitItem._proto = {
  [1] = {
    "items",
    "list<ItemAsset>"
  }
}
_class("CEventTaskSubmitItemResult", CCallReplyEvent)
CEventTaskSubmitItemResult = CEventTaskSubmitItemResult

function CEventTaskSubmitItemResult:Constructor()
  self.nRet = 0
end

CEventTaskSubmitItemResult._proto = {
  [1] = {"nRet", "int"}
}
_class("CEventMobileUseItem", CCallRequestEvent)
CEventMobileUseItem = CEventMobileUseItem

function CEventMobileUseItem:Constructor()
  self.use_param = UseItemParameter:New()
end

CEventMobileUseItem._proto = {
  [1] = {
    "use_param",
    "UseItemParameter"
  }
}
_class("CEventMobileUseItemResult", CCallReplyEvent)
CEventMobileUseItemResult = CEventMobileUseItemResult

function CEventMobileUseItemResult:Constructor()
  self.nRet = 0
  self.m_reward_list = {}
end

CEventMobileUseItemResult._proto = {
  [1] = {"nRet", "int"},
  [2] = {
    "m_reward_list",
    "list<RoleAsset>"
  }
}
_class("CEventMobileSellItem", CCallRequestEvent)
CEventMobileSellItem = CEventMobileSellItem

function CEventMobileSellItem:Constructor()
  self.m_item_pstid = 0
  self.m_num = 0
end

CEventMobileSellItem._proto = {
  [1] = {
    "m_item_pstid",
    "int64"
  },
  [2] = {"m_num", "int64"}
}
_class("CEventMobileSellItemResult", CCallReplyEvent)
CEventMobileSellItemResult = CEventMobileSellItemResult

function CEventMobileSellItemResult:Constructor()
  self.ret = 0
  self.m_reward_list = {}
end

CEventMobileSellItemResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "m_reward_list",
    "list<RoleAsset>"
  }
}
_class("CEventChooseGift", CCallRequestEvent)
CEventChooseGift = CEventChooseGift

function CEventChooseGift:Constructor()
  self.m_item_pstid = 0
  self.m_choose_id = 0
  self.m_use_count = 0
end

CEventChooseGift._proto = {
  [1] = {
    "m_item_pstid",
    "int64"
  },
  [2] = {
    "m_choose_id",
    "int"
  },
  [3] = {
    "m_use_count",
    "int"
  }
}
_class("CEventChooseGiftResult", CCallReplyEvent)
CEventChooseGiftResult = CEventChooseGiftResult

function CEventChooseGiftResult:Constructor()
  self.ret = 0
end

CEventChooseGiftResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventMobileNotifyItemInfoChange", CSvrPushEvent)
CEventMobileNotifyItemInfoChange = CEventMobileNotifyItemInfoChange

function CEventMobileNotifyItemInfoChange:Constructor()
  self.m_update_list = {}
  self.m_delete_list = {}
  self.not_enough = {}
end

CEventMobileNotifyItemInfoChange._proto = {
  [1] = {
    "m_update_list",
    "list<item_data_info>"
  },
  [2] = {
    "m_delete_list",
    "list<int64>"
  },
  [3] = {
    "not_enough",
    "map<int,int64>"
  }
}
_class("CEVentNotifyOpenGift", CSvrPushEvent)
CEVentNotifyOpenGift = CEVentNotifyOpenGift

function CEVentNotifyOpenGift:Constructor()
  self.m_gift_id = 0
  self.m_reward_list = {}
end

CEVentNotifyOpenGift._proto = {
  [1] = {"m_gift_id", "int"},
  [2] = {
    "m_reward_list",
    "list<RoleAsset>"
  }
}
_class("CEventMobileNotifyItemConverChange", CSvrPushEvent)
CEventMobileNotifyItemConverChange = CEventMobileNotifyItemConverChange

function CEventMobileNotifyItemConverChange:Constructor()
  self.m_update_list = {}
end

CEventMobileNotifyItemConverChange._proto = {
  [1] = {
    "m_update_list",
    "map<int,int>"
  }
}
_class("CEventMobileItemObtainFlag", CCallRequestEvent)
CEventMobileItemObtainFlag = CEventMobileItemObtainFlag

function CEventMobileItemObtainFlag:Constructor()
  self.item_pstid = 0
  self.flag = 0
  self.value = 0
end

CEventMobileItemObtainFlag._proto = {
  [1] = {"item_pstid", "int64"},
  [2] = {"flag", "int"},
  [3] = {"value", "int"}
}
_class("CEventMobileItemObtainFlagResult", CCallReplyEvent)
CEventMobileItemObtainFlagResult = CEventMobileItemObtainFlagResult

function CEventMobileItemObtainFlagResult:Constructor()
  self.ret = 0
end

CEventMobileItemObtainFlagResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventItemNewOverlayFlag", CCallRequestEvent)
CEventItemNewOverlayFlag = CEventItemNewOverlayFlag

function CEventItemNewOverlayFlag:Constructor()
  self.item_pstid = 0
  self.flag = 0
  self.value = 0
end

CEventItemNewOverlayFlag._proto = {
  [1] = {"item_pstid", "int64"},
  [2] = {"flag", "int"},
  [3] = {"value", "int"}
}
_class("CEventItemNewOverlayFlagResult", CCallReplyEvent)
CEventItemNewOverlayFlagResult = CEventItemNewOverlayFlagResult

function CEventItemNewOverlayFlagResult:Constructor()
  self.ret = 0
end

CEventItemNewOverlayFlagResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventGetItemQuest", CCallRequestEvent)
CEventGetItemQuest = CEventGetItemQuest

function CEventGetItemQuest:Constructor()
  self.item_type = 0
end

CEventGetItemQuest._proto = {
  [1] = {"item_type", "int"}
}
_class("CEventGetItemResult", CCallReplyEvent)
CEventGetItemResult = CEventGetItemResult

function CEventGetItemResult:Constructor()
  self.item_info = {}
end

CEventGetItemResult._proto = {
  [1] = {
    "item_info",
    "map<int,int64>"
  }
}
_class("CEventItemUpgradeReq", CCallRequestEvent)
CEventItemUpgradeReq = CEventItemUpgradeReq

function CEventItemUpgradeReq:Constructor()
  self.item_id = 0
end

CEventItemUpgradeReq._proto = {
  [1] = {"item_id", "int"}
}
_class("CEventItemUpgradeRes", CCallReplyEvent)
CEventItemUpgradeRes = CEventItemUpgradeRes

function CEventItemUpgradeRes:Constructor()
  self.ret = 0
end

CEventItemUpgradeRes._proto = {
  [1] = {"ret", "int"}
}
_class("CEventItemDecomposeReq", CCallRequestEvent)
CEventItemDecomposeReq = CEventItemDecomposeReq

function CEventItemDecomposeReq:Constructor()
  self.item_id = 0
  self.item_count = 0
end

CEventItemDecomposeReq._proto = {
  [1] = {"item_id", "int"},
  [2] = {"item_count", "int"}
}
_class("CEventItemDecomposeRes", CCallReplyEvent)
CEventItemDecomposeRes = CEventItemDecomposeRes

function CEventItemDecomposeRes:Constructor()
  self.ret = 0
end

CEventItemDecomposeRes._proto = {
  [1] = {"ret", "int"}
}
_class("CEventCommonBreakThoughExchangeReq", CCallRequestEvent)
CEventCommonBreakThoughExchangeReq = CEventCommonBreakThoughExchangeReq

function CEventCommonBreakThoughExchangeReq:Constructor()
  self.src_item_id = 0
  self.src_item_count = 0
  self.dest_item_id = 0
  self.dest_item_count = 0
end

CEventCommonBreakThoughExchangeReq._proto = {
  [1] = {
    "src_item_id",
    "int"
  },
  [2] = {
    "src_item_count",
    "int"
  },
  [3] = {
    "dest_item_id",
    "int"
  },
  [4] = {
    "dest_item_count",
    "int"
  }
}
_class("CEventCommonBreakThoughExchangeRes", CCallReplyEvent)
CEventCommonBreakThoughExchangeRes = CEventCommonBreakThoughExchangeRes

function CEventCommonBreakThoughExchangeRes:Constructor()
  self.ret = 0
end

CEventCommonBreakThoughExchangeRes._proto = {
  [1] = {"ret", "int"}
}
_class("CEventMobileItemListClearFlag", CCallRequestEvent)
CEventMobileItemListClearFlag = CEventMobileItemListClearFlag

function CEventMobileItemListClearFlag:Constructor()
  self.item_psitd_list = {}
  self.flag = 0
end

CEventMobileItemListClearFlag._proto = {
  [1] = {
    "item_psitd_list",
    "list<int64>"
  },
  [2] = {"flag", "int"}
}
_class("CEventMobileItemListClearFlagResult", CCallReplyEvent)
CEventMobileItemListClearFlagResult = CEventMobileItemListClearFlagResult

function CEventMobileItemListClearFlagResult:Constructor()
  self.ret = 0
end

CEventMobileItemListClearFlagResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventChessItemReq", CCallRequestEvent)
CEventChessItemReq = CEventChessItemReq

function CEventChessItemReq:Constructor()
  self.cfg_id = 0
end

CEventChessItemReq._proto = {
  [1] = {"cfg_id", "int"}
}
_class("CEventChessItemResult", CCallReplyEvent)
CEventChessItemResult = CEventChessItemResult

function CEventChessItemResult:Constructor()
  self.ret = 0
end

CEventChessItemResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventChessDataReq", CCallRequestEvent)
CEventChessDataReq = CEventChessDataReq

function CEventChessDataReq:Constructor()
end

CEventChessDataReq._proto = {}
_class("CEventChessDataResult", CCallReplyEvent)
CEventChessDataResult = CEventChessDataResult

function CEventChessDataResult:Constructor()
  self.cfg_id = 0
end

CEventChessDataResult._proto = {
  [1] = {"cfg_id", "int"}
}
