local key = {
  ID = 1,
  ComponentID = 2,
  Odds = 3,
  MinLay = 4,
  MaxLay = 5,
  RelicGroup = 6,
  GoldOdds = 7,
  EXPOdds = 8,
  BeadOdds = 9,
  RelicOdds = 10,
  HardGap = 11,
  GoldItem = 12,
  EXPItem = 13,
  BeadItem = 14
}
local common = {
  {1, 2},
  {3, 4},
  {
    {1, 35},
    {1, 40}
  },
  {
    {2, 35},
    {2, 40}
  },
  {
    {3, 1},
    {3, 1}
  },
  {
    {2, 40},
    {2, 45}
  },
  {
    {2, 45},
    {2, 50}
  },
  {
    {1, 45},
    {1, 50}
  }
}
local config = {
  [10001] = {
    10001,
    900308001,
    100,
    1,
    0,
    1,
    30,
    40,
    0,
    30,
    common[1],
    common[3],
    common[4],
    common[5]
  },
  [10002] = {
    10002,
    900308001,
    100,
    1,
    0,
    1,
    30,
    50,
    0,
    20,
    common[1],
    common[3],
    common[6],
    common[5]
  },
  [10003] = {
    10003,
    900308001,
    100,
    1,
    0,
    1,
    50,
    30,
    0,
    20,
    common[1],
    {
      {1, 40},
      {1, 45}
    },
    common[4],
    common[5]
  },
  [10004] = {
    10004,
    900308001,
    100,
    1,
    0,
    1,
    25,
    25,
    25,
    25,
    common[2],
    common[3],
    common[4],
    common[5]
  },
  [10005] = {
    10005,
    900308001,
    100,
    1,
    2,
    1,
    20,
    20,
    50,
    10,
    common[2],
    common[3],
    common[4],
    common[5]
  },
  [10006] = {
    10006,
    900308001,
    100,
    1,
    2,
    1,
    20,
    50,
    20,
    10,
    common[2],
    common[3],
    common[6],
    common[5]
  },
  [10007] = {
    10007,
    900308001,
    100,
    3,
    0,
    1,
    50,
    20,
    20,
    10,
    common[2],
    {
      {1, 50},
      {1, 55}
    },
    common[7],
    common[5]
  },
  [10008] = {
    10008,
    900308001,
    100,
    3,
    0,
    1,
    20,
    20,
    50,
    10,
    common[2],
    common[8],
    common[7],
    common[5]
  },
  [10009] = {
    10009,
    900308001,
    100,
    3,
    0,
    1,
    20,
    50,
    20,
    10,
    common[2],
    common[8],
    {
      {2, 50},
      {2, 55}
    },
    common[5]
  }
}
return config, "ID", key
