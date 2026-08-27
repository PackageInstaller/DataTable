local activity_general_daily_task = {
  [24001] = {},
  [24002] = {id = 24002, task_time = 1705564800},
  [24003] = {id = 24003, task_time = 1689840000},
  [25001] = {id = 25001, task_time = 1677744000},
  [25003] = {id = 25003, task_time = 1711612800},
  [31001] = {id = 31001, task_time = 1682582400},
  [33001] = {id = 33001, task_time = 1685001600},
  [33002] = {id = 33002, task_time = 1715241900},
  [33003] = {id = 33003, task_time = 1692259200},
  [33004] = {id = 33004, task_time = 1718870700},
  [33005] = {id = 33005, task_time = 1723709100},
  [40001] = {id = 40001, task_time = 1695283200},
  [40002] = {id = 40002, task_time = 1706774400},
  [45001] = {id = 45001, task_time = 1703145600},
  [51001] = {id = 51001, task_time = 1706774460},
  [56001] = {id = 56001, task_time = 1716451500},
  [59001] = {id = 59001, task_time = 1725523500}
}
local __default_values = {
  daily_task_refresh_max = 1,
  id = 24001,
  task_daily_release = 2,
  task_limit = 8,
  task_time = 1673942400
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_general_daily_task) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_general_daily_task, {__index = __rawdata})
return activity_general_daily_task
