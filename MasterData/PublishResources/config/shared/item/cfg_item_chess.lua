local key = {
  ID = 1,
  type = 2,
  order = 3,
  showNoSkin = 4,
  icon = 5,
  thumbnail = 6,
  pieceSkinID = 7,
  acquisitionPath = 8,
  hasGridLine = 9
}
local config = {
  [8800001] = {
    8800001,
    1,
    2,
    1,
    "install_blind_tu1",
    "install_blind_icon3",
    1001,
    nil,
    1
  },
  [8800002] = {
    8800002,
    1,
    3,
    1,
    "install_blind_tu2",
    "install_blind_icon2",
    1002,
    nil,
    0
  },
  [8800003] = {
    8800003,
    1,
    4,
    1,
    "install_blind_tu3",
    "install_blind_icon1",
    1003,
    nil,
    0
  },
  [8800004] = {
    8800004,
    2,
    1,
    1,
    "install_blind_tu4",
    "install_blind_icon4",
    1004,
    "str_set_color_get_path_1",
    0
  }
}
return config, "ID", key
