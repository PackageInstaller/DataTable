RegProperty("ListFactory", {
  {
    mod = "\230\180\187\229\138\168\232\183\179\232\189\172\231\155\184\229\133\179",
    name = "skipStationStart",
    type = "Factory",
    des = "\232\183\179\232\189\172\229\159\142\229\184\130\239\188\136\229\188\128\229\167\139\239\188\137",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "\230\180\187\229\138\168\232\183\179\232\189\172\231\155\184\229\133\179",
    name = "skipQuestList",
    type = "Array",
    des = "\228\187\187\229\138\161\232\183\179\232\189\172\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\187\187\229\138\161\232\183\179\232\189\172",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "\230\180\187\229\138\168\232\183\179\232\189\172\231\155\184\229\133\179",
    name = "skipStationEnd",
    type = "Factory",
    des = "\232\183\179\232\189\172\229\159\142\229\184\130\239\188\136\231\187\147\230\157\159\239\188\137",
    arg0 = "HomeStationFactory"
  },
  {
    mod = "\233\128\154\231\148\168\229\165\150\229\138\177",
    name = "rewardList",
    type = "Array",
    des = "\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\165\150\229\138\177",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#HomeGoodsFactory#HomeFurnitureFactory#FridgeItemFactory#CollectionCardPackFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\143\146\233\146\136\229\176\143\229\156\176\229\155\190\229\157\144\230\160\135",
    name = "needleInMapList",
    type = "Array",
    des = "\230\143\146\233\146\136\229\136\151\232\161\168",
    detail = "id#mapIconPath#iconPosy#iconPosx"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\164\167\229\156\176\229\155\190\230\143\146\233\146\136",
    arg0 = "MapNeedleFactory"
  },
  {
    mod = "\229\164\167\228\184\150\231\149\140\229\137\167\230\131\133\230\143\146\233\146\136",
    name = "iconPosx",
    type = "Double",
    des = "UI\229\157\144\230\160\135X",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "\229\164\167\228\184\150\231\149\140\229\137\167\230\131\133\230\143\146\233\146\136",
    name = "iconPosy",
    type = "Double",
    des = "UI\229\157\144\230\160\135Y",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "\229\164\167\228\184\150\231\149\140\229\137\167\230\131\133\230\143\146\233\146\136",
    name = "mapIconPath",
    type = "String",
    des = "\229\156\176\229\155\190\229\155\190\230\160\135\231\180\160\230\157\144",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "\229\149\134\229\147\129",
    name = "shopList",
    type = "Array",
    des = "\229\149\134\229\147\129\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\149\134\229\147\129ID",
    arg0 = "CommodityFactory#ValuableFactory#HomeWeaponFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\229\149\134\229\147\129\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\149\134\229\147\129",
    name = "priceList",
    type = "Array",
    des = "\228\187\183\230\160\188\229\136\151\232\161\168",
    detail = "num"
  },
  {
    name = "num",
    type = "Int",
    des = "\228\187\183\230\160\188",
    arg0 = "1",
    pythonName = "id"
  },
  {name = "end"},
  {
    mod = "\229\149\134\229\147\129",
    name = "spShopList",
    type = "Array",
    des = "\231\137\185\230\174\138\229\149\134\229\186\151\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\149\134\229\186\151ID",
    arg0 = "StoreFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\229\149\134\229\186\151\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\143\145\229\138\168\230\156\186\230\160\184\229\191\131",
    name = "breakItemList",
    type = "Array",
    des = "\231\170\129\231\160\180\230\157\144\230\150\153\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\175\185\229\186\148\230\157\144\230\150\153",
    arg0 = "ItemFactory#EquipmentFactory#HomeGoodsFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\143\145\229\138\168\230\156\186\230\160\184\229\191\131",
    name = "EngineRewardList",
    type = "Array",
    des = "\229\141\135\231\186\167\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\175\185\229\186\148\230\157\144\230\150\153",
    arg0 = "ItemFactory#EquipmentFactory#HomeGoodsFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "initOrderList",
    type = "Array",
    des = "\229\136\157\229\167\139\228\186\164\232\180\167\232\174\162\229\141\149",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\136\157\229\167\139\232\174\162\229\141\149\228\187\187\229\138\161",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "OrderList",
    type = "Array",
    des = "\228\186\164\232\180\167\232\174\162\229\141\149",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\186\164\232\180\167\232\174\162\229\141\149\228\187\187\229\138\161",
    arg0 = "QuestFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "stageRewardList",
    type = "Array",
    des = "\233\152\182\230\174\181\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "construct#id#num"
  },
  {
    name = "construct",
    type = "Int",
    des = "\229\143\175\233\162\134\229\143\150\229\187\186\232\174\190\232\191\155\229\186\166",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\165\150\229\138\177\231\137\169\229\147\129",
    arg0 = "ItemFactory#EquipmentFactory#HomeGoodsFactory#SourceMaterialFactory#FridgeItemFactory#HomeWeaponFactory#HomeFurnitureFactory#HomeCharacterSkinFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "textTipsList",
    type = "Array",
    des = "\230\150\135\230\156\172\230\143\144\231\164\186\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\143\144\231\164\186\230\150\135\230\156\172",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "seriesType",
    type = "Enum",
    des = "\229\186\143\229\136\151\231\177\187\229\158\139||Story:\228\184\180\230\151\182\229\137\167\230\131\133,Official:\230\173\163\229\188\143\231\137\136",
    arg0 = "Story#Official",
    arg1 = "Official"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "seriesCompleteNum",
    type = "Int",
    des = "\231\179\187\229\136\151\229\174\140\230\136\144\230\149\176\233\135\143",
    arg0 = "3"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "seriesName",
    type = "StringT",
    des = "\231\179\187\229\136\151\229\144\141\231\167\176",
    arg0 = ""
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "sequenceName",
    type = "Factory",
    des = "\229\186\143\229\136\151\229\144\141\231\167\176",
    arg0 = "TextFactory"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "expelNum",
    type = "Int",
    des = "\233\169\177\233\128\144\230\128\187\229\128\188",
    arg0 = "100"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "deterrence",
    type = "Int",
    des = "\229\162\158\229\138\160\229\168\129\230\133\145\229\186\166",
    arg0 = "50"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "expelRewardList",
    type = "Array",
    des = "\233\169\177\233\128\144\232\191\155\229\186\166\229\165\150\229\138\177",
    detail = "expel#id"
  },
  {
    name = "expel",
    type = "Int",
    des = "\230\137\128\233\156\128\233\169\177\233\128\144\229\186\166",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\165\150\229\138\177",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "sideQuestList",
    type = "Array",
    des = "\230\148\175\231\186\191\228\187\187\229\138\161",
    detail = "id#weight#lv"
  },
  {
    name = "lv",
    type = "Int",
    des = "\231\173\137\231\186\167",
    arg0 = "1"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\148\175\231\186\191\228\187\187\229\138\161",
    arg0 = "LevelFactory"
  },
  {name = "end"},
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "dayQuestList",
    type = "Array",
    des = "\230\151\165\233\154\143\230\156\186\228\187\187\229\138\161",
    detail = "id#weight#comNum#lv"
  },
  {
    name = "lv",
    type = "Int",
    des = "\231\173\137\231\186\167",
    arg0 = "1"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {
    name = "comNum",
    type = "Int",
    des = "\233\153\144\229\174\154\229\174\140\230\136\144\230\172\161\230\149\176",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\151\165\233\154\143\230\156\186\228\187\187\229\138\161",
    arg0 = "LevelFactory"
  },
  {name = "end"},
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "buildingId",
    type = "Factory",
    des = "\229\175\185\229\186\148\229\187\186\231\173\145",
    arg0 = "BuildingFactory"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "",
    type = "SysLine",
    des = "\231\186\191\232\183\175\229\133\179\229\141\161\233\131\168\229\136\134"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161,\232\183\175\231\186\191\228\186\139\228\187\182\229\136\151\232\161\168",
    name = "eventType",
    type = "Enum",
    des = "\228\186\139\228\187\182\231\177\187\229\158\139||Hua:\229\143\151\232\176\144\229\147\141\229\186\166\229\189\177\229\147\141,Block:\229\143\151\229\168\129\230\133\145\229\186\166\229\189\177\229\147\141,Other:\228\184\141\229\143\151\229\189\177\229\147\141",
    arg0 = "Hua#Block#Other",
    arg1 = "Other"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "eventDeterrence",
    type = "Int",
    des = "\228\186\139\228\187\182\229\168\129\230\133\145\229\186\166",
    arg0 = "100"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161,\232\183\175\231\186\191\228\186\139\228\187\182\229\136\151\232\161\168",
    name = "eventColoudness",
    type = "Int",
    des = "\228\186\139\228\187\182\232\176\144\229\147\141\229\186\166",
    arg0 = "100"
  },
  {
    mod = "\230\178\187\229\174\137\229\133\179\229\141\161",
    name = "eventLevelList",
    type = "Array",
    des = "\232\167\166\229\143\145\229\133\179\229\141\161\228\186\139\228\187\182",
    detail = "id#weight"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\133\179\229\141\161\228\186\139\228\187\182",
    arg0 = "AFKEventFactory"
  },
  {name = "end"},
  {
    mod = "\230\138\149\232\181\132\231\155\184\229\133\179",
    name = "investorCostList",
    type = "Array",
    des = "\230\138\149\232\181\132\232\138\177\232\180\185\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\138\149\232\181\132\233\129\147\229\133\183",
    arg0 = "ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "100000"
  },
  {name = "end"},
  {
    mod = "\230\138\149\232\181\132\231\155\184\229\133\179",
    name = "investorRewList",
    type = "Array",
    des = "\230\138\149\232\181\132\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\138\149\232\181\132\229\165\150\229\138\177",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\138\149\232\181\132\230\142\146\232\161\140\230\166\156",
    name = "investorRankList",
    type = "Array",
    des = "\230\138\149\232\181\132\230\142\146\232\161\140\230\166\156\229\136\151\232\161\168",
    detail = "rankId"
  },
  {
    name = "rankId",
    type = "Factory",
    des = "\230\142\146\232\161\140\230\166\156",
    arg0 = "RankFactory"
  },
  {name = "end"},
  {
    mod = "\229\136\151\232\189\166\230\173\166\232\163\133",
    name = "gradeExpList",
    type = "Array",
    des = "\229\141\135\231\186\167\231\187\143\233\170\140\229\136\151\232\161\168",
    detail = "num"
  },
  {
    name = "num",
    type = "Int",
    des = "\229\141\135\232\135\179\228\184\139\231\186\167\230\137\128\233\156\128\231\187\143\233\170\140",
    arg0 = "50"
  },
  {name = "end"},
  {
    mod = "\229\136\151\232\189\166\230\173\166\232\163\133",
    name = "offerExpList",
    type = "Array",
    des = "\230\143\144\228\190\155\231\187\143\233\170\140\229\136\151\232\161\168",
    detail = "num"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\143\144\228\190\155\231\187\143\233\170\140",
    arg0 = "50"
  },
  {name = "end"},
  {
    mod = "\232\180\167\231\137\169",
    name = "goodsId",
    type = "Factory",
    des = "\232\180\167\231\137\169",
    arg0 = "HomeGoodsFactory",
    arg1 = "\229\159\186\231\161\128\232\180\167\231\137\169"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "price",
    type = "Int",
    des = "\229\159\186\231\161\128\228\187\183\230\160\188",
    arg0 = "100"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "minQuotation",
    type = "Double",
    des = "\230\156\128\228\189\142\232\161\140\230\131\133",
    arg0 = "0.8"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "maxQuotation",
    type = "Double",
    des = "\230\156\128\233\171\152\232\161\140\230\131\133",
    arg0 = "1.2"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "num",
    type = "Int",
    des = "\229\159\186\231\161\128\230\149\176\233\135\143",
    arg0 = "100"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "stockMultipleMin",
    type = "Int",
    des = "\229\186\147\229\173\152\229\128\141\231\142\135\228\184\139\233\153\144",
    arg0 = "20"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "stockMultipleMax",
    type = "Int",
    des = "\229\186\147\229\173\152\229\128\141\231\142\135\228\184\138\233\153\144",
    arg0 = "40"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "isSudden",
    type = "Bool",
    des = "\230\154\180\230\182\168\230\154\180\232\183\140",
    arg0 = "False"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "",
    type = "SysLine",
    des = ""
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "needDevelopNum",
    type = "Int",
    des = "\229\136\183\230\150\176\232\166\129\230\177\130\239\188\136\229\143\145\229\177\149\229\186\166\239\188\137",
    arg0 = "0"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "needItem",
    type = "Factory",
    des = "\229\143\175\232\180\173\228\185\176\230\138\149\232\181\132\232\180\167\229\184\129\232\166\129\230\177\130",
    arg0 = "ItemFactory"
  },
  {
    mod = "\232\180\167\231\137\169",
    name = "needItemNum",
    type = "Int",
    des = "\229\143\175\232\180\173\228\185\176\230\138\149\232\181\132\232\180\167\229\184\129\230\149\176\233\135\143\232\166\129\230\177\130",
    arg0 = "0"
  },
  {
    mod = "\231\173\190\229\136\176\231\155\184\229\133\179",
    name = "awardList",
    type = "Array",
    des = "\231\173\190\229\136\176\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\165\150\229\138\177id",
    arg0 = "ItemFactory#SourceMaterialFactory#UnitFactory#HomeCharacterSkinFactory#HomeWeaponFactory#EquipmentFactory#PetFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\150\157\233\133\146\231\155\184\229\133\179",
    name = "drinkList",
    type = "Array",
    des = "\229\150\157\233\133\146\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\182\136\232\128\151\233\129\147\229\133\183",
    arg0 = "ItemFactory#SourceMaterialFactory#UnitFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\150\157\233\133\146\231\155\184\229\133\179",
    name = "drinkBuffList",
    type = "Array",
    des = "\229\150\157\233\133\146Buff",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "buff",
    arg0 = "HomeBuffFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "100"
  },
  {name = "end"},
  {
    mod = "\229\183\161\232\136\170\228\186\139\228\187\182",
    name = "eventName",
    type = "StringT",
    des = "\228\186\139\228\187\182\230\177\160\229\144\141\231\167\176",
    arg0 = ""
  },
  {
    mod = "\229\183\161\232\136\170\228\186\139\228\187\182",
    name = "eventList",
    type = "Array",
    des = "\228\186\139\228\187\182\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "ID",
    arg0 = "AFKEventFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\232\163\133\229\164\135\232\175\141\230\157\161",
    name = "EquipmentEntryList",
    type = "Array",
    des = "\232\163\133\229\164\135\232\175\141\230\157\161\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\175\141\230\157\161ID",
    arg0 = "SkillFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\145\168\229\184\184\228\187\187\229\138\161",
    name = "weekQuestList",
    type = "Array",
    des = "\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "ID",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "\230\151\165\229\184\184\228\187\187\229\138\161",
    name = "dailyQuestList",
    type = "Array",
    des = "\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "ID",
    arg0 = "QuestFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\231\148\181\229\138\155\231\155\184\229\133\179",
    name = "electricMaterialList",
    type = "Array",
    des = "\230\182\136\232\128\151\230\157\144\230\150\153",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\182\136\232\128\151\233\129\147\229\133\183",
    arg0 = "ItemFactory#SourceMaterialFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\231\135\131\230\178\185\229\141\135\231\186\167",
    name = "OilMaterialList",
    type = "Array",
    des = "\230\182\136\232\128\151\230\157\144\230\150\153",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\182\136\232\128\151\233\129\147\229\133\183",
    arg0 = "ItemFactory#SourceMaterialFactory#HomeGoodsFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\182\136\232\128\151\231\155\184\229\133\179",
    name = "materialList",
    type = "Array",
    des = "\230\157\144\230\150\153\229\143\138\230\149\176\233\135\143\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\157\144\230\150\153ID",
    arg0 = "SourceMaterialFactory#ItemFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178\230\138\189\229\141\161\231\155\184\229\133\179",
    name = "rewardList",
    type = "Array",
    des = "\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "id#weight#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\167\146\232\137\178ID",
    arg0 = "UnitFactory",
    arg1 = "\231\142\169\229\174\182\232\167\146\232\137\178"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\142\137\232\144\189\231\155\184\229\133\179",
    name = "quality",
    type = "Enum",
    des = "\229\147\129\232\180\168",
    arg0 = "White#Blue#Purple#Golden",
    arg1 = "White"
  },
  {
    mod = "\230\142\137\232\144\189\231\155\184\229\133\179",
    name = "name",
    type = "StringT",
    des = "\229\144\141\231\167\176",
    arg0 = ""
  },
  {
    mod = "\230\142\137\232\144\189\231\155\184\229\133\179",
    name = "iconPath",
    type = "Png",
    des = "\230\142\137\232\144\189\229\155\190\230\160\135",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "\230\142\137\232\144\189\231\155\184\229\133\179",
    name = "tipsPath",
    type = "Png",
    des = "Tips\229\155\190\230\160\135",
    arg0 = "",
    arg1 = "300|300"
  },
  {
    mod = "\230\142\137\232\144\189\231\155\184\229\133\179",
    name = "des",
    type = "StringT",
    des = "\230\143\143\232\191\176",
    arg0 = ""
  },
  {
    mod = "\230\142\137\232\144\189\231\155\184\229\133\179",
    name = "dropList",
    type = "Array",
    des = "\230\142\137\232\144\189\229\136\151\232\161\168",
    detail = "id#weight#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\231\137\169\229\147\129ID",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#HomeGoodsFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "0"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\133\179\229\141\161\230\142\137\232\144\189\229\136\151\232\161\168",
    name = "leveldropList",
    type = "Array",
    des = "\230\142\137\232\144\189\229\136\151\232\161\168",
    detail = "id#percent#numMin#numMax"
  },
  {
    name = "id",
    type = "Factory",
    des = "\231\137\169\229\147\129ID",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#ListFactory#HomeWeaponFactory#HomeFurnitureFactory#ActivityListFactory"
  },
  {
    name = "percent",
    type = "Double",
    des = "\230\142\137\231\142\135",
    arg0 = "1"
  },
  {
    name = "numMin",
    type = "Int",
    des = "\230\156\128\229\176\143\230\142\137\232\144\189\230\149\176\233\135\143",
    arg0 = "0"
  },
  {
    name = "numMax",
    type = "Int",
    des = "\230\156\128\229\164\167\230\142\137\232\144\189\230\149\176\233\135\143",
    arg0 = "999"
  },
  {name = "end"},
  {
    mod = "\229\149\134\229\186\151\232\180\173\228\185\176\230\172\161\230\149\176\229\165\150\229\138\177",
    name = "rewardList",
    type = "Array",
    des = "\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "BuyTimes#id"
  },
  {
    mod = "\229\149\134\229\186\151\232\180\173\228\185\176\230\172\161\230\149\176\229\165\150\229\138\177",
    name = "BuyTimes",
    type = "Int",
    des = "\232\190\190\230\160\135\230\172\161\230\149\176",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\165\150\229\138\177\229\136\151\232\161\168ID",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "\229\163\176\230\156\155\229\165\150\229\138\177",
    name = "repRewardList",
    type = "Array",
    des = "\229\163\176\230\156\155\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\233\129\147\229\133\183",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\233\128\154\231\148\168\231\137\169\229\147\129",
    name = "goodsList",
    type = "Array",
    des = "\231\137\169\229\147\129\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\231\137\169\229\147\129ID",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\184\187\233\161\181\229\149\134\229\186\151",
    name = "mainStoreList",
    type = "Array",
    des = "\229\149\134\229\186\151\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\149\134\229\186\151ID",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "\231\171\153\231\130\185\229\140\186\229\159\159",
    name = "areaStationList",
    type = "Array",
    des = "\229\140\186\229\159\159\231\171\153\231\130\185",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\231\171\153\231\130\185",
    arg0 = "HomeStationFactory"
  },
  {name = "end"},
  {
    mod = "\231\171\153\231\130\185\229\140\186\229\159\159",
    name = "rareGoodsNum",
    type = "Int",
    des = "\231\168\128\229\176\145\228\186\164\230\152\147\229\147\129\230\149\176\233\135\143",
    arg0 = "0"
  },
  {
    mod = "\231\171\153\231\130\185\229\140\186\229\159\159",
    name = "rareGoodsList",
    type = "Array",
    des = "\231\168\128\229\176\145\228\186\164\230\152\147\229\147\129\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\180\167\231\137\169",
    arg0 = "HomeGoodsFactory"
  },
  {name = "end"},
  {
    mod = "\231\171\153\231\130\185\229\140\186\229\159\159",
    name = "areaLevelList",
    type = "Array",
    des = "\229\140\186\229\159\159\233\169\177\233\128\144\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id#weight#comNum"
  },
  {
    name = "id",
    type = "Factory",
    des = "\233\169\177\233\128\144\228\187\187\229\138\161",
    arg0 = "LevelFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "50"
  },
  {
    name = "comNum",
    type = "Int",
    des = "\233\153\144\229\136\182\230\172\161\230\149\176",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\137\167\230\131\133\228\187\187\229\138\161",
    name = "chapterName",
    type = "StringT",
    des = "\231\171\160\232\138\130\229\144\141",
    arg0 = ""
  },
  {
    mod = "\229\137\167\230\131\133\228\187\187\229\138\161",
    name = "condition",
    type = "Factory",
    des = "\232\167\163\233\148\129\230\157\161\228\187\182",
    arg0 = "QuestFactory"
  },
  {
    mod = "\229\137\167\230\131\133\228\187\187\229\138\161",
    name = "width",
    type = "Double",
    des = "\229\156\176\229\155\190\229\174\189",
    arg0 = "1920"
  },
  {
    mod = "\229\137\167\230\131\133\228\187\187\229\138\161",
    name = "height",
    type = "Double",
    des = "\229\156\176\229\155\190\233\171\152",
    arg0 = "1080"
  },
  {
    mod = "\229\137\167\230\131\133\228\187\187\229\138\161",
    name = "questList",
    type = "Array",
    des = "\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id#x#y"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\187\187\229\138\161",
    arg0 = "QuestFactory"
  },
  {
    name = "x",
    type = "Double",
    des = "x\229\157\144\230\160\135",
    arg0 = "0"
  },
  {
    name = "y",
    type = "Double",
    des = "y\229\157\144\230\160\135",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\138\128\232\131\189BUFF",
    name = "skillBuffList",
    type = "Array",
    des = "\230\138\128\232\131\189BUFF\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "buffId",
    arg0 = "SkillFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {name = "end"},
  {
    mod = "TimeLine",
    name = "spineList",
    type = "Array",
    des = "\232\181\132\230\186\144\229\136\151\232\161\168",
    detail = "note#spinePath#weight",
    pyIgnore = true
  },
  {
    name = "note",
    type = "String",
    des = "\229\164\135\230\179\168",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "spinePath",
    type = "String",
    des = "\232\181\132\230\186\144\232\183\175\229\190\132",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "NPC\229\175\185\232\175\157",
    name = "listType",
    type = "Enum",
    des = "\229\136\151\232\161\168\231\177\187\229\158\139||Order:\233\161\186\229\186\143,Mutex:\228\186\146\230\150\165",
    arg0 = "Order#Mutex",
    arg1 = "Order",
    pyIgnore = true
  },
  {
    mod = "NPC\229\175\185\232\175\157",
    name = "dialogList",
    type = "Array",
    des = "\229\175\185\232\175\157\231\187\132",
    detail = "id#reputation",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\175\185\232\175\157\230\150\135\230\156\172",
    arg0 = "TextFactory",
    arg1 = "NPC\229\175\185\232\175\157",
    pyIgnore = true
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\232\189\166\231\171\153\229\156\186\230\153\175",
    name = "stationSceneList",
    type = "Array",
    des = "\229\156\186\230\153\175\229\136\151\232\161\168",
    detail = "dev#stationScene#postProcessingPath#sceneWidth#bgmId#sceneGroup",
    pyIgnore = true
  },
  {
    name = "dev",
    type = "Int",
    des = "\230\137\128\233\156\128\229\143\145\229\177\149\229\186\166",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "stationScene",
    type = "String",
    des = "\232\189\166\231\171\153\229\156\186\230\153\175\229\144\141",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "postProcessingPath",
    type = "String",
    des = "\229\144\142\229\164\132\231\144\134\232\183\175\229\190\132",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "sceneWidth",
    type = "Int",
    des = "\229\156\186\230\153\175\230\139\150\230\139\189\229\141\138\229\190\132",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "bgmId",
    type = "Factory",
    des = "\232\189\166\231\171\153BGM",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "sceneGroup",
    type = "Factory",
    des = "\229\190\170\231\142\175\229\156\186\230\153\175",
    arg0 = "HomeTrainSceneGroupFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\233\147\129\232\183\175\228\186\139\228\187\182",
    name = "eventList",
    type = "Array",
    des = "\229\133\179\229\141\161\229\136\151\232\161\168",
    detail = "distance#id"
  },
  {
    name = "distance",
    type = "Int",
    des = "\232\183\157\231\166\187",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\186\139\228\187\182ID",
    arg0 = "AFKEventFactory",
    arg1 = "\229\133\179\229\141\161\228\186\139\228\187\182"
  },
  {name = "end"},
  {
    mod = "\233\147\129\232\183\175\228\186\139\228\187\182",
    name = "boxList",
    type = "Array",
    des = "\229\174\157\231\174\177\229\136\151\232\161\168",
    detail = "distance#id"
  },
  {
    name = "distance",
    type = "Int",
    des = "\232\183\157\231\166\187",
    arg0 = "0"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\186\139\228\187\182ID",
    arg0 = "AFKEventFactory",
    arg1 = "\231\130\185\229\135\187\229\174\157\231\174\177"
  },
  {name = "end"},
  {
    mod = "\233\187\152\232\174\164\231\148\159\231\137\169",
    name = "defaultCreatureList",
    type = "Array",
    des = "\233\187\152\232\174\164\231\148\159\231\137\169",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\231\148\159\231\137\169",
    arg0 = "HomeCreatureFactory#PetFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\136\144\229\176\177\231\155\184\229\133\179",
    name = "accumulateList",
    type = "Array",
    des = "\230\136\144\229\176\177\231\130\185\230\149\176\231\180\175\232\174\161\229\136\151\232\161\168",
    detail = "sumCount#name#stageName#png#id#achieveList"
  },
  {
    name = "sumCount",
    type = "Int",
    des = "\230\136\144\229\176\177\231\180\175\232\174\161\231\130\185\230\149\176",
    arg0 = "100"
  },
  {
    name = "name",
    type = "StringT",
    des = "\230\128\187\232\167\136\229\144\141\231\167\176",
    arg0 = ""
  },
  {
    name = "stageName",
    type = "StringT",
    des = "\233\152\182\230\174\181\229\144\141\231\167\176",
    arg0 = ""
  },
  {
    name = "png",
    type = "Png",
    des = "\230\152\190\231\164\186\229\155\190\231\137\135",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\165\150\229\138\177",
    arg0 = "ListFactory"
  },
  {
    name = "achieveList",
    type = "Int",
    des = "\229\175\185\229\186\148\230\136\144\229\176\177\229\136\151\232\161\168",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\136\144\229\176\177\231\155\184\229\133\179",
    name = "achieveRewardList",
    type = "Array",
    des = "\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\165\150\229\138\177",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\136\144\229\176\177\231\155\184\229\133\179",
    name = "achieveStartList",
    type = "Array",
    des = "\229\188\128\229\144\175\230\136\144\229\176\177\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\136\144\229\176\177",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "Tag\233\128\154\231\148\168",
    name = "normalTagList",
    type = "Array",
    des = "Tag\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\160\135\231\173\190",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\230\128\167\230\160\188",
    name = "petPersonalityList",
    type = "Array",
    des = "\229\174\160\231\137\169\230\128\167\230\160\188\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\174\160\231\137\169\230\128\167\230\160\188",
    arg0 = "TagFactory",
    arg1 = "\229\174\160\231\137\169\230\128\167\230\160\188"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\231\190\129\231\187\138",
    name = "petTieList",
    type = "Array",
    des = "\229\174\160\231\137\169\231\190\129\231\187\138\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\174\160\231\137\169\231\190\129\231\187\138",
    arg0 = "TagFactory",
    arg1 = "\229\174\160\231\137\169\231\190\129\231\187\138"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\137\167\230\131\133\229\155\158\233\161\190\230\174\181\232\144\189",
    name = "IncludeParagraph",
    type = "Array",
    des = "\229\140\133\229\144\171\230\174\181\232\144\189"
  },
  {
    name = "id",
    type = "Factory",
    des = "\233\128\137\230\139\169\230\174\181\232\144\189",
    arg0 = "ParagraphFactory",
    arg1 = ""
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154\228\187\187\229\138\161",
    name = "starWeightList",
    type = "Array",
    des = "\228\187\187\229\138\161\230\152\159\231\186\167\230\157\131\233\135\141|\229\133\136\233\154\143\230\152\159\231\186\167\229\134\141\233\154\143\228\187\187\229\138\161",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Enum",
    des = "\228\187\187\229\138\161\229\136\151\232\161\168",
    arg0 = "questList1#questList2#questList3#questList4#questList5",
    arg1 = "questList1"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154\228\187\187\229\138\161",
    name = "questList1",
    type = "Array",
    des = "1\230\152\159\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\187\187\229\138\161",
    arg0 = "QuestFactory#PrisonProcurementFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154\228\187\187\229\138\161",
    name = "questList2",
    type = "Array",
    des = "2\230\152\159\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\187\187\229\138\161",
    arg0 = "QuestFactory#PrisonProcurementFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154\228\187\187\229\138\161",
    name = "questList3",
    type = "Array",
    des = "3\230\152\159\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\187\187\229\138\161",
    arg0 = "QuestFactory#PrisonProcurementFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154\228\187\187\229\138\161",
    name = "questList4",
    type = "Array",
    des = "4\230\152\159\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\187\187\229\138\161",
    arg0 = "QuestFactory#PrisonProcurementFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154\228\187\187\229\138\161",
    name = "questList5",
    type = "Array",
    des = "5\230\152\159\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\187\187\229\138\161",
    arg0 = "QuestFactory#PrisonProcurementFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\233\147\129\232\183\175\229\174\157\231\174\177",
    name = "boxGoodsList",
    type = "Array",
    des = "\230\142\137\232\144\189\231\137\169\229\147\129\229\136\151\232\161\168",
    detail = "id#min#max#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\231\137\169\229\147\129id",
    arg0 = "HomeGoodsFactory#ItemFactory#SourceMaterialFactory"
  },
  {
    name = "min",
    type = "Int",
    des = "\230\156\128\229\176\143\230\149\176\233\135\143",
    arg0 = "1"
  },
  {
    name = "max",
    type = "Int",
    des = "\230\156\128\229\164\167\230\149\176\233\135\143",
    arg0 = "1"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\136\151\232\189\166\233\149\191\232\129\140\231\186\167",
    name = "Rankname",
    type = "StringT",
    des = "\232\129\140\231\186\167\229\144\141\231\167\176|\232\129\140\231\186\167\231\154\132\229\144\141\231\167\176",
    arg0 = ""
  },
  {
    mod = "\229\136\151\232\189\166\233\149\191\232\129\140\231\186\167",
    name = "icon",
    type = "Png",
    des = "\232\129\140\231\186\167\229\155\190\230\160\135|\232\129\140\231\186\167\229\155\190\230\160\135200*200",
    arg0 = "",
    arg1 = "200|200"
  },
  {
    mod = "\229\136\151\232\189\166\233\149\191\232\129\140\231\186\167",
    name = "Unlockright",
    type = "Array",
    des = "\232\167\163\233\148\129\231\137\185\230\157\131|\232\190\190\229\136\176\231\173\137\231\186\167\232\142\183\229\190\151\231\154\132\230\157\131\233\153\144",
    detail = "id"
  },
  {
    mod = "\229\136\151\232\189\166\233\149\191\232\129\140\231\186\167",
    name = "id",
    type = "Factory",
    des = "\231\137\185\230\157\131|\232\190\190\229\136\176\231\173\137\231\186\167\232\142\183\229\190\151\231\154\132\230\157\131\233\153\144",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    mod = "\229\136\151\232\189\166\233\149\191\232\129\140\231\186\167",
    name = "reward",
    type = "Array",
    des = "\229\165\150\229\138\177\229\136\151\232\161\168|\232\190\190\229\136\176\231\173\137\231\186\167\229\143\175\233\162\134\229\143\150\231\154\132\229\165\150\229\138\177\229\136\151\232\161\168",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\231\173\137\231\186\167\229\165\150\229\138\177|\229\165\150\229\138\177\233\129\147\229\133\183",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#UnitFactory#HomeCharacterSkinFactory#HomeWeaponFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\233\129\147\229\133\183\230\149\176\233\135\143|\229\165\150\229\138\177\233\129\147\229\133\183\229\175\185\229\186\148\231\154\132\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "",
    type = "SysLine",
    des = "\228\188\160\229\141\149\229\174\163\228\188\160\229\156\176\231\130\185"
  },
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "namePlace",
    type = "StringT",
    des = "\229\156\176\231\130\185\229\144\141",
    arg0 = ""
  },
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "placeType",
    type = "Factory",
    des = "\229\156\176\231\130\185\231\177\187\229\158\139",
    arg0 = "TagFactory"
  },
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "namePlaceIcon",
    type = "Png",
    des = "\229\186\151\233\147\186\229\155\190\230\160\135",
    arg0 = "",
    arg1 = "100|100"
  },
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "PlaceDesc",
    type = "Factory",
    des = "\229\156\176\231\130\185\230\143\143\232\191\176",
    arg0 = "TextFactory"
  },
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "unlockPlace",
    type = "Int",
    des = "\229\186\151\233\147\186\229\159\142\229\184\130\229\163\176\230\156\155\232\167\163\233\148\129\230\157\161\228\187\182",
    arg0 = "0"
  },
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "placeWeight",
    type = "Int",
    des = "\229\186\151\233\147\186\230\142\146\229\186\143\230\157\131\233\135\141",
    arg0 = "0"
  },
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "passengerTypeList",
    type = "Array",
    des = "\232\191\135\229\186\166\228\185\152\229\174\162\230\158\132\230\136\144",
    detail = "id#weight"
  },
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "id",
    type = "Factory",
    des = "\228\185\152\229\174\162id",
    arg0 = "PassageFactory"
  },
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "weight",
    type = "Int",
    des = "\228\185\152\229\174\162\230\158\132\230\136\144\230\157\131\233\135\141",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\188\160\229\141\149\229\156\176\231\130\185",
    name = "passengerTagList",
    type = "Array",
    des = "\232\191\135\229\186\166\228\185\152\229\174\162\230\160\135\231\173\190",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\160\135\231\173\190id",
    arg0 = "ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\160\135\231\173\190\230\158\132\230\136\144\230\157\131\233\135\141",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\157\130\229\191\151\232\167\134\233\162\145\229\185\191\229\145\138",
    name = "adList",
    type = "Array",
    des = "\229\185\191\229\145\138\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\185\191\229\145\138ID",
    arg0 = "PondFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\232\189\166\229\142\162\229\136\151\232\161\168",
    name = "trainLook",
    type = "Array",
    des = "\229\177\149\231\164\186\232\189\166\229\142\162\229\136\151\232\161\168",
    detail = "id",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\136\151\232\189\166\232\189\166\229\142\162id",
    arg0 = "HomeCoachSkinFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\232\189\166\229\142\162\229\136\151\232\161\168",
    name = "trainName",
    type = "Factory",
    des = "\229\136\151\232\189\166\229\144\141\229\173\151",
    arg0 = "TextFactory",
    pyIgnore = true
  },
  {
    mod = "\229\164\167\228\184\150\231\149\140\231\142\175\229\162\131",
    name = "timeStart",
    type = "Int",
    des = "\229\188\128\229\167\139\230\151\182\233\151\180",
    arg0 = "0"
  },
  {
    mod = "\229\164\167\228\184\150\231\149\140\231\142\175\229\162\131",
    name = "timeEnd",
    type = "Int",
    des = "\231\187\147\230\157\159\230\151\182\233\151\180",
    arg0 = "0"
  },
  {
    mod = "\229\164\167\228\184\150\231\149\140\231\142\175\229\162\131",
    name = "environmentList",
    type = "Array",
    des = "\231\142\175\229\162\131\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\189\166\233\129\147\228\191\161\230\129\175id",
    arg0 = "TrainRoadMsgFactory"
  },
  {name = "end"},
  {
    mod = "\232\183\175\231\186\191\228\186\139\228\187\182\229\136\151\232\161\168",
    name = "eventWeightList",
    type = "Array",
    des = "\228\186\139\228\187\182\229\136\151\232\161\168",
    detail = "weight#id"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\186\139\228\187\182id",
    arg0 = "AFKEventFactory"
  },
  {name = "end"},
  {
    mod = "\231\130\185\229\135\187\228\186\139\228\187\182\229\136\151\232\161\168",
    name = "clickEventList",
    type = "Array",
    des = "\231\130\185\229\135\187\228\186\139\228\187\182\230\149\176\230\141\174",
    detail = "pos_x#pos_y#pos_z#id#weight"
  },
  {
    mod = "\231\130\185\229\135\187\228\186\139\228\187\182\229\136\151\232\161\168",
    name = "pos_x",
    type = "Double",
    des = "\229\157\144\230\160\135X",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "\231\130\185\229\135\187\228\186\139\228\187\182\229\136\151\232\161\168",
    name = "pos_y",
    type = "Double",
    des = "\229\157\144\230\160\135Y",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "\231\130\185\229\135\187\228\186\139\228\187\182\229\136\151\232\161\168",
    name = "pos_z",
    type = "Double",
    des = "\229\157\144\230\160\135Z",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "\231\130\185\229\135\187\228\186\139\228\187\182\229\136\151\232\161\168",
    name = "isShowUI",
    type = "Bool",
    des = "\229\156\176\229\155\190\230\152\190\231\164\186\229\155\190\230\160\135",
    arg0 = "false",
    pyIgnore = true
  },
  {
    mod = "\232\183\175\231\186\191\229\140\186\229\159\159",
    name = "icon_x",
    type = "Double",
    des = "UI\229\157\144\230\160\135X",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "\232\183\175\231\186\191\229\140\186\229\159\159",
    name = "icon_y",
    type = "Double",
    des = "UI\229\157\144\230\160\135Y",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\186\139\228\187\182\229\136\151\232\161\168id",
    arg0 = "ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "name",
    type = "StringT",
    des = "\230\160\135\231\173\190\229\144\141\229\173\151",
    arg0 = ""
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "isIncome",
    type = "Bool",
    des = "\230\152\175\229\144\166\232\174\161\231\174\151\230\148\182\231\155\138",
    arg0 = "False"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "",
    type = "SysLine",
    des = "\228\185\152\229\174\162\233\156\128\230\177\130"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "comfort",
    type = "Array",
    des = "\232\136\146\233\128\130\229\186\166\229\159\186\231\161\128\229\128\188|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "common",
    type = "Int",
    des = "\232\136\146\233\128\130\229\186\166\229\159\186\231\161\128\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "most",
    type = "Int",
    des = "\232\136\146\233\128\130\229\186\166\228\184\138\233\153\144\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "pay",
    type = "Int",
    des = "\232\136\146\233\128\130\229\186\166\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "out",
    type = "Int",
    des = "\232\136\146\233\128\130\229\186\166\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "plantScores",
    type = "Array",
    des = "\231\187\191\230\164\141\232\175\132\229\136\134\229\159\186\231\161\128\229\128\188|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "common",
    type = "Int",
    des = "\231\187\191\230\164\141\232\175\132\229\136\134\229\159\186\230\156\172",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "most",
    type = "Int",
    des = "\231\187\191\230\164\141\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "pay",
    type = "Int",
    des = "\231\187\191\230\164\141\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "out",
    type = "Int",
    des = "\231\187\191\230\164\141\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "fishScores",
    type = "Array",
    des = "\230\176\180\230\151\143\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "common",
    type = "Int",
    des = "\230\176\180\230\151\143\232\175\132\229\136\134\229\159\186\230\156\172",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "most",
    type = "Int",
    des = "\230\176\180\230\151\143\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "pay",
    type = "Int",
    des = "\230\176\180\230\151\143\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "out",
    type = "Int",
    des = "\230\176\180\230\151\143\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "petScores",
    type = "Array",
    des = "\229\174\160\231\137\169\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "common",
    type = "Int",
    des = "\229\174\160\231\137\169\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "most",
    type = "Int",
    des = "\229\174\160\231\137\169\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "pay",
    type = "Int",
    des = "\229\174\160\231\137\169\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "out",
    type = "Int",
    des = "\229\174\160\231\137\169\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "foodScores",
    type = "Array",
    des = "\231\190\142\229\145\179\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "common",
    type = "Int",
    des = "\231\190\142\229\145\179\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "most",
    type = "Int",
    des = "\231\190\142\229\145\179\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "pay",
    type = "Int",
    des = "\231\190\142\229\145\179\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "out",
    type = "Int",
    des = "\231\190\142\229\145\179\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "playScores",
    type = "Array",
    des = "\229\168\177\228\185\144\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "common",
    type = "Int",
    des = "\229\168\177\228\185\144\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "most",
    type = "Int",
    des = "\229\168\177\228\185\144\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "pay",
    type = "Int",
    des = "\229\168\177\228\185\144\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "out",
    type = "Int",
    des = "\229\168\177\228\185\144\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "medicalScores",
    type = "Array",
    des = "\229\140\187\231\150\151\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "common",
    type = "Int",
    des = "\229\140\187\231\150\151\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "most",
    type = "Int",
    des = "\229\140\187\231\150\151\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "pay",
    type = "Int",
    des = "\229\140\187\231\150\151\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "out",
    type = "Int",
    des = "\229\140\187\231\150\151\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "arm",
    type = "Array",
    des = "\230\173\166\232\163\133\229\186\166\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "common",
    type = "Int",
    des = "\230\173\166\232\163\133\229\186\166\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "most",
    type = "Int",
    des = "\230\173\166\232\163\133\229\186\166\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "pay",
    type = "Int",
    des = "\230\173\166\232\163\133\229\186\166\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "out",
    type = "Int",
    des = "\230\173\166\232\163\133\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "clean",
    type = "Array",
    des = "\230\184\133\230\180\129\229\186\166\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "common",
    type = "Double",
    des = "\230\184\133\230\180\129\229\186\166\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "most",
    type = "Double",
    des = "\230\184\133\230\180\129\229\186\166\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "pay",
    type = "Double",
    des = "\230\184\133\230\180\129\229\186\166\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "out",
    type = "Double",
    des = "\230\184\133\230\180\129\229\186\166\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "",
    type = "SysLine",
    des = "\230\181\183\229\178\155\228\185\152\229\174\162\233\156\128\230\177\130"
  },
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "islandComfort",
    type = "Array",
    des = "\232\136\146\233\128\130\229\186\166\229\159\186\231\161\128\229\128\188|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    name = "common",
    type = "Int",
    des = "\232\136\146\233\128\130\229\186\166\229\159\186\231\161\128\229\128\188",
    arg0 = "0"
  },
  {
    name = "most",
    type = "Int",
    des = "\232\136\146\233\128\130\229\186\166\228\184\138\233\153\144\229\128\188",
    arg0 = "0"
  },
  {
    name = "pay",
    type = "Int",
    des = "\232\136\146\233\128\130\229\186\166\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    name = "out",
    type = "Int",
    des = "\232\136\146\233\128\130\229\186\166\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "islandPlantScores",
    type = "Array",
    des = "\231\187\191\230\164\141\232\175\132\229\136\134\229\159\186\231\161\128\229\128\188|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    name = "common",
    type = "Int",
    des = "\231\187\191\230\164\141\232\175\132\229\136\134\229\159\186\230\156\172",
    arg0 = "0"
  },
  {
    name = "most",
    type = "Int",
    des = "\231\187\191\230\164\141\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    name = "pay",
    type = "Int",
    des = "\231\187\191\230\164\141\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    name = "out",
    type = "Int",
    des = "\231\187\191\230\164\141\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "islandFishScores",
    type = "Array",
    des = "\230\176\180\230\151\143\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    name = "common",
    type = "Int",
    des = "\230\176\180\230\151\143\232\175\132\229\136\134\229\159\186\230\156\172",
    arg0 = "0"
  },
  {
    name = "most",
    type = "Int",
    des = "\230\176\180\230\151\143\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    name = "pay",
    type = "Int",
    des = "\230\176\180\230\151\143\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    name = "out",
    type = "Int",
    des = "\230\176\180\230\151\143\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "islandPetScores",
    type = "Array",
    des = "\229\174\160\231\137\169\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    name = "common",
    type = "Int",
    des = "\229\174\160\231\137\169\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    name = "most",
    type = "Int",
    des = "\229\174\160\231\137\169\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    name = "pay",
    type = "Int",
    des = "\229\174\160\231\137\169\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    name = "out",
    type = "Int",
    des = "\229\174\160\231\137\169\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "islandFoodScores",
    type = "Array",
    des = "\231\190\142\229\145\179\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    name = "common",
    type = "Int",
    des = "\231\190\142\229\145\179\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    name = "most",
    type = "Int",
    des = "\231\190\142\229\145\179\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    name = "pay",
    type = "Int",
    des = "\231\190\142\229\145\179\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    name = "out",
    type = "Int",
    des = "\231\190\142\229\145\179\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "islandPlayScores",
    type = "Array",
    des = "\229\168\177\228\185\144\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    name = "common",
    type = "Int",
    des = "\229\168\177\228\185\144\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    name = "most",
    type = "Int",
    des = "\229\168\177\228\185\144\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    name = "pay",
    type = "Int",
    des = "\229\168\177\228\185\144\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    name = "out",
    type = "Int",
    des = "\229\168\177\228\185\144\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\185\152\229\174\162\230\160\135\231\173\190",
    name = "islandMedicalScores",
    type = "Array",
    des = "\229\140\187\231\150\151\232\175\132\229\136\134\229\159\186\230\156\172|\228\184\138\233\153\144\229\128\188\239\188\140\230\182\136\232\180\185\233\135\145\233\146\177\228\186\167\229\135\186\239\188\140\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    detail = "common#most#pay#out"
  },
  {
    name = "common",
    type = "Int",
    des = "\229\140\187\231\150\151\232\175\132\229\136\134\229\159\186\231\161\128",
    arg0 = "0"
  },
  {
    name = "most",
    type = "Int",
    des = "\229\140\187\231\150\151\232\175\132\229\136\134\228\184\138\233\153\144",
    arg0 = "0"
  },
  {
    name = "pay",
    type = "Int",
    des = "\229\140\187\231\150\151\230\182\136\232\180\185\229\128\188",
    arg0 = "0"
  },
  {
    name = "out",
    type = "Int",
    des = "\229\140\187\231\150\151\232\182\133\233\162\157\233\156\128\230\177\130\229\128\188",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\232\181\132\230\150\153\233\161\181\231\173\190",
    name = "icon",
    type = "Png",
    des = "\229\155\190\230\160\135",
    arg0 = "",
    arg1 = "96|96"
  },
  {
    mod = "\232\181\132\230\150\153\233\161\181\231\173\190",
    name = "dataTab",
    type = "Array",
    des = "\233\161\181\231\173\190"
  },
  {
    mod = "\232\181\132\230\150\153\233\161\181\231\173\190",
    name = "name",
    type = "StringT",
    des = "\229\144\141\229\173\151",
    arg0 = ""
  },
  {
    mod = "\232\181\132\230\150\153\233\161\181\231\173\190",
    name = "level",
    type = "Int",
    des = "\229\177\130\231\186\167",
    arg0 = "1"
  },
  {
    mod = "\232\181\132\230\150\153\233\161\181\231\173\190",
    name = "id",
    type = "Factory",
    des = "\229\140\133\229\144\171\229\134\133\229\174\185",
    arg0 = "ListFactory#DataFactory"
  },
  {name = "end"},
  {
    mod = "\232\181\132\230\150\153\233\161\181\231\173\190",
    name = "coverPage",
    type = "Png",
    des = "\230\150\135\228\187\182\229\164\185\232\131\140\230\153\175",
    arg0 = "",
    arg1 = "140|110"
  },
  {
    mod = "\232\181\132\230\150\153\233\161\181\231\173\190",
    name = "interfaceUrl",
    type = "String",
    des = "UI\231\149\140\233\157\162",
    arg0 = ""
  },
  {
    mod = "\232\181\132\230\150\153\233\161\181\231\173\190",
    name = "txt",
    type = "Factory",
    des = "\229\164\167\233\161\181\231\173\190\228\187\139\231\187\141",
    arg0 = "DataFactory"
  },
  {
    mod = "\230\137\139\232\180\166\229\184\174\229\138\169\228\184\137\231\186\167",
    name = "lock",
    type = "Int",
    des = "\232\167\163\233\148\129\230\157\161\228\187\182",
    arg0 = "0",
    pyIgnore = true
  },
  {
    mod = "\230\137\139\232\180\166\229\184\174\229\138\169\228\184\137\231\186\167",
    name = "name",
    type = "String",
    des = "\229\144\141\229\173\151",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "\230\137\139\232\180\166\229\184\174\229\138\169\228\184\137\231\186\167",
    name = "icon",
    type = "Png",
    des = "\229\176\129\231\154\174\229\155\190\230\160\135",
    arg0 = "",
    arg1 = "500|500",
    pyIgnore = true
  },
  {
    mod = "\230\137\139\232\180\166\229\184\174\229\138\169\228\184\137\231\186\167",
    name = "notebook",
    type = "Array",
    des = "\230\137\139\232\180\166\233\161\181\231\173\190",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\137\139\232\180\166\229\184\174\229\138\169|\230\152\190\231\164\186\232\175\166\231\187\134\229\134\133\229\174\185png",
    arg0 = "DataFactory"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\230\137\139\232\180\166\229\184\174\229\138\169\228\184\137\231\186\167",
    name = "cover",
    type = "Png",
    des = "\229\138\168\230\149\136\229\176\129\233\157\162",
    arg0 = "",
    arg1 = "500|500",
    pyIgnore = true
  },
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "",
    type = "SysLine",
    des = "\232\167\146\232\137\178\232\175\173\233\159\179"
  },
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "CvName1",
    type = "StringT",
    des = "\229\155\189\232\175\173cv"
  },
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "CvName2",
    type = "StringT",
    des = "\230\151\165\232\175\173cv"
  },
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "TrustAudio",
    type = "Array",
    des = "\229\133\172\231\148\168\232\175\173\233\159\179"
  },
  {
    name = "audioType",
    type = "Enum",
    des = "\232\175\173\233\159\179\231\177\187\229\158\139||Gacha:\230\138\189\229\141\161,#PosterGirl:\232\174\190\231\189\174\231\156\139\230\157\191\229\168\152,#Trust:\233\187\152\229\165\145",
    arg0 = "Gacha#PosterGirl#Trust",
    arg1 = "Trust",
    pyIgnore = true
  },
  {
    name = "AudioName",
    type = "StringT",
    des = "\230\160\135\233\162\152",
    arg0 = ""
  },
  {
    name = "Audio1",
    type = "Factory",
    des = "\229\155\189\232\175\173",
    arg0 = "SoundFactory"
  },
  {
    name = "Audio2",
    type = "Factory",
    des = "\230\151\165\232\175\173",
    arg0 = "SoundFactory"
  },
  {
    name = "UnlockLevel",
    type = "Int",
    des = "\232\167\163\233\148\129\231\173\137\231\186\167",
    arg0 = "1"
  },
  {
    name = "StoryText",
    type = "TextT",
    des = "\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "weight",
    type = "Int",
    des = "\233\154\143\230\156\186\230\157\131\233\135\141|\232\174\190\231\189\174\228\184\186\231\156\139\230\157\191\229\168\152\230\151\182\233\154\143\230\156\186\230\146\173\230\148\190\230\173\164\232\175\173\233\159\179\231\154\132\230\166\130\231\142\135",
    arg0 = "10"
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "AudioM",
    type = "Array",
    des = "\229\175\185\231\148\183\232\175\173\233\159\179"
  },
  {
    name = "AudioName",
    type = "StringT",
    des = "\230\160\135\233\162\152",
    arg0 = ""
  },
  {
    name = "Audio1",
    type = "Factory",
    des = "\229\155\189\232\175\173",
    arg0 = "SoundFactory"
  },
  {
    name = "Audio2",
    type = "Factory",
    des = "\230\151\165\232\175\173",
    arg0 = "SoundFactory"
  },
  {
    name = "UnlockLevel",
    type = "Int",
    des = "\232\167\163\233\148\129\231\173\137\231\186\167",
    arg0 = "1"
  },
  {
    name = "StoryText",
    type = "TextT",
    des = "\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "weight",
    type = "Int",
    des = "\233\154\143\230\156\186\230\157\131\233\135\141|\232\174\190\231\189\174\228\184\186\231\156\139\230\157\191\229\168\152\230\151\182\233\154\143\230\156\186\230\146\173\230\148\190\230\173\164\232\175\173\233\159\179\231\154\132\230\166\130\231\142\135",
    arg0 = "10"
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "AudioF",
    type = "Array",
    des = "\229\175\185\229\165\179\232\175\173\233\159\179"
  },
  {
    name = "AudioName",
    type = "StringT",
    des = "\230\160\135\233\162\152",
    arg0 = ""
  },
  {
    name = "Audio1",
    type = "Factory",
    des = "\229\155\189\232\175\173",
    arg0 = "SoundFactory"
  },
  {
    name = "Audio2",
    type = "Factory",
    des = "\230\151\165\232\175\173",
    arg0 = "SoundFactory"
  },
  {
    name = "UnlockLevel",
    type = "Int",
    des = "\232\167\163\233\148\129\231\173\137\231\186\167",
    arg0 = "1"
  },
  {
    name = "StoryText",
    type = "TextT",
    des = "\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "weight",
    type = "Int",
    des = "\233\154\143\230\156\186\230\157\131\233\135\141|\232\174\190\231\189\174\228\184\186\231\156\139\230\157\191\229\168\152\230\151\182\233\154\143\230\156\186\230\146\173\230\148\190\230\173\164\232\175\173\233\159\179\231\154\132\230\166\130\231\142\135",
    arg0 = "10"
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "BattleAudio",
    type = "Array",
    des = "\230\136\152\230\150\151\229\134\133\232\175\173\233\159\179",
    pyIgnore = true
  },
  {
    name = "AudioType",
    type = "Enum",
    des = "\232\175\173\233\159\179\231\177\187\229\158\139||Attack:\229\135\186\229\135\187,#Advance:\229\137\141\232\191\155,#SkillS:\229\191\133\230\157\128,#Defeat:\230\136\152\232\180\165,#Mvp:MVP",
    arg0 = "Attack#Advance#SkillS#Defeat#Mvp",
    arg1 = "Attack",
    pyIgnore = true
  },
  {
    name = "AudioName",
    type = "StringT",
    des = "\230\160\135\233\162\152",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "id1",
    type = "Factory",
    des = "\229\155\189\233\133\141",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "id2",
    type = "Factory",
    des = "\230\151\165\233\133\141",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {
    name = "StoryText",
    type = "TextT",
    des = "\232\175\173\233\159\179\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "",
    type = "SysLine",
    des = "\232\167\146\232\137\178\228\186\146\229\138\168\232\175\173\233\159\179"
  },
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "roleTalkAudio",
    type = "Array",
    des = "\232\167\146\232\137\178\228\186\146\229\138\168\232\175\173\233\159\179|\232\139\165\230\156\137\229\175\185\229\186\148\231\154\132\232\175\173\233\159\179\239\188\140\229\136\164\230\150\173\230\151\182\228\188\154\230\183\183\229\133\165\230\173\163\229\184\184\230\157\131\233\135\141\229\136\164\230\150\173\239\188\140\232\139\165\230\156\137\229\175\185\229\186\148\232\167\146\232\137\178\230\146\173\230\148\190\239\188\140\232\139\165\230\151\160\229\136\153\229\134\141\230\172\161\233\154\143\230\156\186",
    pyIgnore = true
  },
  {
    name = "audioList",
    type = "Factory",
    des = "\229\175\185\229\186\148\229\175\185\232\175\157\229\136\151\232\161\168",
    arg0 = "ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\233\154\143\230\156\186\230\157\131\233\135\141|\232\174\190\231\189\174\228\184\186\231\156\139\230\157\191\229\168\152\230\151\182\233\154\143\230\156\186\230\146\173\230\148\190\230\173\164\232\175\173\233\159\179\231\154\132\230\166\130\231\142\135",
    arg0 = "10"
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "",
    type = "SysLine",
    des = "\232\167\146\232\137\178\230\149\133\228\186\139"
  },
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "ResumeList",
    type = "Array",
    des = "\229\177\165\229\142\134",
    detail = "",
    pyIgnore = true
  },
  {
    name = "des",
    type = "TextT",
    des = "\229\177\165\229\142\134\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "StoryList",
    type = "Array",
    des = "\232\167\146\232\137\178\230\149\133\228\186\139",
    detail = "",
    pyIgnore = true
  },
  {
    name = "Title",
    type = "StringT",
    des = "\230\160\135\233\162\152",
    arg0 = ""
  },
  {
    name = "des",
    type = "TextT",
    des = "\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "UnlockLevel",
    type = "Int",
    des = "\232\167\163\233\148\129\231\173\137\231\186\167",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178\230\161\163\230\161\136",
    name = "Restype",
    type = "Array",
    des = "\232\181\132\230\186\144\231\138\182\230\128\129\229\136\151\232\161\168",
    detail = "Language#isExistent",
    pyIgnore = true
  },
  {
    name = "Language",
    type = "String",
    des = "\232\175\173\232\168\128",
    arg0 = ""
  },
  {
    name = "isExistent",
    type = "Bool",
    des = "\230\152\175\229\144\166\230\156\137\232\181\132\230\186\144",
    arg0 = "True"
  },
  {name = "end"},
  {
    mod = "\228\186\146\229\138\168\232\175\173\233\159\179",
    name = "roleList",
    type = "Array",
    des = "\229\143\130\228\184\142\232\167\146\232\137\178|\230\150\185\228\190\191\231\168\139\229\186\143\229\136\164\230\150\173",
    detail = "",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\167\146\232\137\178",
    arg0 = "UnitFactory"
  },
  {name = "end"},
  {
    mod = "\228\186\146\229\138\168\232\175\173\233\159\179",
    name = "VoiceList",
    type = "Array",
    des = "\232\175\173\233\159\179|\232\175\173\233\159\179\229\136\151\232\161\168\239\188\140\233\128\144\230\157\161\230\146\173\230\148\190",
    detail = "",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\167\146\232\137\178",
    arg0 = "UnitFactory"
  },
  {
    name = "AudioName",
    type = "StringT",
    des = "\230\160\135\233\162\152",
    arg0 = ""
  },
  {
    name = "Audio1",
    type = "Factory",
    des = "\229\155\189\232\175\173",
    arg0 = "SoundFactory"
  },
  {
    name = "Audio2",
    type = "Factory",
    des = "\230\151\165\232\175\173",
    arg0 = "SoundFactory"
  },
  {
    name = "StoryText",
    type = "TextT",
    des = "\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "\230\184\184\228\185\144\229\156\186",
    name = "investChoose",
    type = "Array",
    des = "\230\138\149\232\181\132\233\128\137\230\139\169|\230\160\185\230\141\174\230\157\131\233\135\141\229\156\168\229\134\133\229\174\185\230\177\160\233\154\143\230\138\149\232\181\132\229\134\133\229\174\185",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\138\149\232\181\132id",
    arg0 = "PondFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178Spine\229\138\168\231\148\187\231\187\132",
    name = "animList",
    type = "Array",
    des = "\229\138\168\231\148\187",
    detail = "name",
    pyIgnore = true
  },
  {
    name = "name",
    type = "String",
    des = "\229\138\168\231\148\187\229\144\141\231\167\176",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\228\185\152\229\174\162\229\138\168\231\148\187",
    name = "passengerAction1",
    type = "Array",
    des = "\229\183\166\232\176\136\232\175\157npc|\231\148\168\228\186\142\228\185\152\229\174\162\228\184\138\228\184\139\232\189\166\232\131\140\230\153\175\228\186\186\231\137\169",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc\232\161\140\228\184\186",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\228\185\152\229\174\162\229\138\168\231\148\187",
    name = "passengerAction2",
    type = "Array",
    des = "\229\143\179\232\176\136\232\175\157npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc\232\161\140\228\184\186",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\228\185\152\229\174\162\229\138\168\231\148\187",
    name = "passengerAction3",
    type = "Array",
    des = "\232\183\145npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc\232\161\140\228\184\186",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\228\185\152\229\174\162\229\138\168\231\148\187",
    name = "passengerAction4",
    type = "Array",
    des = "\232\181\176\232\183\175npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc\232\161\140\228\184\186",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\228\185\152\229\174\162\229\138\168\231\148\187",
    name = "passengerAction5",
    type = "Array",
    des = "1\231\171\153\231\171\139npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc\232\161\140\228\184\186",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\228\185\152\229\174\162\229\138\168\231\148\187",
    name = "passengerAction6",
    type = "Array",
    des = "2\231\171\153\231\171\139npc",
    detail = "id#action",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "npc",
    arg0 = "PassageFactory",
    pyIgnore = true
  },
  {
    name = "action",
    type = "String",
    des = "npc\232\161\140\228\184\186",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\232\138\130\230\151\165\229\165\150\229\138\177",
    name = "FestivalReward",
    type = "Array",
    des = "\229\165\150\229\138\177|\231\137\185\230\174\138\232\138\130\230\151\165\231\156\139\230\157\191\229\168\152\232\181\160\233\128\129\231\154\132\231\164\188\231\137\169",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\165\150\229\138\177ID|\229\165\150\229\138\177\233\129\147\229\133\183",
    arg0 = "ItemFactory#SourceMaterialFactory#HomeFurnitureFactory#PetFactory#HomeGoodsFactory#FridgeItemFactory#EquipmentFactory"
  },
  {
    name = "num",
    type = "Int",
    des = "\229\165\150\229\138\177\230\149\176\233\135\143|\229\165\150\229\138\177\233\129\147\229\133\183\231\154\132\230\149\176\233\135\143",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178\230\141\162\232\163\133\229\138\168\231\148\187",
    name = "frontAnimList",
    type = "Array",
    des = "\230\173\163\233\157\162\230\141\162\232\163\133\229\138\168\231\148\187",
    detail = "animName",
    pyIgnore = true
  },
  {
    name = "animName",
    type = "String",
    des = "\229\138\168\231\148\187\229\144\141\231\167\176",
    arg0 = "dorm_stand"
  },
  {name = "end"},
  {
    mod = "\232\167\146\232\137\178\230\141\162\232\163\133\229\138\168\231\148\187",
    name = "backAnimList",
    type = "Array",
    des = "\232\131\140\233\157\162\230\141\162\232\163\133\229\138\168\231\148\187",
    detail = "animName",
    pyIgnore = true
  },
  {
    name = "animName",
    type = "String",
    des = "\229\138\168\231\148\187\229\144\141\231\167\176",
    arg0 = "dorm_stand_back"
  },
  {name = "end"},
  {
    mod = "\229\184\174\229\138\169",
    name = "helpTitle",
    type = "Factory",
    des = "\229\184\174\229\138\169\230\160\135\233\162\152",
    arg0 = "TextFactory"
  },
  {
    mod = "\229\184\174\229\138\169",
    name = "help",
    type = "Array",
    des = "\233\161\181\231\173\190\229\146\140\229\134\133\229\174\185",
    detail = "tadId#txtId"
  },
  {
    name = "tadId",
    type = "Factory",
    des = "\233\161\181\231\173\190id",
    arg0 = "TextFactory"
  },
  {
    name = "txtId",
    type = "Factory",
    des = "\230\150\135\230\156\172id",
    arg0 = "TextFactory"
  },
  {name = "end"},
  {
    mod = "\232\183\175\231\186\191\230\143\146\233\146\136",
    name = "distance",
    type = "Int",
    des = "\232\183\157\231\166\187",
    arg0 = "0"
  },
  {
    mod = "\232\175\177\233\165\181\230\176\148\231\144\131",
    name = "balloonList",
    type = "Array",
    des = "\230\176\148\231\144\131\233\133\141\231\189\174",
    detail = "ratio"
  },
  {
    name = "ratio",
    type = "Double",
    des = "\230\166\130\231\142\135",
    arg0 = "0",
    pythonName = "id"
  },
  {name = "end"},
  {
    mod = "\229\155\186\229\174\154\230\177\161\230\159\147",
    name = "polluteRegularList",
    type = "Array",
    des = "\229\140\186\229\159\159\229\143\138\230\177\161\230\159\147",
    detail = "id#index"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\140\186\229\159\159id",
    arg0 = "AreaFactory"
  },
  {
    name = "index",
    type = "Int",
    des = "\230\177\161\230\159\147\231\173\137\231\186\167",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\173\166\232\163\133\229\136\151\232\161\168",
    name = "trainWeaponList",
    type = "Array",
    des = "\229\136\182\233\128\160\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\173\166\232\163\133",
    arg0 = "HomeWeaponFactory"
  },
  {name = "end"},
  {
    mod = "\230\180\187\229\138\168\231\155\184\229\133\179",
    name = "achievementList",
    type = "Array",
    des = "\230\180\187\229\138\168\230\136\144\229\176\177\229\136\151\232\161\168",
    detail = "id#icon#englishPic"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\180\187\229\138\168\230\136\144\229\176\177",
    arg0 = "QuestFactory",
    arg1 = "\230\180\187\229\138\168\228\187\187\229\138\161"
  },
  {
    name = "icon",
    type = "Png",
    des = "\232\180\184\230\152\147\230\136\144\229\176\177\229\155\190\230\160\135",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {
    name = "englishPic",
    type = "Png",
    des = "\232\139\177\230\150\135\232\163\133\233\165\176",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "\231\173\137\231\186\167\231\155\184\229\133\179",
    name = "lvList",
    type = "Array",
    des = "\231\173\137\231\186\167\229\136\151\232\161\168",
    detail = "lv"
  },
  {
    name = "lv",
    type = "Int",
    des = "\231\173\137\231\186\167",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\230\148\182\233\155\134\229\141\161\231\155\184\229\133\179",
    name = "packList",
    type = "Array",
    des = "\229\141\161\229\140\133\229\136\151\232\161\168",
    detail = "packId#name#png"
  },
  {
    name = "packId",
    type = "Factory",
    des = "\229\136\151\232\161\168id",
    arg0 = "ListFactory",
    arg1 = "\230\148\182\233\155\134\229\141\161\231\155\184\229\133\179"
  },
  {
    name = "name",
    type = "String",
    des = "\229\141\161\229\140\133\229\144\141\231\167\176",
    arg0 = ""
  },
  {
    name = "png",
    type = "Png",
    des = "\232\131\140\230\153\175\229\155\190",
    arg0 = "",
    arg1 = "100|100"
  },
  {name = "end"},
  {
    mod = "\230\148\182\233\155\134\229\141\161\231\155\184\229\133\179",
    name = "collectionCardList",
    type = "Array",
    des = "\230\148\182\233\155\134\229\141\161\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\148\182\233\155\134\229\141\161id",
    arg0 = "CollectionCardFactory"
  },
  {name = "end"},
  {
    mod = "\231\155\145\231\139\177\229\155\154\231\138\175\229\138\168\231\148\187",
    name = "prisonerActionReady",
    type = "Array",
    des = "\229\135\134\229\164\135\228\184\173|\228\184\138\233\152\181\230\156\170\231\148\159\228\186\167\231\154\132\230\151\182\231\154\132\229\138\168\231\148\187",
    detail = "actionName",
    pyIgnore = true
  },
  {
    name = "actionName",
    type = "String",
    des = "\229\138\168\231\148\187\229\144\141\231\167\176|\229\138\168\231\148\187\232\181\132\230\186\144\229\144\141\231\167\176",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\231\155\145\231\139\177\229\155\154\231\138\175\229\138\168\231\148\187",
    name = "prisonerActionWorking",
    type = "Array",
    des = "\229\183\165\228\189\156\228\184\173|\228\184\138\233\152\181\231\148\159\228\186\167\231\154\132\230\151\182\231\154\132\229\138\168\231\148\187",
    detail = "id#actionName#Weight",
    pyIgnore = true
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\136\182\233\128\160\231\177\187\229\158\139|\231\148\159\228\186\167\229\175\185\229\186\148\231\154\132\231\148\159\228\186\167\232\174\190\229\164\135\231\177\187\229\158\139",
    arg0 = "TagFactory",
    pyIgnore = true
  },
  {
    name = "actionName",
    type = "String",
    des = "\229\138\168\231\148\187\229\144\141\231\167\176|\229\138\168\231\148\187\232\181\132\230\186\144\229\144\141\231\167\176",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141|\230\146\173\230\148\190\231\154\132\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\231\155\145\231\139\177\229\155\154\231\138\175\229\138\168\231\148\187",
    name = "prisonerPunish",
    type = "Array",
    des = "\231\166\129\233\151\173\229\174\164\229\136\151\232\161\168\229\138\168\231\148\187|\231\166\129\233\151\173\229\174\164\229\136\151\232\161\168\229\138\168\231\148\187",
    detail = "actionName",
    pyIgnore = true
  },
  {
    name = "actionName",
    type = "String",
    des = "\229\138\168\231\148\187\229\144\141\231\167\176|\229\138\168\231\148\187\232\181\132\230\186\144\229\144\141\231\167\176",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\231\155\145\231\139\177\229\155\154\231\138\175\229\138\168\231\148\187",
    name = "prisonerFrisk",
    type = "Array",
    des = "\231\166\129\233\151\173\229\174\164\230\144\156\232\186\171\229\138\168\231\148\187|\231\166\129\233\151\173\229\174\164\230\144\156\232\186\171\229\138\168\231\148\187",
    detail = "actionName",
    pyIgnore = true
  },
  {
    name = "actionName",
    type = "String",
    des = "\229\138\168\231\148\187\229\144\141\231\167\176|\229\138\168\231\148\187\232\181\132\230\186\144\229\144\141\231\167\176",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\231\155\145\231\139\177\229\155\154\231\138\175\229\138\168\231\148\187",
    name = "prisonerMedical",
    type = "Array",
    des = "\229\140\187\229\138\161\229\174\164\229\136\151\232\161\168\229\138\168\231\148\187|\231\166\129\233\151\173\229\174\164\229\136\151\232\161\168\229\138\168\231\148\187",
    detail = "actionName",
    pyIgnore = true
  },
  {
    name = "actionName",
    type = "String",
    des = "\229\138\168\231\148\187\229\144\141\231\167\176|\229\138\168\231\148\187\232\181\132\230\186\144\229\144\141\231\167\176",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\231\155\145\231\139\177\229\155\154\231\138\175\229\138\168\231\148\187",
    name = "prisonerRoom",
    type = "Array",
    des = "\231\137\162\230\136\191\229\138\168\231\148\187|\231\166\129\233\151\173\229\174\164\229\136\151\232\161\168\229\138\168\231\148\187",
    detail = "actionName",
    pyIgnore = true
  },
  {
    name = "actionName",
    type = "String",
    des = "\229\138\168\231\148\187\229\144\141\231\167\176|\229\138\168\231\148\187\232\181\132\230\186\144\229\144\141\231\167\176",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\233\128\154\231\148\168\229\133\179\229\141\161",
    name = "levelList",
    type = "Array",
    des = "\229\133\179\229\141\161\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\133\179\229\141\161ID",
    arg0 = "LevelFactory"
  },
  {name = "end"},
  {
    mod = "\232\189\174\231\155\152\230\149\140\230\150\185\229\162\158\231\155\138",
    name = "enemyBuffDesList",
    type = "Array",
    des = "\230\149\140\230\150\185\229\162\158\231\155\138\230\143\143\232\191\176\229\136\151\232\161\168",
    detail = "resistanceTex#numericText#buffText",
    pyIgnore = true
  },
  {
    name = "resistanceText",
    type = "StringT",
    des = "\230\138\151\230\128\167\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "numericText",
    type = "String",
    des = "\230\138\151\230\128\167\230\149\176\229\128\188\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "buffText",
    type = "TextT",
    des = "\229\162\158\231\155\138\230\150\135\230\156\172",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\233\187\145\230\156\136\230\156\141\232\163\133\232\174\162\229\141\149\231\171\153",
    name = "prisonerOrderList",
    type = "Array",
    des = "\228\186\164\232\180\167\232\174\162\229\141\149",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\186\164\232\180\167\232\174\162\229\141\149",
    arg0 = "PrisonProcurementFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\155\154\231\138\175\230\128\167\230\160\188\228\186\139\228\187\182",
    name = "prisonerHappenProbabilityList",
    type = "Array",
    des = "\229\155\154\231\138\175\230\128\167\230\160\188\228\186\139\228\187\182\229\143\145\231\148\159\230\166\130\231\142\135|\231\148\159\228\186\167\229\188\128\229\167\139\229\144\142\231\154\132\229\176\143\230\151\182\230\149\176\229\175\185\229\186\148\231\154\132\230\128\167\230\160\188\228\186\139\228\187\182\229\143\145\231\148\159\230\149\176\233\135\143\229\143\138\229\133\182\230\157\131\233\135\141",
    detail = "happenNum#weight"
  },
  {
    name = "happenNum",
    type = "Int",
    des = "\229\143\145\231\148\159\230\172\161\230\149\176|\229\143\145\231\148\159n\230\172\161",
    arg0 = "0"
  },
  {
    name = "weight",
    type = "Int",
    des = "\229\143\145\231\148\159\230\157\131\233\135\141|\229\143\145\231\148\159n\230\172\161\231\154\132\230\157\131\233\135\141",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\187\187\229\138\161\229\136\151\232\161\168",
    name = "questList",
    type = "Array",
    des = "\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\187\187\229\138\161",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "\229\149\134\229\186\151\233\161\181\231\173\190\229\136\134\231\177\187",
    name = "classifyIcon",
    type = "Png",
    des = "\233\161\181\231\173\190\229\155\190\230\160\135",
    arg0 = "",
    arg1 = "30|30"
  },
  {
    mod = "\229\149\134\229\186\151\233\161\181\231\173\190\229\136\134\231\177\187",
    name = "classifyName",
    type = "Factory",
    des = "\229\144\141\229\173\151",
    arg0 = "TextFactory"
  },
  {
    mod = "\229\149\134\229\186\151\233\161\181\231\173\190\229\136\134\231\177\187",
    name = "commodityList",
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
    mod = "\230\149\140\230\150\185\230\138\128\232\131\189\228\191\161\230\129\175",
    name = "actionSkillList",
    type = "Array",
    des = "\228\184\187\229\138\168\230\138\128\232\131\189",
    detail = "skillName#skillText",
    pyIgnore = true
  },
  {
    name = "skillName",
    type = "StringT",
    des = "\229\144\141\231\167\176",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "skillText",
    type = "TextT",
    des = "\230\149\136\230\158\156",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\230\149\140\230\150\185\230\138\128\232\131\189\228\191\161\230\129\175",
    name = "passivSkillList",
    type = "Array",
    des = "\232\162\171\229\138\168\230\138\128\232\131\189",
    detail = "skillName#skillText",
    pyIgnore = true
  },
  {
    name = "skillName",
    type = "StringT",
    des = "\229\144\141\231\167\176",
    arg0 = "",
    pyIgnore = true
  },
  {
    name = "skillText",
    type = "TextT",
    des = "\230\149\136\230\158\156",
    arg0 = "",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\229\136\151\232\189\166\233\149\191\229\184\174\229\138\169\230\137\139\229\134\140",
    name = "helpbookList",
    type = "Array",
    des = "\229\136\151\232\189\166\233\149\191\229\184\174\229\138\169\230\137\139\229\134\140",
    detail = "imgPath",
    pyIgnore = true
  },
  {
    name = "imgPath",
    type = "Png",
    des = "\230\142\137\232\144\189\229\155\190\230\160\135",
    arg0 = "",
    arg1 = "100|100",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\231\155\145\231\139\177\229\156\186\230\153\175\228\189\141\231\189\174",
    name = "prisonFurniturePosition",
    type = "Array",
    des = "\231\137\162\230\136\191\229\174\182\229\133\183\228\189\141\231\189\174\229\136\151\232\161\168|\231\148\168\228\186\142\232\174\176\229\189\149\231\155\145\231\139\177\231\154\132\231\137\162\230\136\191\228\184\173\231\154\132\229\174\182\229\133\183\228\189\141\231\189\174",
    detail = "id#x#y"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\152\190\231\164\186\229\174\182\229\133\183",
    arg0 = "HomeFurnitureFactory"
  },
  {
    name = "x",
    type = "Int",
    des = "x\229\157\144\230\160\135",
    arg0 = "0"
  },
  {
    name = "y",
    type = "Int",
    des = "y\229\157\144\230\160\135",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\231\155\145\231\139\177\229\156\186\230\153\175\228\189\141\231\189\174",
    name = "prisonPrisonerPosition",
    type = "Array",
    des = "\231\137\162\230\136\191\229\155\154\231\138\175\228\189\141\231\189\174\229\136\151\232\161\168|\231\148\168\228\186\142\232\174\176\229\189\149\231\155\145\231\139\177\231\154\132\229\155\154\231\138\175\228\184\173\231\154\132\231\148\159\230\136\144\228\189\141\231\189\174",
    detail = "id#x#y"
  },
  {
    name = "x",
    type = "Int",
    des = "x\229\157\144\230\160\135",
    arg0 = "0"
  },
  {
    name = "y",
    type = "Int",
    des = "y\229\157\144\230\160\135",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\175\188\232\136\170\230\137\139\229\134\140\229\136\151\232\161\168",
    name = "stageQuestList",
    type = "Array",
    des = "\229\175\188\232\136\170\230\137\139\229\134\140\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\175\188\232\136\170\230\137\139\229\134\140ID",
    arg0 = "StageQuestFactory"
  },
  {name = "end"},
  {
    mod = "\232\175\141\230\157\161\231\173\155\233\128\137",
    name = "occList",
    type = "Array",
    des = "\232\129\140\228\184\154",
    detail = "tagOcc"
  },
  {
    name = "tagOcc",
    type = "Factory",
    des = "\230\160\135\231\173\190",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "\232\175\141\230\157\161\231\173\155\233\128\137",
    name = "hitList",
    type = "Array",
    des = "\229\133\131\231\180\160",
    detail = "tagHit"
  },
  {
    name = "tagHit",
    type = "Factory",
    des = "\230\160\135\231\173\190",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "\232\175\141\230\157\161\231\173\155\233\128\137",
    name = "tecList",
    type = "Array",
    des = "\231\137\185\230\128\167",
    detail = "tagTec"
  },
  {
    name = "tagTec",
    type = "Factory",
    des = "\230\160\135\231\173\190",
    arg0 = "TagFactory"
  },
  {name = "end"},
  {
    mod = "\231\148\178\233\147\129\229\159\142\229\133\179\229\141\161\229\136\151\232\161\168",
    name = "kabanerList",
    type = "Array",
    des = "\231\148\178\233\147\129\229\159\142\229\133\179\229\141\161\229\136\151\232\161\168",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\133\179\229\141\161id",
    arg0 = "KabaneriMapFactory"
  },
  {name = "end"},
  {
    mod = "\231\156\139\230\157\191\229\168\152spine\229\190\133\230\156\186\229\138\168\231\148\187",
    name = "posterGirlIdleList",
    type = "Array",
    des = "\231\156\139\230\157\191\229\168\152\229\190\133\230\156\186\229\138\168\231\148\187\233\133\141\231\189\174",
    detail = "idleName|btnListId"
  },
  {
    name = "idleName",
    type = "String",
    des = "\229\190\133\230\156\186\229\138\168\231\148\187\229\144\141"
  },
  {
    name = "btnListId",
    type = "Factory",
    des = "\231\130\185\229\135\187\229\138\168\231\148\187\233\133\141\231\189\174\232\161\168id",
    arg0 = "ListFactory"
  },
  {name = "end"},
  {
    mod = "\231\156\139\230\157\191\229\168\152spine\231\130\185\229\135\187\229\138\168\231\148\187",
    name = "posterGirlBtnList",
    type = "Array",
    des = "\231\156\139\230\157\191\229\168\152\231\130\185\229\135\187\229\138\168\231\148\187\233\133\141\231\189\174",
    detail = "clickAct|idleAct"
  },
  {
    name = "clickAct",
    type = "String",
    des = "\231\130\185\229\135\187\229\138\168\231\148\187\229\144\141|\229\191\133\233\161\187\229\146\140\233\162\132\229\136\182\228\189\147\231\149\140\233\157\162\231\154\132btn\229\144\140\229\144\141",
    pyIgnore = true
  },
  {
    name = "idleAct",
    type = "String",
    des = "\229\190\133\230\156\186\229\138\168\231\148\187\229\144\141|\231\130\185\229\135\187\229\138\168\231\148\187\230\146\173\229\174\140\229\144\142\231\154\132\229\190\133\230\156\186\231\138\182\230\128\129",
    pyIgnore = true
  },
  {
    name = "localPosX",
    type = "Double",
    des = "btn\229\157\144\230\160\135X\232\189\180",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "localPosY",
    type = "Double",
    des = "btn\229\157\144\230\160\135Y\232\189\180",
    arg0 = "0",
    pyIgnore = true
  },
  {
    name = "width",
    type = "Double",
    des = "btn\229\174\189\229\186\166",
    arg0 = "1",
    pyIgnore = true
  },
  {
    name = "height",
    type = "Double",
    des = "btn\233\171\152\229\186\166",
    arg0 = "1",
    pyIgnore = true
  },
  {name = "end"},
  {
    mod = "\230\138\128\232\131\189\229\133\187\230\136\144",
    name = "attributeGradeList",
    type = "Array",
    des = "\229\177\158\230\128\167\231\173\137\231\186\167|\232\167\146\232\137\178\229\177\158\230\128\167\233\131\168\229\136\134\231\173\137\231\186\167\229\188\186\229\140\150",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\177\158\230\128\167",
    arg0 = "SkillFactory"
  },
  {name = "end"},
  {
    mod = "\233\128\154\231\148\168\233\154\143\230\156\186",
    name = "randomList",
    type = "Array",
    des = "\233\154\143\230\156\186\229\136\151\232\161\168",
    detail = "id#weight#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\231\137\169\229\147\129ID",
    arg0 = "ItemFactory#SourceMaterialFactory#EquipmentFactory#ListFactory#HomeWeaponFactory#HomeFurnitureFactory#ActivityListFactory#GuKaFactory"
  },
  {
    name = "weight",
    type = "Double",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {
    name = "num",
    type = "Int",
    des = "\230\149\176\233\135\143",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\232\138\177\232\189\166\232\183\175\229\190\132\232\161\168",
    name = "carRouteList",
    type = "Array",
    des = "\232\138\177\232\189\166\232\183\175\229\190\132\229\157\144\230\160\135\229\136\151\232\161\168",
    detail = "id#x#y"
  },
  {
    name = "id",
    type = "Factory",
    des = "\229\156\176\229\157\151id",
    arg0 = "ParkGridFactory"
  },
  {name = "end"},
  {
    mod = "\229\136\182\233\128\160\232\174\162\229\141\149\231\155\184\229\133\179",
    name = "orderList",
    type = "Array",
    des = "\232\174\162\229\141\149\233\154\143\230\156\186\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\174\162\229\141\149id",
    arg0 = "ManufacturingOrderFactory"
  },
  {
    name = "weight",
    type = "Double",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\136\182\233\128\160\232\174\162\229\141\149\231\155\184\229\133\179",
    name = "orderQualityList",
    type = "Array",
    des = "\232\174\162\229\141\149\229\147\129\232\180\168\233\154\143\230\156\186\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\174\162\229\141\149\229\136\151\232\161\168id",
    arg0 = "ListFactory"
  },
  {
    name = "weight",
    type = "Double",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\229\136\182\233\128\160\232\174\162\229\141\149\231\155\184\229\133\179",
    name = "orderFrameList",
    type = "Array",
    des = "\229\136\182\233\128\160\231\173\137\231\186\167\229\175\185\229\186\148\229\144\132\229\147\129\232\180\168\230\157\131\233\135\141\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\174\162\229\141\149\229\136\151\232\161\168id",
    arg0 = "ListFactory"
  },
  {
    name = "weight",
    type = "Double",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\231\148\159\230\180\187\230\138\128\232\131\189",
    name = "homeSkillList",
    type = "Array",
    des = "\231\148\159\230\180\187\230\138\128\232\131\189\229\136\151\232\161\168",
    detail = "id#weight"
  },
  {
    name = "id",
    type = "Factory",
    des = "\231\148\159\230\180\187\230\138\128\232\131\189id",
    arg0 = "HomeSkillFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "1"
  },
  {name = "end"},
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "cardPathS",
    type = "String",
    des = "\228\184\187\231\149\140\233\157\162\229\144\141\231\137\135\231\137\185\230\149\136",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "cardPath",
    type = "Png",
    des = "\228\184\187\231\149\140\233\157\162\229\144\141\231\137\135",
    arg0 = "",
    arg1 = "200|200",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "bgPathS",
    type = "String",
    des = "\231\149\140\233\157\162\232\131\140\230\153\175\231\137\185\230\149\136",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "bgImgPath",
    type = "Png",
    des = "\231\149\140\233\157\162\232\131\140\230\153\175\233\129\174\231\189\169",
    arg0 = "",
    arg1 = "200|200",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "bgPath",
    type = "Png",
    des = "\231\149\140\233\157\162\232\131\140\230\153\175\229\155\190\231\137\135",
    arg0 = "",
    arg1 = "200|200",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "friendPathS",
    type = "String",
    des = "\229\165\189\229\143\139\229\177\149\231\164\186\229\144\141\231\137\135\231\137\185\230\149\136",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "friendPath",
    type = "Png",
    des = "\229\165\189\229\143\139\229\177\149\231\164\186\229\144\141\231\137\135",
    arg0 = "",
    arg1 = "200|200",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "rankPathS",
    type = "String",
    des = "\230\142\146\232\161\140\230\166\156\229\144\141\231\137\135\231\137\185\230\149\136",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "rankPath",
    type = "Png",
    des = "\230\142\146\232\161\140\230\166\156\229\144\141\231\137\135",
    arg0 = "",
    arg1 = "200|200",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "rankPathLS",
    type = "String",
    des = "\233\149\191\230\180\187\229\138\168\230\142\146\232\161\140\230\166\156\229\144\141\231\137\135\231\137\185\230\149\136",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "rankPathL",
    type = "Png",
    des = "\233\149\191\230\180\187\229\138\168\230\142\146\232\161\140\230\166\156\229\144\141\231\137\135",
    arg0 = "",
    arg1 = "200|200",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "selfPathS",
    type = "String",
    des = "Esc\231\149\140\233\157\162\229\144\141\231\137\135\231\137\185\230\149\136",
    arg0 = "",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "selfPath",
    type = "Png",
    des = "Esc\231\149\140\233\157\162\229\144\141\231\137\135",
    arg0 = "",
    arg1 = "200|200",
    pyIgnore = true
  },
  {
    mod = "\231\142\169\229\174\182\229\144\141\231\137\135",
    name = "item",
    type = "Factory",
    des = "\229\175\185\229\186\148\233\129\147\229\133\183",
    arg0 = "ItemFactory"
  },
  {
    mod = "\232\180\167\229\184\129\230\177\135\231\142\135",
    name = "rateNum",
    type = "Double",
    des = "\229\159\186\231\161\128\230\141\162\231\174\151\230\177\135\231\142\135|\228\187\165\233\147\129\231\155\159\229\184\129\228\184\186\229\141\149\228\189\141,\229\166\13020\233\147\129\231\155\159\229\184\129\229\143\175\229\133\145\230\141\162\228\184\1861\231\130\185\229\133\182\228\187\150\232\180\167\229\184\129",
    arg0 = "20"
  },
  {
    mod = "\232\180\167\229\184\129\230\177\135\231\142\135",
    name = "rateMax",
    type = "Double",
    des = "\230\177\135\231\142\135\228\184\138\233\153\144|\230\156\128\229\164\167\229\143\175\229\189\177\229\147\141\231\154\132\228\184\138\233\153\144,\229\141\179\233\147\129\231\155\159\229\184\129\229\175\185\229\133\182\228\187\150\232\180\167\229\184\129\229\141\135\229\128\188",
    arg0 = "1.2"
  },
  {
    mod = "\232\180\167\229\184\129\230\177\135\231\142\135",
    name = "rateMin",
    type = "Double",
    des = "\230\177\135\231\142\135\228\184\139\233\153\144|\230\156\128\229\164\167\229\143\175\229\189\177\229\147\141\231\154\132\228\184\139\233\153\144,\229\141\179\233\147\129\231\155\159\229\184\129\229\175\185\229\133\182\228\187\150\232\180\167\229\184\129\232\180\172\229\128\188",
    arg0 = "0.8"
  },
  {
    mod = "\232\180\167\229\184\129\230\177\135\231\142\135",
    name = "rateTime",
    type = "Int",
    des = "\230\177\135\231\142\135\229\143\152\230\141\162\229\145\168\230\156\159|\228\187\165s\228\184\186\229\141\149\228\189\141,\230\160\135\229\135\134\228\184\186\230\175\143\229\164\1695\231\130\185\229\136\183\230\150\176\228\184\128\230\172\161\230\177\135\231\142\135",
    arg0 = "82400"
  },
  {
    mod = "\229\159\142\229\184\130\228\187\187\229\138\161\231\179\187\229\136\151",
    name = "questList",
    type = "Array",
    des = "\228\187\187\229\138\161\229\136\151\232\161\168|\229\174\140\230\136\144\228\184\128\231\179\187\229\136\151\228\187\187\229\138\161",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\228\187\187\229\138\161",
    arg0 = "QuestFactory"
  },
  {name = "end"},
  {
    mod = "\232\180\167\231\137\169\232\161\140\230\131\133buff",
    name = "quotation",
    type = "Array",
    des = "\232\180\167\231\137\169\232\161\140\230\131\133",
    detail = "id"
  },
  {
    name = "id",
    type = "Factory",
    des = "\232\180\167\231\137\169\232\161\140\230\131\133",
    arg0 = "HomeGoodsQuotationFactory"
  },
  {name = "end"}
})
