local __rt_1 = {
  [1002] = 50
}
local activity_divergent_main = {
  {}
}
local __default_values = {
  chapter_id = 2,
  daily_task_type = 2,
  extra_price = __rt_1,
  heroid_group = {1071},
  id = 1,
  refresh_limit = 5,
  refresh_price = __rt_1,
  rule_des = 9601,
  rule_title = 9600,
  sector_id = 590021127,
  skin_id = 307105,
  special_task_type = 1,
  task_complete_num = 3,
  task_extra_num = 0,
  task_item = 1236,
  task_own_num = 3,
  task_time = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_divergent_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_divergent_main, {__index = __rawdata})
return activity_divergent_main
