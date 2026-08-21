local key = {
  ID = 1,
  VigPoint = 2,
  Reward = 3,
  ExtraReward = 4
}
local common = {
  {5}
}
local config = {
  {
    1,
    20,
    {
      {3100013, 5},
      {3000002, 5000}
    },
    common[1]
  },
  {
    2,
    40,
    {
      {3400037, 5},
      {3000001, 10}
    },
    common[1]
  },
  {
    3,
    60,
    {
      {3100014, 2},
      {3000003, 20}
    },
    common[1]
  },
  {
    4,
    80,
    {
      {3400038, 2},
      {3000002, 5000}
    },
    common[1]
  },
  {
    5,
    100,
    {
      {3220000, 10},
      {3000003, 30}
    },
    common[1]
  }
}
return config, "ID", key
