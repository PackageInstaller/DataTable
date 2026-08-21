local key = {
  ID = 1,
  ComponentID = 2,
  Condition = 3,
  Rewards = 4,
  Desc = 5
}
local common = {
  "3500,108111008,3",
  "str_n27_poststation_target_1",
  "str_n27_poststation_target_2",
  "3501,108111008,70",
  "str_n27_poststation_target_3",
  "str_n27_poststation_target_4",
  "str_n27_poststation_target_5",
  "3501,108111008,80",
  "str_n27_poststation_target_6",
  "3500,108111008,4",
  "str_n27_poststation_target_7",
  "str_n27_poststation_target_8",
  "str_n27_poststation_target_9",
  "str_n27_poststation_target_10",
  "str_n27_poststation_target_11",
  "str_n27_poststation_target_12",
  "3500,108111008,5",
  "str_n27_poststation_target_13",
  "str_n27_poststation_target_14",
  "str_n27_poststation_target_15",
  "str_n27_poststation_target_16",
  "str_n27_poststation_target_17",
  "str_n27_poststation_target_18",
  "3500,114411008,3",
  "3501,114411008,70",
  "3501,114411008,80",
  "3500,114411008,4",
  "3500,114411008,5",
  {
    {3000003, 30},
    {3100013, 10}
  },
  {
    {3000003, 30},
    {3000002, 10000}
  },
  {
    {3000003, 30},
    {3500001, 100}
  },
  {
    {3000003, 30},
    {3400043, 1}
  }
}
local config = {
  {
    1,
    108111008,
    common[1],
    common[29],
    common[2]
  },
  {
    2,
    108111008,
    "3501,108111008,40",
    common[30],
    common[3]
  },
  {
    3,
    108111008,
    common[4],
    common[31],
    common[5]
  },
  {
    4,
    108111008,
    common[1],
    common[29],
    common[6]
  },
  {
    5,
    108111008,
    "3501,108111008,50",
    common[30],
    common[7]
  },
  {
    6,
    108111008,
    common[8],
    common[32],
    common[9]
  },
  {
    7,
    108111008,
    common[10],
    common[29],
    common[11]
  },
  {
    8,
    108111008,
    common[4],
    common[30],
    common[12]
  },
  {
    9,
    108111008,
    "3503,108111008,1,4,3",
    common[31],
    common[13]
  },
  {
    10,
    108111008,
    common[10],
    common[29],
    common[14]
  },
  {
    11,
    108111008,
    "3503,108111008,1,3,3",
    common[30],
    common[15]
  },
  {
    12,
    108111008,
    common[8],
    common[32],
    common[16]
  },
  {
    13,
    108111008,
    common[17],
    common[29],
    common[18]
  },
  {
    14,
    108111008,
    "3503,108111008,1,4,4",
    common[30],
    common[19]
  },
  {
    15,
    108111008,
    "3501,108111008,85",
    common[31],
    common[20]
  },
  {
    16,
    108111008,
    common[17],
    common[29],
    common[21]
  },
  {
    17,
    108111008,
    "3503,108111008,0,15,3",
    common[30],
    common[22]
  },
  {
    18,
    108111008,
    "3501,108111008,90",
    common[32],
    common[23]
  },
  [101] = {
    101,
    114411008,
    common[24],
    common[29],
    common[2]
  },
  [102] = {
    102,
    114411008,
    "3501,114411008,40",
    common[30],
    common[3]
  },
  [103] = {
    103,
    114411008,
    common[25],
    common[31],
    common[5]
  },
  [104] = {
    104,
    114411008,
    common[24],
    common[29],
    common[6]
  },
  [105] = {
    105,
    114411008,
    "3501,114411008,50",
    common[30],
    common[7]
  },
  [106] = {
    106,
    114411008,
    common[26],
    common[32],
    common[9]
  },
  [107] = {
    107,
    114411008,
    common[27],
    common[29],
    common[11]
  },
  [108] = {
    108,
    114411008,
    common[25],
    common[30],
    common[12]
  },
  [109] = {
    109,
    114411008,
    "3503,114411008,1,4,3",
    common[31],
    common[13]
  },
  [110] = {
    110,
    114411008,
    common[27],
    common[29],
    common[14]
  },
  [111] = {
    111,
    114411008,
    "3503,114411008,1,3,3",
    common[30],
    common[15]
  },
  [112] = {
    112,
    114411008,
    common[26],
    common[32],
    common[16]
  },
  [113] = {
    113,
    114411008,
    common[28],
    common[29],
    common[18]
  },
  [114] = {
    114,
    114411008,
    "3503,114411008,1,4,4",
    common[30],
    common[19]
  },
  [115] = {
    115,
    114411008,
    "3501,114411008,85",
    common[31],
    common[20]
  },
  [116] = {
    116,
    114411008,
    common[28],
    common[29],
    common[21]
  },
  [117] = {
    117,
    114411008,
    "3503,114411008,0,115,3",
    common[30],
    common[22]
  },
  [118] = {
    118,
    114411008,
    "3501,114411008,90",
    common[32],
    common[23]
  }
}
return config, "ID", key
