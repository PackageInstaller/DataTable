local __rt_1 = {
  [6036] = 10
}
local __rt_2 = {6036}
local __rt_3 = {
  6037,
  6038,
  6039,
  6040,
  6041,
  6042,
  6043,
  6044,
  6045,
  6046,
  6047
}
local __rt_4 = {
  [6048] = 5
}
local __rt_5 = {6048}
local __rt_6 = {
  6049,
  6050,
  6051,
  6052,
  6053,
  6054
}
local task_activity = {
  {},
  {
    id = 2,
    refresh_limit = __rt_4,
    refresh_task = __rt_5,
    task = __rt_6
  },
  {id = 3},
  {
    id = 4,
    refresh_limit = __rt_4,
    refresh_task = __rt_5,
    task = __rt_6
  }
}
local __default_values = {
  id = 1,
  refresh_limit = __rt_1,
  refresh_task = __rt_2,
  refresh_time = 1,
  task = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(task_activity) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(task_activity, {__index = __rawdata})
return task_activity
