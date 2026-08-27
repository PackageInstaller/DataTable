local daily_bonus_time = {
  {end_time = 1669841999},
  {id = 2, start_time = 1669842000}
}
local __default_values = {
  end_time = -1,
  id = 1,
  start_time = -1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(daily_bonus_time) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  startTimeIdList = {1, 2}
}
setmetatable(daily_bonus_time, {__index = __rawdata})
return daily_bonus_time
