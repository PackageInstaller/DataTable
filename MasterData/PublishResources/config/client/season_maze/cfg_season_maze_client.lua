local key = {
  ID = 1,
  SeasonID = 2,
  PlayerRes = 3,
  PlayerScale = 4,
  PlayerSpeed = 5,
  PlayerIdleTime = 6,
  FollowerOffset = 7,
  FollowParam = 8,
  Bgm = 9,
  StartStory = 10
}
local common = {
  "S1000011.prefab",
  {
    -0.3,
    0,
    -0.5
  }
}
local config = {
  [9001] = {
    9001,
    8001,
    common[1],
    1,
    3,
    30000,
    common[2],
    3,
    510,
    50770101
  },
  [9002] = {
    9002,
    8002,
    common[1],
    1,
    4,
    30000,
    common[2],
    3,
    603,
    50770101
  },
  [9003] = {
    9003,
    8003,
    common[1],
    1,
    4,
    30000,
    common[2],
    3,
    604,
    50770101
  }
}
return config, "ID", key
