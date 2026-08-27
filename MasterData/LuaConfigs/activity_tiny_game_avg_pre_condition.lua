local activity_tiny_game_avg_pre_condition = {
  {
    {},
    {activity_avg_id = 2},
    {activity_avg_id = 3},
    {
      activity_avg_id = 4,
      avg_group = 2,
      describe_condition = 65467,
      task_condition = 8257
    },
    {
      activity_avg_id = 5,
      avg_group = 3,
      describe_condition = 144648,
      task_condition = 8261
    },
    {
      activity_avg_id = 6,
      avg_group = 4,
      describe_condition = 486000,
      task_condition = 8270
    },
    {
      activity_avg_id = 7,
      avg_group = 5,
      describe_condition = 245552,
      task_condition = 8267
    },
    {
      activity_avg_id = 8,
      avg_group = 6,
      describe_condition = 128230,
      task_condition = 8264
    },
    {
      activity_avg_id = 9,
      avg_group = 7,
      describe_condition = 429869
    }
  }
}
local __default_values = {
  activity_avg_id = 1,
  avg_group = 1,
  describe_condition = "",
  id = 1,
  task_condition = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_tiny_game_avg_pre_condition) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  groupDic = {
    {
      {
        1,
        2,
        3
      },
      {4},
      {5},
      {6},
      {7},
      {8},
      {9}
    }
  },
  taskDic = {
    {
      [0] = true,
      [8257] = true,
      [8261] = true,
      [8264] = true,
      [8267] = true,
      [8270] = true
    }
  }
}
setmetatable(activity_tiny_game_avg_pre_condition, {__index = __rawdata})
return activity_tiny_game_avg_pre_condition
