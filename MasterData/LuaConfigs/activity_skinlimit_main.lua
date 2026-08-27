local activity_skinlimit_main = {
  {},
  {
    activity_id = 43002,
    end_time = "2024-01-18 15:59:59",
    id = 2,
    start_time = "2024-01-04 16:00:00"
  },
  {
    activity_id = 43003,
    end_time = "2024-02-29 15:59:59",
    id = 3,
    start_time = "2024-02-01 16:00:00"
  }
}
local __default_values = {
  activity_id = 43001,
  activity_rule = 9706,
  end_time = "2023-11-23 15:59:59",
  id = 1,
  name = 40594,
  start_time = "2023-10-26 16:00:00",
  task_type = 778
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_skinlimit_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_skinlimit_main, {__index = __rawdata})
return activity_skinlimit_main
