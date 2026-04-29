local key = {
  ID = 1,
  RankType = 2,
  Icon = 3,
  Limit = 4,
  BrostcastCycle = 5,
  ClientCacheTime = 6,
  Name = 7
}
local config = {
  {
    1,
    1,
    "21020101_icon",
    100,
    10,
    5,
    "玩家等级榜"
  },
  {
    2,
    2,
    "21020102_icon",
    100,
    10,
    5,
    "玩家消费榜"
  },
  {
    3,
    3,
    "21020103_icon",
    100,
    10,
    5,
    "玩家活跃榜"
  }
}
return config, "ID", key
