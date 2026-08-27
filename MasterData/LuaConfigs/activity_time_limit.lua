local activity_time_limit = {
  {}
}
local __default_values = {
  chapterPosList = {
    {100, 0},
    {6487, 0}
  },
  down_time = 1635973199,
  easy_stage = 90011,
  exchange_itemid = 1021,
  first_avg = 12,
  frequency_day = 2,
  hard_stage = 6,
  id = 1,
  jump_arg = {9001},
  jump_id = 109,
  rechallenge_stage = 90012,
  refresh_times = {},
  task_list = {
    6001,
    6002,
    6003,
    6004,
    6005,
    6011,
    6012,
    6013,
    6014,
    6015,
    6006,
    6007,
    6008,
    6009,
    6010
  },
  weekly_time = 1636923600
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_time_limit) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  exchangeMapping = {
    [1021] = 1
  },
  sectorMapping = {
    [6] = 1,
    [90011] = 1,
    [90012] = 1
  }
}
setmetatable(activity_time_limit, {__index = __rawdata})
return activity_time_limit
