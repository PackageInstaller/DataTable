local key = {
  ID = 1,
  ExpressType = 2,
  NoRepeat = 3,
  MissionID = 4,
  Animation = 5,
  Effect = 6,
  StoryID = 7,
  Bubble = 8,
  Reward = 9,
  Show = 10,
  Obstacle = 11,
  Focus = 12,
  LockInput = 13,
  Sign = 14,
  UI = 15,
  Transmit = 16,
  Transitions = 17,
  UnlockZone = 18,
  Born = 19,
  Delay = 20,
  StoryID3D = 21,
  Function = 22
}
local common = {
  {
    eventanim = "eff_Scene_ludian_end"
  },
  {
    eventeffec = "eff_S2906001_idle"
  },
  {type = 1},
  {
    type = 1,
    show = true,
    sprite = "exp_s1_map_icon01"
  },
  {
    type = 1,
    show = true,
    sprite = "exp_s1_map_icon03"
  },
  {zoneID = 2, time = 1},
  {show = true},
  {show = false},
  {
    type = 1,
    show = true,
    sprite = "exp_s1_map_icon30"
  },
  {
    type = 2,
    show = false,
    sprite = "exp_s1_map_icon03"
  },
  {
    [1] = {
      text = "str_season_mission_bubble_info_2_1",
      type = 1,
      offset = {x = 0, y = 120}
    }
  },
  {
    [1] = {
      text = "str_season_mission_bubble_info_4_1",
      type = 1,
      offset = {x = 0, y = 120}
    }
  },
  {
    [1] = {
      text = "str_season_mission_bubble_info_9_1",
      type = 1,
      offset = {x = 0, y = 120}
    }
  },
  {
    [1] = {
      text = "str_season_mission_bubble_info_10_1",
      type = 1,
      offset = {x = 0, y = 120}
    }
  },
  {
    eventanim = "S2_anim_damen_close"
  },
  {
    eventanim = "S2_anim_damen_open"
  },
  {
    eventanim = "S2_anim_wuding_disappear"
  },
  {
    eventanim = "S2_anim_wuding_appear"
  },
  {zoneID = 3, time = 1},
  {zoneID = 4, time = 1},
  {
    eventanim = "S2_pfb_book_open"
  },
  {
    eventanim = "S2_anim_balance_juanzong"
  },
  {
    type = 1,
    show = true,
    sprite = "exp_S3_map_doubt_red"
  },
  {
    eventanim = "eff_Scene_ludian_end",
    playeranim = "interact",
    playerloop = "1"
  },
  {
    type = 1,
    show = true,
    sprite = "exp_s3_map_icon19"
  },
  {
    eventanim = "S4_envani_fight_close"
  },
  {
    eventanim = "S4_anim_door_open"
  },
  {
    eventanim = "s5_fight_normal_close"
  },
  {
    eventanim = "s5_fight_hard_close"
  },
  {
    eventanim = "s5_fight_white_close"
  },
  {
    type = 1,
    show = true,
    sprite = "exp_S6_map_doubt_red"
  },
  {
    type = 1,
    show = true,
    sprite = "exp_S7_map_doubt_red"
  },
  {
    eventeffect = "S7_pfb_boss_idle"
  },
  {
    type = 1,
    show = true,
    sprite = "exp_S8_map_doubt_red"
  },
  {
    type = 1,
    show = true,
    sprite = "exp_s2_map_icon015",
    functionType = 2
  },
  {
    eventanim = "S2_pfb_clean_smoke"
  },
  {
    playeranim = "clean",
    eventeffect = "S2_pfb_clean_smoke",
    playereffect = "S2_pfb_clean_saoba"
  },
  {
    {7000101, 1}
  },
  "UISeasonBalanceEvidenceController",
  "UISeasonBalanceWeightController",
  "UISeasonBackTrack",
  "UISeasonOnceMissionController"
}
local config = {
  {
    1,
    1,
    nil,
    8001001
  },
  {
    2,
    2,
    nil,
    nil,
    common[1]
  },
  {
    3,
    3,
    nil,
    nil,
    nil,
    common[2]
  },
  {
    4,
    4,
    true,
    nil,
    nil,
    nil,
    50550001
  },
  {
    5,
    5,
    true,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_1_1",
        type = 1,
        offset = {x = 0, y = 120}
      },
      [2] = {
        text = "str_season_treasure_bubble_info_2_1",
        type = 2,
        offset = {x = 0, y = 120}
      }
    }
  },
  {
    6,
    6,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[38]
  },
  {
    7,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {id = 8001001, show = true}
  },
  {
    8,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {id = 8001001, show = false}
  },
  {
    9,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  {
    10,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[3]
  },
  {
    11,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  {
    12,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  {
    13,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[4]
  },
  {
    14,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[5]
  },
  {
    15,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[39]
  },
  {
    16,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[40]
  },
  {
    17,
    13,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      position = {
        0,
        0,
        0
      },
      direction = {
        0,
        0,
        0
      }
    }
  },
  {
    18,
    14,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  {
    19,
    14,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  {
    20,
    15,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[6]
  },
  {
    21,
    16,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {type = 1, anim = "born"}
  },
  {
    22,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  {
    23,
    17,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    1
  },
  [101] = {
    101,
    1,
    nil,
    8001001
  },
  [102] = {
    102,
    1,
    nil,
    8001002
  },
  [103] = {
    103,
    1,
    nil,
    8001003
  },
  [104] = {
    104,
    1,
    nil,
    8001004
  },
  [105] = {
    105,
    1,
    nil,
    8001005
  },
  [106] = {
    106,
    1,
    nil,
    8001006
  },
  [107] = {
    107,
    1,
    nil,
    8001007
  },
  [108] = {
    108,
    1,
    nil,
    8001008
  },
  [109] = {
    109,
    1,
    nil,
    8001009
  },
  [110] = {
    110,
    1,
    nil,
    8001010
  },
  [111] = {
    111,
    1,
    nil,
    8001011
  },
  [112] = {
    112,
    1,
    nil,
    8001012
  },
  [113] = {
    113,
    1,
    nil,
    8001013
  },
  [114] = {
    114,
    1,
    nil,
    8001014
  },
  [115] = {
    115,
    1,
    nil,
    8001015
  },
  [116] = {
    116,
    1,
    nil,
    8001016
  },
  [117] = {
    117,
    1,
    nil,
    8001017
  },
  [118] = {
    118,
    1,
    nil,
    8001018
  },
  [119] = {
    119,
    1,
    nil,
    8001019
  },
  [120] = {
    120,
    1,
    nil,
    8001020
  },
  [121] = {
    121,
    1,
    nil,
    8001021
  },
  [122] = {
    122,
    1,
    nil,
    8001022
  },
  [123] = {
    123,
    1,
    nil,
    8001023
  },
  [124] = {
    124,
    1,
    nil,
    8001024
  },
  [125] = {
    125,
    1,
    nil,
    8001025
  },
  [126] = {
    126,
    1,
    nil,
    8001026
  },
  [127] = {
    127,
    1,
    nil,
    8001027
  },
  [128] = {
    128,
    1,
    nil,
    8001028
  },
  [129] = {
    129,
    1,
    nil,
    8001029
  },
  [130] = {
    130,
    1,
    nil,
    8001030
  },
  [131] = {
    131,
    1,
    nil,
    8001031
  },
  [132] = {
    132,
    1,
    nil,
    8001032
  },
  [133] = {
    133,
    1,
    nil,
    8001033
  },
  [134] = {
    134,
    1,
    nil,
    8001034
  },
  [135] = {
    135,
    1,
    nil,
    8001035
  },
  [136] = {
    136,
    1,
    nil,
    8001036
  },
  [151] = {
    151,
    1,
    nil,
    8001301
  },
  [152] = {
    152,
    1,
    nil,
    8001302
  },
  [153] = {
    153,
    1,
    nil,
    8001303
  },
  [201] = {
    201,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001001,
      focusType = 1,
      sizeScale = true
    }
  },
  [202] = {
    202,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001002,
      focusType = 1,
      sizeScale = true
    }
  },
  [203] = {
    203,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001003,
      focusType = 1,
      sizeScale = true
    }
  },
  [204] = {
    204,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001004,
      focusType = 1,
      sizeScale = true
    }
  },
  [205] = {
    205,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001005,
      focusType = 1,
      sizeScale = true
    }
  },
  [206] = {
    206,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001006,
      focusType = 1,
      sizeScale = true
    }
  },
  [207] = {
    207,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001007,
      focusType = 1,
      sizeScale = true
    }
  },
  [208] = {
    208,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001008,
      focusType = 1,
      sizeScale = true
    }
  },
  [209] = {
    209,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001009,
      focusType = 1,
      sizeScale = true
    }
  },
  [210] = {
    210,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001010,
      focusType = 1,
      sizeScale = true
    }
  },
  [211] = {
    211,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001011,
      focusType = 1,
      sizeScale = true
    }
  },
  [212] = {
    212,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001012,
      focusType = 1,
      sizeScale = true
    }
  },
  [213] = {
    213,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001013,
      focusType = 1,
      sizeScale = true
    }
  },
  [214] = {
    214,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001014,
      focusType = 1,
      sizeScale = true
    }
  },
  [215] = {
    215,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001015,
      focusType = 1,
      sizeScale = true
    }
  },
  [216] = {
    216,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001016,
      focusType = 1,
      sizeScale = true
    }
  },
  [217] = {
    217,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001017,
      focusType = 1,
      sizeScale = true
    }
  },
  [218] = {
    218,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001018,
      focusType = 1,
      sizeScale = true
    }
  },
  [219] = {
    219,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001019,
      focusType = 1,
      sizeScale = true
    }
  },
  [220] = {
    220,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001020,
      focusType = 1,
      sizeScale = true
    }
  },
  [221] = {
    221,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001021,
      focusType = 1,
      sizeScale = true
    }
  },
  [222] = {
    222,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001022,
      focusType = 1,
      sizeScale = true
    }
  },
  [223] = {
    223,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001023,
      focusType = 1,
      sizeScale = true
    }
  },
  [224] = {
    224,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001024,
      focusType = 1,
      sizeScale = true
    }
  },
  [225] = {
    225,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001025,
      focusType = 1,
      sizeScale = true
    }
  },
  [226] = {
    226,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001026,
      focusType = 1,
      sizeScale = true
    }
  },
  [227] = {
    227,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001027,
      focusType = 1,
      sizeScale = true
    }
  },
  [228] = {
    228,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001028,
      focusType = 1,
      sizeScale = true
    }
  },
  [229] = {
    229,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001029,
      focusType = 1,
      sizeScale = true
    }
  },
  [230] = {
    230,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001030,
      focusType = 1,
      sizeScale = true
    }
  },
  [231] = {
    231,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001031,
      focusType = 1,
      sizeScale = true
    }
  },
  [232] = {
    232,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001032,
      focusType = 1,
      sizeScale = true
    }
  },
  [233] = {
    233,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001033,
      focusType = 1,
      sizeScale = true
    }
  },
  [234] = {
    234,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001034,
      focusType = 1,
      sizeScale = true
    }
  },
  [235] = {
    235,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001035,
      focusType = 1,
      sizeScale = true
    }
  },
  [236] = {
    236,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001036,
      focusType = 1,
      sizeScale = true
    }
  },
  [251] = {
    251,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001301,
      focusType = 1,
      sizeScale = true
    }
  },
  [252] = {
    252,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001302,
      focusType = 1,
      sizeScale = true
    }
  },
  [253] = {
    253,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8001303,
      focusType = 1,
      sizeScale = true
    }
  },
  [301] = {
    301,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000100, 1}
    }
  },
  [302] = {
    302,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[38]
  },
  [303] = {
    303,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000102, 1}
    }
  },
  [304] = {
    304,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000103, 1}
    }
  },
  [305] = {
    305,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000104, 1}
    }
  },
  [306] = {
    306,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000105, 1}
    }
  },
  [307] = {
    307,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000106, 1}
    }
  },
  [308] = {
    308,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000107, 1}
    }
  },
  [309] = {
    309,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000108, 1}
    }
  },
  [310] = {
    310,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000109, 1}
    }
  },
  [311] = {
    311,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000110, 1}
    }
  },
  [312] = {
    312,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000111, 1}
    }
  },
  [313] = {
    313,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000115, 1}
    }
  },
  [314] = {
    314,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000113, 1}
    }
  },
  [315] = {
    315,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000117, 1}
    }
  },
  [351] = {
    351,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_1_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [352] = {
    352,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_2_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [353] = {
    353,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_3_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [354] = {
    354,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_4_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [355] = {
    355,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_5_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [356] = {
    356,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_6_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [357] = {
    357,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_7_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [358] = {358, 5},
  [359] = {359, 5},
  [360] = {360, 5},
  [361] = {
    361,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_11_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [362] = {
    362,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_12_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [363] = {
    363,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_14_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [364] = {
    364,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_15_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [365] = {
    365,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_treasure_bubble_info_16_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [401] = {
    401,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [402] = {
    402,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [403] = {
    403,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [404] = {
    404,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [405] = {
    405,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[3]
  },
  [406] = {
    406,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[4]
  },
  [407] = {
    407,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[5]
  },
  [408] = {
    408,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [409] = {
    409,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[9]
  },
  [410] = {
    410,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [501] = {
    501,
    2,
    nil,
    nil,
    common[1]
  },
  [502] = {
    502,
    2,
    nil,
    nil,
    {
      eventanim = "S1_pfb_hua_open"
    }
  },
  [503] = {
    503,
    2,
    nil,
    nil,
    {
      eventanim = "pohuai",
      playeranim = "banshou",
      audio = "1808"
    }
  },
  [504] = {
    504,
    2,
    nil,
    nil,
    {
      eventanim = "S1_Anim_tiemen_opened"
    }
  },
  [505] = {
    505,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_gear_bubble_info_1_1",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [506] = {
    506,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      [1] = {
        text = "str_season_gear_bubble_info_1_2",
        type = 1,
        offset = {x = 0, y = 120}
      }
    }
  },
  [507] = {
    507,
    3,
    nil,
    nil,
    nil,
    common[2]
  },
  [508] = {
    508,
    2,
    nil,
    nil,
    {
      eventanim = "eff_Scene_level_eye_normal_eye_close"
    }
  },
  [509] = {
    509,
    2,
    nil,
    nil,
    {
      eventanim = "eff_Scene_level_eye_hardl_eye_close"
    }
  },
  [510] = {
    510,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [511] = {
    511,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[12]
  },
  [512] = {
    512,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[13]
  },
  [513] = {
    513,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[14]
  },
  [601] = {601, 4},
  [602] = {
    602,
    4,
    nil,
    nil,
    nil,
    nil,
    50559901
  },
  [603] = {
    603,
    4,
    nil,
    nil,
    nil,
    nil,
    50559902
  },
  [604] = {604, 4},
  [605] = {605, 4},
  [606] = {
    606,
    4,
    nil,
    nil,
    nil,
    nil,
    50559903
  },
  [607] = {
    607,
    4,
    nil,
    nil,
    nil,
    nil,
    50559904
  },
  [608] = {608, 4},
  [609] = {609, 4},
  [610] = {610, 4},
  [611] = {611, 4},
  [612] = {
    612,
    4,
    nil,
    nil,
    nil,
    nil,
    50559905
  },
  [613] = {
    613,
    4,
    nil,
    nil,
    nil,
    nil,
    50559907
  },
  [614] = {
    614,
    4,
    nil,
    nil,
    nil,
    nil,
    50559908
  },
  [615] = {
    615,
    4,
    nil,
    nil,
    nil,
    nil,
    50559909
  },
  [1001] = {
    1001,
    2,
    nil,
    nil,
    common[15]
  },
  [1002] = {
    1002,
    2,
    nil,
    nil,
    common[16]
  },
  [1003] = {
    1003,
    2,
    nil,
    nil,
    common[17]
  },
  [1004] = {
    1004,
    2,
    nil,
    nil,
    common[18]
  },
  [1005] = {
    1005,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[6]
  },
  [1006] = {
    1006,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[19]
  },
  [1007] = {
    1007,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1101] = {
    1101,
    1,
    nil,
    8002001
  },
  [1102] = {
    1102,
    1,
    nil,
    8002002
  },
  [1103] = {
    1103,
    1,
    nil,
    8002003
  },
  [1104] = {
    1104,
    1,
    nil,
    8002004
  },
  [1105] = {
    1105,
    1,
    nil,
    8002005
  },
  [1106] = {
    1106,
    1,
    nil,
    8002006
  },
  [1107] = {
    1107,
    1,
    nil,
    8002007
  },
  [1108] = {
    1108,
    1,
    nil,
    8002008
  },
  [1109] = {
    1109,
    1,
    nil,
    8002009
  },
  [1110] = {
    1110,
    1,
    nil,
    8002010
  },
  [1111] = {
    1111,
    4,
    nil,
    nil,
    nil,
    nil,
    50630601
  },
  [1112] = {
    1112,
    1,
    nil,
    8002013
  },
  [1113] = {
    1113,
    1,
    nil,
    8002014
  },
  [1114] = {
    1114,
    1,
    nil,
    8002015
  },
  [1115] = {
    1115,
    1,
    nil,
    8002016
  },
  [1116] = {
    1116,
    1,
    nil,
    8002017
  },
  [1117] = {
    1117,
    1,
    nil,
    8002018
  },
  [1118] = {
    1118,
    1,
    nil,
    8002019
  },
  [1119] = {
    1119,
    1,
    nil,
    8002020
  },
  [1120] = {
    1120,
    4,
    nil,
    nil,
    nil,
    nil,
    50631101
  },
  [1121] = {
    1121,
    1,
    nil,
    8002023
  },
  [1122] = {
    1122,
    1,
    nil,
    8002024
  },
  [1123] = {
    1123,
    1,
    nil,
    8002025
  },
  [1124] = {
    1124,
    1,
    nil,
    8002026
  },
  [1125] = {
    1125,
    1,
    nil,
    8002027
  },
  [1126] = {
    1126,
    1,
    nil,
    8002028
  },
  [1127] = {
    1127,
    1,
    nil,
    8002029
  },
  [1128] = {
    1128,
    1,
    nil,
    8002030
  },
  [1129] = {
    1129,
    4,
    nil,
    nil,
    nil,
    nil,
    50631601
  },
  [1130] = {
    1130,
    1,
    nil,
    8002033
  },
  [1131] = {
    1131,
    1,
    nil,
    8002034
  },
  [1132] = {
    1132,
    1,
    nil,
    8002035
  },
  [1133] = {
    1133,
    1,
    nil,
    8002036
  },
  [1134] = {
    1134,
    1,
    nil,
    8002102
  },
  [1135] = {
    1135,
    1,
    nil,
    8002501
  },
  [1136] = {
    1136,
    1,
    nil,
    8002502
  },
  [1137] = {
    1137,
    1,
    nil,
    8002503
  },
  [1138] = {
    1138,
    1,
    nil,
    8002504
  },
  [1139] = {
    1139,
    1,
    nil,
    8002505
  },
  [1140] = {
    1140,
    1,
    nil,
    8002506
  },
  [1141] = {
    1141,
    1,
    nil,
    8002701
  },
  [1201] = {
    1201,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002001,
      focusType = 1,
      sizeScale = true
    }
  },
  [1202] = {
    1202,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002002,
      focusType = 1,
      sizeScale = true
    }
  },
  [1203] = {
    1203,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002003,
      focusType = 1,
      sizeScale = true
    }
  },
  [1204] = {
    1204,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002004,
      focusType = 1,
      sizeScale = true
    }
  },
  [1205] = {
    1205,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002005,
      focusType = 1,
      sizeScale = true
    }
  },
  [1206] = {
    1206,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002006,
      focusType = 1,
      sizeScale = true
    }
  },
  [1207] = {
    1207,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002007,
      focusType = 1,
      sizeScale = true
    }
  },
  [1208] = {
    1208,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002008,
      focusType = 1,
      sizeScale = true
    }
  },
  [1209] = {
    1209,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002009,
      focusType = 1,
      sizeScale = true
    }
  },
  [1210] = {
    1210,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002010,
      focusType = 1,
      sizeScale = true
    }
  },
  [1211] = {
    1211,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002011,
      focusType = 2,
      sizeScale = true
    }
  },
  [1212] = {
    1212,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002013,
      focusType = 1,
      sizeScale = true
    }
  },
  [1213] = {
    1213,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002014,
      focusType = 1,
      sizeScale = true
    }
  },
  [1214] = {
    1214,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002015,
      focusType = 1,
      sizeScale = true
    }
  },
  [1215] = {
    1215,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002016,
      focusType = 1,
      sizeScale = true
    }
  },
  [1216] = {
    1216,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002017,
      focusType = 1,
      sizeScale = true
    }
  },
  [1217] = {
    1217,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002018,
      focusType = 1,
      sizeScale = true
    }
  },
  [1218] = {
    1218,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002019,
      focusType = 1,
      sizeScale = true
    }
  },
  [1219] = {
    1219,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002020,
      focusType = 1,
      sizeScale = true
    }
  },
  [1220] = {
    1220,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002021,
      focusType = 2,
      sizeScale = true
    }
  },
  [1221] = {
    1221,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002023,
      focusType = 1,
      sizeScale = true
    }
  },
  [1222] = {
    1222,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002024,
      focusType = 1,
      sizeScale = true
    }
  },
  [1223] = {
    1223,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002025,
      focusType = 1,
      sizeScale = true
    }
  },
  [1224] = {
    1224,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002026,
      focusType = 1,
      sizeScale = true
    }
  },
  [1225] = {
    1225,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002027,
      focusType = 1,
      sizeScale = true
    }
  },
  [1226] = {
    1226,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002028,
      focusType = 1,
      sizeScale = true
    }
  },
  [1227] = {
    1227,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002029,
      focusType = 1,
      sizeScale = true
    }
  },
  [1228] = {
    1228,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002030,
      focusType = 1,
      sizeScale = true
    }
  },
  [1229] = {
    1229,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002031,
      focusType = 2,
      sizeScale = true
    }
  },
  [1230] = {
    1230,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002033,
      focusType = 1,
      sizeScale = true
    }
  },
  [1231] = {
    1231,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002034,
      focusType = 1,
      sizeScale = true
    }
  },
  [1232] = {
    1232,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002035,
      focusType = 1,
      sizeScale = true
    }
  },
  [1233] = {
    1233,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002036,
      focusType = 1,
      sizeScale = true
    }
  },
  [1234] = {
    1234,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002102,
      focusType = 1,
      sizeScale = true
    }
  },
  [1235] = {
    1235,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002501,
      focusType = 1,
      sizeScale = true
    }
  },
  [1236] = {
    1236,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002502,
      focusType = 1,
      sizeScale = true
    }
  },
  [1237] = {
    1237,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002503,
      focusType = 1,
      sizeScale = true
    }
  },
  [1238] = {
    1238,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002504,
      focusType = 1,
      sizeScale = true
    }
  },
  [1239] = {
    1239,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002505,
      focusType = 1,
      sizeScale = true
    }
  },
  [1240] = {
    1240,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002506,
      focusType = 1,
      sizeScale = true
    }
  },
  [1241] = {
    1241,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002701,
      focusType = 1,
      sizeScale = true
    }
  },
  [1251] = {
    1251,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002401,
      focusType = 2,
      sizeScale = true
    }
  },
  [1252] = {
    1252,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002402,
      focusType = 2,
      sizeScale = true
    }
  },
  [1253] = {
    1253,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002403,
      focusType = 2,
      sizeScale = true
    }
  },
  [1254] = {
    1254,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002404,
      focusType = 2,
      sizeScale = true
    }
  },
  [1255] = {
    1255,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002405,
      focusType = 2,
      sizeScale = true
    }
  },
  [1301] = {
    1301,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000200, 1}
    }
  },
  [1302] = {
    1302,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000201, 1}
    }
  },
  [1303] = {
    1303,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000202, 1}
    }
  },
  [1304] = {
    1304,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000203, 1}
    }
  },
  [1305] = {
    1305,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000204, 1}
    }
  },
  [1306] = {
    1306,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000205, 1}
    }
  },
  [1307] = {
    1307,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000206, 1}
    }
  },
  [1308] = {
    1308,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000300, 1}
    }
  },
  [1309] = {
    1309,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000301, 1}
    }
  },
  [1310] = {
    1310,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000302, 1}
    }
  },
  [1311] = {
    1311,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000303, 1}
    }
  },
  [1312] = {
    1312,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000304, 1}
    }
  },
  [1313] = {
    1313,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000305, 1}
    }
  },
  [1314] = {
    1314,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000306, 1}
    }
  },
  [1315] = {
    1315,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000307, 1}
    }
  },
  [1316] = {
    1316,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000308, 1}
    }
  },
  [1317] = {
    1317,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000309, 1}
    }
  },
  [1318] = {
    1318,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000310, 1}
    }
  },
  [1319] = {
    1319,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000311, 1}
    }
  },
  [1320] = {
    1320,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000312, 1}
    }
  },
  [1321] = {
    1321,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000313, 1}
    }
  },
  [1322] = {
    1322,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000314, 1}
    }
  },
  [1323] = {
    1323,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000315, 1}
    }
  },
  [1324] = {
    1324,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000316, 1}
    }
  },
  [1325] = {
    1325,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000317, 1}
    }
  },
  [1326] = {
    1326,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000318, 1}
    }
  },
  [1327] = {
    1327,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000319, 1}
    }
  },
  [1328] = {
    1328,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000320, 1}
    }
  },
  [1401] = {
    1401,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1402] = {
    1402,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1403] = {
    1403,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [1404] = {
    1404,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [1405] = {
    1405,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[3]
  },
  [1406] = {
    1406,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[4]
  },
  [1407] = {
    1407,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[5]
  },
  [1408] = {
    1408,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [1409] = {
    1409,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [1410] = {
    1410,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[9]
  },
  [1411] = {
    1411,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [1412] = {
    1412,
    14,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [1413] = {
    1413,
    14,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [1414] = {
    1414,
    17,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    1
  },
  [1501] = {
    1501,
    2,
    nil,
    nil,
    common[1]
  },
  [1502] = {
    1502,
    2,
    nil,
    nil,
    common[21]
  },
  [1503] = {
    1503,
    3,
    nil,
    nil,
    nil,
    common[2]
  },
  [1504] = {
    1504,
    2,
    nil,
    nil,
    {
      eventanim = "S2_envani_normal_close"
    }
  },
  [1505] = {
    1505,
    2,
    nil,
    nil,
    {
      eventanim = "S2_envani_hard_close"
    }
  },
  [1506] = {
    1506,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[11]
  },
  [1507] = {
    1507,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[12]
  },
  [1508] = {
    1508,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[13]
  },
  [1509] = {
    1509,
    5,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[14]
  },
  [1510] = {
    1510,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[6]
  },
  [1511] = {
    1511,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[19]
  },
  [1512] = {
    1512,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [1513] = {1513, 2},
  [1514] = {
    1514,
    2,
    nil,
    nil,
    common[15]
  },
  [1515] = {
    1515,
    2,
    true,
    nil,
    common[16]
  },
  [1516] = {
    1516,
    2,
    nil,
    nil,
    common[17]
  },
  [1517] = {
    1517,
    2,
    nil,
    nil,
    common[18]
  },
  [1518] = {
    1518,
    13,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      position = {
        -27.97,
        1,
        12
      },
      direction = {
        -43.6,
        2.7,
        -2.4
      }
    }
  },
  [1519] = {
    1519,
    13,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      position = {
        1.17,
        1,
        5.42
      },
      direction = {
        -43.6,
        2.7,
        -2.4
      }
    }
  },
  [1520] = {
    1520,
    2,
    nil,
    nil,
    {
      eventanim = "S2_anim_proprs_paper_open"
    }
  },
  [1521] = {
    1521,
    2,
    nil,
    nil,
    {
      eventanim = "S2_anim_proprs_paper_close"
    }
  },
  [1522] = {
    1522,
    2,
    nil,
    nil,
    common[17]
  },
  [1523] = {
    1523,
    2,
    nil,
    nil,
    common[18]
  },
  [1524] = {
    1524,
    2,
    nil,
    nil,
    common[22]
  },
  [1525] = {
    1525,
    2,
    nil,
    nil,
    {
      eventanim = "S2_anim_balance_fama"
    }
  },
  [1526] = {
    1526,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[39]
  },
  [1527] = {
    1527,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[40]
  },
  [1528] = {
    1528,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [1529] = {
    1529,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [1530] = {
    1530,
    9,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002401,
      focusType = 2,
      sizeScale = false
    }
  },
  [1531] = {
    1531,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [1532] = {
    1532,
    9,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002402,
      focusType = 2,
      sizeScale = false
    }
  },
  [1533] = {
    1533,
    2,
    true,
    nil,
    common[22]
  },
  [1534] = {
    1534,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [1535] = {
    1535,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [1536] = {
    1536,
    9,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002403,
      focusType = 2,
      sizeScale = false
    }
  },
  [1537] = {
    1537,
    2,
    true,
    nil,
    common[22]
  },
  [1538] = {
    1538,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [1539] = {
    1539,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [1540] = {
    1540,
    9,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002404,
      focusType = 2,
      sizeScale = false
    }
  },
  [1541] = {
    1541,
    2,
    true,
    nil,
    common[22]
  },
  [1542] = {
    1542,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [1543] = {
    1543,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [1544] = {
    1544,
    9,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8002405,
      focusType = 2,
      sizeScale = false
    }
  },
  [1545] = {
    1545,
    2,
    true,
    nil,
    common[22]
  },
  [1546] = {
    1546,
    10,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [1601] = {
    1601,
    4,
    nil,
    nil,
    nil,
    nil,
    50630303
  },
  [1602] = {
    1602,
    4,
    nil,
    nil,
    nil,
    nil,
    50630304
  },
  [1603] = {
    1603,
    4,
    nil,
    nil,
    nil,
    nil,
    50630803
  },
  [1604] = {
    1604,
    4,
    nil,
    nil,
    nil,
    nil,
    50630804
  },
  [1605] = {
    1605,
    4,
    nil,
    nil,
    nil,
    nil,
    50631103
  },
  [1606] = {
    1606,
    4,
    nil,
    nil,
    nil,
    nil,
    50631303
  },
  [2001] = {
    2001,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[6]
  },
  [2002] = {
    2002,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[19]
  },
  [2003] = {
    2003,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [2101] = {
    2101,
    1,
    nil,
    8003001
  },
  [2102] = {
    2102,
    1,
    nil,
    8003002
  },
  [2103] = {
    2103,
    1,
    nil,
    8003003
  },
  [2104] = {
    2104,
    1,
    nil,
    8003004
  },
  [2105] = {
    2105,
    1,
    nil,
    8003005
  },
  [2106] = {
    2106,
    1,
    nil,
    8003006
  },
  [2107] = {
    2107,
    1,
    nil,
    8003007
  },
  [2108] = {
    2108,
    1,
    nil,
    8003008
  },
  [2109] = {
    2109,
    1,
    nil,
    8003009
  },
  [2110] = {
    2110,
    1,
    nil,
    8003010
  },
  [2111] = {
    2111,
    1,
    nil,
    8003011
  },
  [2112] = {
    2112,
    1,
    nil,
    8003012
  },
  [2113] = {
    2113,
    1,
    nil,
    8003013
  },
  [2114] = {
    2114,
    1,
    nil,
    8003014
  },
  [2115] = {
    2115,
    1,
    nil,
    8003015
  },
  [2116] = {
    2116,
    1,
    nil,
    8003016
  },
  [2117] = {
    2117,
    1,
    nil,
    8003017
  },
  [2118] = {
    2118,
    1,
    nil,
    8003018
  },
  [2119] = {
    2119,
    1,
    nil,
    8003019
  },
  [2120] = {
    2120,
    1,
    nil,
    8003020
  },
  [2121] = {
    2121,
    1,
    nil,
    8003021
  },
  [2122] = {
    2122,
    1,
    nil,
    8003022
  },
  [2123] = {
    2123,
    1,
    nil,
    8003023
  },
  [2124] = {
    2124,
    1,
    nil,
    8003024
  },
  [2125] = {
    2125,
    1,
    nil,
    8003025
  },
  [2126] = {
    2126,
    1,
    nil,
    8003026
  },
  [2127] = {
    2127,
    1,
    nil,
    8003027
  },
  [2128] = {
    2128,
    1,
    nil,
    8003028
  },
  [2129] = {
    2129,
    1,
    nil,
    8003029
  },
  [2130] = {
    2130,
    1,
    nil,
    8003030
  },
  [2131] = {
    2131,
    1,
    nil,
    8003101
  },
  [2132] = {
    2132,
    1,
    nil,
    8003102
  },
  [2133] = {
    2133,
    1,
    nil,
    8003103
  },
  [2134] = {
    2134,
    1,
    nil,
    8003104
  },
  [2135] = {
    2135,
    1,
    nil,
    8003105
  },
  [2136] = {
    2136,
    1,
    nil,
    8003106
  },
  [2201] = {
    2201,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003001,
      focusType = 1,
      sizeScale = true
    }
  },
  [2202] = {
    2202,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003002,
      focusType = 1,
      sizeScale = true
    }
  },
  [2203] = {
    2203,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003003,
      focusType = 1,
      sizeScale = true
    }
  },
  [2204] = {
    2204,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003004,
      focusType = 1,
      sizeScale = true
    }
  },
  [2205] = {
    2205,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003005,
      focusType = 1,
      sizeScale = true
    }
  },
  [2206] = {
    2206,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003006,
      focusType = 1,
      sizeScale = true
    }
  },
  [2207] = {
    2207,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003007,
      focusType = 1,
      sizeScale = true
    }
  },
  [2208] = {
    2208,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003008,
      focusType = 1,
      sizeScale = true
    }
  },
  [2209] = {
    2209,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003009,
      focusType = 1,
      sizeScale = true
    }
  },
  [2210] = {
    2210,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003010,
      focusType = 1,
      sizeScale = true
    }
  },
  [2211] = {
    2211,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003011,
      focusType = 1,
      sizeScale = true
    }
  },
  [2212] = {
    2212,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003012,
      focusType = 1,
      sizeScale = true
    }
  },
  [2213] = {
    2213,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003013,
      focusType = 1,
      sizeScale = true
    }
  },
  [2214] = {
    2214,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003014,
      focusType = 1,
      sizeScale = true
    }
  },
  [2215] = {
    2215,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003015,
      focusType = 1,
      sizeScale = true
    }
  },
  [2216] = {
    2216,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003016,
      focusType = 1,
      sizeScale = true
    }
  },
  [2217] = {
    2217,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003017,
      focusType = 1,
      sizeScale = true
    }
  },
  [2218] = {
    2218,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003018,
      focusType = 1,
      sizeScale = true
    }
  },
  [2219] = {
    2219,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003019,
      focusType = 1,
      sizeScale = true
    }
  },
  [2220] = {
    2220,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003020,
      focusType = 1,
      sizeScale = true
    }
  },
  [2221] = {
    2221,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003021,
      focusType = 1,
      sizeScale = true
    }
  },
  [2222] = {
    2222,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003022,
      focusType = 1,
      sizeScale = true
    }
  },
  [2223] = {
    2223,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003023,
      focusType = 1,
      sizeScale = true
    }
  },
  [2224] = {
    2224,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003024,
      focusType = 1,
      sizeScale = true
    }
  },
  [2225] = {
    2225,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003025,
      focusType = 1,
      sizeScale = true
    }
  },
  [2226] = {
    2226,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003026,
      focusType = 1,
      sizeScale = true
    }
  },
  [2227] = {
    2227,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003027,
      focusType = 1,
      sizeScale = true
    }
  },
  [2228] = {
    2228,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003028,
      focusType = 1,
      sizeScale = true
    }
  },
  [2229] = {
    2229,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003029,
      focusType = 1,
      sizeScale = true
    }
  },
  [2230] = {
    2230,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003030,
      focusType = 1,
      sizeScale = true
    }
  },
  [2231] = {
    2231,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003101,
      focusType = 1,
      sizeScale = true
    }
  },
  [2232] = {
    2232,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003102,
      focusType = 1,
      sizeScale = true
    }
  },
  [2233] = {
    2233,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003103,
      focusType = 1,
      sizeScale = true
    }
  },
  [2234] = {
    2234,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003104,
      focusType = 1,
      sizeScale = true
    }
  },
  [2235] = {
    2235,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003105,
      focusType = 1,
      sizeScale = true
    }
  },
  [2236] = {
    2236,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8003106,
      focusType = 1,
      sizeScale = true
    }
  },
  [2301] = {
    2301,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000400, 1}
    }
  },
  [2302] = {
    2302,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000401, 1}
    }
  },
  [2303] = {
    2303,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000402, 1}
    }
  },
  [2304] = {
    2304,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000403, 1}
    }
  },
  [2305] = {
    2305,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000404, 1}
    }
  },
  [2306] = {
    2306,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000405, 1}
    }
  },
  [2307] = {
    2307,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000406, 1}
    }
  },
  [2308] = {
    2308,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000407, 1}
    }
  },
  [2309] = {
    2309,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000408, 1}
    }
  },
  [2351] = {
    2351,
    4,
    nil,
    nil,
    nil,
    nil,
    50630303
  },
  [2352] = {
    2352,
    4,
    nil,
    nil,
    nil,
    nil,
    50630304
  },
  [2353] = {
    2353,
    4,
    nil,
    nil,
    nil,
    nil,
    50630803
  },
  [2354] = {
    2354,
    4,
    nil,
    nil,
    nil,
    nil,
    50630804
  },
  [2355] = {
    2355,
    4,
    nil,
    nil,
    nil,
    nil,
    50631103
  },
  [2401] = {
    2401,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [2402] = {
    2402,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [2403] = {
    2403,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [2404] = {
    2404,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [2405] = {
    2405,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[3]
  },
  [2406] = {
    2406,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[23]
  },
  [2407] = {
    2407,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[23]
  },
  [2408] = {
    2408,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [2409] = {
    2409,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [2410] = {
    2410,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      show = false,
      sprite = "exp_S3_map_doubt_blue"
    }
  },
  [2501] = {
    2501,
    2,
    nil,
    nil,
    common[24]
  },
  [2502] = {
    2502,
    2,
    nil,
    nil,
    {
      eventanim = "S3_anim_beike_open",
      playeranim = "interact",
      playerloop = "1"
    }
  },
  [2503] = {
    2503,
    3,
    nil,
    nil,
    nil,
    {
      eventeffec = "eff_S3906001_idle"
    }
  },
  [2504] = {
    2504,
    2,
    nil,
    nil,
    {
      eventanim = "S3_envani_normal_close"
    }
  },
  [2505] = {
    2505,
    2,
    nil,
    nil,
    {
      eventanim = "S3_envani_hard_close"
    }
  },
  [2506] = {
    2506,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[6]
  },
  [2507] = {
    2507,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[19]
  },
  [2508] = {
    2508,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [2509] = {
    2509,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    "UISeasonBuildControllerS3"
  },
  [2510] = {
    2510,
    2,
    nil,
    nil,
    {playeranim = "interact", playerloop = "1"}
  },
  [2511] = {
    2511,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    "UISeasonBackpack"
  },
  [2512] = {
    2512,
    2,
    nil,
    nil,
    {
      eventanim = "S3_pfb_yd_magicludian_in"
    }
  },
  [3101] = {
    3101,
    4,
    nil,
    nil,
    nil,
    nil,
    50720101
  },
  [3102] = {
    3102,
    4,
    nil,
    nil,
    nil,
    nil,
    50720101
  },
  [3103] = {
    3103,
    1,
    nil,
    8004003
  },
  [3104] = {
    3104,
    1,
    nil,
    8004004
  },
  [3105] = {
    3105,
    1,
    nil,
    8004005
  },
  [3106] = {
    3106,
    1,
    nil,
    8004006
  },
  [3107] = {
    3107,
    1,
    nil,
    8004007
  },
  [3108] = {
    3108,
    1,
    nil,
    8004008
  },
  [3109] = {
    3109,
    1,
    nil,
    8004009
  },
  [3110] = {
    3110,
    1,
    nil,
    8004010
  },
  [3111] = {
    3111,
    1,
    nil,
    8004011
  },
  [3112] = {
    3112,
    1,
    nil,
    8004012
  },
  [3113] = {
    3113,
    1,
    nil,
    8004013
  },
  [3114] = {
    3114,
    1,
    nil,
    8004014
  },
  [3115] = {
    3115,
    1,
    nil,
    8004015
  },
  [3116] = {
    3116,
    1,
    nil,
    8004016
  },
  [3117] = {
    3117,
    1,
    nil,
    8004017
  },
  [3118] = {
    3118,
    1,
    nil,
    8004018
  },
  [3119] = {
    3119,
    1,
    nil,
    8004019
  },
  [3120] = {
    3120,
    1,
    nil,
    8004020
  },
  [3121] = {
    3121,
    1,
    nil,
    8004021
  },
  [3122] = {
    3122,
    1,
    nil,
    8004022
  },
  [3123] = {
    3123,
    1,
    nil,
    8004023
  },
  [3124] = {
    3124,
    1,
    nil,
    8004024
  },
  [3125] = {
    3125,
    1,
    nil,
    8004025
  },
  [3126] = {
    3126,
    1,
    nil,
    8004026
  },
  [3127] = {
    3127,
    1,
    nil,
    8004027
  },
  [3128] = {
    3128,
    1,
    nil,
    8004028
  },
  [3129] = {
    3129,
    1,
    nil,
    8004029
  },
  [3130] = {
    3130,
    1,
    nil,
    8004030
  },
  [3131] = {
    3131,
    1,
    nil,
    8004031
  },
  [3132] = {
    3132,
    1,
    nil,
    8004032
  },
  [3133] = {
    3133,
    1,
    nil,
    8004101
  },
  [3134] = {
    3134,
    1,
    nil,
    8004102
  },
  [3135] = {
    3135,
    1,
    nil,
    8004103
  },
  [3136] = {
    3136,
    1,
    nil,
    8004104
  },
  [3137] = {
    3137,
    1,
    nil,
    8004105
  },
  [3138] = {
    3138,
    1,
    nil,
    8004106
  },
  [3139] = {
    3139,
    1,
    nil,
    8004107
  },
  [3140] = {
    3140,
    1,
    nil,
    8004108
  },
  [3141] = {
    3141,
    1,
    nil,
    8004109
  },
  [3142] = {
    3142,
    1,
    nil,
    8004110
  },
  [3143] = {
    3143,
    1,
    nil,
    8004111
  },
  [3144] = {
    3144,
    1,
    nil,
    8004112
  },
  [3151] = {
    3151,
    1,
    nil,
    8004501
  },
  [3201] = {
    3201,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004001,
      focusType = 2,
      sizeScale = false
    }
  },
  [3202] = {
    3202,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004002,
      focusType = 2,
      sizeScale = false
    }
  },
  [3203] = {
    3203,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004003,
      focusType = 1,
      sizeScale = true
    }
  },
  [3204] = {
    3204,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004004,
      focusType = 1,
      sizeScale = true
    }
  },
  [3205] = {
    3205,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004005,
      focusType = 1,
      sizeScale = true
    }
  },
  [3206] = {
    3206,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004006,
      focusType = 1,
      sizeScale = true
    }
  },
  [3207] = {
    3207,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004007,
      focusType = 1,
      sizeScale = true
    }
  },
  [3208] = {
    3208,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004008,
      focusType = 1,
      sizeScale = true
    }
  },
  [3209] = {
    3209,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004009,
      focusType = 1,
      sizeScale = true
    }
  },
  [3210] = {
    3210,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004010,
      focusType = 1,
      sizeScale = true
    }
  },
  [3211] = {
    3211,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004011,
      focusType = 1,
      sizeScale = true
    }
  },
  [3212] = {
    3212,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004012,
      focusType = 1,
      sizeScale = true
    }
  },
  [3213] = {
    3213,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004013,
      focusType = 1,
      sizeScale = true
    }
  },
  [3214] = {
    3214,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004014,
      focusType = 1,
      sizeScale = true
    }
  },
  [3215] = {
    3215,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004015,
      focusType = 1,
      sizeScale = true
    }
  },
  [3216] = {
    3216,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004016,
      focusType = 1,
      sizeScale = true
    }
  },
  [3217] = {
    3217,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004017,
      focusType = 1,
      sizeScale = true
    }
  },
  [3218] = {
    3218,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004018,
      focusType = 1,
      sizeScale = true
    }
  },
  [3219] = {
    3219,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004019,
      focusType = 1,
      sizeScale = true
    }
  },
  [3220] = {
    3220,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004020,
      focusType = 1,
      sizeScale = true
    }
  },
  [3221] = {
    3221,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004021,
      focusType = 1,
      sizeScale = true
    }
  },
  [3222] = {
    3222,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004022,
      focusType = 1,
      sizeScale = true
    }
  },
  [3223] = {
    3223,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004023,
      focusType = 1,
      sizeScale = true
    }
  },
  [3224] = {
    3224,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004024,
      focusType = 1,
      sizeScale = true
    }
  },
  [3225] = {
    3225,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004025,
      focusType = 1,
      sizeScale = true
    }
  },
  [3226] = {
    3226,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004026,
      focusType = 1,
      sizeScale = true
    }
  },
  [3227] = {
    3227,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004027,
      focusType = 1,
      sizeScale = true
    }
  },
  [3228] = {
    3228,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004028,
      focusType = 1,
      sizeScale = true
    }
  },
  [3229] = {
    3229,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004029,
      focusType = 1,
      sizeScale = true
    }
  },
  [3230] = {
    3230,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004030,
      focusType = 1,
      sizeScale = true
    }
  },
  [3231] = {
    3231,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004031,
      focusType = 1,
      sizeScale = true
    }
  },
  [3232] = {
    3232,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004032,
      focusType = 1,
      sizeScale = true
    }
  },
  [3233] = {
    3233,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004101,
      focusType = 1,
      sizeScale = true
    }
  },
  [3234] = {
    3234,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004102,
      focusType = 1,
      sizeScale = true
    }
  },
  [3235] = {
    3235,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004103,
      focusType = 1,
      sizeScale = true
    }
  },
  [3236] = {
    3236,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004104,
      focusType = 1,
      sizeScale = true
    }
  },
  [3237] = {
    3237,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004105,
      focusType = 1,
      sizeScale = true
    }
  },
  [3238] = {
    3238,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004106,
      focusType = 1,
      sizeScale = true
    }
  },
  [3239] = {
    3239,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004107,
      focusType = 1,
      sizeScale = true
    }
  },
  [3240] = {
    3240,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004108,
      focusType = 1,
      sizeScale = true
    }
  },
  [3241] = {
    3241,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004109,
      focusType = 1,
      sizeScale = true
    }
  },
  [3242] = {
    3242,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004110,
      focusType = 1,
      sizeScale = true
    }
  },
  [3243] = {
    3243,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004111,
      focusType = 1,
      sizeScale = true
    }
  },
  [3244] = {
    3244,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004112,
      focusType = 1,
      sizeScale = true
    }
  },
  [3251] = {
    3251,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004501,
      focusType = 1,
      sizeScale = true
    }
  },
  [3301] = {
    3301,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {7000801, 1}
    }
  },
  [3401] = {
    3401,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [3402] = {
    3402,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [3403] = {
    3403,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [3404] = {
    3404,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [3405] = {
    3405,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[3]
  },
  [3406] = {
    3406,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [3407] = {
    3407,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [3408] = {
    3408,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[4]
  },
  [3409] = {
    3409,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[4]
  },
  [3410] = {
    3410,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[5]
  },
  [3411] = {
    3411,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [3412] = {
    3412,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[9]
  },
  [3413] = {
    3413,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[25]
  },
  [3414] = {
    3414,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = false,
      sprite = "exp_s3_map_icon19"
    }
  },
  [3415] = {
    3415,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = true,
      sprite = "exp_s3_map_icon20"
    }
  },
  [3416] = {
    3416,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = false,
      sprite = "exp_s3_map_icon20"
    }
  },
  [3417] = {
    3417,
    17,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    1000
  },
  [3501] = {
    3501,
    2,
    nil,
    nil,
    common[24]
  },
  [3502] = {
    3502,
    2,
    nil,
    nil,
    {
      eventanim = "S4_anim_baoxiang_open",
      playeranim = "interact",
      playerloop = "1",
      audio = "9900095"
    }
  },
  [3503] = {
    3503,
    3,
    nil,
    nil,
    nil,
    {
      eventeffec = "eff_S4906001_idle"
    }
  },
  [3504] = {
    3504,
    2,
    nil,
    nil,
    common[26]
  },
  [3505] = {
    3505,
    2,
    nil,
    nil,
    common[26]
  },
  [3506] = {
    3506,
    2,
    nil,
    nil,
    common[21]
  },
  [3507] = {
    3507,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[6]
  },
  [3508] = {
    3508,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[19]
  },
  [3509] = {
    3509,
    15,
    true,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[20]
  },
  [3510] = {
    3510,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004301,
      focusType = 2,
      sizeScale = false
    }
  },
  [3511] = {
    3511,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004302,
      focusType = 2,
      sizeScale = false
    }
  },
  [3512] = {
    3512,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004303,
      focusType = 2,
      sizeScale = false
    }
  },
  [3513] = {
    3513,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004304,
      focusType = 2,
      sizeScale = false
    }
  },
  [3514] = {
    3514,
    2,
    nil,
    nil,
    {
      eventanim = "S4_anim_split_C_03_fix"
    }
  },
  [3515] = {
    3515,
    2,
    nil,
    nil,
    common[27]
  },
  [3516] = {
    3516,
    2,
    nil,
    nil,
    common[27]
  },
  [3517] = {
    3517,
    2,
    nil,
    nil,
    {
      id = 8004304,
      eventanim = "S3_anim_beike_open"
    }
  },
  [3518] = {
    3518,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004401,
      focusType = 2,
      sizeScale = false
    }
  },
  [3519] = {
    3519,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004402,
      focusType = 2,
      sizeScale = false
    }
  },
  [3520] = {
    3520,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8004403,
      focusType = 2,
      sizeScale = false
    }
  },
  [3521] = {
    3521,
    4,
    nil,
    nil,
    nil,
    nil,
    50720703
  },
  [3522] = {
    3522,
    4,
    nil,
    nil,
    nil,
    nil,
    50720503
  },
  [3523] = {
    3523,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65180101
  },
  [3524] = {
    3524,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65180201
  },
  [4101] = {
    4101,
    4,
    nil,
    nil,
    nil,
    nil,
    50760100
  },
  [4102] = {
    4102,
    4,
    nil,
    nil,
    nil,
    nil,
    50760200
  },
  [4103] = {
    4103,
    4,
    nil,
    nil,
    nil,
    nil,
    50760300
  },
  [4104] = {
    4104,
    4,
    nil,
    nil,
    nil,
    nil,
    50760400
  },
  [4105] = {
    4105,
    1,
    nil,
    8005005
  },
  [4106] = {
    4106,
    4,
    nil,
    nil,
    nil,
    nil,
    50760600
  },
  [4107] = {
    4107,
    1,
    nil,
    8005007
  },
  [4108] = {
    4108,
    4,
    nil,
    nil,
    nil,
    nil,
    50760800
  },
  [4109] = {
    4109,
    4,
    nil,
    nil,
    nil,
    nil,
    50760900
  },
  [4110] = {
    4110,
    4,
    nil,
    nil,
    nil,
    nil,
    50761000
  },
  [4111] = {
    4111,
    1,
    nil,
    8005011
  },
  [4112] = {
    4112,
    4,
    nil,
    nil,
    nil,
    nil,
    50761200
  },
  [4113] = {
    4113,
    4,
    nil,
    nil,
    nil,
    nil,
    50761300
  },
  [4114] = {
    4114,
    4,
    nil,
    nil,
    nil,
    nil,
    50761400
  },
  [4115] = {
    4115,
    4,
    nil,
    nil,
    nil,
    nil,
    50761500
  },
  [4116] = {
    4116,
    1,
    nil,
    8005016
  },
  [4117] = {
    4117,
    1,
    nil,
    8005101
  },
  [4118] = {
    4118,
    1,
    nil,
    8005102
  },
  [4119] = {
    4119,
    1,
    nil,
    8005103
  },
  [4120] = {
    4120,
    1,
    nil,
    8005104
  },
  [4121] = {
    4121,
    1,
    nil,
    8005105
  },
  [4122] = {
    4122,
    1,
    nil,
    8005106
  },
  [4123] = {
    4123,
    1,
    nil,
    8005107
  },
  [4124] = {
    4124,
    1,
    nil,
    8005108
  },
  [4125] = {
    4125,
    1,
    nil,
    8005109
  },
  [4126] = {
    4126,
    1,
    nil,
    8005110
  },
  [4201] = {
    4201,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005001,
      focusType = 2,
      sizeScale = false
    }
  },
  [4202] = {
    4202,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005002,
      focusType = 2,
      sizeScale = false
    }
  },
  [4203] = {
    4203,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005003,
      focusType = 2,
      sizeScale = false
    }
  },
  [4204] = {
    4204,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005004,
      focusType = 2,
      sizeScale = false
    }
  },
  [4205] = {
    4205,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005005,
      focusType = 1,
      sizeScale = true
    }
  },
  [4206] = {
    4206,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005006,
      focusType = 2,
      sizeScale = false
    }
  },
  [4207] = {
    4207,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005007,
      focusType = 1,
      sizeScale = true
    }
  },
  [4208] = {
    4208,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005008,
      focusType = 2,
      sizeScale = false
    }
  },
  [4209] = {
    4209,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005009,
      focusType = 2,
      sizeScale = false
    }
  },
  [4210] = {
    4210,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005010,
      focusType = 2,
      sizeScale = false
    }
  },
  [4211] = {
    4211,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005011,
      focusType = 1,
      sizeScale = true
    }
  },
  [4212] = {
    4212,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005012,
      focusType = 2,
      sizeScale = false
    }
  },
  [4213] = {
    4213,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005013,
      focusType = 2,
      sizeScale = false
    }
  },
  [4214] = {
    4214,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005014,
      focusType = 2,
      sizeScale = false
    }
  },
  [4215] = {
    4215,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005015,
      focusType = 2,
      sizeScale = false
    }
  },
  [4216] = {
    4216,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005016,
      focusType = 1,
      sizeScale = true
    }
  },
  [4217] = {
    4217,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005101,
      focusType = 1,
      sizeScale = true
    }
  },
  [4218] = {
    4218,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005102,
      focusType = 1,
      sizeScale = true
    }
  },
  [4219] = {
    4219,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005103,
      focusType = 1,
      sizeScale = true
    }
  },
  [4220] = {
    4220,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005104,
      focusType = 1,
      sizeScale = true
    }
  },
  [4221] = {
    4221,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005105,
      focusType = 1,
      sizeScale = true
    }
  },
  [4222] = {
    4222,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005106,
      focusType = 1,
      sizeScale = true
    }
  },
  [4223] = {
    4223,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005107,
      focusType = 1,
      sizeScale = true
    }
  },
  [4224] = {
    4224,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005108,
      focusType = 1,
      sizeScale = true
    }
  },
  [4225] = {
    4225,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005109,
      focusType = 1,
      sizeScale = true
    }
  },
  [4226] = {
    4226,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005110,
      focusType = 1,
      sizeScale = true
    }
  },
  [4301] = {
    4301,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {3001025, 1}
    }
  },
  [4302] = {
    4302,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {3001022, 300}
    }
  },
  [4401] = {
    4401,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [4402] = {
    4402,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [4403] = {
    4403,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [4404] = {
    4404,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [4405] = {
    4405,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[3]
  },
  [4406] = {
    4406,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [4407] = {
    4407,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [4408] = {
    4408,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[4]
  },
  [4409] = {
    4409,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[4]
  },
  [4410] = {
    4410,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[5]
  },
  [4411] = {
    4411,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[10]
  },
  [4412] = {
    4412,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[9]
  },
  [4413] = {
    4413,
    17,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    1000
  },
  [4501] = {
    4501,
    2,
    nil,
    nil,
    common[24]
  },
  [4502] = {
    4502,
    2,
    nil,
    nil,
    {
      eventanim = "S5_pfb_baoxiang_open",
      playeranim = "interact",
      playerloop = "1",
      audio = "10700096"
    }
  },
  [4503] = {
    4503,
    3,
    nil,
    nil,
    nil,
    {
      eventeffec = "S5_pfb_boss_idle"
    }
  },
  [4504] = {
    4504,
    2,
    nil,
    nil,
    common[28]
  },
  [4505] = {
    4505,
    2,
    nil,
    nil,
    common[29]
  },
  [4506] = {
    4506,
    2,
    nil,
    nil,
    common[21]
  },
  [4507] = {
    4507,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005301,
      focusType = 2,
      sizeScale = false
    }
  },
  [4508] = {
    4508,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8005302,
      focusType = 2,
      sizeScale = false
    }
  },
  [4509] = {
    4509,
    2,
    nil,
    nil,
    {
      eventanim = "S5_pfb_temple_collapse"
    }
  },
  [4510] = {
    4510,
    2,
    nil,
    nil,
    common[30]
  },
  [4511] = {
    4511,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    "UISeasonOnceMission"
  },
  [4512] = {
    4512,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[41]
  },
  [5101] = {
    5101,
    4,
    nil,
    nil,
    nil,
    nil,
    50790100
  },
  [5102] = {
    5102,
    4,
    nil,
    nil,
    nil,
    nil,
    50790200
  },
  [5103] = {
    5103,
    4,
    nil,
    nil,
    nil,
    nil,
    50790300
  },
  [5104] = {
    5104,
    4,
    nil,
    nil,
    nil,
    nil,
    50790400
  },
  [5105] = {
    5105,
    4,
    nil,
    nil,
    nil,
    nil,
    50790500
  },
  [5106] = {
    5106,
    1,
    nil,
    8006006
  },
  [5107] = {
    5107,
    4,
    nil,
    nil,
    nil,
    nil,
    50790700
  },
  [5108] = {
    5108,
    4,
    nil,
    nil,
    nil,
    nil,
    50790800
  },
  [5109] = {
    5109,
    4,
    nil,
    nil,
    nil,
    nil,
    50790900
  },
  [5110] = {
    5110,
    1,
    nil,
    8006010
  },
  [5111] = {
    5111,
    4,
    nil,
    nil,
    nil,
    nil,
    50791100
  },
  [5112] = {
    5112,
    4,
    nil,
    nil,
    nil,
    nil,
    50791200
  },
  [5113] = {
    5113,
    1,
    nil,
    8006013
  },
  [5114] = {
    5114,
    1,
    nil,
    8006014
  },
  [5115] = {
    5115,
    4,
    nil,
    nil,
    nil,
    nil,
    50791500
  },
  [5116] = {
    5116,
    1,
    nil,
    8006016
  },
  [5117] = {
    5117,
    1,
    nil,
    8006101
  },
  [5118] = {
    5118,
    1,
    nil,
    8006102
  },
  [5119] = {
    5119,
    1,
    nil,
    8006103
  },
  [5120] = {
    5120,
    1,
    nil,
    8006104
  },
  [5121] = {
    5121,
    1,
    nil,
    8006105
  },
  [5122] = {
    5122,
    1,
    nil,
    8006106
  },
  [5123] = {
    5123,
    1,
    nil,
    8006107
  },
  [5124] = {
    5124,
    1,
    nil,
    8006108
  },
  [5125] = {
    5125,
    1,
    nil,
    8006109
  },
  [5126] = {
    5126,
    1,
    nil,
    8006110
  },
  [5201] = {
    5201,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006001,
      focusType = 2,
      sizeScale = false
    }
  },
  [5202] = {
    5202,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006002,
      focusType = 2,
      sizeScale = false
    }
  },
  [5203] = {
    5203,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006003,
      focusType = 2,
      sizeScale = false
    }
  },
  [5204] = {
    5204,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006004,
      focusType = 2,
      sizeScale = false
    }
  },
  [5205] = {
    5205,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006005,
      focusType = 2,
      sizeScale = false
    }
  },
  [5206] = {
    5206,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006006,
      focusType = 1,
      sizeScale = true
    }
  },
  [5207] = {
    5207,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006007,
      focusType = 2,
      sizeScale = false
    }
  },
  [5208] = {
    5208,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006008,
      focusType = 2,
      sizeScale = false
    }
  },
  [5209] = {
    5209,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006009,
      focusType = 2,
      sizeScale = false
    }
  },
  [5210] = {
    5210,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006010,
      focusType = 1,
      sizeScale = true
    }
  },
  [5211] = {
    5211,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006011,
      focusType = 2,
      sizeScale = false
    }
  },
  [5212] = {
    5212,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006012,
      focusType = 2,
      sizeScale = false
    }
  },
  [5213] = {
    5213,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006013,
      focusType = 1,
      sizeScale = true
    }
  },
  [5214] = {
    5214,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006014,
      focusType = 1,
      sizeScale = true
    }
  },
  [5215] = {
    5215,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006015,
      focusType = 2,
      sizeScale = false
    }
  },
  [5216] = {
    5216,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006016,
      focusType = 1,
      sizeScale = true
    }
  },
  [5217] = {
    5217,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006101,
      focusType = 1,
      sizeScale = true
    }
  },
  [5218] = {
    5218,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006102,
      focusType = 1,
      sizeScale = true
    }
  },
  [5219] = {
    5219,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006103,
      focusType = 1,
      sizeScale = true
    }
  },
  [5220] = {
    5220,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006104,
      focusType = 1,
      sizeScale = true
    }
  },
  [5221] = {
    5221,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006105,
      focusType = 1,
      sizeScale = true
    }
  },
  [5222] = {
    5222,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006106,
      focusType = 1,
      sizeScale = true
    }
  },
  [5223] = {
    5223,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006107,
      focusType = 1,
      sizeScale = true
    }
  },
  [5224] = {
    5224,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006108,
      focusType = 1,
      sizeScale = true
    }
  },
  [5225] = {
    5225,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006109,
      focusType = 1,
      sizeScale = true
    }
  },
  [5226] = {
    5226,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006110,
      focusType = 1,
      sizeScale = true
    }
  },
  [5301] = {
    5301,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {3001030, 1}
    }
  },
  [5302] = {
    5302,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {3001027, 350}
    }
  },
  [5401] = {
    5401,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [5402] = {
    5402,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [5403] = {
    5403,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [5404] = {
    5404,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [5405] = {
    5405,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[3]
  },
  [5406] = {
    5406,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [5407] = {
    5407,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [5408] = {
    5408,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[31]
  },
  [5409] = {
    5409,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[31]
  },
  [5410] = {
    5410,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = true,
      sprite = "exp_S6_map_doubt_blue"
    }
  },
  [5411] = {
    5411,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      show = false,
      sprite = "exp_S6_map_doubt_blue"
    }
  },
  [5412] = {
    5412,
    17,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    1000
  },
  [5501] = {
    5501,
    2,
    nil,
    nil,
    common[24]
  },
  [5502] = {
    5502,
    2,
    nil,
    nil,
    {
      eventanim = "S5_pfb_baoxiang_open",
      playeranim = "interact",
      playerloop = "1",
      audio = "9200090"
    }
  },
  [5503] = {
    5503,
    3,
    nil,
    nil,
    nil,
    {
      eventeffec = "S6_pfb_boss_idle"
    }
  },
  [5504] = {
    5504,
    2,
    nil,
    nil,
    common[28]
  },
  [5505] = {
    5505,
    2,
    nil,
    nil,
    common[29]
  },
  [5506] = {
    5506,
    2,
    nil,
    nil,
    common[21]
  },
  [5507] = {
    5507,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8006301,
      focusType = 2,
      sizeScale = false
    }
  },
  [5508] = {
    5508,
    2,
    nil,
    nil,
    common[30]
  },
  [5509] = {
    5509,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[42]
  },
  [5510] = {
    5510,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[41]
  },
  [6101] = {
    6101,
    4,
    nil,
    nil,
    nil,
    nil,
    50830100
  },
  [6102] = {
    6102,
    4,
    nil,
    nil,
    nil,
    nil,
    50830200
  },
  [6103] = {
    6103,
    1,
    nil,
    8007003
  },
  [6104] = {
    6104,
    4,
    nil,
    nil,
    nil,
    nil,
    50830400
  },
  [6105] = {
    6105,
    4,
    nil,
    nil,
    nil,
    nil,
    50830500
  },
  [6106] = {
    6106,
    4,
    nil,
    nil,
    nil,
    nil,
    50830600
  },
  [6107] = {
    6107,
    4,
    nil,
    nil,
    nil,
    nil,
    50830700
  },
  [6108] = {
    6108,
    1,
    nil,
    8007008
  },
  [6109] = {
    6109,
    4,
    nil,
    nil,
    nil,
    nil,
    50830900
  },
  [6110] = {
    6110,
    4,
    nil,
    nil,
    nil,
    nil,
    50831000
  },
  [6111] = {
    6111,
    4,
    nil,
    nil,
    nil,
    nil,
    50831100
  },
  [6112] = {
    6112,
    4,
    nil,
    nil,
    nil,
    nil,
    50831200
  },
  [6113] = {
    6113,
    1,
    nil,
    8007013
  },
  [6114] = {
    6114,
    4,
    nil,
    nil,
    nil,
    nil,
    50831400
  },
  [6115] = {
    6115,
    4,
    nil,
    nil,
    nil,
    nil,
    50831500
  },
  [6116] = {
    6116,
    1,
    nil,
    8007016
  },
  [6117] = {
    6117,
    1,
    nil,
    8007101
  },
  [6118] = {
    6118,
    1,
    nil,
    8007102
  },
  [6119] = {
    6119,
    1,
    nil,
    8007103
  },
  [6120] = {
    6120,
    1,
    nil,
    8007104
  },
  [6121] = {
    6121,
    1,
    nil,
    8007105
  },
  [6122] = {
    6122,
    1,
    nil,
    8007106
  },
  [6123] = {
    6123,
    1,
    nil,
    8007107
  },
  [6124] = {
    6124,
    1,
    nil,
    8007108
  },
  [6125] = {
    6125,
    1,
    nil,
    8007109
  },
  [6126] = {
    6126,
    1,
    nil,
    8007110
  },
  [6201] = {
    6201,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007001,
      focusType = 2,
      sizeScale = false
    }
  },
  [6202] = {
    6202,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007002,
      focusType = 2,
      sizeScale = false
    }
  },
  [6203] = {
    6203,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007003,
      focusType = 1,
      sizeScale = true
    }
  },
  [6204] = {
    6204,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007004,
      focusType = 2,
      sizeScale = false
    }
  },
  [6205] = {
    6205,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007005,
      focusType = 2,
      sizeScale = false
    }
  },
  [6206] = {
    6206,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007006,
      focusType = 2,
      sizeScale = false
    }
  },
  [6207] = {
    6207,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007007,
      focusType = 2,
      sizeScale = false
    }
  },
  [6208] = {
    6208,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007008,
      focusType = 1,
      sizeScale = true
    }
  },
  [6209] = {
    6209,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007009,
      focusType = 2,
      sizeScale = false
    }
  },
  [6210] = {
    6210,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007010,
      focusType = 2,
      sizeScale = false
    }
  },
  [6211] = {
    6211,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007011,
      focusType = 2,
      sizeScale = false
    }
  },
  [6212] = {
    6212,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007012,
      focusType = 2,
      sizeScale = false
    }
  },
  [6213] = {
    6213,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007013,
      focusType = 1,
      sizeScale = true
    }
  },
  [6214] = {
    6214,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007014,
      focusType = 2,
      sizeScale = false
    }
  },
  [6215] = {
    6215,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007015,
      focusType = 2,
      sizeScale = false
    }
  },
  [6216] = {
    6216,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007016,
      focusType = 1,
      sizeScale = true
    }
  },
  [6217] = {
    6217,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007101,
      focusType = 1,
      sizeScale = true
    }
  },
  [6218] = {
    6218,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007102,
      focusType = 1,
      sizeScale = true
    }
  },
  [6219] = {
    6219,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007103,
      focusType = 1,
      sizeScale = true
    }
  },
  [6220] = {
    6220,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007104,
      focusType = 1,
      sizeScale = true
    }
  },
  [6221] = {
    6221,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007105,
      focusType = 1,
      sizeScale = true
    }
  },
  [6222] = {
    6222,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007106,
      focusType = 1,
      sizeScale = true
    }
  },
  [6223] = {
    6223,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007107,
      focusType = 1,
      sizeScale = true
    }
  },
  [6224] = {
    6224,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007108,
      focusType = 1,
      sizeScale = true
    }
  },
  [6225] = {
    6225,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007109,
      focusType = 1,
      sizeScale = true
    }
  },
  [6226] = {
    6226,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007110,
      focusType = 1,
      sizeScale = true
    }
  },
  [6301] = {
    6301,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {3001035, 1}
    }
  },
  [6302] = {
    6302,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {3001032, 300}
    }
  },
  [6401] = {
    6401,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [6402] = {
    6402,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [6403] = {
    6403,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [6404] = {
    6404,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [6405] = {
    6405,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[3]
  },
  [6406] = {
    6406,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [6407] = {
    6407,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [6408] = {
    6408,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[32]
  },
  [6409] = {
    6409,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[32]
  },
  [6410] = {
    6410,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = true,
      sprite = "exp_S7_map_doubt_blue"
    }
  },
  [6411] = {
    6411,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      show = false,
      sprite = "exp_S7_map_doubt_blue"
    }
  },
  [6412] = {
    6412,
    17,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    1000
  },
  [6501] = {
    6501,
    2,
    nil,
    nil,
    common[24]
  },
  [6502] = {
    6502,
    2,
    nil,
    nil,
    {
      eventanim = "S5_pfb_baoxiang_open",
      playeranim = "interact",
      playerloop = "1",
      audio = "15500085"
    }
  },
  [6503] = {
    6503,
    3,
    nil,
    nil,
    nil,
    common[33]
  },
  [6504] = {
    6504,
    2,
    nil,
    nil,
    common[28]
  },
  [6505] = {
    6505,
    2,
    nil,
    nil,
    common[29]
  },
  [6506] = {
    6506,
    2,
    nil,
    nil,
    common[21]
  },
  [6507] = {
    6507,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8007301,
      focusType = 2,
      sizeScale = false
    }
  },
  [6508] = {
    6508,
    2,
    nil,
    nil,
    common[30]
  },
  [6509] = {
    6509,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[42]
  },
  [6510] = {
    6510,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[41]
  },
  [7101] = {
    7101,
    4,
    nil,
    nil,
    nil,
    nil,
    50870100
  },
  [7102] = {
    7102,
    1,
    nil,
    8008002
  },
  [7103] = {
    7103,
    4,
    nil,
    nil,
    nil,
    nil,
    50870300
  },
  [7104] = {
    7104,
    4,
    nil,
    nil,
    nil,
    nil,
    50870400
  },
  [7105] = {
    7105,
    1,
    nil,
    8008005
  },
  [7106] = {
    7106,
    4,
    nil,
    nil,
    nil,
    nil,
    50870600
  },
  [7107] = {
    7107,
    4,
    nil,
    nil,
    nil,
    nil,
    50870700
  },
  [7108] = {
    7108,
    4,
    nil,
    nil,
    nil,
    nil,
    50870800
  },
  [7109] = {
    7109,
    4,
    nil,
    nil,
    nil,
    nil,
    50870900
  },
  [7110] = {
    7110,
    4,
    nil,
    nil,
    nil,
    nil,
    50871000
  },
  [7111] = {
    7111,
    1,
    nil,
    8008011
  },
  [7112] = {
    7112,
    4,
    nil,
    nil,
    nil,
    nil,
    50871200
  },
  [7113] = {
    7113,
    4,
    nil,
    nil,
    nil,
    nil,
    50871300
  },
  [7114] = {
    7114,
    4,
    nil,
    nil,
    nil,
    nil,
    50871400
  },
  [7115] = {
    7115,
    1,
    nil,
    8008015
  },
  [7116] = {
    7116,
    1,
    nil,
    8008016
  },
  [7117] = {
    7117,
    1,
    nil,
    8008101
  },
  [7118] = {
    7118,
    1,
    nil,
    8008102
  },
  [7119] = {
    7119,
    1,
    nil,
    8008103
  },
  [7120] = {
    7120,
    1,
    nil,
    8008104
  },
  [7121] = {
    7121,
    1,
    nil,
    8008105
  },
  [7122] = {
    7122,
    1,
    nil,
    8008106
  },
  [7123] = {
    7123,
    1,
    nil,
    8008107
  },
  [7124] = {
    7124,
    1,
    nil,
    8008108
  },
  [7125] = {
    7125,
    1,
    nil,
    8008109
  },
  [7126] = {
    7126,
    1,
    nil,
    8008110
  },
  [7201] = {
    7201,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008001,
      focusType = 2,
      sizeScale = false
    }
  },
  [7202] = {
    7202,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008002,
      focusType = 1,
      sizeScale = true
    }
  },
  [7203] = {
    7203,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008003,
      focusType = 2,
      sizeScale = false
    }
  },
  [7204] = {
    7204,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008004,
      focusType = 2,
      sizeScale = false
    }
  },
  [7205] = {
    7205,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008005,
      focusType = 1,
      sizeScale = true
    }
  },
  [7206] = {
    7206,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008006,
      focusType = 2,
      sizeScale = false
    }
  },
  [7207] = {
    7207,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008007,
      focusType = 2,
      sizeScale = false
    }
  },
  [7208] = {
    7208,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008008,
      focusType = 2,
      sizeScale = false
    }
  },
  [7209] = {
    7209,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008009,
      focusType = 2,
      sizeScale = false
    }
  },
  [7210] = {
    7210,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008010,
      focusType = 2,
      sizeScale = false
    }
  },
  [7211] = {
    7211,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008011,
      focusType = 1,
      sizeScale = true
    }
  },
  [7212] = {
    7212,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008012,
      focusType = 2,
      sizeScale = false
    }
  },
  [7213] = {
    7213,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008013,
      focusType = 2,
      sizeScale = false
    }
  },
  [7214] = {
    7214,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008014,
      focusType = 2,
      sizeScale = false
    }
  },
  [7215] = {
    7215,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008015,
      focusType = 1,
      sizeScale = true
    }
  },
  [7216] = {
    7216,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008016,
      focusType = 1,
      sizeScale = true
    }
  },
  [7217] = {
    7217,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008101,
      focusType = 1,
      sizeScale = true
    }
  },
  [7218] = {
    7218,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008102,
      focusType = 1,
      sizeScale = true
    }
  },
  [7219] = {
    7219,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008103,
      focusType = 1,
      sizeScale = true
    }
  },
  [7220] = {
    7220,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008104,
      focusType = 1,
      sizeScale = true
    }
  },
  [7221] = {
    7221,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008105,
      focusType = 1,
      sizeScale = true
    }
  },
  [7222] = {
    7222,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008106,
      focusType = 1,
      sizeScale = true
    }
  },
  [7223] = {
    7223,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008107,
      focusType = 1,
      sizeScale = true
    }
  },
  [7224] = {
    7224,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008108,
      focusType = 1,
      sizeScale = true
    }
  },
  [7225] = {
    7225,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008109,
      focusType = 1,
      sizeScale = true
    }
  },
  [7226] = {
    7226,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008110,
      focusType = 1,
      sizeScale = true
    }
  },
  [7301] = {
    7301,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {3001040, 1}
    }
  },
  [7302] = {
    7302,
    6,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      {3001037, 300}
    }
  },
  [7401] = {
    7401,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [7402] = {
    7402,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [7403] = {
    7403,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [7404] = {
    7404,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [7405] = {
    7405,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[3]
  },
  [7406] = {
    7406,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [7407] = {
    7407,
    8,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [7408] = {
    7408,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[34]
  },
  [7409] = {
    7409,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[34]
  },
  [7410] = {
    7410,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = true,
      sprite = "exp_S8_map_doubt_blue"
    }
  },
  [7411] = {
    7411,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      show = false,
      sprite = "exp_S8_map_doubt_blue"
    }
  },
  [7412] = {
    7412,
    17,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    1000
  },
  [7501] = {
    7501,
    2,
    nil,
    nil,
    common[24]
  },
  [7502] = {
    7502,
    2,
    nil,
    nil,
    {
      eventanim = "S5_pfb_baoxiang_open",
      playeranim = "interact",
      playerloop = "1"
    }
  },
  [7503] = {
    7503,
    3,
    nil,
    nil,
    nil,
    common[33]
  },
  [7504] = {
    7504,
    2,
    nil,
    nil,
    common[28]
  },
  [7505] = {
    7505,
    2,
    nil,
    nil,
    common[29]
  },
  [7506] = {
    7506,
    2,
    nil,
    nil,
    common[21]
  },
  [7507] = {
    7507,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8008301,
      focusType = 2,
      sizeScale = false
    }
  },
  [7508] = {
    7508,
    2,
    nil,
    nil,
    common[30]
  },
  [7509] = {
    7509,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[42]
  },
  [7510] = {
    7510,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[41]
  },
  [7511] = {
    7511,
    2,
    nil,
    nil,
    common[17]
  },
  [7512] = {
    7512,
    2,
    nil,
    nil,
    common[18]
  },
  [1607] = {1607, 7},
  [1608] = {1608, 7},
  [1609] = {
    1609,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    true
  },
  [1610] = {
    1610,
    10,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    false
  },
  [1611] = {
    1611,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = true,
      sprite = "exp_s2_map_icon014"
    }
  },
  [1612] = {
    1612,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[35]
  },
  [1613] = {
    1613,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = true,
      sprite = "exp_s2_map_icon016"
    }
  },
  [1614] = {
    1614,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = false,
      sprite = "exp_s2_map_icon014"
    }
  },
  [1615] = {
    1615,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[35]
  },
  [1616] = {
    1616,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = false,
      sprite = "exp_s2_map_icon016"
    }
  },
  [1617] = {
    1617,
    11,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {type = 1, show = true}
  },
  [1618] = {1618, 14},
  [1619] = {1619, 17},
  [1620] = {1620, 18},
  [1621] = {
    1621,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1622] = {
    1622,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65010301
  },
  [1623] = {
    1623,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1624] = {
    1624,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1625] = {
    1625,
    4,
    nil,
    nil,
    nil,
    nil,
    50630303
  },
  [1626] = {
    1626,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1627] = {
    1627,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1628] = {
    1628,
    2,
    nil,
    nil,
    {
      playeranim = "tidy",
      eventeffect = "S2_pfb_clean_smoke.prefab"
    }
  },
  [1629] = {
    1629,
    2,
    nil,
    nil,
    common[36]
  },
  [1630] = {
    1630,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1631] = {
    1631,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1632] = {
    1632,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65010401
  },
  [1633] = {
    1633,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1634] = {
    1634,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1635] = {
    1635,
    2,
    nil,
    nil,
    {
      playeranim = "clean",
      eventeffect = "S2_pfb_clean_smoke.prefab",
      playereffect = "S2_pfb_saoba.prefab"
    }
  },
  [1636] = {
    1636,
    2,
    nil,
    nil,
    common[36]
  },
  [1637] = {
    1637,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1638] = {
    1638,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1639] = {
    1639,
    4,
    nil,
    nil,
    nil,
    nil,
    50630303
  },
  [1640] = {
    1640,
    1,
    nil,
    80020001
  },
  [1641] = {
    1641,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1642] = {
    1642,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1643] = {
    1643,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65010414
  },
  [1644] = {
    1644,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1645] = {
    1645,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1646] = {
    1646,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500201,
      focusType = 2,
      sizeScale = true
    }
  },
  [1647] = {
    1647,
    4,
    nil,
    nil,
    nil,
    nil,
    50650101
  },
  [1648] = {
    1648,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1649] = {
    1649,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1650] = {
    1650,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500202,
      focusType = 2,
      sizeScale = true
    }
  },
  [1651] = {
    1651,
    4,
    nil,
    nil,
    nil,
    nil,
    50650102
  },
  [1652] = {
    1652,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1653] = {
    1653,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1654] = {
    1654,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500203,
      focusType = 2,
      sizeScale = true
    }
  },
  [1655] = {
    1655,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65010301
  },
  [1656] = {
    1656,
    1,
    nil,
    80020001
  },
  [1657] = {
    1657,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1658] = {
    1658,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1659] = {
    1659,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500204,
      focusType = 2,
      sizeScale = true
    }
  },
  [1660] = {
    1660,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65010401
  },
  [1661] = {
    1661,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1662] = {
    1662,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1663] = {
    1663,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500205,
      focusType = 2,
      sizeScale = true
    }
  },
  [1664] = {
    1664,
    1,
    nil,
    80020002
  },
  [1665] = {
    1665,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1666] = {
    1666,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1667] = {
    1667,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500206,
      focusType = 2,
      sizeScale = true
    }
  },
  [1668] = {
    1668,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65010414
  },
  [1669] = {
    1669,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1670] = {
    1670,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1671] = {
    1671,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500207,
      focusType = 2,
      sizeScale = true
    }
  },
  [1672] = {
    1672,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65020101
  },
  [1673] = {
    1673,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1674] = {
    1674,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1675] = {
    1675,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500208,
      focusType = 2,
      sizeScale = true
    }
  },
  [1676] = {
    1676,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[39]
  },
  [1677] = {
    1677,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1678] = {
    1678,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1679] = {
    1679,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500209,
      focusType = 2,
      sizeScale = true
    }
  },
  [1680] = {
    1680,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65020201
  },
  [1681] = {
    1681,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1682] = {
    1682,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1683] = {
    1683,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500210,
      focusType = 2,
      sizeScale = true
    }
  },
  [1684] = {
    1684,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[39]
  },
  [1685] = {
    1685,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1686] = {
    1686,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1687] = {
    1687,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500211,
      focusType = 2,
      sizeScale = true
    }
  },
  [1688] = {
    1688,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65020301
  },
  [1689] = {
    1689,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1690] = {
    1690,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1691] = {
    1691,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500212,
      focusType = 2,
      sizeScale = true
    }
  },
  [1692] = {
    1692,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[39]
  },
  [1693] = {
    1693,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1694] = {
    1694,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1695] = {
    1695,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500213,
      focusType = 2,
      sizeScale = true
    }
  },
  [1696] = {
    1696,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65020401
  },
  [1697] = {
    1697,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1698] = {
    1698,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1699] = {
    1699,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500214,
      focusType = 2,
      sizeScale = true
    }
  },
  [1700] = {
    1700,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65020501
  },
  [1701] = {
    1701,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1702] = {
    1702,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1703] = {
    1703,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500215,
      focusType = 2,
      sizeScale = true
    }
  },
  [1704] = {
    1704,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65030101
  },
  [1705] = {
    1705,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1706] = {
    1706,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1707] = {
    1707,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500216,
      focusType = 2,
      sizeScale = true
    }
  },
  [1708] = {
    1708,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65030201
  },
  [1709] = {
    1709,
    1,
    nil,
    80020003
  },
  [1710] = {
    1710,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1711] = {
    1711,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1712] = {
    1712,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500217,
      focusType = 2,
      sizeScale = true
    }
  },
  [1713] = {
    1713,
    18,
    nil,
    80020001,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65030301
  },
  [1714] = {
    1714,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1715] = {
    1715,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1716] = {
    1716,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500218,
      focusType = 2,
      sizeScale = true
    }
  },
  [1717] = {
    1717,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65030401
  },
  [1718] = {
    1718,
    1,
    nil,
    80020004
  },
  [1719] = {
    1719,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1720] = {
    1720,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1721] = {
    1721,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500219,
      focusType = 2,
      sizeScale = true
    }
  },
  [1722] = {
    1722,
    4,
    nil,
    nil,
    nil,
    nil,
    50650305
  },
  [1723] = {
    1723,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1724] = {
    1724,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1725] = {
    1725,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500220,
      focusType = 2,
      sizeScale = true
    }
  },
  [1726] = {
    1726,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65040101
  },
  [1727] = {
    1727,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1728] = {
    1728,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1729] = {
    1729,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500221,
      focusType = 2,
      sizeScale = true
    }
  },
  [1730] = {
    1730,
    4,
    nil,
    nil,
    nil,
    nil,
    50650402
  },
  [1731] = {
    1731,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1732] = {
    1732,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1733] = {
    1733,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500222,
      focusType = 2,
      sizeScale = true
    }
  },
  [1734] = {
    1734,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65040301
  },
  [1735] = {
    1735,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1736] = {
    1736,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1737] = {
    1737,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500223,
      focusType = 2,
      sizeScale = true
    }
  },
  [1738] = {
    1738,
    2,
    nil,
    nil,
    {
      playeranim = "tidy",
      eventeffect = "S2_pfb_clean_smoke"
    }
  },
  [1739] = {
    1739,
    2,
    nil,
    nil,
    common[36]
  },
  [1740] = {
    1740,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1741] = {
    1741,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1742] = {
    1742,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500224,
      focusType = 2,
      sizeScale = true
    }
  },
  [1743] = {
    1743,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65040401
  },
  [1744] = {
    1744,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1745] = {
    1745,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1746] = {
    1746,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500225,
      focusType = 2,
      sizeScale = true
    }
  },
  [1747] = {
    1747,
    2,
    nil,
    nil,
    common[37]
  },
  [1748] = {
    1748,
    2,
    nil,
    nil,
    common[36]
  },
  [1749] = {
    1749,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1750] = {
    1750,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1751] = {
    1751,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500226,
      focusType = 2,
      sizeScale = true
    }
  },
  [1752] = {
    1752,
    4,
    nil,
    nil,
    nil,
    nil,
    50650405
  },
  [1753] = {
    1753,
    1,
    nil,
    80020005
  },
  [1754] = {
    1754,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1755] = {
    1755,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1756] = {
    1756,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500227,
      focusType = 2,
      sizeScale = true
    }
  },
  [1757] = {
    1757,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65040601
  },
  [1758] = {
    1758,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1759] = {
    1759,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1760] = {
    1760,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500228,
      focusType = 2,
      sizeScale = true
    }
  },
  [1761] = {
    1761,
    4,
    nil,
    nil,
    nil,
    nil,
    50650501
  },
  [1762] = {
    1762,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1763] = {
    1763,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1764] = {
    1764,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500229,
      focusType = 2,
      sizeScale = true
    }
  },
  [1765] = {
    1765,
    4,
    nil,
    nil,
    nil,
    nil,
    50650502
  },
  [1766] = {
    1766,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1767] = {
    1767,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1768] = {
    1768,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500230,
      focusType = 2,
      sizeScale = true
    }
  },
  [1769] = {
    1769,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65050301
  },
  [1770] = {
    1770,
    1,
    nil,
    80020006
  },
  [1771] = {
    1771,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65050312
  },
  [1772] = {
    1772,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1773] = {
    1773,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1774] = {
    1774,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500231,
      focusType = 2,
      sizeScale = true
    }
  },
  [1775] = {
    1775,
    4,
    nil,
    nil,
    nil,
    nil,
    50650601
  },
  [1776] = {
    1776,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1777] = {
    1777,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1778] = {
    1778,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500232,
      focusType = 2,
      sizeScale = true
    }
  },
  [1779] = {
    1779,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65060201
  },
  [1780] = {
    1780,
    1,
    nil,
    80020007
  },
  [1781] = {
    1781,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1782] = {
    1782,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1783] = {
    1783,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500233,
      focusType = 2,
      sizeScale = true
    }
  },
  [1784] = {
    1784,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65060301
  },
  [1785] = {
    1785,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1786] = {
    1786,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1787] = {
    1787,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500234,
      focusType = 2,
      sizeScale = true
    }
  },
  [1788] = {
    1788,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65060401
  },
  [1789] = {
    1789,
    1,
    nil,
    80020008
  },
  [1790] = {
    1790,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1791] = {
    1791,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1792] = {
    1792,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500235,
      focusType = 2,
      sizeScale = true
    }
  },
  [1793] = {
    1793,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65070101
  },
  [1794] = {
    1794,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1795] = {
    1795,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1796] = {
    1796,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500236,
      focusType = 2,
      sizeScale = true
    }
  },
  [1797] = {
    1797,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65070201
  },
  [1798] = {
    1798,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1799] = {
    1799,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1800] = {
    1800,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500237,
      focusType = 2,
      sizeScale = true
    }
  },
  [1801] = {
    1801,
    1,
    nil,
    80020009
  },
  [1802] = {
    1802,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1803] = {
    1803,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1804] = {
    1804,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500238,
      focusType = 2,
      sizeScale = true
    }
  },
  [1805] = {
    1805,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65070210
  },
  [1806] = {
    1806,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1807] = {
    1807,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1808] = {
    1808,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500239,
      focusType = 2,
      sizeScale = true
    }
  },
  [1809] = {
    1809,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65070301
  },
  [1810] = {
    1810,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1811] = {
    1811,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1812] = {
    1812,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500240,
      focusType = 2,
      sizeScale = true
    }
  },
  [1813] = {
    1813,
    2,
    nil,
    nil,
    common[37]
  },
  [1814] = {
    1814,
    2,
    nil,
    nil,
    common[36]
  },
  [1815] = {
    1815,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1816] = {
    1816,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1817] = {
    1817,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500241,
      focusType = 2,
      sizeScale = true
    }
  },
  [1818] = {
    1818,
    4,
    nil,
    nil,
    nil,
    nil,
    50650704
  },
  [1819] = {
    1819,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1820] = {
    1820,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1821] = {
    1821,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500242,
      focusType = 2,
      sizeScale = true
    }
  },
  [1822] = {
    1822,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65080101
  },
  [1823] = {
    1823,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1824] = {
    1824,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1825] = {
    1825,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500243,
      focusType = 2,
      sizeScale = true
    }
  },
  [1826] = {
    1826,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65080201
  },
  [1827] = {
    1827,
    1,
    nil,
    80020010
  },
  [1828] = {
    1828,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1829] = {
    1829,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1830] = {
    1830,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500244,
      focusType = 2,
      sizeScale = true
    }
  },
  [1831] = {
    1831,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65080301
  },
  [1832] = {
    1832,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1833] = {
    1833,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1834] = {
    1834,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500245,
      focusType = 2,
      sizeScale = true
    }
  },
  [1835] = {
    1835,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65080401
  },
  [1836] = {
    1836,
    1,
    nil,
    80020011
  },
  [1837] = {
    1837,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1838] = {
    1838,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1839] = {
    1839,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500246,
      focusType = 2,
      sizeScale = true
    }
  },
  [1840] = {
    1840,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65090101
  },
  [1841] = {
    1841,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1842] = {
    1842,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1843] = {
    1843,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500247,
      focusType = 2,
      sizeScale = true
    }
  },
  [1844] = {
    1844,
    4,
    nil,
    nil,
    nil,
    nil,
    50650902
  },
  [1845] = {
    1845,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1846] = {
    1846,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1847] = {
    1847,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500248,
      focusType = 2,
      sizeScale = true
    }
  },
  [1848] = {
    1848,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65090301
  },
  [1849] = {
    1849,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[39]
  },
  [1850] = {
    1850,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65090303
  },
  [1851] = {
    1851,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1852] = {
    1852,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1853] = {
    1853,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500249,
      focusType = 2,
      sizeScale = true
    }
  },
  [1854] = {
    1854,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[39]
  },
  [1855] = {
    1855,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65090401
  },
  [1856] = {
    1856,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1857] = {
    1857,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1858] = {
    1858,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500250,
      focusType = 2,
      sizeScale = true
    }
  },
  [1859] = {
    1859,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[39]
  },
  [1860] = {
    1860,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65090501
  },
  [1861] = {
    1861,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1862] = {
    1862,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1863] = {
    1863,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500251,
      focusType = 2,
      sizeScale = true
    }
  },
  [1864] = {
    1864,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65090601
  },
  [1865] = {
    1865,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1866] = {
    1866,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1867] = {
    1867,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500252,
      focusType = 2,
      sizeScale = true
    }
  },
  [1868] = {
    1868,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65100101
  },
  [1869] = {
    1869,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1870] = {
    1870,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1871] = {
    1871,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500253,
      focusType = 2,
      sizeScale = true
    }
  },
  [1872] = {
    1872,
    4,
    nil,
    nil,
    nil,
    nil,
    50651002
  },
  [1873] = {
    1873,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1874] = {
    1874,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1875] = {
    1875,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      value = 8500254,
      focusType = 2,
      sizeScale = true
    }
  },
  [1876] = {
    1876,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65100301
  },
  [1877] = {
    1877,
    1,
    nil,
    80020012
  },
  [1878] = {
    1878,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1879] = {
    1879,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1880] = {
    1880,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500255,
      focusType = 2,
      sizeScale = true
    }
  },
  [1881] = {
    1881,
    4,
    nil,
    nil,
    nil,
    nil,
    50651101
  },
  [1882] = {
    1882,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1883] = {
    1883,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1884] = {
    1884,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500256,
      focusType = 2,
      sizeScale = true
    }
  },
  [1885] = {
    1885,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65110201
  },
  [1886] = {
    1886,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1887] = {
    1887,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1888] = {
    1888,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      value = 8500257,
      focusType = 2,
      sizeScale = true
    }
  },
  [1889] = {
    1889,
    1,
    nil,
    80020013
  },
  [1890] = {
    1890,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1891] = {
    1891,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1892] = {
    1892,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      value = 8500258,
      focusType = 2,
      sizeScale = true
    }
  },
  [1893] = {
    1893,
    1,
    nil,
    80020014
  },
  [1894] = {
    1894,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1895] = {
    1895,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1896] = {
    1896,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500259,
      focusType = 2,
      sizeScale = true
    }
  },
  [1897] = {
    1897,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65120101
  },
  [1898] = {
    1898,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1899] = {
    1899,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1900] = {
    1900,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500260,
      focusType = 2,
      sizeScale = true
    }
  },
  [1901] = {
    1901,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65120201
  },
  [1902] = {
    1902,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1903] = {
    1903,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1904] = {
    1904,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500261,
      focusType = 2,
      sizeScale = true
    }
  },
  [1905] = {
    1905,
    1,
    nil,
    80020015
  },
  [1906] = {
    1906,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1907] = {
    1907,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1908] = {
    1908,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500262,
      focusType = 2,
      sizeScale = true
    }
  },
  [1909] = {
    1909,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65120401
  },
  [1910] = {
    1910,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1911] = {
    1911,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1912] = {
    1912,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500263,
      focusType = 2,
      sizeScale = true
    }
  },
  [1913] = {
    1913,
    1,
    nil,
    80020016
  },
  [1914] = {
    1914,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1915] = {
    1915,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1916] = {
    1916,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500264,
      focusType = 2,
      sizeScale = true
    }
  },
  [1917] = {
    1917,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65130101
  },
  [1918] = {
    1918,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1919] = {
    1919,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1920] = {
    1920,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500265,
      focusType = 2,
      sizeScale = true
    }
  },
  [1921] = {
    1921,
    12,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[39]
  },
  [1922] = {
    1922,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65130201
  },
  [1923] = {
    1923,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1924] = {
    1924,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1925] = {
    1925,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500266,
      focusType = 2,
      sizeScale = true
    }
  },
  [1926] = {
    1926,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65130301
  },
  [1927] = {
    1927,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1928] = {
    1928,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1929] = {
    1929,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500267,
      focusType = 2,
      sizeScale = true
    }
  },
  [1930] = {
    1930,
    2,
    nil,
    nil,
    common[37]
  },
  [1931] = {
    1931,
    2,
    nil,
    nil,
    common[36]
  },
  [1932] = {
    1932,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1933] = {
    1933,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65130310
  },
  [1934] = {
    1934,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1935] = {
    1935,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500268,
      focusType = 2,
      sizeScale = true
    }
  },
  [1936] = {
    1936,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65130401
  },
  [1937] = {
    1937,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1938] = {
    1938,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1939] = {
    1939,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500269,
      focusType = 2,
      sizeScale = true
    }
  },
  [1940] = {
    1940,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65140101
  },
  [1941] = {
    1941,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1942] = {
    1942,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1943] = {
    1943,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500270,
      focusType = 2,
      sizeScale = true
    }
  },
  [1944] = {
    1944,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65140201
  },
  [1945] = {
    1945,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1946] = {
    1946,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1947] = {
    1947,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      value = 8500271,
      focusType = 2,
      sizeScale = true
    }
  },
  [1948] = {
    1948,
    1,
    nil,
    80020017
  },
  [1949] = {
    1949,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65140301
  },
  [1950] = {
    1950,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1951] = {
    1951,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1952] = {
    1952,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      value = 8500272,
      focusType = 2,
      sizeScale = true
    }
  },
  [1953] = {
    1953,
    1,
    nil,
    80020018
  },
  [1954] = {
    1954,
    4,
    nil,
    nil,
    nil,
    nil,
    50651404
  },
  [1955] = {
    1955,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1956] = {
    1956,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1957] = {
    1957,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500273,
      focusType = 2,
      sizeScale = true
    }
  },
  [1958] = {
    1958,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65150101
  },
  [1959] = {
    1959,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1960] = {
    1960,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1961] = {
    1961,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500274,
      focusType = 2,
      sizeScale = true
    }
  },
  [1962] = {
    1962,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65150201
  },
  [1963] = {
    1963,
    2,
    nil,
    nil,
    common[37]
  },
  [1964] = {
    1964,
    2,
    nil,
    nil,
    common[36]
  },
  [1965] = {
    1965,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1966] = {
    1966,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65150204
  },
  [1967] = {
    1967,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1968] = {
    1968,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500275,
      focusType = 2,
      sizeScale = true
    }
  },
  [1969] = {
    1969,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65150301
  },
  [1970] = {
    1970,
    2,
    nil,
    nil,
    common[37]
  },
  [1971] = {
    1971,
    2,
    nil,
    nil,
    common[36]
  },
  [1972] = {
    1972,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1973] = {
    1973,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65150304
  },
  [1974] = {
    1974,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1975] = {
    1975,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500276,
      focusType = 2,
      sizeScale = true
    }
  },
  [1976] = {
    1976,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1977] = {
    1977,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65150401
  },
  [1978] = {
    1978,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1979] = {
    1979,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500277,
      focusType = 2,
      sizeScale = true
    }
  },
  [1980] = {
    1980,
    4,
    nil,
    nil,
    nil,
    nil,
    50651505
  },
  [1981] = {
    1981,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1982] = {
    1982,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1983] = {
    1983,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500278,
      focusType = 2,
      sizeScale = true
    }
  },
  [1984] = {
    1984,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65160101
  },
  [1985] = {
    1985,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [1986] = {
    1986,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [1987] = {
    1987,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500279,
      focusType = 2,
      sizeScale = true
    }
  },
  [1988] = {
    1988,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65160201
  },
  [1989] = {
    1989,
    1,
    nil,
    80020019
  },
  [1990] = {
    1990,
    4,
    nil,
    nil,
    nil,
    nil,
    50651602
  },
  [1991] = {
    1991,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300101] = {
    300101,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300102] = {
    300102,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500316,
      focusType = 2,
      sizeScale = true
    }
  },
  [300103] = {
    300103,
    4,
    nil,
    nil,
    nil,
    nil,
    50670101
  },
  [300104] = {
    300104,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300105] = {
    300105,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300106] = {
    300106,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500317,
      focusType = 2,
      sizeScale = true
    }
  },
  [300107] = {
    300107,
    18,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    65170101
  },
  [300108] = {
    300108,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300109] = {
    300109,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300110] = {
    300110,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500318,
      focusType = 2,
      sizeScale = true
    }
  },
  [300111] = {
    300111,
    4,
    nil,
    nil,
    nil,
    nil,
    50670501
  },
  [300112] = {
    300112,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300113] = {
    300113,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300114] = {
    300114,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500319,
      focusType = 2,
      sizeScale = true
    }
  },
  [300115] = {
    300115,
    1,
    nil,
    80030001
  },
  [300116] = {
    300116,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300117] = {
    300117,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300118] = {
    300118,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500320,
      focusType = 2,
      sizeScale = true
    }
  },
  [300119] = {
    300119,
    1,
    nil,
    80030002
  },
  [300120] = {
    300120,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300121] = {
    300121,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300122] = {
    300122,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500321,
      focusType = 2,
      sizeScale = true
    }
  },
  [300123] = {
    300123,
    1,
    nil,
    80030003
  },
  [300124] = {
    300124,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300125] = {
    300125,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300126] = {
    300126,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500322,
      focusType = 2,
      sizeScale = true
    }
  },
  [300127] = {
    300127,
    1,
    nil,
    80030004
  },
  [300128] = {
    300128,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300129] = {
    300129,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300130] = {
    300130,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500323,
      focusType = 2,
      sizeScale = true
    }
  },
  [300131] = {
    300131,
    1,
    nil,
    80030005
  },
  [300132] = {
    300132,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300133] = {
    300133,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300134] = {
    300134,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500324,
      focusType = 2,
      sizeScale = true
    }
  },
  [300135] = {
    300135,
    1,
    nil,
    80030006
  },
  [300136] = {
    300136,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300137] = {
    300137,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300138] = {
    300138,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500325,
      focusType = 2,
      sizeScale = true
    }
  },
  [300139] = {
    300139,
    1,
    nil,
    80030007
  },
  [300140] = {
    300140,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300141] = {
    300141,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300142] = {
    300142,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500326,
      focusType = 2,
      sizeScale = true
    }
  },
  [300143] = {
    300143,
    1,
    nil,
    80030008
  },
  [300144] = {
    300144,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300145] = {
    300145,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300146] = {
    300146,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500327,
      focusType = 2,
      sizeScale = true
    }
  },
  [300147] = {
    300147,
    1,
    nil,
    80030009
  },
  [300148] = {
    300148,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300149] = {
    300149,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300150] = {
    300150,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500328,
      focusType = 2,
      sizeScale = true
    }
  },
  [300151] = {
    300151,
    1,
    nil,
    80030010
  },
  [300152] = {
    300152,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300153] = {
    300153,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300154] = {
    300154,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500329,
      focusType = 2,
      sizeScale = true
    }
  },
  [300155] = {
    300155,
    1,
    nil,
    80030011
  },
  [300156] = {
    300156,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300157] = {
    300157,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300158] = {
    300158,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500330,
      focusType = 2,
      sizeScale = true
    }
  },
  [300159] = {
    300159,
    1,
    nil,
    80030012
  },
  [300160] = {
    300160,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300161] = {
    300161,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300162] = {
    300162,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500331,
      focusType = 2,
      sizeScale = true
    }
  },
  [300163] = {
    300163,
    1,
    nil,
    80030013
  },
  [300164] = {
    300164,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300165] = {
    300165,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300166] = {
    300166,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500332,
      focusType = 2,
      sizeScale = true
    }
  },
  [300167] = {
    300167,
    1,
    nil,
    80030014
  },
  [300168] = {
    300168,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300169] = {
    300169,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300170] = {
    300170,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500333,
      focusType = 2,
      sizeScale = true
    }
  },
  [300171] = {
    300171,
    1,
    nil,
    80030015
  },
  [300172] = {
    300172,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300173] = {
    300173,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300174] = {
    300174,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500334,
      focusType = 2,
      sizeScale = true
    }
  },
  [300175] = {
    300175,
    4,
    nil,
    nil,
    nil,
    nil,
    50670601
  },
  [300176] = {
    300176,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300177] = {
    300177,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[7]
  },
  [300178] = {
    300178,
    9,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 2,
      value = 8500335,
      focusType = 2,
      sizeScale = true
    }
  },
  [300179] = {
    300179,
    4,
    nil,
    nil,
    nil,
    nil,
    50670801
  },
  [300180] = {
    300180,
    7,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[8]
  },
  [300181] = {
    300181,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[25]
  },
  [300182] = {
    300182,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = true,
      sprite = "exp_s3_map_icon20",
      functionType = 2
    }
  },
  [300183] = {
    300183,
    19,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    {
      type = 1,
      show = true,
      sprite = "exp_s3_map_icon21"
    }
  }
}
return config, "ID", key
