local key = {
  ID = 1,
  Name = 2,
  size = 3,
  BeAttackedDuration = 4,
  DeadDuration = 5,
  AttackDuration = 6
}
local common = {
  "200001.prefab",
  {100100}
}
local config = {
  [200001] = {
    200001,
    common[1],
    common[2],
    500,
    400
  },
  [200002] = {
    200002,
    "200002.prefab",
    common[2],
    400,
    210
  },
  [200003] = {
    200003,
    common[1],
    common[2],
    400,
    400
  },
  [200004] = {
    200004,
    "200004.prefab",
    common[2]
  },
  [200005] = {
    200005,
    "200005.prefab",
    common[2],
    200,
    260,
    500
  },
  [200006] = {
    200006,
    "200006.prefab",
    common[2],
    500,
    800
  },
  [200007] = {
    200007,
    "200007.prefab",
    common[2],
    500,
    400
  }
}
return config, "ID", key
