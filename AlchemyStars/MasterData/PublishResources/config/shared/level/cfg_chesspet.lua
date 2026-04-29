local key = {
  ID = 1,
  Attack = 2,
  Defense = 3,
  Health = 4,
  Evade = 5,
  ElementType = 6,
  ClassID = 7,
  BuffList = 8,
  EliteID = 9
}
local common = {
  {1},
  {0},
  {3},
  {2},
  {5}
}
local config = {
  [2000191] = {
    2000191,
    common[1],
    common[2],
    common[3],
    0,
    1,
    2000191
  },
  [2000201] = {
    2000201,
    common[1],
    common[2],
    {10},
    0,
    3,
    2000201
  },
  [2000311] = {
    2000311,
    common[4],
    common[2],
    common[5],
    0,
    2,
    2000311
  },
  [2000321] = {
    2000321,
    common[1],
    common[2],
    common[4],
    0,
    1,
    2000321
  },
  [2000501] = {
    2000501,
    common[1],
    common[2],
    common[4],
    0,
    1,
    2000501
  },
  [2000901] = {
    2000901,
    common[1],
    common[2],
    common[4],
    0,
    1,
    2000901
  },
  [2000312] = {
    2000312,
    common[4],
    common[2],
    common[5],
    0,
    1,
    2000312
  },
  [2000101] = {
    2000101,
    common[1],
    common[2],
    common[4],
    0,
    1,
    2000101
  },
  [2002301] = {
    2002301,
    common[1],
    common[2],
    common[3],
    0,
    1,
    2002301
  },
  [2000351] = {
    2000351,
    common[1],
    common[2],
    common[4],
    0,
    1,
    2000351
  }
}
return config, "ID", key
