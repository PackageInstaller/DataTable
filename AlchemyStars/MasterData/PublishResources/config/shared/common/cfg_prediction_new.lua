local key = {
  ID = 1,
  enter = 2,
  mainBG = 3,
  titleIcon = 4,
  beginTime = 5,
  endTime = 6,
  spine = 7,
  leftTimeIcon = 8,
  leftTime = 9,
  forecastTitle = 10,
  forecastContent = 11
}
local common = {
  "main_open_di46",
  "main_general_di16",
  "n45_zjm_ent",
  "main_general_di02",
  "#ffe1bb",
  {"06", "12"}
}
local config = {
  [1000042] = {
    1000042,
    common[1],
    common[2],
    common[3],
    {"05", "22"},
    common[6],
    "main_prediction_general_board",
    common[4],
    common[5],
    "str_prediction_info_title",
    "str_prediction_info_1000042"
  },
  [1000043] = {
    1000043,
    common[1],
    common[2],
    common[3],
    common[6],
    {"07", "03"},
    "main_prediction_comic47_pet",
    common[4],
    common[5]
  },
  [1000044] = {
    1000044,
    common[1],
    common[2],
    common[3],
    {"07", "26"},
    {"08", "16"},
    "main_prediction_comic49_pet",
    common[4],
    common[5]
  }
}
return config, "ID", key
