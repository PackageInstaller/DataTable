local key = {
  ID = 1,
  BuildType = 2,
  AddFirefly = 3,
  CleanNeedTime = 4,
  Floor = 5,
  CleanCost = 6,
  Mat = 7,
  Size = 8,
  UnlockTime = 9
}
local common = {
  {2},
  {10.34, 4.5},
  {0.83, 0.4}
}
local config = {
  {
    1,
    {1},
    0,
    0,
    2,
    nil,
    2,
    {2, 1.4}
  },
  {
    2,
    {201},
    0,
    0,
    1
  },
  {
    3,
    {202},
    0,
    0,
    1
  },
  {
    4,
    {204},
    0,
    0,
    2
  },
  {
    5,
    {203},
    0,
    0,
    2
  },
  {
    6,
    common[1],
    0,
    0,
    3,
    nil,
    4,
    common[2]
  },
  {
    7,
    common[1],
    0,
    0,
    3,
    nil,
    4,
    common[2]
  },
  {
    8,
    {5},
    0,
    0,
    3,
    nil,
    2,
    common[3]
  },
  {
    9,
    {4},
    0,
    0,
    3,
    nil,
    2,
    common[3]
  },
  {
    10,
    {6},
    0,
    0,
    3,
    nil,
    2,
    common[3]
  },
  {
    11,
    common[1],
    0,
    0,
    4,
    nil,
    4,
    common[2]
  },
  {
    12,
    common[1],
    0,
    0,
    4,
    nil,
    4,
    common[2]
  },
  {
    13,
    {3},
    0,
    0,
    4,
    nil,
    2,
    common[3]
  },
  {
    14,
    {9},
    0,
    0,
    4,
    nil,
    2,
    common[3]
  },
  {
    15,
    {10},
    0,
    0,
    4,
    nil,
    2,
    common[3]
  },
  {
    16,
    {11},
    0,
    0,
    3,
    nil,
    2,
    common[3],
    "2021-11-30 04:00:00"
  }
}
return config, "ID", key
