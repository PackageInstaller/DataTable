local key = {
  ID = 1,
  CampaignType = 2,
  ComponentID = 3,
  TabName = 4
}
local common = {
  "str_shop_activity_limit_time_tab_1"
}
local config = {
  [100100] = {
    100100,
    10064,
    3,
    common[1]
  },
  [100103] = {
    100103,
    10106,
    7,
    "str_shop_n42_title"
  },
  [100104] = {
    100104,
    10107,
    3,
    common[1]
  },
  [100105] = {
    100105,
    10033,
    6,
    "str_n25_point_shop"
  },
  [100106] = {
    100106,
    50033,
    6,
    "str_shop_cn16_title"
  },
  [100107] = {
    100107,
    50034,
    6,
    "str_shop_cn17_title"
  },
  [100108] = {
    100108,
    50035,
    6,
    "str_shop_cn18_title"
  },
  [100109] = {
    100109,
    10109,
    6,
    "str_n48_shop_name"
  },
  [100120] = {
    100120,
    50037,
    5,
    "str_shop_cn20_title"
  },
  [100110] = {
    100110,
    50038,
    5,
    "str_shop_cn21_title"
  },
  [100111] = {
    100111,
    50039,
    5,
    "str_shop_cn22_title"
  }
}
return config, "ID", key
