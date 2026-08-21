local key = {
  ID = 1,
  NeedCount = 2,
  Reward = 3,
  QuestStage = 4
}
local common = {
  {
    {3000100, 5}
  }
}
local config = {
  {
    1,
    10,
    {
      {1400481, 1}
    },
    1
  },
  {
    2,
    25,
    {
      {3000100, 1}
    },
    1
  },
  {
    3,
    40,
    {
      {3000100, 2}
    },
    1
  },
  {
    4,
    55,
    {
      {3000100, 3}
    },
    1
  },
  {
    5,
    70,
    common[1],
    1
  },
  {
    6,
    9,
    {
      {3420116, 1}
    },
    2
  },
  {
    7,
    18,
    common[1],
    2
  },
  {
    8,
    27,
    common[1],
    2
  }
}
return config, "ID", key
