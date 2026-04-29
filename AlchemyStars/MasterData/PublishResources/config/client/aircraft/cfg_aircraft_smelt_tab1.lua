local key = {
  ID = 1,
  Name = 2,
  Icon = 3,
  SelectIcon = 4,
  Index = 5,
  TopTips = 6,
  UIType = 7
}
local common = {
  {3000013, 3000005}
}
local config = {
  {
    1,
    "str_aircraft_smelt_shuxing",
    "wind_ronglian_icon7",
    "wind_ronglian_icon8",
    1,
    common[1],
    1
  },
  {
    2,
    "str_aircraft_item_resolve",
    "resolve_fenjie_icon5",
    "resolve_fenjie_icon6",
    3,
    common[1],
    2
  },
  {
    3,
    "str_aircraft_smelt_juxiang",
    "resolve_fenjie_icon2",
    "resolve_fenjie_icon3",
    4,
    common[1],
    2
  },
  {
    4,
    "str_aircraft_smelt_shili",
    "wind_ronglian_icon5",
    "wind_ronglian_icon6",
    2,
    common[1],
    3
  }
}
return config, "ID", key
