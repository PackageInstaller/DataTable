local key = {
  ID = 1,
  ComponentID = 2,
  Icon = 3,
  LevelIcon = 4,
  Title = 5,
  Content = 6,
  EndingStory = 7,
  HeadIcon = 8,
  AfterPlayIcon = 9,
  lockTitle = 10,
  lockContent = 11,
  LockIcon = 12,
  RoleName = 13,
  ClosingHeadIcon = 14,
  OtherPlayerHeads = 15,
  SelectingFaceIcon = 16,
  StoryCfgName = 17
}
local common = {
  "n36_qhead_15",
  "n36_qhead_16",
  "str_xiaolinjia_rolename_2",
  "n36_qhead_13",
  "n36_qhead_14",
  "n36_qhead_12",
  {
    "n36_qhead_7",
    "n36_qhead_1"
  },
  {
    "n36_qhead_10",
    "n36_qhead_4"
  }
}
local config = {
  {
    1,
    502711706,
    "n36_chh_zp02",
    "n36_chh_xt02",
    "str_xiaolinjia_levelname_1",
    "str_xiaolinjia_leveldesc_1",
    50590102,
    common[7],
    nil,
    "str_xiaolinjia_levelname_lock_1",
    "str_xiaolinjia_leveldesc_lock_1",
    common[1],
    "str_xiaolinjia_rolename_1",
    common[1],
    common[7],
    {
      "n36_bust_8_1",
      "n36_bust_15_1",
      "n36_bust_7_1",
      "n36_bust_1_1"
    },
    "cfg_xiaolinjia_story_1"
  },
  {
    2,
    502711706,
    "n36_chh_zp05",
    "n36_chh_xt04",
    "str_xiaolinjia_levelname_2",
    "str_xiaolinjia_leveldesc_2",
    50590103,
    {
      "n36_qhead_11",
      "n36_qhead_3"
    },
    nil,
    "str_xiaolinjia_levelname_lock_2",
    "str_xiaolinjia_leveldesc_lock_2",
    common[2],
    common[3],
    common[2],
    {
      "n36_qhead_3",
      "n36_qhead_11"
    },
    {
      "n36_bust_8_1",
      "n36_bust_16_1",
      "n36_bust_3_2",
      "n36_bust_11_1",
      ""
    },
    "cfg_xiaolinjia_story_2"
  },
  {
    3,
    502711706,
    "n36_chh_zp03",
    "n36_chh_xt03",
    "str_xiaolinjia_levelname_3",
    "str_xiaolinjia_leveldesc_3",
    50590105,
    common[8],
    nil,
    "str_xiaolinjia_levelname_lock_3",
    "str_xiaolinjia_leveldesc_lock_3",
    common[4],
    "str_xiaolinjia_rolename_3",
    common[4],
    common[8],
    {
      "n36_bust_8_1",
      "n36_bust_13_1",
      "n36_bust_10_1",
      "n36_bust_4_1"
    },
    "cfg_xiaolinjia_story_4"
  },
  {
    4,
    502711706,
    "n36_chh_zp06",
    "n36_chh_xt05",
    "str_xiaolinjia_levelname_4",
    "str_xiaolinjia_leveldesc_4",
    50590104,
    {
      "n36_qhead_6",
      "n36_qhead_5"
    },
    nil,
    "str_xiaolinjia_levelname_lock_4",
    "str_xiaolinjia_leveldesc_lock_4",
    common[5],
    "str_xiaolinjia_rolename_4",
    common[5],
    {
      "n36_qhead_5",
      "n36_qhead_6"
    },
    {
      "n36_bust_8_1",
      "n36_bust_14_1",
      "n36_bust_5_1",
      "n36_bust_6_3"
    },
    "cfg_xiaolinjia_story_3"
  },
  {
    5,
    502711706,
    "n36_chh_zp01",
    "n36_chh_xt06",
    "str_xiaolinjia_levelname_5",
    "str_xiaolinjia_leveldesc_5",
    50590106,
    {
      "n36_qhead_9",
      "n36_qhead_2"
    },
    nil,
    "str_xiaolinjia_levelname_lock_5",
    "str_xiaolinjia_leveldesc_lock_5",
    common[6],
    "str_xiaolinjia_rolename_5",
    common[6],
    {
      "n36_qhead_2",
      "n36_qhead_9"
    },
    {
      "n36_bust_8_1",
      "n36_bust_12_1",
      "n36_bust_2_1",
      "n36_bust_9_1"
    },
    "cfg_xiaolinjia_story_5"
  },
  {
    6,
    502711706,
    "n36_chh_zp04",
    "n36_chh_xt01",
    "str_xiaolinjia_levelname_6",
    "str_xiaolinjia_leveldesc_6",
    50590107,
    nil,
    "n36_chh_zp07",
    "str_xiaolinjia_levelname_lock_6",
    "str_xiaolinjia_leveldesc_lock_6",
    nil,
    common[3],
    common[2]
  }
}
return config, "ID", key
