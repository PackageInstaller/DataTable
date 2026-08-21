local key = {
  Layer = 1,
  BornPos = 2,
  BossPos = 3,
  SceneLength = 4,
  SceneWidth = 5
}
local common = {
  {-40, -3},
  {-10, -3},
  {-5, -3}
}
local config = {
  {
    1,
    common[1],
    common[2],
    25,
    12
  },
  {
    2,
    common[1],
    common[2],
    25,
    12
  },
  {
    3,
    common[1],
    common[3],
    30,
    12
  },
  {
    4,
    common[1],
    common[3],
    30,
    12
  },
  {
    5,
    common[1],
    {0, -3},
    35,
    12
  }
}
return config, "Layer", key
