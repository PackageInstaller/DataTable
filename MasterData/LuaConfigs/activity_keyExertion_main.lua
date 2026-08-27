local __rt_1 = {}
local __rt_2 = {
  1002,
  6003,
  1502,
  6002,
  5007,
  8205,
  1503,
  1501,
  1003
}
local __rt_3 = {
  150,
  1,
  5,
  10,
  5,
  5,
  200,
  1500,
  15000
}
local __rt_4 = {
  1002,
  6003,
  1502,
  1503
}
local __rt_5 = {
  150,
  1,
  5,
  200
}
local __rt_6 = {
  -183.8,
  40.5,
  0
}
local __rt_7 = {
  0,
  0,
  -26.1
}
local activity_keyExertion_main = {
  {
    activity_des = 475596,
    bag_des = 229497,
    button_des = 157543,
    color = "#ffe63f",
    enter_picture = "LuckyBagEntrance1",
    icon_picture = "LuckyBagLogo1",
    main_picture = "LuckyBagBG1",
    rewards_des = 56793,
    task = {9379},
    task_rule_id = 7601,
    task_rule_title = 7600
  },
  {
    activity_des = 430804,
    bag_des = 418161,
    button_des = 324051,
    color = "#53a2b0",
    enter_picture = "LuckyBagEntrance2",
    general_id = 23002,
    icon_picture = "LuckyBagLogo2",
    id = 2,
    main_picture = "LuckyBagBG2",
    rewards_bag = 2003,
    rewards_des = 318353,
    task_rule_id = 7603,
    task_rule_title = 7602,
    token = 1230
  },
  {
    activity_des = 141304,
    bag_des = 511530,
    button_des = 383522,
    color = "#e4c697",
    enter_picture = "LuckyBagEntrance3",
    general_id = 23003,
    icon_picture = "LuckyBagLogo3",
    id = 3,
    main_picture = "LuckyBagBG3",
    rewards_bag = 2005,
    rewards_des = 21618,
    task = {9380},
    task_rule_id = 7605,
    task_rule_title = 7604,
    token = 1239
  },
  {
    activity_des = 383401,
    bag_des = 169048,
    color = "#3b8ed7",
    enter_picture = "LuckyBagEntrance4",
    general_id = 23004,
    icon_picture = "LuckyBagLogo4",
    id = 4,
    main_picture = "LuckyBagBG4",
    rewards_bag = 2006,
    rewards_des = 31568,
    task = {9381},
    task_rule_id = 7607,
    task_rule_title = 7606,
    token = 1241
  },
  {
    button_des = 440211,
    button_pos = __rt_6,
    button_rotation = __rt_7,
    button_size = 36,
    general_id = 23005,
    id = 5,
    rewards_bag = 2007,
    task = {9382},
    token = 1246
  },
  {
    activity_des = 312907,
    bag_des = 242148,
    button_des = 200111,
    button_pos = {
      -206,
      52.6,
      0
    },
    button_rotation = __rt_7,
    button_size = 36,
    color = "#c7be02",
    enter_picture = "LuckyBagEntrance6",
    general_id = 23006,
    icon_picture = "LuckyBagLogo6",
    id = 6,
    main_picture = "LuckyBagBG6",
    rewards_bag = 2008,
    rewards_des = 263612,
    task = {9383},
    task_rule_id = 7611,
    task_rule_title = 7610,
    token = 1266
  },
  {
    activity_des = 422511,
    bag_des = 232005,
    button_pos = {
      -178,
      37,
      0
    },
    button_rotation = {
      0,
      0,
      -15
    },
    button_size = 36,
    color = "#f89a36",
    enter_picture = "LuckyBagEntrance7",
    general_id = 23007,
    icon_picture = "LuckyBagLogo7",
    id = 7,
    main_picture = "LuckyBagBG7",
    rewards_bag = 2009,
    rewards_des = 102021,
    task = {9384},
    task_rule_id = 7613,
    task_rule_title = 7612,
    token = 1285
  },
  {
    button_des = 440211,
    button_pos = __rt_6,
    button_rotation = __rt_7,
    button_size = 36,
    general_id = 23008,
    id = 8,
    rewards_bag = 2010,
    task = {9385},
    token = 1287
  }
}
local __default_values = {
  activity_des = 352933,
  all_rewards = "1002=150|6003=1|1502=5|6002=10|5007=5|8205=5|1503=200|1501=1500|1003=15000",
  bag_des = 502284,
  big_reward = 1002,
  button_des = 417831,
  button_pos = __rt_1,
  button_rotation = __rt_1,
  button_size = 0,
  color = "#b9bcff",
  enter_picture = "LuckyBagEntrance5",
  general_id = 23001,
  icon_picture = "LuckyBagLogo5",
  id = 1,
  main_des = 343919,
  main_picture = "LuckyBagBG5",
  main_rewards = "1002=150|6003=1|1502=5|1503=200",
  preprecess_all_rewardIds = __rt_2,
  preprecess_all_rewardNums = __rt_3,
  preprecess_main_rewardIds = __rt_4,
  preprecess_main_rewardNums = __rt_5,
  progress_bar = 100,
  reward_times = 7,
  rewards_bag = 2001,
  rewards_des = 341540,
  task = {7100},
  task_rule_id = 7609,
  task_rule_title = 7608,
  token = 1210
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_keyExertion_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_keyExertion_main, {__index = __rawdata})
return activity_keyExertion_main
