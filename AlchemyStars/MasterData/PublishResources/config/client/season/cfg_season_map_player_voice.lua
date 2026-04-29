local key = {
  ID = 1,
  box1Audio = 2,
  box2Audio = 3,
  stepInterval = 4
}
local common = {
  {1012, 0.8}
}
local config = {
  [8001] = {
    8001,
    common[1],
    common[1],
    0.5
  },
  [8002] = {
    8002,
    common[1],
    common[1],
    0.5
  },
  [8003] = {
    8003,
    common[1],
    common[1],
    0.5
  },
  [8004] = {
    8004,
    common[1],
    common[1],
    0.5
  },
  [8005] = {
    8005,
    common[1],
    common[1],
    0.5
  },
  [8006] = {
    8006,
    common[1],
    common[1],
    0.5
  },
  [8007] = {
    8007,
    common[1],
    common[1],
    0.5
  },
  [8008] = {
    8008,
    common[1],
    common[1],
    0.5
  }
}
return config, "ID", key
