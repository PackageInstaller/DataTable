local key = {
  ID = 1,
  Quality = 2,
  ItemIcon = 3,
  MapIcon = 4,
  CardIcon = 5,
  Name = 6,
  Desc = 7
}
local common = {
  "cn14_sjmj_zjm_jifen",
  "str_season_maze_lv_prop_200",
  "str_season_maze_lv_prop_201",
  "str_season_maze_lv_prop_202",
  "str_season_maze_lv_prop_203",
  "str_season_maze_lv_prop_204",
  "str_season_maze_lv_prop_205"
}
local config = {
  {
    1,
    1,
    "season_maze_map_icon_attr_01",
    "season_maze_map_toptoon_attr_01",
    "season_maze_card_toptoon_attr_01",
    "str_season_maze_gold_name",
    "str_season_maze_gold_desc"
  },
  {
    2,
    1,
    "season_maze_map_icon_attr_02",
    "season_maze_map_toptoon_attr_02",
    "season_maze_card_toptoon_attr_02",
    "str_season_maze_exp_name",
    "str_season_maze_exp_desc"
  },
  {
    3,
    1,
    "season_maze_map_icon_attr_03",
    "season_maze_map_toptoon_attr_03",
    "season_maze_card_toptoon_attr_03",
    "str_season_maze_ms_name",
    "str_season_maze_ms_desc"
  },
  {4, 1},
  {5, 1},
  {
    6,
    1,
    "season_maze_map_icon_attr_06",
    "season_maze_map_toptoon_attr_06",
    "season_maze_card_toptoon_attr_06",
    "str_season_maze_add_name",
    "str_season_maze_add_desc"
  },
  {7, 1},
  {8, 1},
  {9, 1},
  {10, 1},
  {
    11,
    1,
    "season_maze_map_icon_attr_11",
    "season_maze_map_toptoon_attr_11",
    "season_maze_card_toptoon_attr_11",
    "str_season_maze_card_add_name",
    "str_season_maze_card_add_desc"
  },
  {12, 1},
  [14] = {14, 1},
  [15] = {15, 1},
  [16] = {16, 1},
  [17] = {17, 1},
  [18] = {18, 1},
  [19] = {19, 1},
  [20] = {20, 1},
  [21] = {21, 1},
  [22] = {22, 1},
  [23] = {23, 1},
  [24] = {24, 1},
  [25] = {25, 1},
  [26] = {26, 1},
  [27] = {
    27,
    1,
    "season_maze_map_icon_attr_27",
    common[1],
    common[1],
    "str_season_maze_points_name",
    "str_season_maze_points_desc"
  },
  [33] = {33, 1},
  [34] = {34, 1},
  [37] = {
    37,
    1,
    "season_maze_map_icon_attr_14",
    nil,
    nil,
    "str_season_maze_ticket_name",
    "str_season_maze_ticket_desc"
  },
  [200] = {
    200,
    1,
    nil,
    nil,
    nil,
    common[2],
    common[2]
  },
  [201] = {
    201,
    1,
    nil,
    nil,
    nil,
    common[3],
    common[3]
  },
  [202] = {
    202,
    1,
    nil,
    nil,
    nil,
    common[4],
    common[4]
  },
  [203] = {
    203,
    1,
    nil,
    nil,
    nil,
    common[5],
    common[5]
  },
  [204] = {
    204,
    1,
    nil,
    nil,
    nil,
    common[6],
    common[6]
  },
  [205] = {
    205,
    1,
    nil,
    nil,
    nil,
    common[7],
    common[7]
  }
}
return config, "ID", key
