local key = {
  ID = 1,
  ComponentID = 2,
  EntiesID = 3,
  Rewards = 4,
  KillNum = 5
}
local common = {
  {
    {3400043, 1}
  }
}
local config = {
  {
    1,
    109902901,
    1,
    {
      {3000003, 30}
    },
    200
  },
  {
    2,
    109902901,
    2,
    common[1],
    300
  },
  {
    3,
    109902901,
    3,
    common[1],
    400
  }
}
return config, "ID", key
