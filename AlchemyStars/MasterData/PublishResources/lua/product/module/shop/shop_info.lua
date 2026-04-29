local MarketType = {
  Shop_Error = 0,
  Shop_BlackMarket = 1,
  Shop_MysteryMarket = 2,
  Shop_PayMarket = 3,
  Shop_GiftMarket = 4,
  Shop_XingZuan = 5,
  Shop_HuiYao = 6,
  Shop_GuangPo = 7,
  Shop_SkinMarket = 8,
  Shop_HongPiao = 9,
  Shop_Furniture = 10,
  Shop_Furniture_Precious = 11,
  Shop_WorldBoss = 12,
  Shop_BattlePass = 13,
  Shop_Season = 100,
  Shop_CampaignMarket = 100100
}
_enum("MarketType", MarketType)
local RecommendType = {RecommendType_CountLimit = 1, RecommendType_TimeLimit = 2}
_enum("RecommendType", RecommendType)
local ShopGiftType = {
  SGT_NormalGift = 1,
  SGT_MonthCard = 2,
  SGT_BattlePassGift = 3,
  SGT_WeekCard = 4,
  SGT_LevelGift = 5,
  SGT_RechargeGift = 6,
  SGT_CommonTime = 10
}
_enum("ShopGiftType", ShopGiftType)
local PageType = {
  PageType_NewPreferential = 1,
  PageType_MonthMembershipCard = 2,
  PageType_ChoicenessGift = 3,
  PageType_FashionClothes = 4,
  PageType_Furniture = 5
}
_enum("PageType", PageType)
local ExchangePhyPointType = {EPPT_LEFT = 1, EPPT_RIGHT = 2}
_enum("ExchangePhyPointType", ExchangePhyPointType)
local SpecialNum = {
  FreeGiftSaleType = 0,
  NeedPayMoney = 888,
  EitherDiamondOrMoney = 8889,
  MysteryGoodsUnlimitedNum = 888888888
}
_enum("SpecialNum", SpecialNum)
local ConfigKey = {
  ConfigKey_ID = 1,
  ConfigKey_ItemId = 2,
  ConfigKey_ItemCount = 3,
  ConfigKey_SaleType = 4,
  ConfigKey_RawPrice = 5,
  ConfigKey_NowPrice = 6,
  ConfigKey_Discount = 7,
  ConfigKey_SaleNum = 8,
  ConfigKey_SaleTag = 9,
  ConfigKey_MidasItemId = 10,
  ConfigKey_FirstPresentCount = 11,
  ConfigKey_FixedPresentCount = 12,
  ConfigKey_ShowBeginTime = 13,
  ConfigKey_ShowEndTime = 14,
  ConfigKey_RefreshMethod = 15,
  ConfigKey_FirstRefreshDate = 16,
  ConfigKey_RefreshInterval = 17,
  ConfigKey_DirectAssetList = 18,
  ConfigKey_CycleAcceptAssetList = 19,
  ConfigKey_ShopGiftType = 20,
  ConfigKey_LimitDay = 21,
  ConfigKey_ProposeGift = 22,
  ConfigKey_LevelCondition = 23,
  ConfigKey_AcceptUseFullLife = 24,
  ConfigKey_BattleType = 25,
  ConfigKey_ConvertType = 26,
  ConfigKey_ConvertPrice = 27,
  ConfigKey_IsAddBagNum = 50
}
_enum("ConfigKey", ConfigKey)
local RefreshMethod = {
  RM_ByWeek = 1,
  RM_ByMonth = 2,
  RM_CycleRefresh = 3,
  RM_OneOff = 4
}
_enum("RefreshMethod", RefreshMethod)
local CommonShopType = {
  CommonShopType_Skin = 1,
  CommonShopType_Campaign = 2,
  CommonShopType_SeniorSkin = 3
}
_enum("CommonShopType", CommonShopType)
_class("GoodsInfo", Object)
GoodsInfo = GoodsInfo

function GoodsInfo:Constructor()
  self.goods_id = 0
  self.selled_num = 0
end

GoodsInfo._proto = {
  [1] = {"goods_id", "int"},
  [2] = {"selled_num", "int"}
}
local GiftLockStatus = {GLS_LevelLock = 1, GLS_PreposeLock = 16}
_enum("GiftLockStatus", GiftLockStatus)
local FurnitureShopType = {
  FRN_Set = 1,
  FRN_Components = 2,
  FRN_Precious = 3
}
_enum("FurnitureShopType", FurnitureShopType)
_class("MonthGiftGoodsInfo", Object)
MonthGiftGoodsInfo = MonthGiftGoodsInfo

function MonthGiftGoodsInfo:Constructor()
  self.gift_id = 0
  self.effect_daynum = 0
  self.take_effect_day = 0
  self.selled_num = 0
  self.last_refresh_time = 0
  self.deadline_time = 0
  self.month_card_days = 0
  self.gift_lock_status = 0
  self.deadline_timestamp = 0
end

MonthGiftGoodsInfo._proto = {
  [1] = {"gift_id", "int"},
  [2] = {
    "effect_daynum",
    "int"
  },
  [3] = {
    "take_effect_day",
    "int"
  },
  [4] = {"selled_num", "int"},
  [5] = {
    "last_refresh_time",
    "time"
  },
  [6] = {
    "deadline_time",
    "time"
  },
  [7] = {
    "month_card_days",
    "int"
  },
  [8] = {
    "gift_lock_status",
    "int"
  },
  [9] = {
    "deadline_timestamp",
    "time"
  }
}
_class("SkinMarketGoodsInfo", Object)
SkinMarketGoodsInfo = SkinMarketGoodsInfo

function SkinMarketGoodsInfo:Constructor()
  self.goodid = 0
  self.endtime = 0
  self.saletype = 0
  self.price = 0
  self.skin_id = 0
  self.new_price = 0
  self.discount = 0
end

SkinMarketGoodsInfo._proto = {
  [1] = {"goodid", "int"},
  [2] = {"endtime", "time"},
  [3] = {"saletype", "int"},
  [4] = {"price", "int"},
  [5] = {"skin_id", "int"},
  [6] = {"new_price", "int"},
  [7] = {"discount", "int"}
}
_class("MarketInfo", Object)
MarketInfo = MarketInfo

function MarketInfo:Constructor()
  self.market_type = 0
  self.cur_level_id = 0
  self.last_auto_refresh_time = 0
  self.last_apply_refresh_time = 0
  self.today_refreshed_count = 0
  self.goods = {}
  self.version = 0
  self.old_selling_goods = {}
  self.new_mark_goods = {}
end

MarketInfo._proto = {
  [1] = {
    "market_type",
    "int"
  },
  [2] = {
    "cur_level_id",
    "int"
  },
  [3] = {
    "last_auto_refresh_time",
    "time"
  },
  [4] = {
    "last_apply_refresh_time",
    "time"
  },
  [5] = {
    "today_refreshed_count",
    "int"
  },
  [6] = {
    "goods",
    "list<GoodsInfo>"
  },
  [7] = {"version", "int"},
  [8] = {
    "old_selling_goods",
    "list<int>"
  },
  [9] = {
    "new_mark_goods",
    "list<int>"
  }
}
_class("GiftMarketInfo", Object)
GiftMarketInfo = GiftMarketInfo

function GiftMarketInfo:Constructor()
  self.last_accept_gift_time = 0
  self.goods = {}
  self.old_selling_goods = {}
  self.new_mark_goods = {}
end

GiftMarketInfo._proto = {
  [1] = {
    "last_accept_gift_time",
    "time"
  },
  [2] = {
    "goods",
    "list<MonthGiftGoodsInfo>"
  },
  [3] = {
    "old_selling_goods",
    "list<int>"
  },
  [4] = {
    "new_mark_goods",
    "list<int>"
  }
}
_class("all_market_data", Object)
all_market_data = all_market_data

function all_market_data:Constructor()
  self.pstid = 0
  self.market_datas = {}
  self.month_card_data = GiftMarketInfo:New()
end

all_market_data._proto = {
  [1] = {"pstid", "int64"},
  [2] = {
    "market_datas",
    "map<int,MarketInfo>"
  },
  [3] = {
    "month_card_data",
    "GiftMarketInfo"
  }
}
_class("AllShopConfig", Object)
AllShopConfig = AllShopConfig

function AllShopConfig:Constructor()
  self.mystery_market_config = {}
  self.black_market_config = {}
  self.xingzuan_market_config = {}
  self.yaojing_market_config = {}
  self.guangpo_market_config = {}
  self.pay_market_config = {}
  self.gift_market_config = {}
  self.skin_market_config = {}
  self.hongpiao_market_config = {}
  self.furniture_market_config = {}
  self.furniture_precious_market_config = {}
  self.season_market_config = {}
  self.battlepass_market_config = {}
end

AllShopConfig._proto = {
  [1] = {
    "mystery_market_config",
    "map<int,map<int,int>>"
  },
  [2] = {
    "black_market_config",
    "map<int,map<int,int>>"
  },
  [3] = {
    "xingzuan_market_config",
    "map<int,map<int,int>>"
  },
  [4] = {
    "yaojing_market_config",
    "map<int,map<int,int>>"
  },
  [5] = {
    "guangpo_market_config",
    "map<int,map<int,int>>"
  },
  [6] = {
    "pay_market_config",
    "map<int,map<int,string>>"
  },
  [7] = {
    "gift_market_config",
    "map<int,map<int,string>>"
  },
  [8] = {
    "skin_market_config",
    "map<int,map<int,string>>"
  },
  [9] = {
    "hongpiao_market_config",
    "map<int,map<int,int>>"
  },
  [10] = {
    "furniture_market_config",
    "map<int,map<int,int>>"
  },
  [11] = {
    "furniture_precious_market_config",
    "map<int,map<int,int>>"
  },
  [12] = {
    "season_market_config",
    "map<int,map<int,int>>"
  },
  [13] = {
    "battlepass_market_config",
    "map<int,map<int,int>>"
  }
}
_class("ExchangePhyState", Object)
ExchangePhyState = ExchangePhyState

function ExchangePhyState:Constructor()
  self.cur_times = 0
  self.max_times = 0
  self.cost_id = 0
  self.cost_count = 0
  self.add_phy_count = 0
  self.begin_end = {}
end

ExchangePhyState._proto = {
  [1] = {"cur_times", "int"},
  [2] = {"max_times", "int"},
  [3] = {"cost_id", "int"},
  [4] = {"cost_count", "int"},
  [5] = {
    "add_phy_count",
    "int"
  },
  [6] = {
    "begin_end",
    "list<string>"
  }
}
_class("EventBuyItemOnce", Object)
EventBuyItemOnce = EventBuyItemOnce

function EventBuyItemOnce:Constructor()
  self.goods_id = 0
  self.buy_num = 0
  self.currency_type = 0
  self.selling_price = 0
  self.discount = 0
end

EventBuyItemOnce._proto = {
  [1] = {"goods_id", "int"},
  [2] = {"buy_num", "int"},
  [3] = {
    "currency_type",
    "int"
  },
  [4] = {
    "selling_price",
    "int"
  },
  [5] = {"discount", "float"}
}
