local ShopEnum = {}
ShopEnum.eShopType = {
  Normal = 1,
  Random = 2,
  Resource = 3,
  Charcter = 4,
  MonthCard = 5,
  Recommend = 6,
  Skin = 7,
  Recharge = 8,
  PayGift = 9,
  ResourceRefresh = 10
}
ShopEnum.ShopId = {
  dormFnt = 101,
  recomme = 601,
  hero = 403,
  resident = 203,
  fluent = 204,
  fragConvert = 206,
  skin = 701,
  vow = 705,
  specialSkin = 702,
  recharge = 801,
  gift = 901,
  MonthCardId = 903,
  weekly = 1002,
  supportShop = 1003,
  DailyDungeonShop = 1004,
  remasterDailyShop = 1038,
  photoCommemorate = 1039
}
ShopEnum.ButtonListRule = {empty = 0, gift = 1}
ShopEnum.eGoodsShowType = {
  normal = 1,
  heroGoods = 2,
  monthcard = 3,
  recommend = 4,
  giftBag = 5,
  recharge = 6,
  dormfnt = 7,
  themeSkin = 8
}
ShopEnum.eHeadBarType = {
  advTouchBar = 1,
  pointTouchBar = 2,
  limitTimeBar = 3,
  ruleTouchBar = 4,
  heroFrageBar = 5
}
ShopEnum.eShopDataCompType = {
  page = 1,
  refresh = 2,
  timeLimit = 3
}
ShopEnum.eShopDataCompClass = {
  [ShopEnum.eShopDataCompType.page] = require("Game.Shop.Data.ShopDataComp.ShopData_pageComp"),
  [ShopEnum.eShopDataCompType.refresh] = require("Game.Shop.Data.ShopDataComp.ShopData_refreshComp"),
  [ShopEnum.eShopDataCompType.timeLimit] = require("Game.Shop.Data.ShopDataComp.ShopData_timeLimitComp")
}
ShopEnum.eLimitType = {
  None = 0,
  Day = 1,
  Week = 2,
  Month = 3,
  Eternal = 4,
  Subscription = 801,
  EternalSubscription = 1001
}
ShopEnum.eQuickBuy = {
  stamina = {
    shopId = 301,
    shelfId = 1,
    resourceIds = {
      1001,
      1002,
      1007
    }
  },
  lottery = {shopId = 203, shelfId = 1},
  DmHouse = {shopId = 203, shelfId = 1},
  factoryEnergy = {
    shopId = 301,
    shelfId = 2,
    resourceIds = {
      1001,
      1002,
      ConfigData.game_config.factoryEnergyItemId
    }
  },
  dormCoin = {
    shopId = 301,
    shelfId = 3,
    resourceIds = {
      1001,
      1002,
      ConstGlobalItem.DormCoin
    }
  },
  skinTicket = {
    shopId = 203,
    shelfId = 6,
    resourceIds = {
      ConstGlobalItem.PaidItem,
      ConstGlobalItem.SkinTicket
    }
  },
  skinUpTicket = {
    shopId = 203,
    shelfId = 16,
    resourceIds = {
      ConstGlobalItem.PaidItem,
      ConstGlobalItem.SkinUpTicket
    }
  },
  whiteDayAcc = {
    shopId = 1100,
    shelfId = 1,
    resourceIds = {1001, 1002}
  },
  ADCUnlockItem = {
    shopId = 1200,
    shelfId = 1,
    resourceIds = {1001, 1002}
  },
  activityToken = {
    shopId = 1039,
    shelfId = 999,
    resourceIds = {1001, 1002}
  }
}
ShopEnum.eRecommeStyle = {SingleModel = 1, MultiModel = 2}
ShopEnum.eRecommePicType = {
  Banner = 1,
  Middle = 2,
  Small = 3,
  Single = 99
}
ShopEnum.ePageMarkType = {MonthCard = 1}
ShopEnum.ePayGiftTag = {Discount = 1}
ShopEnum.eGiftType = {
  normal = 0,
  order = 1,
  select = 2,
  checkNextGift = 3,
  orderOfManyType = 4,
  raffle = 5
}
ShopEnum.SingleRecommendPage = {MonthCard = 602, Fund = 603}
ShopEnum.eFurnitureItemType = {
  normal = 0,
  empty = 1,
  title = 2
}
ShopEnum.FurnitureSuits = {
  defaultSuits = {
    forward = {},
    back = {}
  },
  actSuits = {
    forward = {
      ShopEnum.eFurnitureItemType.empty,
      ShopEnum.eFurnitureItemType.empty,
      ShopEnum.eFurnitureItemType.empty,
      ShopEnum.eFurnitureItemType.title
    },
    back = {}
  }
}
ShopEnum.ColorShowFntThemeTags = {
  Color.New(0.996, 0.769, 0.09),
  Color.New(0.678, 0.902, 0.2)
}
return ShopEnum
