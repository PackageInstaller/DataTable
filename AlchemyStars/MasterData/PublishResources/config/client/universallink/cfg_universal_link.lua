local key = {
  ID = 1,
  OpenType = 2,
  UI = 3,
  GameModuleID = 4,
  CampaignType = 5,
  Param = 6
}
local config = {
  [120011] = {
    120011,
    1,
    "UIShopController",
    9,
    nil,
    {0, 5}
  },
  [120013] = {
    120013,
    2,
    "UIDrawCard",
    8
  },
  [120014] = {
    120014,
    3,
    "UIActivityN9MainController",
    nil,
    10015
  }
}
return config, "ID", key
