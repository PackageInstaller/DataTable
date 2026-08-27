local __rt_1 = {1002}
local __rt_2 = {600}
local __rt_3 = {5008}
local __rt_4 = {1}
local __rt_5 = {500}
local __rt_6 = {
  1002,
  1002,
  1002,
  1002
}
local __rt_7 = {
  150,
  150,
  150,
  150
}
local __rt_8 = {1300}
local __rt_9 = {5009}
local __rt_10 = {1000}
local __rt_11 = {
  325,
  325,
  325,
  325
}
local __rt_12 = {2800}
local __rt_13 = {5010}
local __rt_14 = {2000}
local __rt_15 = {
  700,
  700,
  700,
  700
}
local activity_saveMoney_save = {
  {
    {
      cumulative_rewards_nums = __rt_2,
      level_name = 441555,
      save_consume_nums = __rt_5
    },
    {
      immediate_rewards_ids = __rt_9,
      level_picture = "level_2",
      save_level = 2,
      show_rewards_nums = __rt_11
    },
    {
      cumulative_rewards_nums = __rt_12,
      immediate_rewards_ids = __rt_13,
      level_name = 24722,
      level_picture = "level_3",
      save_consume_nums = __rt_14,
      save_level = 3,
      show_rewards_nums = __rt_15
    }
  },
  {
    {
      cumulative_rewards_nums = __rt_2,
      id = 2,
      level_name = 441555,
      save_consume_nums = __rt_5
    },
    {
      id = 2,
      immediate_rewards_ids = __rt_9,
      level_picture = "level_2",
      save_level = 2,
      show_rewards_nums = __rt_11
    },
    {
      cumulative_rewards_nums = __rt_12,
      id = 2,
      immediate_rewards_ids = __rt_13,
      level_name = 24722,
      level_picture = "level_3",
      save_consume_nums = __rt_14,
      save_level = 3,
      show_rewards_nums = __rt_15
    }
  },
  {
    {
      cumulative_rewards_nums = __rt_2,
      id = 3,
      level_name = 441555,
      save_consume_nums = __rt_5
    },
    {
      id = 3,
      immediate_rewards_ids = __rt_9,
      level_picture = "level_2",
      save_level = 2,
      show_rewards_nums = __rt_11
    },
    {
      cumulative_rewards_nums = __rt_12,
      id = 3,
      immediate_rewards_ids = __rt_13,
      level_name = 24722,
      level_picture = "level_3",
      save_consume_nums = __rt_14,
      save_level = 3,
      show_rewards_nums = __rt_15
    }
  }
}
local __default_values = {
  cumulative_rewards_ids = __rt_1,
  cumulative_rewards_nums = __rt_8,
  id = 1,
  immediate_rewards_ids = __rt_3,
  immediate_rewards_nums = __rt_4,
  level_name = 2463,
  level_picture = "level_1",
  save_consume_ids = __rt_1,
  save_consume_nums = __rt_10,
  save_level = 1,
  show_rewards_ids = __rt_6,
  show_rewards_nums = __rt_7
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_saveMoney_save) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_saveMoney_save, {__index = __rawdata})
return activity_saveMoney_save
