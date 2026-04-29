local key = {
  ID = 1,
  SpecialRewards = 2,
  Rewards = 3,
  Last = 4
}
local config = {
  {
    1,
    {
      {3000001, 1}
    },
    {
      {3000002, 10},
      {3000003, 10},
      {3000004, 12}
    },
    false
  },
  {
    2,
    {
      {3000010, 1},
      {3000011, 2}
    },
    {
      {3000012, 10},
      {3000013, 100}
    },
    true
  }
}
return config, "ID", key
