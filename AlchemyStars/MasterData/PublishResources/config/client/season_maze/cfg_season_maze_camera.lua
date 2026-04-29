local key = {
  ID = 1,
  CameraSizeMax = 2,
  CameraSizeMin = 3,
  DefaultSize = 4,
  CameraSizeChangeSpeed_PC = 5,
  CameraSizeChangeSpeed_Mobile = 6,
  PlayerTipHideRange = 7
}
local common = {
  {120, 220}
}
local config = {
  [9001] = {
    9001,
    5,
    2,
    3.5,
    2,
    0.036,
    common[1]
  },
  [9002] = {
    9002,
    5,
    2,
    3.5,
    2,
    0.036,
    common[1]
  },
  [9003] = {
    9003,
    5,
    2,
    3.5,
    2,
    0.036,
    common[1]
  }
}
return config, "ID", key
