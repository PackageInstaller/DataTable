local key = {
  ID = 1,
  ComponentID = 2,
  MissionID = 3,
  ItemID = 4,
  Icon = 5,
  UnlockName = 6,
  LockName = 7,
  InnerRewardDesc = 8,
  Desc = 9,
  LockClue = 10,
  LockRoleSpeak = 11,
  UnlockRoleSpeak = 12
}
local common = {
  "str_xiaolinjia_itemdesc_1",
  "str_xiaolinjia_itemdesc_2",
  "str_xiaolinjia_itemdesc_3",
  "str_xiaolinjia_itemdesc_4",
  "str_xiaolinjia_itemdesc_5",
  "str_xiaolinjia_itemdesc_6"
}
local config = {
  {
    1,
    502711706,
    1,
    7000500,
    "n36_chh_dt02",
    "str_xiaolinjia_itemname_1",
    "str_xiaolinjia_itemname_lock_1",
    common[1],
    common[1],
    "str_xiaolinjia_itemdesc_lock_1",
    "str_xiaolinjia_rolephrase_lock_1",
    "str_xiaolinjia_rolephrase_1"
  },
  {
    2,
    502711706,
    2,
    7000501,
    "n36_chh_dt01",
    "str_xiaolinjia_itemname_2",
    "str_xiaolinjia_itemname_lock_2",
    common[2],
    common[2],
    "str_xiaolinjia_itemdesc_lock_2",
    "str_xiaolinjia_rolephrase_lock_2",
    "str_xiaolinjia_rolephrase_2"
  },
  {
    3,
    502711706,
    3,
    7000502,
    "n36_chh_dt03",
    "str_xiaolinjia_itemname_3",
    "str_xiaolinjia_itemname_lock_3",
    common[3],
    common[3],
    "str_xiaolinjia_itemdesc_lock_3",
    "str_xiaolinjia_rolephrase_lock_3",
    "str_xiaolinjia_rolephrase_3"
  },
  {
    4,
    502711706,
    4,
    7000503,
    "n36_chh_dt04",
    "str_xiaolinjia_itemname_4",
    "str_xiaolinjia_itemname_lock_4",
    common[4],
    common[4],
    "str_xiaolinjia_itemdesc_lock_4",
    "str_xiaolinjia_rolephrase_lock_4",
    "str_xiaolinjia_rolephrase_4"
  },
  {
    5,
    502711706,
    5,
    7000504,
    "n36_chh_dt05",
    "str_xiaolinjia_itemname_5",
    "str_xiaolinjia_itemname_lock_5",
    common[5],
    common[5],
    "str_xiaolinjia_itemdesc_lock_5",
    "str_xiaolinjia_rolephrase_lock_5",
    "str_xiaolinjia_rolephrase_5"
  },
  {
    6,
    502711706,
    6,
    7000505,
    "n36_chh_dt06",
    "str_xiaolinjia_itemname_6",
    "str_xiaolinjia_itemname_lock_6",
    common[6],
    common[6],
    "str_xiaolinjia_itemdesc_lock_6",
    "str_xiaolinjia_rolephrase_lock_6",
    "str_xiaolinjia_rolephrase_6"
  }
}
return config, "ID", key
