local key = {
  ID = 1,
  IsActive = 2,
  Hot = 3,
  NewEffect = 4,
  BtnKey = 5,
  ContentKey = 6,
  ContentParams = 7,
  Bgm = 8,
  HelpIntrKey = 9,
  GetDataClassName = 10
}
local common = {
  "EventTrailer_CN13",
  "TempSignIn",
  "CrazyLogin",
  "NewYearLuckBag",
  "DanTangPre",
  "DanTang",
  "Training",
  "SecondAnniversary",
  "N33EightPets",
  "SummonGift",
  "ActiveTask",
  "PopStar",
  "BlackBox",
  "SouthSeaN9",
  "ShareSkin",
  "N39EightPets",
  "LuckLand",
  "LuckLandEnter",
  "CollectCard",
  "NewYearDinner",
  "EliminateWorldBoss",
  "JumpMiniGame",
  "MessengerGame",
  "WeekTower",
  "FrogMiniGame",
  "SendPet",
  "VigorousReward",
  "Alice",
  "FishingGame",
  "PerfectPuzzle",
  "N4CrisisContract",
  "StoryCopyN22",
  "PetForecast",
  "PetForecastEnter",
  "BetweenTheChapters",
  "PetForecastNew",
  "PetTry",
  "PetTryEnter",
  "PetTryPlus",
  "UISpecialTask",
  "UISpecialTaskV3",
  "DoubleDrop",
  "WorldBossMulti",
  "TimeLogin",
  "TimeLoginV2",
  "ReturnSystem",
  "UISeasonMazeEnter",
  "LuckLandNew",
  {
    campaign_type = 10059,
    component_ids = {1}
  }
}
local empty = {}
local config = {
  {
    1,
    true,
    false,
    empty,
    common[1],
    common[1],
    {
      main_cfg = "EventTrailer_CN13"
    },
    2
  },
  [201] = {
    201,
    true,
    false,
    empty,
    common[2],
    common[2],
    empty,
    2,
    nil,
    "TempSignInEnter"
  },
  [202] = {
    202,
    true,
    false,
    empty,
    "CrazyLogin_5044",
    common[3],
    {
      campaign_type = 10055,
      component_ids = {1},
      campaign_id = 5004
    },
    2
  },
  [203] = {
    203,
    true,
    false,
    empty,
    "CrazyLogin_1100",
    common[3],
    {
      campaign_type = 10055,
      component_ids = {1},
      campaign_id = 1226
    },
    2
  },
  [204] = {
    204,
    true,
    false,
    empty,
    "CrazyLogin_1123",
    common[3],
    {
      campaign_type = 10055,
      component_ids = {1},
      campaign_id = 1138
    },
    2
  },
  [205] = {
    205,
    true,
    false,
    empty,
    common[4],
    common[4],
    {
      campaign_type = 54000,
      component_ids = {1},
      campaign_id = 7003
    },
    2
  },
  [206] = {
    206,
    true,
    false,
    empty,
    "CrazyLogin_11230",
    common[3],
    {
      campaign_type = 10055,
      component_ids = {1},
      campaign_id = 1229
    },
    2
  },
  [207] = {
    207,
    true,
    false,
    empty,
    "CrazyLogin_11231",
    common[3],
    {
      campaign_type = 10055,
      component_ids = {1},
      campaign_id = 1230
    },
    2
  },
  [208] = {
    208,
    true,
    false,
    empty,
    "CrazyLogin_11229",
    common[3],
    {
      campaign_type = 10055,
      component_ids = {1},
      campaign_id = 1231
    },
    2
  },
  [209] = {
    209,
    true,
    false,
    empty,
    "CrazyLogin_11232",
    common[3],
    {
      campaign_type = 10055,
      component_ids = {1},
      campaign_id = 1232
    },
    2
  },
  [401] = {
    401,
    true,
    false,
    empty,
    common[5],
    common[5],
    {
      campaign_type = 50006,
      component_ids = {1}
    },
    500
  },
  [402] = {
    402,
    true,
    true,
    {key = 5003, duration = 3000},
    common[6],
    common[6],
    {
      campaign_type = 50003,
      component_ids = {1}
    },
    500,
    nil,
    "ActivityDanTangEnter"
  },
  [403] = {
    403,
    true,
    true,
    empty,
    common[7],
    common[7],
    {
      campaign_type = 10061,
      component_ids = {1}
    },
    2
  },
  [404] = {
    404,
    true,
    false,
    empty,
    common[8],
    common[8],
    {
      campaign_type = 10045,
      component_ids = {}
    },
    2
  },
  [405] = {
    405,
    true,
    true,
    empty,
    common[9],
    common[9],
    {
      campaign_type = 10102,
      component_ids = {1},
      campaign_id = 1115
    },
    31
  },
  [406] = {
    406,
    true,
    false,
    empty,
    common[10],
    common[10],
    empty,
    2
  },
  [407] = {
    407,
    true,
    true,
    empty,
    common[11],
    common[11],
    {
      campaign_type = 10049,
      component_ids = {1}
    },
    2
  },
  [408] = {
    408,
    true,
    false,
    empty,
    common[12],
    common[12],
    {
      campaign_type = 10046,
      component_ids = {1}
    },
    2
  },
  [409] = {
    409,
    true,
    false,
    empty,
    common[13],
    common[13],
    {
      campaign_type = 10044,
      component_ids = {1}
    },
    2
  },
  [410] = {
    410,
    true,
    false,
    empty,
    "FavourPet",
    "FavourPet3",
    {
      campaign_type = 50021,
      component_ids = {1}
    },
    2
  },
  [411] = {
    411,
    true,
    false,
    empty,
    common[14],
    common[14],
    {
      campaign_type = 50023,
      component_ids = {1},
      campaign_id = 7018
    },
    2,
    nil,
    "SeaNoteEnter"
  },
  [412] = {
    412,
    true,
    false,
    empty,
    common[15],
    common[15],
    {
      campaign_type = 50202,
      component_ids = {1},
      campaign_id = 1131
    },
    2
  },
  [413] = {
    413,
    true,
    true,
    empty,
    common[16],
    common[16],
    {
      campaign_type = 10102,
      component_ids = {1},
      campaign_id = 5040
    },
    31
  },
  [414] = {
    414,
    false,
    false,
    empty,
    common[17],
    common[17],
    {
      campaign_type = 50025,
      component_ids = {1},
      campaign_id = 7001
    },
    34,
    nil,
    common[18]
  },
  [415] = {
    415,
    true,
    false,
    empty,
    common[19],
    common[19],
    {
      campaign_type = 10065,
      component_ids = {1, 2},
      campaign_id = 7002
    },
    2,
    "UICollectCardIntr"
  },
  [416] = {
    416,
    true,
    false,
    empty,
    common[20],
    common[20],
    {
      campaign_type = 50011,
      component_ids = {1}
    },
    37
  },
  [417] = {
    417,
    true,
    false,
    empty,
    common[21],
    common[21],
    empty,
    2
  },
  [418] = {
    418,
    true,
    false,
    empty,
    common[22],
    common[22],
    {
      campaign_type = 10040,
      component_ids = {1},
      campaign_id = 5143
    },
    2
  },
  [419] = {
    419,
    true,
    false,
    empty,
    common[23],
    common[23],
    {
      campaign_type = 10037,
      component_ids = {1},
      campaign_id = 1144
    },
    38,
    nil,
    "MessengerGameEnter"
  },
  [420] = {
    420,
    true,
    false,
    empty,
    common[24],
    common[24],
    {
      campaign_type = 10012,
      component_ids = {1, 2},
      campaign_id = 1150
    },
    2
  },
  [421] = {
    421,
    true,
    false,
    empty,
    common[25],
    common[25],
    {
      campaign_type = 10066,
      component_ids = {1},
      campaign_id = 5144
    },
    2
  },
  [423] = {
    423,
    true,
    false,
    empty,
    common[26],
    common[26],
    {
      campaign_type = 10068,
      component_ids = {1, 2}
    },
    2,
    nil,
    "PetSendEnter"
  },
  [424] = {
    424,
    true,
    false,
    empty,
    common[27],
    common[27],
    empty,
    2,
    nil,
    "VigorousRewardEnter"
  },
  [425] = {
    425,
    true,
    false,
    empty,
    "WeekTower_1152",
    common[24],
    {
      campaign_type = 10012,
      component_ids = {1, 2},
      campaign_id = 1152
    },
    2
  },
  [426] = {
    426,
    true,
    false,
    empty,
    common[28],
    common[28],
    {
      campaign_type = 50009,
      component_ids = {1},
      campaign_id = 5145
    },
    2
  },
  [427] = {
    427,
    true,
    false,
    empty,
    common[29],
    common[29],
    {
      campaign_type = 10069,
      component_ids = {1},
      campaign_id = 7012
    },
    2
  },
  [428] = {
    428,
    true,
    false,
    empty,
    common[30],
    common[30],
    {
      campaign_type = 50028,
      component_ids = {1},
      campaign_id = 7016
    },
    34,
    nil,
    "PerfectPuzzleEnter"
  },
  [429] = {
    429,
    true,
    false,
    empty,
    common[31],
    common[31],
    {
      campaign_type = 50020,
      component_ids = {1},
      campaign_id = 5020
    },
    49,
    nil,
    "UISideEnterMainN4CCData"
  },
  [430] = {
    430,
    true,
    false,
    empty,
    common[17],
    common[17],
    {
      campaign_type = 50025,
      component_ids = {1},
      campaign_id = 7014
    },
    34,
    nil,
    common[18]
  },
  [431] = {
    431,
    true,
    false,
    empty,
    "WeekTower_5063",
    common[24],
    {
      campaign_type = 10012,
      component_ids = {1, 2},
      campaign_id = 5063
    },
    2
  },
  [433] = {
    433,
    true,
    false,
    empty,
    common[32],
    common[32],
    {
      campaign_type = 10067,
      component_ids = {
        1,
        2,
        3
      },
      campaign_id = 5076
    },
    80,
    nil,
    "UICommonLineMissionCampEnter"
  },
  [701] = {
    701,
    true,
    false,
    empty,
    common[33],
    common[33],
    empty,
    2,
    nil,
    common[34]
  },
  [702] = {
    702,
    true,
    false,
    empty,
    common[35],
    common[35],
    {
      campaign_type = 10056,
      component_ids = {1}
    },
    2
  },
  [703] = {
    703,
    true,
    false,
    empty,
    common[36],
    common[36],
    empty,
    2,
    nil,
    common[34]
  },
  [801] = {
    801,
    true,
    false,
    empty,
    "PetTry_1096",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1096
    },
    2,
    nil,
    common[38]
  },
  [802] = {
    802,
    true,
    false,
    empty,
    "PetTry_1107",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1107
    },
    2,
    nil,
    common[38]
  },
  [803] = {
    803,
    true,
    false,
    empty,
    "PetTry_1109",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1109
    },
    2,
    nil,
    common[38]
  },
  [804] = {
    804,
    true,
    false,
    empty,
    "PetTry_1120",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1120
    },
    2,
    nil,
    common[38]
  },
  [805] = {
    805,
    true,
    false,
    empty,
    "PetTry_1121",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1121
    },
    2,
    nil,
    common[38]
  },
  [806] = {
    806,
    true,
    false,
    empty,
    "PetTry_5030",
    common[39],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 5030
    },
    2,
    nil,
    common[38]
  },
  [807] = {
    807,
    true,
    false,
    empty,
    "PetTry_1130",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1130
    },
    2,
    nil,
    common[38]
  },
  [808] = {
    808,
    true,
    false,
    empty,
    "PetTry_1132",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1132
    },
    2,
    nil,
    common[38]
  },
  [809] = {
    809,
    true,
    false,
    empty,
    "PetTry_1135",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1135
    },
    2,
    nil,
    common[38]
  },
  [810] = {
    810,
    true,
    false,
    empty,
    "PetTry_1140",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1140
    },
    2,
    nil,
    common[38]
  },
  [811] = {
    811,
    true,
    false,
    empty,
    "PetTry_1143",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1143
    },
    2,
    nil,
    common[38]
  },
  [812] = {
    812,
    true,
    false,
    empty,
    "PetTry_1153",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1153
    },
    2,
    nil,
    common[38]
  },
  [813] = {
    813,
    true,
    false,
    empty,
    "PetTry_1154",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1154
    },
    2,
    nil,
    common[38]
  },
  [814] = {
    814,
    true,
    false,
    empty,
    "PetTry_5054",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 5054
    },
    2,
    nil,
    common[38]
  },
  [815] = {
    815,
    true,
    false,
    empty,
    "PetTry_1222",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 1222
    },
    2,
    nil,
    common[38]
  },
  [816] = {
    816,
    true,
    false,
    empty,
    "PetTry_5071",
    common[39],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 5071
    },
    2,
    nil,
    common[38]
  },
  [817] = {
    817,
    true,
    false,
    empty,
    "PetTry_5074",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 5074
    },
    2,
    nil,
    common[38]
  },
  [818] = {
    818,
    true,
    false,
    empty,
    "PetTry_5078",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 5078
    },
    2,
    nil,
    common[38]
  },
  [819] = {
    819,
    true,
    false,
    empty,
    "PetTry_5075",
    common[37],
    {
      campaign_type = 50005,
      component_ids = {1},
      campaign_id = 5075
    },
    2,
    nil,
    common[38]
  },
  [1001] = {
    1001,
    false,
    false,
    empty,
    common[40],
    common[40],
    common[49],
    2
  },
  [1002] = {
    1002,
    false,
    false,
    empty,
    common[40],
    "UISpecialTaskV2_S3",
    common[49],
    2
  },
  [1003] = {
    1003,
    true,
    false,
    empty,
    common[41],
    common[41],
    common[49],
    2
  },
  [1102] = {
    1102,
    true,
    false,
    empty,
    common[42],
    common[42],
    {
      campaign_type = 10051,
      component_ids = {1}
    },
    2
  },
  [2001] = {
    2001,
    true,
    false,
    empty,
    common[43],
    common[43],
    empty,
    2,
    nil,
    common[43]
  },
  [3001] = {
    3001,
    true,
    false,
    empty,
    common[44],
    common[44],
    {
      campaign_type = 50007,
      component_ids = {1, 2}
    },
    2
  },
  [3002] = {
    3002,
    true,
    false,
    empty,
    common[45],
    common[45],
    {
      campaign_type = 50007,
      component_ids = {1, 2},
      campaign_id = 1208
    },
    2
  },
  [4001] = {
    4001,
    true,
    false,
    empty,
    common[46],
    common[46],
    {
      campaign_type = 10060,
      component_ids = {}
    },
    2
  },
  [6001] = {
    6001,
    true,
    false,
    empty,
    common[47],
    common[47],
    {
      campaign_type = 80003,
      component_ids = {1},
      campaign_id = 9003
    },
    2,
    nil,
    "UISeasonMazeEnterBtn"
  },
  [434] = {
    434,
    true,
    false,
    empty,
    common[48],
    common[48],
    {
      campaign_type = 50025,
      component_ids = {1},
      campaign_id = 7030
    },
    34,
    nil,
    common[18]
  }
}
return config, "ID", key
