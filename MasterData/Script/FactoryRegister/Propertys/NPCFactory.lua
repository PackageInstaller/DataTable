RegProperty("NPCFactory", {
  {
    name = "name",
    type = "StringT",
    des = "\229\144\141\229\173\151",
    arg0 = ""
  },
  {
    name = "spineUrl",
    type = "String",
    des = "Spine",
    arg0 = ""
  },
  {
    name = "spineOffsetX",
    type = "Double",
    des = "SpineX\232\189\180\229\129\143\231\167\187",
    arg0 = "0"
  },
  {
    name = "spineOffsetY",
    type = "Double",
    des = "SpineY\232\189\180\229\129\143\231\167\187",
    arg0 = "0"
  },
  {
    name = "spineScale",
    type = "Double",
    des = "Spine\231\188\169\230\148\190",
    arg0 = "1"
  },
  {
    name = "resUrl",
    type = "Png",
    des = "\231\171\139\231\187\152",
    arg0 = "",
    arg1 = "200|200"
  },
  {
    name = "offsetX",
    type = "Double",
    des = "\231\171\139\231\187\152X\232\189\180\229\129\143\231\167\187",
    arg0 = "0"
  },
  {
    name = "offsetY",
    type = "Double",
    des = "\231\171\139\231\187\152Y\232\189\180\229\129\143\231\167\187",
    arg0 = "0"
  },
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "qResUrl",
    type = "Png",
    des = "Q\231\137\136\239\188\136\228\184\180\230\151\182\239\188\137",
    arg0 = "",
    arg1 = "200|200"
  },
  {
    name = "",
    type = "SysLine",
    des = "\229\143\176\232\175\141"
  },
  {
    name = "enterText",
    type = "Array",
    des = "\230\137\147\229\188\128\231\149\140\233\157\162",
    detail = "id#weight#reputation#activityId#startTime#endTime"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {
    name = "activityId",
    type = "Factory",
    des = "\229\156\168\230\180\187\229\138\168\230\156\159\233\151\180\230\152\190\231\164\186|\230\180\187\229\138\168ID",
    arg0 = "ActivityFactory"
  },
  {
    name = "startTime",
    type = "String",
    des = "\229\188\128\229\167\139\230\151\182\233\151\180|\228\184\142\230\180\187\229\138\168\230\151\182\233\151\180\228\186\146\230\150\165",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "\231\187\147\230\157\159\230\151\182\233\151\180|\228\184\142\230\180\187\229\138\168\230\151\182\233\151\180\228\186\146\230\150\165",
    arg0 = ""
  },
  {name = "end"},
  {
    name = "talkText",
    type = "Array",
    des = "\228\186\164\232\176\136",
    detail = "id#weight#reputation#activityId#startTime#endTime"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {
    name = "activityId",
    type = "Factory",
    des = "\229\156\168\230\180\187\229\138\168\230\156\159\233\151\180\230\152\190\231\164\186|\230\180\187\229\138\168ID",
    arg0 = "ActivityFactory"
  },
  {
    name = "startTime",
    type = "String",
    des = "\229\188\128\229\167\139\230\151\182\233\151\180|\228\184\142\230\180\187\229\138\168\230\151\182\233\151\180\228\186\146\230\150\165",
    arg0 = ""
  },
  {
    name = "endTime",
    type = "String",
    des = "\231\187\147\230\157\159\230\151\182\233\151\180|\228\184\142\230\180\187\229\138\168\230\151\182\233\151\180\228\186\146\230\150\165",
    arg0 = ""
  },
  {name = "end"},
  {
    name = "UseItem",
    type = "Array",
    des = "\228\189\191\231\148\168\233\129\147\229\133\183",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    name = "ItemText",
    type = "Array",
    des = "\233\129\147\229\133\183\228\184\141\232\182\179\230\150\135\230\156\172",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154",
    name = "questListText",
    type = "Array",
    des = "\230\137\147\229\188\128\228\187\187\229\138\161\229\136\151\232\161\168",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154",
    name = "questListNullText",
    type = "Array",
    des = "\228\187\187\229\138\161\229\136\151\232\161\168\228\184\186\231\169\186",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154",
    name = "acceptQuestText",
    type = "Array",
    des = "\230\142\165\229\143\151\228\187\187\229\138\161",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154",
    name = "cancelQuestText",
    type = "Array",
    des = "\229\143\150\230\182\136\228\187\187\229\138\161",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154",
    name = "addQuestSuccessText",
    type = "Array",
    des = "\230\183\187\229\138\160\228\187\187\229\138\161\230\136\144\229\138\159",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\149\134\228\188\154",
    name = "notEnoughText",
    type = "Array",
    des = "\233\129\147\229\133\183\228\184\141\232\182\179",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\233\133\146\229\144\167",
    name = "drinkText",
    type = "Array",
    des = "\230\136\144\229\138\159\229\150\157\233\133\146\230\150\135\230\156\172",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\233\133\146\229\144\167",
    name = "StoreText",
    type = "Array",
    des = "\230\181\143\232\167\136\233\187\145\229\184\130\230\150\135\230\156\172",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\233\133\146\229\144\167",
    name = "OneText",
    type = "Array",
    des = "\229\150\157\228\184\128\230\157\175\230\150\135\230\156\172",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\233\133\146\229\144\167",
    name = "upperText",
    type = "Array",
    des = "\228\184\138\233\153\144\229\144\142\230\150\135\230\156\172",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\233\133\146\229\144\167",
    name = "SpecialText",
    type = "Array",
    des = "\231\137\185\230\174\138\229\149\134\229\147\129\230\150\135\230\156\172",
    detail = "id#weight#reputation#station#store"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {
    name = "station",
    type = "Factory",
    des = "\232\189\166\231\171\153",
    arg0 = "HomeStationFactory"
  },
  {
    name = "store",
    type = "Factory",
    des = "\229\149\134\229\186\151",
    arg0 = "StoreFactory"
  },
  {name = "end"},
  {
    mod = "\230\178\187\229\174\137\228\184\173\229\191\131",
    name = "levelListText",
    type = "Array",
    des = "\230\181\143\232\167\136\229\133\179\229\141\161\230\150\135\230\156\172",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\178\187\229\174\137\228\184\173\229\191\131",
    name = "enterOfferText",
    type = "Array",
    des = "\232\191\155\229\133\165\230\130\172\232\181\143\229\133\179\230\150\135\230\156\172",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\178\187\229\174\137\228\184\173\229\191\131",
    name = "notEnterOfferText",
    type = "Array",
    des = "\228\184\141\229\143\175\232\191\155\229\133\165\230\130\172\232\181\143\229\133\179\230\150\135\230\156\172",
    detail = "id#num"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "tabBuyText",
    type = "Array",
    des = "\230\137\147\229\188\128\232\180\173\228\185\176\233\161\181\231\173\190",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "tabSellText",
    type = "Array",
    des = "\230\137\147\229\188\128\229\135\186\229\148\174\233\161\181\231\173\190",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "buyDownText",
    type = "Array",
    des = "\229\176\134\230\137\147\230\138\152\229\149\134\229\147\129\229\138\160\229\133\165\233\162\132\232\180\173",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "buyUpText",
    type = "Array",
    des = "\229\176\134\230\182\168\228\187\183\229\149\134\229\147\129\229\138\160\229\133\165\233\162\132\232\180\173",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "buyFlatText",
    type = "Array",
    des = "\229\176\134\229\142\159\228\187\183\229\149\134\229\147\129\229\138\160\229\133\165\233\162\132\232\180\173",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "cancelBuyText",
    type = "Array",
    des = "\229\176\134\231\137\169\229\147\129\228\187\142\233\162\132\232\180\173\228\184\173\229\143\150\230\182\136",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128,\230\180\187\229\138\168",
    name = "buySuccessText",
    type = "Array",
    des = "\232\180\173\228\185\176\230\136\144\229\138\159",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "sellDownText",
    type = "Array",
    des = "\229\176\134\230\138\152\230\137\163\229\149\134\229\147\129\229\138\160\229\133\165\233\162\132\229\135\186\229\148\174",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "sellUpText",
    type = "Array",
    des = "\229\176\134\230\182\168\228\187\183\229\149\134\229\147\129\229\138\160\229\133\165\233\162\132\229\135\186\229\148\174",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "sellFlatText",
    type = "Array",
    des = "\229\176\134\229\142\159\228\187\183\229\149\134\229\147\129\229\138\160\229\133\165\233\162\132\229\135\186\229\148\174",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "cancelSellText",
    type = "Array",
    des = "\229\176\134\231\137\169\229\147\129\228\187\142\233\162\132\229\135\186\229\148\174\228\184\173\229\143\150\230\182\136",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "sellSuccessText",
    type = "Array",
    des = "\229\135\186\229\148\174\230\136\144\229\138\159",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "haggleSuccessText",
    type = "Array",
    des = "\231\160\141\228\187\183\230\136\144\229\138\159",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "haggleFailText",
    type = "Array",
    des = "\231\160\141\228\187\183\229\164\177\232\180\165",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "raiseSuccessText",
    type = "Array",
    des = "\230\138\172\228\187\183\230\136\144\229\138\159",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "raiseFailText",
    type = "Array",
    des = "\230\138\172\228\187\183\229\164\177\232\180\165",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "openWarehouseText",
    type = "Array",
    des = "\230\137\147\229\188\128\228\187\147\229\186\147",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "buySettlementText",
    type = "Array",
    des = "\228\185\176\229\133\165\231\187\147\231\174\151",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "sellSettlementText",
    type = "Array",
    des = "\229\141\150\229\135\186\231\187\147\231\174\151",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\184\130\230\148\191\229\142\133",
    name = "investText",
    type = "Array",
    des = "\230\138\149\232\181\132\229\175\185\232\175\157",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\184\130\230\148\191\229\142\133",
    name = "investOneText",
    type = "Array",
    des = "\230\138\149\232\181\132\239\188\13610w\239\188\137",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\184\130\230\148\191\229\142\133",
    name = "investTwoText",
    type = "Array",
    des = "\230\138\149\232\181\132\239\188\13620w\239\188\137",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\184\130\230\148\191\229\142\133",
    name = "investThreeText",
    type = "Array",
    des = "\230\138\149\232\181\132\239\188\13630w\239\188\137",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\184\130\230\148\191\229\142\133",
    name = "investFourText",
    type = "Array",
    des = "\230\138\149\232\181\132\239\188\13640w\239\188\137",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\184\130\230\148\191\229\142\133",
    name = "investFiveText",
    type = "Array",
    des = "\230\138\149\232\181\132\239\188\13650w\239\188\137",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\184\130\230\148\191\229\142\133",
    name = "investSixText",
    type = "Array",
    des = "\230\138\149\232\181\132\239\188\136100w\239\188\137",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\229\186\151",
    name = "animalStoreText",
    type = "Array",
    des = "\230\137\147\229\188\128\228\185\176\229\141\150\231\149\140\233\157\162",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\229\186\151",
    name = "petStoreText",
    type = "Array",
    des = "\230\137\147\229\188\128\229\174\160\231\137\169\229\186\151\233\161\181\231\173\190",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\229\186\151",
    name = "plantStoreText",
    type = "Array",
    des = "\230\137\147\229\188\128\230\164\141\231\137\169\229\186\151\233\161\181\231\173\190",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\229\186\151",
    name = "fishStoreText",
    type = "Array",
    des = "\230\137\147\229\188\128\230\176\180\230\151\143\229\186\151\233\161\181\231\173\190",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\229\186\151",
    name = "petStuffStoreText",
    type = "Array",
    des = "\230\137\147\229\188\128\229\174\160\231\137\169\231\148\168\229\147\129\229\186\151\233\161\181\231\173\190",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\229\186\151",
    name = "petSellText",
    type = "Array",
    des = "\229\174\160\231\137\169\229\155\158\230\148\182\229\149\134\229\186\151",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\229\186\151",
    name = "plantSellText",
    type = "Array",
    des = "\230\164\141\231\137\169\229\155\158\230\148\182\229\149\134\229\186\151",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\229\186\151",
    name = "fishSellText",
    type = "Array",
    des = "\230\176\180\230\151\143\229\155\158\230\148\182\229\149\134\229\186\151",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\174\160\231\137\169\229\186\151",
    name = "petStuffSellText",
    type = "Array",
    des = "\229\174\160\231\137\169\231\148\168\229\147\129\229\155\158\230\148\182\229\149\134\229\186\151",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "tabBattleText",
    type = "Array",
    des = "\230\137\147\229\188\128\228\189\156\230\136\152\232\174\161\229\136\146\233\161\181\231\173\190",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131,\229\133\145\230\141\162\231\171\153,\233\187\145\230\156\136\230\156\141\232\163\133\232\174\162\229\141\149\231\171\153",
    name = "tabOrderText",
    type = "Array",
    des = "\230\137\147\229\188\128\231\137\169\232\181\132\232\191\144\232\190\147\233\161\181\231\173\190",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131,\229\133\145\230\141\162\231\171\153,\233\187\145\230\156\136\230\156\141\232\163\133\232\174\162\229\141\149\231\171\153",
    name = "orderSuccessText",
    type = "Array",
    des = "\230\136\144\229\138\159\228\186\164\228\187\152",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "signText",
    type = "Array",
    des = "\230\160\135\232\174\176\232\174\162\229\141\149",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "cancelSignText",
    type = "Array",
    des = "\229\143\150\230\182\136\230\160\135\232\174\176",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "discardText",
    type = "Array",
    des = "\228\184\162\229\188\131",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\158\131\229\156\190\231\171\153",
    name = "enterRecycleText",
    type = "Array",
    des = "\232\191\155\229\133\165\229\155\158\230\148\182\231\149\140\233\157\162",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\158\131\229\156\190\231\171\153",
    name = "recycleSuccessText",
    type = "Array",
    des = "\230\136\144\229\138\159\229\155\158\230\148\182",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\229\158\131\229\156\190\231\171\153",
    name = "rewardGetText",
    type = "Array",
    des = "\228\187\187\229\138\161\229\165\150\229\138\177\233\162\134\229\143\150",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131,\229\133\145\230\141\162\231\171\153",
    name = "enterExchangeText",
    type = "Array",
    des = "\232\191\155\229\133\165\229\133\145\230\141\162\231\149\140\233\157\162",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "enterSaleText",
    type = "Array",
    des = "\232\191\155\229\133\165\229\135\186\229\148\174\231\149\140\233\157\162",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131,\229\133\145\230\141\162\231\171\153",
    name = "exchangeSuccessText",
    type = "Array",
    des = "\230\136\144\229\138\159\229\133\145\230\141\162",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\189\156\230\136\152\228\184\173\229\191\131",
    name = "saleSuccessText",
    type = "Array",
    des = "\230\136\144\229\138\159\229\135\186\229\148\174",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\180\187\229\138\168",
    name = "saleOutText",
    type = "Array",
    des = "\229\148\174\231\189\132",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "",
    type = "SysLine",
    des = "\233\133\141\233\159\179"
  },
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "stationSoundList",
    type = "Array",
    des = "\232\189\166\231\171\153\233\133\141\233\159\179",
    detail = "stationId#soundId",
    pyIgnore = true
  },
  {
    name = "stationId",
    type = "Factory",
    des = "\232\189\166\231\171\153",
    arg0 = "HomeStationFactory",
    pyIgnore = true
  },
  {
    name = "soundId",
    type = "Factory",
    des = "\233\133\141\233\159\179",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\228\186\164\230\152\147\230\137\128",
    name = "goodsSoundList",
    type = "Array",
    des = "\232\180\167\231\137\169\233\133\141\233\159\179",
    detail = "goodsId#soundId",
    pyIgnore = true
  },
  {
    name = "goodsId",
    type = "Factory",
    des = "\232\180\167\231\137\169",
    arg0 = "HomeGoodsFactory",
    arg1 = "\229\159\186\231\161\128\232\180\167\231\137\169",
    pyIgnore = true
  },
  {
    name = "soundId",
    type = "Factory",
    des = "\233\133\141\233\159\179",
    arg0 = "SoundFactory",
    pyIgnore = true
  },
  {name = "end", pyIgnore = true},
  {
    mod = "\230\149\180\233\161\191\228\184\173\229\191\131",
    name = "prisonOpenShopText",
    type = "Array",
    des = "\230\137\147\229\188\128\229\149\134\229\186\151\231\149\140\233\157\162",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\149\180\233\161\191\228\184\173\229\191\131",
    name = "prisonExchangeText",
    type = "Array",
    des = "\229\133\145\230\141\162\229\149\134\229\147\129",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\149\180\233\161\191\228\184\173\229\191\131",
    name = "prisonMaterialText",
    type = "Array",
    des = "\230\147\141\228\189\156\229\142\159\230\150\153\228\187\147\229\186\147",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\149\180\233\161\191\228\184\173\229\191\131",
    name = "prisonProductlText",
    type = "Array",
    des = "\230\147\141\228\189\156\230\136\144\229\147\129\228\187\147\229\186\147",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\149\180\233\161\191\228\184\173\229\191\131",
    name = "prisonOpenWarehouseText",
    type = "Array",
    des = "\230\137\147\229\188\128\228\187\147\229\186\147\231\149\140\233\157\162",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\139\188\229\141\149\229\141\149",
    name = "chooseOrderText",
    type = "Array",
    des = "\233\128\137\228\184\173\230\139\188\229\141\149",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\139\188\229\141\149\229\141\149",
    name = "joinOrderText",
    type = "Array",
    des = "\229\138\160\229\133\165\230\139\188\229\141\149",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\139\188\229\141\149\229\141\149",
    name = "refreshOrderText",
    type = "Array",
    des = "\230\141\162\228\184\128\230\137\185",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\138\149\232\181\132\228\184\173\229\191\131",
    name = "investOpenText",
    type = "Array",
    des = "\230\137\147\229\188\128\231\149\140\233\157\162",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\138\149\232\181\132\228\184\173\229\191\131",
    name = "investChatText",
    type = "Array",
    des = "\230\151\165\229\184\184\228\186\164\232\176\136",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\138\149\232\181\132\228\184\173\229\191\131",
    name = "investSuccessText",
    type = "Array",
    des = "\230\138\149\232\181\132\230\136\144\229\138\159",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\138\149\232\181\132\228\184\173\229\191\131",
    name = "investFailText",
    type = "Array",
    des = "\230\138\149\232\181\132\229\164\177\232\180\165",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"},
  {
    mod = "\230\138\149\232\181\132\228\184\173\229\191\131",
    name = "investQuestText",
    type = "Array",
    des = "\228\187\187\229\138\161\231\149\140\233\157\162",
    detail = "id#weight#reputation"
  },
  {
    name = "id",
    type = "Factory",
    des = "\230\146\173\230\148\190\230\150\135\230\156\172",
    arg0 = "TextFactory#ListFactory"
  },
  {
    name = "weight",
    type = "Int",
    des = "\230\157\131\233\135\141",
    arg0 = "10"
  },
  {
    name = "reputation",
    type = "Int",
    des = "\230\137\128\233\156\128\229\163\176\230\156\155\231\173\137\231\186\167",
    arg0 = "0"
  },
  {name = "end"}
})
