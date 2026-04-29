local key = {
  ID = 1,
  UIName = 2,
  UINodeName = 3,
  PopPos = 4,
  PopTxtKey = 5
}
local common = {
  "UIMainLobbyController",
  "FrogNode1",
  "FrogNode2",
  "UIPlayerInfoController",
  {320, 328},
  {-192, -310}
}
local config = {
  {
    1,
    common[1],
    common[2],
    common[5],
    "str_cn14_n43_frog_pop_txt1"
  },
  {
    2,
    common[1],
    common[3],
    common[6],
    "str_cn14_n43_frog_pop_txt2"
  },
  {
    3,
    common[4],
    common[2],
    common[6],
    "str_cn14_n43_frog_pop_txt3"
  },
  {
    4,
    common[4],
    common[3],
    common[5],
    "str_cn14_n43_frog_pop_txt4"
  },
  {
    5,
    "UIDiscovery",
    common[2],
    common[6],
    "str_cn14_n43_frog_pop_txt5"
  },
  {
    6,
    "UIN43MainController",
    common[2],
    common[5],
    "str_cn14_n43_frog_pop_txt6"
  },
  {
    7,
    "UIAircraftController",
    common[2],
    common[5],
    "str_cn14_n43_frog_pop_txt7"
  },
  {
    8,
    "UIRecruit",
    common[2],
    common[5],
    "str_cn14_n43_frog_pop_txt8"
  },
  {
    9,
    "UIS5MainController",
    common[2],
    common[5],
    "str_cn14_n43_frog_pop_txt9"
  }
}
return config, "ID", key
