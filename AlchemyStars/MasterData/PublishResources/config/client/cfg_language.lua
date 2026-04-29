local key = {
  ID = 1,
  Index = 2,
  Text = 3,
  Sprite = 4
}
local config = {
  [2] = {
    2,
    2,
    "str_set_language_tw",
    "install_shezhi_zi2"
  },
  [4] = {
    4,
    3,
    "str_set_language_us",
    "install_shezhi_zi3"
  },
  [8] = {
    8,
    4,
    "str_set_language_kr",
    "install_shezhi_zi4"
  },
  [16] = {
    16,
    5,
    "str_set_language_jp",
    "install_shezhi_zi5"
  },
  [32] = {
    32,
    6,
    "str_set_language_pt",
    "install_shezhi_zi6"
  },
  [64] = {
    64,
    7,
    "str_set_language_es",
    "install_shezhi_zi7"
  },
  [128] = {
    128,
    8,
    "str_set_language_idn",
    "install_shezhi_zi8"
  },
  [256] = {
    256,
    9,
    "str_set_language_th",
    "install_shezhi_zi9"
  }
}
return config, "ID", key
