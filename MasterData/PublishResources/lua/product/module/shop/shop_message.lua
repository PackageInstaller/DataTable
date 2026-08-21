require("message_def")
local shopMessageDef = {
  CLSID_CEventApplyAdvertisingData = 23000,
  CLSID_CEventApplyAdvertisingDataResult = 23001,
  CLSID_CEventApplyMarketData = 23002,
  CLSID_CEventApplyMarketDataResult = 23003,
  CLSID_CEventApplyRefreshMarketData = 23004,
  CLSID_CEventApplyRefreshMarketDataResult = 23005,
  CLSID_CEventBuyItem = 23006,
  CLSID_CEventBuyItemResult = 23007,
  CLSID_CEventDiamondExchangeGlow = 23008,
  CLSID_CEventDiamondExchangeGlowResult = 23009,
  CLSID_CEventTakeFurnitureReward = 23010,
  CLSID_CEventTakeFurnitureRewardResult = 23011,
  CLSID_CEventGlowExchangeFurnitureCoin = 23012,
  CLSID_CEventGlowExchangeFurnitureCoinResult = 23013,
  CLSID_CEventPushShopConfig = 23014,
  CLSID_CEventApplyPayMarketData = 23015,
  CLSID_CEventApplyPayMarketDataResult = 23016,
  CLSID_CEventPushDiamondData = 23017,
  CLSID_CEventApplyGiftMarketData = 23018,
  CLSID_CEventApplyGiftMarketDataResult = 23019,
  CLSID_CEventBuyGift = 23020,
  CLSID_CEventBuyGiftResult = 23021,
  CLSID_CEventReqExchangePhyInfo = 23022,
  CLSID_CEventReplyExchangePhyInfo = 23023,
  CLSID_CEventReqExchangePhyPoint = 23024,
  CLSID_CEventReplyExchangePhyPoint = 23025,
  CLSID_CEventApplySkinMarketData = 23026,
  CLSID_CEventApplySkinMarketDataResult = 23027,
  CLSID_CEventBuyPetSkin = 23028,
  CLSID_CEventBuyPetSkinResult = 23029,
  CLSID_CEventCancelGoodNewMark = 23030,
  CLSID_CEventPushCommonTimeIds = 23031
}
table.append(MessageDef, shopMessageDef)
local SHOP_CODE = {
  SHOP_SUCCESS = 0,
  SHOP_CONFIG_ERROR = 1,
  SHOP_SERVER_RETURN_ERROR = 2,
  SHOP_GOODS_ID_ERROR = 3,
  SHOP_GOODS_SELLED_OUT = 4,
  SHOP_ERROR_PRICE = 5,
  SHOP_DONNOT_HAVE_DISCOUNT = 6,
  SHOP_ERROR_DISCOUNT = 7,
  SHOP_CURRENCY_TYPE_ERROR = 8,
  SHOP_CURRENCY_NOT_ENOUGH = 9,
  SHOP_EXCEED_MAX_REFRESH_COUNT = 10,
  SHOP_SHOPTYPE_ERROR = 11,
  SHOP_BUY_COUNT_INVILID = 12,
  SHOP_HAVENT_MARKET = 13,
  SHOP_EXCHANGE_RATE_ERROR = 14,
  SHOP_MIDAS_COST_ERROR = 15,
  SHOP_BUY_GIFT_ID_ERROR = 16,
  SHOP_BUY_GIFT_ID_ALREADY_DELETE_CFG = 17,
  SHOP_GIFT_MAX_DAY_LIMIT = 18,
  SHOP_BE_MIDAS_DIRECT_GOODS = 19,
  SHOP_MIDAS_PRESENT_DIAMOND_ERROR = 20,
  SHOP_EXCHANGE_PHY_NO_TIMES = 21,
  SHOP_AlREADY_PASSED_DOWN_LIMIT = 22,
  SHOP_UNREACH_SHOW_TIME = 23,
  SHOP_ITEM_REPEAT_GOT_ERROR = 24,
  SHOP_COMMON_TIME_LOCK_ERROR = 25,
  SHOP_COMMON_TIME_EXPIRE_ERROR = 26,
  SHOP_BATTLEPASS_ERROE = 27
}
_enum("SHOP_CODE", SHOP_CODE)
_class("CEventApplyAdvertisingData", CCallRequestEvent)
CEventApplyAdvertisingData = CEventApplyAdvertisingData

function CEventApplyAdvertisingData:Constructor()
end

CEventApplyAdvertisingData._proto = {}
_class("CEventApplyAdvertisingDataResult", CCallReplyEvent)
CEventApplyAdvertisingDataResult = CEventApplyAdvertisingDataResult

function CEventApplyAdvertisingDataResult:Constructor()
  self.ret = 0
  self.advertising_data = {}
  self.month_card_list = {}
  self.market_config = {}
end

CEventApplyAdvertisingDataResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "advertising_data",
    "map<int,int>"
  },
  [3] = {
    "month_card_list",
    "list<MonthGiftGoodsInfo>"
  },
  [4] = {
    "market_config",
    "map<int,map<int,string>>"
  }
}
_class("CEventApplyMarketData", CCallRequestEvent)
CEventApplyMarketData = CEventApplyMarketData

function CEventApplyMarketData:Constructor()
  self.market_type = 0
end

CEventApplyMarketData._proto = {
  [1] = {
    "market_type",
    "int"
  }
}
_class("CEventApplyMarketDataResult", CCallReplyEvent)
CEventApplyMarketDataResult = CEventApplyMarketDataResult

function CEventApplyMarketDataResult:Constructor()
  self.ret = 0
  self.refresh_leave_second = 0
  self.update_data = false
  self.market_data = MarketInfo:New()
  self.market_config = {}
end

CEventApplyMarketDataResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "refresh_leave_second",
    "time"
  },
  [3] = {
    "update_data",
    "bool"
  },
  [4] = {
    "market_data",
    "MarketInfo"
  },
  [5] = {
    "market_config",
    "map<int,map<int,int>>"
  }
}
_class("CEventApplyRefreshMarketData", CCallRequestEvent)
CEventApplyRefreshMarketData = CEventApplyRefreshMarketData

function CEventApplyRefreshMarketData:Constructor()
  self.market_type = 1
end

CEventApplyRefreshMarketData._proto = {
  [1] = {
    "market_type",
    "int"
  }
}
_class("CEventApplyRefreshMarketDataResult", CCallReplyEvent)
CEventApplyRefreshMarketDataResult = CEventApplyRefreshMarketDataResult

function CEventApplyRefreshMarketDataResult:Constructor()
  self.ret = 0
  self.market_data = MarketInfo:New()
  self.market_config = {}
  self.leave_refresh_time = 0
end

CEventApplyRefreshMarketDataResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "market_data",
    "MarketInfo"
  },
  [3] = {
    "market_config",
    "map<int,map<int,int>>"
  },
  [4] = {
    "leave_refresh_time",
    "time"
  }
}
_class("CEventBuyItem", CCallRequestEvent)
CEventBuyItem = CEventBuyItem

function CEventBuyItem:Constructor()
  self.market_type = 0
  self.goods_id = 0
  self.buy_num = 0
  self.currency_type = 0
  self.selling_price = 0
  self.discount = 0
  self.ids = {}
end

CEventBuyItem._proto = {
  [1] = {
    "market_type",
    "int"
  },
  [2] = {"goods_id", "int"},
  [3] = {"buy_num", "int"},
  [4] = {
    "currency_type",
    "int"
  },
  [5] = {
    "selling_price",
    "int"
  },
  [6] = {"discount", "float"},
  [7] = {
    "ids",
    "list<EventBuyItemOnce>"
  }
}
_class("CEventBuyItemResult", CCallReplyEvent)
CEventBuyItemResult = CEventBuyItemResult

function CEventBuyItemResult:Constructor()
  self.ret = 0
end

CEventBuyItemResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventDiamondExchangeGlow", CCallRequestEvent)
CEventDiamondExchangeGlow = CEventDiamondExchangeGlow

function CEventDiamondExchangeGlow:Constructor()
  self.diamond_count = 0
  self.exchange_glow_count = 0
end

CEventDiamondExchangeGlow._proto = {
  [1] = {
    "diamond_count",
    "uint64"
  },
  [2] = {
    "exchange_glow_count",
    "uint64"
  }
}
_class("CEventDiamondExchangeGlowResult", CCallReplyEvent)
CEventDiamondExchangeGlowResult = CEventDiamondExchangeGlowResult

function CEventDiamondExchangeGlowResult:Constructor()
  self.ret = 0
end

CEventDiamondExchangeGlowResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventTakeFurnitureReward", CCallRequestEvent)
CEventTakeFurnitureReward = CEventTakeFurnitureReward

function CEventTakeFurnitureReward:Constructor()
  self.shop_id = 0
  self.good_id = 0
end

CEventTakeFurnitureReward._proto = {
  [1] = {"shop_id", "int"},
  [2] = {"good_id", "int"}
}
_class("CEventTakeFurnitureRewardResult", CCallReplyEvent)
CEventTakeFurnitureRewardResult = CEventTakeFurnitureRewardResult

function CEventTakeFurnitureRewardResult:Constructor()
  self.ret = 0
end

CEventTakeFurnitureRewardResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventGlowExchangeFurnitureCoin", CCallRequestEvent)
CEventGlowExchangeFurnitureCoin = CEventGlowExchangeFurnitureCoin

function CEventGlowExchangeFurnitureCoin:Constructor()
  self.glow_count = 0
  self.exchange_coin_count = 0
end

CEventGlowExchangeFurnitureCoin._proto = {
  [1] = {"glow_count", "uint64"},
  [2] = {
    "exchange_coin_count",
    "uint64"
  }
}
_class("CEventGlowExchangeFurnitureCoinResult", CCallReplyEvent)
CEventGlowExchangeFurnitureCoinResult = CEventGlowExchangeFurnitureCoinResult

function CEventGlowExchangeFurnitureCoinResult:Constructor()
  self.ret = 0
end

CEventGlowExchangeFurnitureCoinResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventPushShopConfig", CSvrPushEvent)
CEventPushShopConfig = CEventPushShopConfig

function CEventPushShopConfig:Constructor()
  self.all_shop_config = AllShopConfig:New()
end

CEventPushShopConfig._proto = {
  [1] = {
    "all_shop_config",
    "AllShopConfig"
  }
}
_class("CEventApplyPayMarketData", CCallRequestEvent)
CEventApplyPayMarketData = CEventApplyPayMarketData

function CEventApplyPayMarketData:Constructor()
end

CEventApplyPayMarketData._proto = {}
_class("CEventApplyPayMarketDataResult", CCallReplyEvent)
CEventApplyPayMarketDataResult = CEventApplyPayMarketDataResult

function CEventApplyPayMarketDataResult:Constructor()
  self.ret = 0
  self.market_data = MarketInfo:New()
  self.market_config = {}
  self.month_card_list = {}
  self.gift_market_config = {}
end

CEventApplyPayMarketDataResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "market_data",
    "MarketInfo"
  },
  [3] = {
    "market_config",
    "map<int,map<int,string>>"
  },
  [4] = {
    "month_card_list",
    "list<MonthGiftGoodsInfo>"
  },
  [5] = {
    "gift_market_config",
    "map<int,map<int,string>>"
  }
}
_class("CEventPushDiamondData", CSvrPushEvent)
CEventPushDiamondData = CEventPushDiamondData

function CEventPushDiamondData:Constructor()
  self.diamond_count = 0
  self.free_diamond_count = 0
end

CEventPushDiamondData._proto = {
  [1] = {
    "diamond_count",
    "uint64"
  },
  [2] = {
    "free_diamond_count",
    "uint64"
  }
}
_class("CEventApplyGiftMarketData", CCallRequestEvent)
CEventApplyGiftMarketData = CEventApplyGiftMarketData

function CEventApplyGiftMarketData:Constructor()
end

CEventApplyGiftMarketData._proto = {}
_class("CEventApplyGiftMarketDataResult", CCallReplyEvent)
CEventApplyGiftMarketDataResult = CEventApplyGiftMarketDataResult

function CEventApplyGiftMarketDataResult:Constructor()
  self.ret = 0
  self.market_data = GiftMarketInfo:New()
  self.market_config = {}
end

CEventApplyGiftMarketDataResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "market_data",
    "GiftMarketInfo"
  },
  [3] = {
    "market_config",
    "map<int,map<int,string>>"
  }
}
_class("CEventBuyGift", CCallRequestEvent)
CEventBuyGift = CEventBuyGift

function CEventBuyGift:Constructor()
  self.gift_id = 0
  self.pay_id = 0
end

CEventBuyGift._proto = {
  [1] = {"gift_id", "int"},
  [2] = {"pay_id", "int"}
}
_class("CEventBuyGiftResult", CCallReplyEvent)
CEventBuyGiftResult = CEventBuyGiftResult

function CEventBuyGiftResult:Constructor()
  self.ret = 0
end

CEventBuyGiftResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventReqExchangePhyInfo", CCallRequestEvent)
CEventReqExchangePhyInfo = CEventReqExchangePhyInfo

function CEventReqExchangePhyInfo:Constructor()
end

CEventReqExchangePhyInfo._proto = {}
_class("CEventReplyExchangePhyInfo", CCallReplyEvent)
CEventReplyExchangePhyInfo = CEventReplyExchangePhyInfo

function CEventReplyExchangePhyInfo:Constructor()
  self.ret = 0
  self.left_info = ExchangePhyState:New()
  self.right_info = ExchangePhyState:New()
  self.valid_left_infos = {}
end

CEventReplyExchangePhyInfo._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "left_info",
    "ExchangePhyState"
  },
  [3] = {
    "right_info",
    "ExchangePhyState"
  },
  [4] = {
    "valid_left_infos",
    "list<ExchangePhyState>"
  }
}
_class("CEventReqExchangePhyPoint", CCallRequestEvent)
CEventReqExchangePhyPoint = CEventReqExchangePhyPoint

function CEventReqExchangePhyPoint:Constructor()
  self.exchange_type = 0
  self.count = 0
end

CEventReqExchangePhyPoint._proto = {
  [1] = {
    "exchange_type",
    "int"
  },
  [2] = {"count", "int"}
}
_class("CEventReplyExchangePhyPoint", CCallReplyEvent)
CEventReplyExchangePhyPoint = CEventReplyExchangePhyPoint

function CEventReplyExchangePhyPoint:Constructor()
  self.ret = 0
  self.item_cost = 0
end

CEventReplyExchangePhyPoint._proto = {
  [1] = {"ret", "int"},
  [2] = {"item_cost", "int"}
}
_class("CEventApplySkinMarketData", CCallRequestEvent)
CEventApplySkinMarketData = CEventApplySkinMarketData

function CEventApplySkinMarketData:Constructor()
end

CEventApplySkinMarketData._proto = {}
_class("CEventApplySkinMarketDataResult", CCallReplyEvent)
CEventApplySkinMarketDataResult = CEventApplySkinMarketDataResult

function CEventApplySkinMarketDataResult:Constructor()
  self.ret = 0
  self.data = {}
  self.market_config = {}
  self.new_mark_goods = {}
end

CEventApplySkinMarketDataResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "data",
    "map<int,SkinMarketGoodsInfo>"
  },
  [3] = {
    "market_config",
    "map<int,map<int,string>>"
  },
  [4] = {
    "new_mark_goods",
    "list<int>"
  }
}
_class("CEventBuyPetSkin", CCallRequestEvent)
CEventBuyPetSkin = CEventBuyPetSkin

function CEventBuyPetSkin:Constructor()
  self.goods_id = 0
end

CEventBuyPetSkin._proto = {
  [1] = {"goods_id", "int"}
}
_class("CEventBuyPetSkinResult", CCallReplyEvent)
CEventBuyPetSkinResult = CEventBuyPetSkinResult

function CEventBuyPetSkinResult:Constructor()
  self.ret = 0
end

CEventBuyPetSkinResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventCancelGoodNewMark", CCliPushEvent)
CEventCancelGoodNewMark = CEventCancelGoodNewMark

function CEventCancelGoodNewMark:Constructor()
  self.market_type = 0
  self.goods_id = 0
end

CEventCancelGoodNewMark._proto = {
  [1] = {
    "market_type",
    "int"
  },
  [2] = {"goods_id", "int"}
}
_class("CEventPushCommonTimeIds", CSvrPushEvent)
CEventPushCommonTimeIds = CEventPushCommonTimeIds

function CEventPushCommonTimeIds:Constructor()
  self.data = {}
end

CEventPushCommonTimeIds._proto = {
  [1] = {
    "data",
    "map<int,MonthGiftGoodsInfo>"
  }
}
