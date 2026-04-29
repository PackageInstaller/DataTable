local key = {
  ID = 1,
  Sort = 2,
  Matrix = 3,
  RotateCenter = 4,
  ScoreShow = 5,
  ScoreShow1 = 6,
  ScoreShow2 = 7,
  ScoreShow3 = 8,
  ScoreShow4 = 9,
  GameItemIcon = 10,
  BagItemIcon = 11,
  CanPutItemIcon = 12,
  UnPutItemIcon = 13,
  ItemThumbIcon = 14,
  Score = 15,
  ExtraScore = 16,
  ExtraScoreText = 17,
  PassCount = 18
}
local common = {
  "exp_s3_game_xuanzhong2",
  "exp_s3_game_xuanzhong10",
  "exp_s3_game_tuxing1",
  "exp_s3_game_xuanzhong3",
  "exp_s3_game_xuanzhong11",
  "exp_s3_game_tuxing5",
  "exp_s3_game_xuanzhong1",
  "exp_s3_game_xuanzhong9",
  "exp_s3_game_tuxing8",
  {
    {1, 1},
    {1, 1}
  },
  {
    {
      1,
      1,
      1
    }
  },
  {
    {1}
  },
  {2, 2},
  {2, 0},
  {2, -75},
  {-4, -65},
  {-2, -71},
  {2, -70},
  {2, 1},
  {1, 1},
  {25, -35},
  {-35, -25},
  {-25, 35},
  {35, 25}
}
local config = {
  {
    1,
    1,
    common[10],
    common[13],
    common[13],
    common[14],
    common[14],
    common[14],
    common[14],
    "s3_normaldebris_1",
    "icon_item_7000600",
    common[1],
    common[2],
    common[3],
    3,
    nil,
    nil,
    1
  },
  {
    2,
    3,
    {
      {
        0,
        0,
        1
      },
      {
        1,
        1,
        1
      }
    },
    common[13],
    {3, 2},
    common[15],
    common[16],
    common[17],
    common[15],
    "s3_normaldebris_2",
    "icon_item_7000601",
    "exp_s3_game_xuanzhong4",
    "exp_s3_game_xuanzhong12",
    "exp_s3_game_tuxing2",
    4,
    nil,
    nil,
    4
  },
  {
    3,
    4,
    {
      {
        1,
        0,
        0
      },
      {
        1,
        1,
        1
      }
    },
    common[13],
    {1, 2},
    common[15],
    common[16],
    common[17],
    common[15],
    "s3_normaldebris_3",
    "icon_item_7000602",
    "exp_s3_game_xuanzhong5",
    "exp_s3_game_xuanzhong13",
    "exp_s3_game_tuxing3",
    4,
    nil,
    nil,
    4
  },
  {
    4,
    5,
    {
      {
        0,
        1,
        0
      },
      {
        1,
        1,
        1
      }
    },
    common[13],
    common[13],
    common[18],
    common[18],
    common[18],
    common[18],
    "s3_normaldebris_4",
    "icon_item_7000603",
    "exp_s3_game_xuanzhong6",
    "exp_s3_game_xuanzhong14",
    "exp_s3_game_tuxing4",
    4,
    nil,
    nil,
    4
  },
  {
    5,
    8,
    common[11],
    common[19],
    common[19],
    common[14],
    common[14],
    common[14],
    common[14],
    "s3_normaldebris_5",
    "icon_item_7000604",
    common[4],
    common[5],
    common[6],
    2,
    nil,
    nil,
    2
  },
  {
    6,
    6,
    {
      {1, 1}
    },
    common[19],
    common[19],
    common[14],
    common[14],
    common[14],
    common[14],
    "s3_normaldebris_6",
    "icon_item_7000605",
    "exp_s3_game_xuanzhong7",
    "exp_s3_game_xuanzhong15",
    "exp_s3_game_tuxing6",
    1,
    nil,
    nil,
    2
  },
  {
    7,
    7,
    {
      {
        0,
        1,
        0
      },
      {
        1,
        1,
        1
      },
      {
        0,
        1,
        0
      }
    },
    common[13],
    common[13],
    common[14],
    common[14],
    common[14],
    common[14],
    "s3_normaldebris_7",
    "icon_item_7000606",
    "exp_s3_game_xuanzhong8",
    "exp_s3_game_xuanzhong16",
    "exp_s3_game_tuxing7",
    6,
    nil,
    nil,
    1
  },
  {
    8,
    10,
    common[12],
    common[20],
    common[20],
    common[21],
    common[22],
    common[23],
    common[24],
    "s3_extradebris_1",
    "icon_item_7000607",
    common[7],
    common[8],
    common[9],
    0,
    1,
    "str_season_debris_extra_rule_1",
    1
  },
  {
    9,
    11,
    common[12],
    common[20],
    common[20],
    common[21],
    common[22],
    common[23],
    common[24],
    "s3_extradebris_2",
    "icon_item_7000608",
    common[7],
    common[8],
    common[9],
    0,
    2,
    "str_season_debris_extra_rule_2",
    1
  },
  {
    10,
    2,
    common[10],
    common[13],
    common[13],
    {53, -122},
    {-122, -53},
    {-53122},
    {122, 53},
    "s3_extradebris_3",
    "icon_item_7000609",
    common[1],
    common[2],
    common[3],
    3,
    3,
    "str_season_debris_extra_rule_3",
    1
  },
  {
    11,
    12,
    common[12],
    common[20],
    common[20],
    common[21],
    common[22],
    common[23],
    common[24],
    "s3_extradebris_4",
    "icon_item_7000610",
    common[7],
    common[8],
    common[9],
    0,
    4,
    "str_season_debris_extra_rule_4",
    1
  },
  {
    12,
    9,
    common[11],
    common[19],
    common[19],
    common[14],
    common[14],
    common[14],
    common[14],
    "s3_extradebris_5",
    "icon_item_7000611",
    common[4],
    common[5],
    common[6],
    2,
    5,
    "str_season_debris_extra_rule_5",
    2
  }
}
return config, "ID", key
