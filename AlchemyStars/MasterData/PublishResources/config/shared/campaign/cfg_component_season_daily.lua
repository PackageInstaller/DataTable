local key = {
  ID = 1,
  ComponentID = 2,
  MapMode = 3,
  MaxReward = 4,
  MaxHigh = 5,
  MaxSame = 6,
  MaxProgress = 7,
  LockTitle = 8,
  LockContent = 9,
  UnlockTitle = 10,
  UnlockContent = 11,
  RefreshText = 12,
  UnlockTime = 13,
  CloseTime = 14,
  NeedMission = 15,
  SwitchModeText = 16
}
local common = {
  {2},
  "str_season_daily_s1_level_title_1",
  "str_season_daily_s1_level_title_2",
  "str_season_daily_s1_level_condition_2",
  "str_season_daily_s1_refresh",
  "str_season_daily_s2_switchmode"
}
local config = {
  {
    1,
    800107201,
    {1},
    5,
    2,
    1,
    5,
    common[2],
    "str_season_daily_s1_level_condition_1",
    common[3],
    common[4],
    common[5],
    "2023-09-06 05:00:00",
    "2023-09-27 04:00:00",
    8001023,
    common[6]
  },
  [8002] = {
    8002,
    800207201,
    common[1],
    5,
    2,
    1,
    5,
    common[2],
    "str_season_daily_s2_level_condition_1",
    common[3],
    common[4],
    common[5],
    "2023-10-04 05:00:00",
    "2023-11-06 05:00:00",
    8002035,
    common[6]
  },
  [8004] = {
    8004,
    800407201,
    common[1],
    5,
    2,
    1,
    5,
    "str_season_s4_daily_level_title_1",
    "str_season_s4_daily_level_condition_1",
    "str_season_s4_daily_level_title_2",
    "str_season_s4_daily_level_condition_2",
    "str_season_s4_daily_level_refresh",
    "2024-02-14 05:00:00",
    "2024-03-06 05:00:00",
    8004031,
    "str_season_s4_daily_level_switchmode"
  }
}
return config, "ID", key
