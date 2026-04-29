local key = {
  ID = 1,
  ComponentID = 2,
  OnceID = 3,
  ShowOrder = 4,
  Type = 5,
  LockHard = 6,
  Price = 7,
  BookSaveLv = 8,
  EffectIDs = 9,
  Name = 10,
  Desc = 11,
  Icon = 12,
  ToptoonIcon = 13
}
local config = {
  {
    1,
    900308001,
    1,
    4,
    8,
    1,
    10,
    0,
    {9},
    "str_season_maze_once_1_name",
    "str_season_maze_once_1_desc",
    "season_maze_map_icon_item_08",
    "season_maze_map_toptoon_item_08"
  },
  {
    2,
    900308001,
    2,
    3,
    11,
    1,
    30,
    0,
    nil,
    "str_season_maze_once_2_name",
    "str_season_maze_once_2_desc",
    "season_maze_map_icon_item_11",
    "season_maze_map_toptoon_item_11"
  },
  {
    3,
    900308001,
    3,
    2,
    12,
    1,
    75,
    0,
    nil,
    "str_season_maze_once_3_name",
    "str_season_maze_once_3_desc",
    "season_maze_map_icon_item_12",
    "season_maze_map_toptoon_item_12"
  },
  {
    4,
    900308001,
    4,
    1,
    13,
    1,
    50,
    0,
    nil,
    "str_season_maze_once_4_name",
    "str_season_maze_once_4_desc",
    "season_maze_map_icon_item_13",
    "season_maze_map_toptoon_item_13"
  }
}
return config, "ID", key
