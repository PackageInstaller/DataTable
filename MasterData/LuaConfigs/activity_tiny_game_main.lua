local activity_tiny_game_main = {
  {}
}
local __default_values = {
  activity_avg = {
    1800101,
    1800102,
    1800103,
    1800104,
    1800105,
    1800106,
    1800107,
    1800108,
    1800109
  },
  activity_avg_finish = 1800109,
  activity_avg_start1 = 1800101,
  activity_avg_start2 = 1800103,
  activity_daily_task = {
    8253,
    8254,
    8255,
    8256
  },
  activity_point = 1045,
  avg_guide = 40001,
  avg_pre_condition = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9
  },
  daily_task_max = 2,
  daily_task_refresh_max = 1,
  id = 1,
  point_reward = 1,
  task_list = {
    8257,
    8258,
    8259,
    8260,
    8261,
    8262,
    8263,
    8264,
    8265,
    8266,
    8267,
    8268,
    8269,
    8270,
    8271,
    8272
  },
  tiny_game_type = {
    1,
    3,
    2,
    4
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_tiny_game_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_tiny_game_main, {__index = __rawdata})
return activity_tiny_game_main
