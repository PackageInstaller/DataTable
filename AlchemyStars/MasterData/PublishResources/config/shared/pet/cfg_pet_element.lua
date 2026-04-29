local key = {
  ID = 1,
  Name = 2,
  TeamIcon = 3,
  Icon = 4,
  IconWhite = 5
}
local common = {
  "ui_pet_tag_name_4",
  "map_biandui_lei"
}
local config = {
  {
    1,
    "ui_pet_tag_name_1",
    "map_biandui_shui",
    "bing_color",
    "bing"
  },
  {
    2,
    "ui_pet_tag_name_2",
    "map_biandui_huo",
    "huo_color",
    "huo"
  },
  {
    3,
    "ui_pet_tag_name_3",
    "map_biandui_sen",
    "sen_color",
    "sen"
  },
  {
    4,
    common[1],
    common[2],
    "lei_color",
    "lei"
  },
  [6] = {
    6,
    common[1],
    common[2],
    "wu_color",
    "wu"
  }
}
return config, "ID", key
