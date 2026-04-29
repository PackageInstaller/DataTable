local key = {
  ID = 1,
  Count = 2,
  DropId = 3,
  Icon = 4,
  Desc = 5,
  Name = 6
}
local common = {
  "str_tale_pet_trail_level_reward_des"
}
local config = {
  {
    1,
    4,
    630001,
    "icon_3621008_furniture",
    common[1],
    "str_tale_pet_mission_award_01"
  },
  {
    2,
    8,
    630002,
    "icon_3642301_furniture",
    common[1],
    "str_tale_pet_mission_award_02"
  },
  {
    3,
    12,
    630003,
    "icon_3642201_furniture",
    common[1],
    "str_tale_pet_mission_award_03"
  },
  {
    4,
    16,
    630004,
    "icon_3641301_furniture",
    common[1],
    "str_tale_pet_mission_award_04"
  }
}
return config, "ID", key
