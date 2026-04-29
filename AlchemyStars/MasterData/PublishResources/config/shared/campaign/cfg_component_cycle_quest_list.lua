local key = {
  ID = 1,
  ComponentID = 2,
  Condition = 3,
  Reward = 4,
  Desc = 5,
  BubbleText = 6
}
local common = {
  "str_n17_daily_plan_get_token"
}
local config = {
  {
    1,
    105910401,
    89,
    30,
    "str_n17_daily_plan_home_desc_3",
    common[1]
  },
  {
    2,
    105910401,
    90,
    5,
    "str_n17_daily_plan_home_desc_1",
    common[1]
  },
  {
    3,
    105910401,
    91,
    15,
    "str_n17_daily_plan_home_desc_2",
    common[1]
  },
  {
    4,
    105910401,
    92,
    30,
    "str_n17_daily_plan_home_desc_4",
    common[1]
  },
  {
    5,
    105910401,
    93,
    50,
    "str_n17_daily_plan_home_desc_5",
    common[1]
  }
}
return config, "ID", key
