local key = {
  ID = 1,
  TabName = 2,
  TabNamePic = 3,
  TabPicture = 4,
  LevelDesc = 5,
  FightAttrDesc = 6,
  UIStyle = 7
}
local common = {
  "cn12_zdg_di29",
  "cn12_zdg_di28",
  "cn12_zdg_di27",
  "ycxxxg_zi02",
  "ycxxxg_zi03",
  "ycxxxg_zi01"
}
local config = {
  [800500513] = {
    800500513,
    "str_season_s5_branch_tab_button_2",
    "cn12_zdg_di32",
    common[1]
  },
  [800500514] = {
    800500514,
    "str_season_s5_branch_tab_button_3",
    "cn12_zdg_di33",
    common[2]
  },
  [800500515] = {
    800500515,
    "str_season_s5_branch_tab_button_1",
    "cn12_zdg_di31",
    common[3]
  },
  [800600513] = {
    800600513,
    "str_season_s6_branch_tab_button_2",
    common[4],
    common[1],
    "str_season_s6_branch_tab_desc_2",
    "str_season_s6_branch_tab_detail_2",
    2
  },
  [800600514] = {
    800600514,
    "str_season_s6_branch_tab_button_3",
    common[5],
    common[2],
    "str_season_s6_branch_tab_desc_3",
    "str_season_s6_branch_tab_detail_3",
    3
  },
  [800600515] = {
    800600515,
    "str_season_s6_branch_tab_button_1",
    common[6],
    common[3],
    "str_season_s6_branch_tab_desc_1",
    "str_season_s6_branch_tab_detail_1",
    1
  },
  [800700513] = {
    800700513,
    "str_season_s7_branch_tab_button_2",
    common[4],
    common[1],
    "str_season_s7_branch_tab_desc_2",
    "str_season_s7_branch_tab_detail_2",
    2
  },
  [800700514] = {
    800700514,
    "str_season_s7_branch_tab_button_3",
    common[5],
    common[2],
    "str_season_s7_branch_tab_desc_3",
    "str_season_s7_branch_tab_detail_3",
    3
  },
  [800700515] = {
    800700515,
    "str_season_s7_branch_tab_button_1",
    common[6],
    common[3],
    "str_season_s7_branch_tab_desc_1",
    "str_season_s7_branch_tab_detail_1",
    1
  },
  [800800513] = {
    800800513,
    "str_season_s8_branch_tab_button_2",
    common[4],
    common[1],
    "str_season_s8_branch_tab_desc_2",
    "str_season_s8_branch_tab_detail_2",
    2
  },
  [800800514] = {
    800800514,
    "str_season_s8_branch_tab_button_3",
    common[5],
    common[2],
    "str_season_s8_branch_tab_desc_3",
    "str_season_s8_branch_tab_detail_3",
    3
  },
  [800800515] = {
    800800515,
    "str_season_s8_branch_tab_button_1",
    common[6],
    common[3],
    "str_season_s8_branch_tab_desc_1",
    "str_season_s8_branch_tab_detail_1",
    1
  }
}
return config, "ID", key
