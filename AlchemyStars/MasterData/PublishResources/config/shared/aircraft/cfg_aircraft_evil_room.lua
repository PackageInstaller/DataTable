local key = {
  ID = 1,
  RefreshEvilCount = 2,
  SearchEvilStar = 3,
  SearchEvilCount = 4,
  SearchCount = 5,
  CellCount = 6,
  QuickCaptureEvilStar = 7,
  TraceEvilCount = 8
}
local common = {
  {10, 12}
}
local config = {
  [7107001] = {
    7107001,
    {10, 20},
    {1, 3},
    common[1],
    1,
    2,
    2,
    2
  },
  [7107002] = {
    7107002,
    {15, 30},
    {1, 4},
    common[1],
    2,
    3,
    2,
    2
  },
  [7107003] = {
    7107003,
    {20, 35},
    {1, 5},
    common[1],
    3,
    4,
    3,
    2
  },
  [7107004] = {
    7107004,
    {25, 40},
    {2, 5},
    common[1],
    4,
    5,
    3,
    2
  },
  [7107005] = {
    7107005,
    {30, 45},
    {3, 5},
    common[1],
    5,
    6,
    3,
    2
  }
}
return config, "ID", key
