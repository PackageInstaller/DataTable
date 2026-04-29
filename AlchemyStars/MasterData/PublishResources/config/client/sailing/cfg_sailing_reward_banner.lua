local key = {
  ID = 1,
  Icon = 2,
  Title = 3,
  Desc = 4,
  UnlockInfo = 5,
  ItemID = 6
}
local common = {
  "str_sailing_mission_sp_reward"
}
local config = {
  {
    1,
    "N22_dhh_jlts_banner01",
    "str_sailing_mission_banner1_title",
    "str_sailing_mission_banner1_desc"
  },
  {
    2,
    "N22_dhh_jlts_banner02",
    "str_sailing_mission_banner2_title",
    "str_sailing_mission_banner2_desc"
  },
  {
    3,
    "N22_dhh_jlts_banner03",
    "str_sailing_mission_banner3_title",
    "str_sailing_mission_banner3_desc"
  },
  {
    4,
    "N22_dhh_jlts_banner04",
    "str_sailing_mission_banner4_title",
    "str_sailing_mission_banner4_desc",
    common[1],
    1501301
  },
  {
    5,
    "N22_dhh_jlts_banner05",
    "str_sailing_mission_banner5_title",
    "str_sailing_mission_banner5_desc",
    common[1],
    4091193
  }
}
return config, "ID", key
