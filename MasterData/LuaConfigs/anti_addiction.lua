local anti_addiction = {
  [8] = {age = 8},
  [16] = {},
  [18] = {age = 18}
}
local __default_values = {
  age = 16,
  begin_time = "8:00:00",
  daily_total_time = 5400,
  end_time = "22:00:00",
  holiday_total_time = 10800
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(anti_addiction) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  id_sort_list = {
    8,
    16,
    18
  }
}
setmetatable(anti_addiction, {__index = __rawdata})
return anti_addiction
