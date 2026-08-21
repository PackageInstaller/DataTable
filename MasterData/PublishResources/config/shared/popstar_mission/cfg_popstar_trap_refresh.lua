local key = {
  ID = 1,
  TotalWeight = 2,
  TrapIDList = 3,
  WeightList = 4,
  CountLimitList = 5
}
local common = {
  {611001, 81001},
  {1, 1},
  {12, 18},
  {611001, 81002}
}
local config = {
  [5319001] = {
    5319001,
    200,
    {611001},
    {10},
    {1}
  },
  [5319002] = {
    5319002,
    200,
    common[1],
    {10, 10},
    common[2]
  },
  [5319003] = {
    5319003,
    200,
    common[1],
    common[3],
    common[2]
  },
  [5319004] = {
    5319004,
    200,
    common[4],
    common[3],
    common[2]
  },
  [5319005] = {
    5319005,
    200,
    common[4],
    {20, 30},
    common[2]
  },
  [5319006] = {
    5319006,
    100,
    common[1],
    {8, 8},
    common[2]
  }
}
return config, "ID", key
