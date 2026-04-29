local key = {
  ID = 1,
  LevelID = 2,
  WaveCount = 3,
  RecommendAwaken = 4,
  RecomendLV = 5,
  MissionName = 6,
  BaseWordBuff = 7,
  RecommendDesc = 8
}
local common = {
  {5250010, 40804},
  {5250013, 40804},
  {
    5250014,
    5250011,
    40804
  },
  {
    5250015,
    5250011,
    5250012,
    40804
  },
  "str_n25_battlefield_mission_name1",
  "str_n25_battlefield_mission_name2",
  "str_n25_battlefield_mission_name3",
  "str_n25_battlefield_mission_name4",
  "str_n25_battlefield_mission_name5",
  "str_n25_battlefield_mission_name6"
}
local config = {
  [10001] = {
    10001,
    5259001,
    5,
    3,
    1,
    common[5],
    common[1]
  },
  [10002] = {
    10002,
    5259002,
    8,
    3,
    1,
    common[6],
    common[2]
  },
  [10003] = {
    10003,
    5259003,
    8,
    3,
    1,
    common[7],
    common[2]
  },
  [10004] = {
    10004,
    5259004,
    10,
    3,
    1,
    common[8],
    common[3]
  },
  [10005] = {
    10005,
    5259005,
    10,
    3,
    1,
    common[9],
    common[3]
  },
  [10006] = {
    10006,
    5259006,
    12,
    3,
    1,
    common[10],
    common[4]
  },
  [10007] = {
    10007,
    5449001,
    5,
    3,
    1,
    common[5],
    common[1]
  },
  [10008] = {
    10008,
    5449002,
    8,
    3,
    1,
    common[6],
    common[2]
  },
  [10009] = {
    10009,
    5449003,
    8,
    3,
    1,
    common[7],
    common[2]
  },
  [10010] = {
    10010,
    5449004,
    10,
    3,
    1,
    common[8],
    common[3]
  },
  [10011] = {
    10011,
    5449005,
    10,
    3,
    1,
    common[9],
    common[3]
  },
  [10012] = {
    10012,
    5449006,
    12,
    3,
    1,
    common[10],
    common[4]
  }
}
return config, "ID", key
