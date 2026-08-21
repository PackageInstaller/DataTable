local key = {
  ID = 1,
  TemplateID = 2,
  BehaviorType = 3,
  Duration = 4,
  CD = 5,
  Prob = 6,
  Range = 7,
  Angle = 8,
  ExclusiveBuildings = 9,
  InteractLoopTime = 10,
  NextBehaviorType = 11,
  RotateTime = 12,
  InterruptInteraction = 13
}
local common = {
  {
    {
      {
        [1] = 5241006,
        [2] = "Bip001"
      },
      {
        [1] = 5275001,
        [2] = "Bip001"
      }
    }
  }
}
local config = {
  {
    1,
    0,
    1,
    15,
    2,
    40
  },
  {
    2,
    0,
    2,
    10,
    10,
    30,
    20
  },
  {
    3,
    0,
    3,
    999999999,
    2,
    nil,
    nil,
    nil,
    nil,
    nil,
    1
  },
  {
    4,
    0,
    4,
    999999999,
    2
  },
  {
    5,
    0,
    5,
    10,
    3,
    80,
    10,
    nil,
    nil,
    7000,
    2,
    nil,
    common[1]
  },
  {
    6,
    0,
    6,
    99999999,
    0
  },
  {
    7,
    0,
    7,
    20,
    5,
    70,
    5,
    70,
    nil,
    nil,
    nil,
    3
  },
  {
    8,
    0,
    8,
    99999999,
    0
  },
  {
    9,
    0,
    9,
    99999999,
    0,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    common[1]
  },
  {
    10,
    0,
    10,
    99999999,
    0
  },
  {
    11,
    0,
    11,
    99999999,
    0
  },
  {
    12,
    0,
    12,
    99999999,
    0
  },
  {
    13,
    0,
    13,
    99999999,
    0
  },
  {
    14,
    0,
    14,
    99999999,
    60,
    80,
    20,
    nil,
    nil,
    60000,
    2
  },
  {
    15,
    0,
    15,
    99999999,
    0
  },
  {
    16,
    0,
    16,
    99999999,
    0
  }
}
return config, "ID", key
