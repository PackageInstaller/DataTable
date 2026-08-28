RegProperty("StoreFactory", {
  {
    name = "pngSelect",
    type = "Png",
    des = "\229\155\190\230\160\135\239\188\136\233\128\137\228\184\173\239\188\137",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "pngNotSelect",
    type = "Png",
    des = "\229\155\190\230\160\135\239\188\136\230\156\170\233\128\137\228\184\173\239\188\137",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "shopList",
    type = "Array",
    des = "\229\149\134\229\147\129\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\149\134\229\147\129ID",
    arg0 = "CommodityFactory#ValuableFactory#HomeWeaponFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\229\149\134\229\147\129\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\155\158\230\148\182\229\149\134\229\186\151",
    name = "recycleShopList",
    type = "Array",
    des = "\229\155\158\230\148\182\229\149\134\229\147\129\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\149\134\229\147\129ID",
    arg0 = "CommodityFactory#ValuableFactory"
  },
  {name = "end"},
  {
    mod = "\230\142\168\232\141\144\229\149\134\229\186\151",
    name = "recommendList",
    type = "Array",
    des = "\230\142\168\232\141\144\233\161\181\229\136\151\232\161\168",
    detail = "name#tabPng#png#type#isBattlePass#sequence#otherUI#id#storeId#comSequence#funcId"
  },
  {
    name = "name",
    type = "StringT",
    des = "\230\142\168\232\141\144\233\161\181\229\144\141\231\167\176",
    arg0 = ""
  },
  {
    name = "tabPng",
    type = "Png",
    des = "\233\161\181\231\173\190",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "png",
    type = "Png",
    des = "\230\142\168\232\141\144\233\161\181\229\155\190\231\137\135",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "type",
    type = "Enum",
    des = "\229\138\159\232\131\189\231\177\187\229\158\139",
    arg0 = "SkipStore#SkipPage#Buy",
    arg1 = "SkipStore"
  },
  {
    name = "isBattlePass",
    type = "Bool",
    des = "\230\152\175\233\128\154\232\161\140\232\175\129|\230\152\175\229\144\166\230\152\175\233\128\154\232\161\140\232\175\129\239\188\140\229\139\190\233\128\137\232\161\168\231\164\186\230\152\175\233\128\154\232\161\140\232\175\129\239\188\140\233\128\154\232\161\140\232\175\129\231\154\132\229\155\190\231\137\135\232\181\132\230\186\144\228\184\141\232\181\176\230\173\164\229\164\132\233\133\141\231\189\174",
    arg0 = "False"
  },
  {
    name = "sequence",
    type = "Int",
    des = "\232\183\179\232\189\172\233\161\181\233\157\162\233\161\186\229\186\143",
    arg0 = "1"
  },
  {
    name = "otherUI",
    type = "String",
    des = "\232\183\179\232\189\172UI\231\149\140\233\157\162",
    arg0 = " "
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\149\134\229\147\129ID",
    arg0 = "CommodityFactory#ValuableFactory"
  },
  {
    name = "storeId",
    type = "Factory",
    des = "\229\175\185\229\186\148\229\149\134\229\186\151",
    arg0 = "StoreFactory"
  },
  {
    name = "comSequence",
    type = "Int",
    des = "\229\149\134\229\147\129\233\161\186\229\186\143",
    arg0 = "1"
  },
  {
    name = "funcId",
    type = "Int",
    des = "\229\138\159\232\131\189ID",
    arg0 = "-1"
  },
  {
    name = "andPath",
    type = "String",
    des = "\229\174\137\229\141\147\232\183\179\232\189\172\233\147\190\230\142\165",
    arg0 = ""
  },
  {
    name = "iosPath",
    type = "String",
    des = "IOS\232\183\179\232\189\172\233\147\190\230\142\165|",
    arg0 = ""
  },
  {name = "end"},
  {
    name = "storeType",
    type = "Enum",
    des = "\229\149\134\229\186\151\231\177\187\229\158\139",
    arg0 = "Random#Regular#Repeatable#Rogue",
    arg1 = "Random"
  },
  {
    mod = "\229\149\134\229\186\151",
    name = "TextLockId",
    type = "Factory",
    des = "\230\156\170\232\167\163\233\148\129\230\150\135\230\156\172",
    arg0 = "TextFactory"
  },
  {
    name = "showUI",
    type = "String",
    des = "\230\152\190\231\164\186\231\149\140\233\157\162",
    arg0 = "Group_DiamondStore"
  },
  {
    mod = "\229\149\134\229\186\151",
    name = "commodityFixedList",
    type = "Array",
    des = "\232\135\170\229\138\168\229\136\183\230\150\176\229\155\186\229\174\154\229\149\134\229\147\129",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\149\134\229\147\129ID",
    arg0 = "CommodityFactory#ListFactory"
  },
  {name = "end"},
  {
    mod = "\229\149\134\229\186\151",
    name = "specialShopList",
    type = "Array",
    des = "\231\137\185\230\174\138\229\149\134\229\147\129\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\149\134\229\147\129ID",
    arg0 = "CommodityFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\229\149\134\229\147\129\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\180\187\229\138\168\229\149\134\229\186\151",
    name = "activityId",
    type = "Factory",
    des = "\230\137\128\229\177\158\230\180\187\229\138\168",
    arg0 = "ActivityFactory"
  },
  {
    mod = "\229\149\134\229\186\151",
    name = "isRecordTimes",
    type = "Bool",
    des = "\230\152\175\229\144\166\230\156\137\232\180\173\228\185\176\229\165\150\229\138\177",
    arg0 = "False"
  },
  {
    mod = "\229\149\134\229\186\151",
    name = "rewardList",
    type = "Array",
    des = "\232\180\173\228\185\176\230\172\161\230\149\176\229\165\150\229\138\177",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\165\150\229\138\177\229\136\151\232\161\168ID",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "\229\149\134\229\186\151",
    name = "isStationRefresh",
    type = "Bool",
    des = "\230\152\175\229\144\166\229\136\135\230\141\162\231\171\153\231\130\185\229\136\183\230\150\176",
    arg0 = "False"
  },
  {
    name = "capacityType",
    type = "Array",
    des = "\229\174\185\233\135\143\231\177\187\229\158\139",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\174\185\233\135\143id",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    name = "refreshType",
    type = "Enum",
    des = "\229\136\183\230\150\176\231\177\187\229\158\139",
    arg0 = "Daily#Weekly#Monthly",
    arg1 = "Daily"
  },
  {
    name = "",
    type = "SysLine",
    des = "\233\153\144\230\151\182\229\149\134\229\186\151"
  },
  {
    name = "isTime",
    type = "Bool",
    des = "\230\152\175\229\144\166\233\153\144\230\151\182",
    arg0 = "False"
  },
  {
    name = "startTime",
    type = "String",
    des = "\229\188\128\229\167\139\230\151\182\233\151\180",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "\231\187\147\230\157\159\230\151\182\233\151\180",
    arg0 = ""
  },
  {
    name = "",
    type = "SysLine",
    des = "\232\180\167\229\184\129\230\152\190\231\164\186"
  },
  {
    name = "currencyShow",
    type = "Array",
    des = "\232\180\167\229\184\129\230\152\190\231\164\186",
    detail = "id#click"
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\180\167\229\184\129\230\152\190\231\164\186",
    arg0 = "ItemFactory"
  },
  {
    name = "click",
    type = "Enum",
    des = "\231\130\185\229\135\187\229\138\159\232\131\189",
    arg0 = "Other#Tips#Hua",
    arg1 = "Other"
  },
  {name = "end"},
  {
    mod = "\229\133\133\229\128\188\229\149\134\229\186\151",
    name = "",
    type = "SysLine",
    des = "\228\186\140\231\186\167\233\161\181\231\173\190"
  },
  {
    mod = "\229\133\133\229\128\188\229\149\134\229\186\151",
    name = "isTab",
    type = "Bool",
    des = "\230\152\175\229\144\166\229\173\152\229\156\168\228\186\140\231\186\167\233\161\181\231\173\190",
    arg0 = "False"
  }
})
