local key = {
  ID = 1,
  BaseLightCount = 2,
  MainCollectNeedNum = 3,
  LightRecover = 4,
  UnlockRoomType = 5,
  UnlockRelicCount = 6,
  CoinIncrease = 7,
  InitAsset = 8
}
local config = {
  [7103001] = {
    7103001,
    0,
    8,
    3600,
    {1},
    0,
    1.1
  },
  [7103002] = {
    7103002,
    0,
    8,
    3600,
    {2},
    0,
    1.2
  },
  [7103003] = {
    7103003,
    0,
    8,
    3600,
    {3},
    0,
    1.3
  },
  [7103004] = {
    7103004,
    0,
    8,
    3600,
    {4},
    0,
    1.4
  },
  [7103005] = {
    7103005,
    0,
    8,
    3600,
    {5},
    0,
    1.5
  }
}
return config, "ID", key
