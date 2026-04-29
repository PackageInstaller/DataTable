local key = {
  ID = 1,
  DayMaxEventNum = 2,
  OnceRandNum = 3,
  CurEventNum = 4,
  RefreshTime = 5,
  ItemId = 6
}
local common = {
  {32400}
}
local config = {
  [100701601] = {
    100701601,
    2,
    2,
    2,
    common[1],
    3000214
  },
  [102101604] = {
    102101604,
    2,
    2,
    2,
    {72000},
    3000238
  },
  [1900601602] = {
    1900601602,
    0,
    0,
    0,
    common[1],
    3000214
  }
}
return config, "ID", key
