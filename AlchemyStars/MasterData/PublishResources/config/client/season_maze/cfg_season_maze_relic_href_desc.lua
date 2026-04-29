local key = {
  ID = 1,
  PS = 2,
  Name = 3,
  Desc = 4
}
local common = {
  "str_season_maze_relic_001_effect_name",
  "str_season_maze_relic_001_effect_tips"
}
local config = {
  [1001] = {
    1001,
    "词条1",
    common[1],
    common[2]
  },
  [1002] = {
    1002,
    "词条2",
    common[1],
    common[2]
  },
  [1003] = {
    1003,
    "融化",
    "str_season_maze_relic_003_effect_name",
    "str_season_maze_relic_003_effect_tips"
  },
  [1004] = {
    1004,
    "诅咒血",
    "str_season_maze_relic_004_effect_name",
    "str_season_maze_relic_004_effect_tips"
  },
  [1005] = {
    1005,
    "算法升级模块",
    "str_season_maze_relic_005_effect_name",
    "str_season_maze_relic_005_effect_tips"
  },
  [1006] = {
    1006,
    "过载值",
    "str_season_maze_relic_006_effect_name",
    "str_season_maze_relic_006_effect_tips"
  },
  [1007] = {
    1007,
    "溃痛（中毒）",
    "str_season_maze_relic_007_effect_name",
    "str_season_maze_relic_007_effect_tips"
  },
  [1008] = {
    1008,
    "灼热",
    "str_season_maze_relic_008_effect_name",
    "str_season_maze_relic_008_effect_tips"
  },
  [1009] = {
    1009,
    "创伤（流血）",
    "str_season_maze_relic_009_effect_name",
    "str_season_maze_relic_009_effect_tips"
  },
  [1010] = {
    1010,
    "致盲",
    "str_season_maze_relic_010_effect_name",
    "str_season_maze_relic_010_effect_tips"
  },
  [1011] = {
    1011,
    "麻痹",
    "str_season_maze_relic_011_effect_name",
    "str_season_maze_relic_011_effect_tips"
  },
  [1012] = {
    1012,
    "恐惧",
    "str_season_maze_relic_012_effect_name",
    "str_season_maze_relic_012_effect_tips"
  }
}
return config, "ID", key
