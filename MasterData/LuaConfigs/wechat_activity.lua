local __rt_1 = {1}
local __rt_2 = {8222}
local wechat_activity = {
  {
    awardCounts = {
      1,
      1,
      20000
    },
    awardIds = {
      3001,
      5009,
      1003
    },
    res_name = "willow"
  },
  {id = 2},
  {
    id = 3,
    res_name = "persicaria_sp_avg"
  }
}
local __default_values = {
  awardCounts = __rt_1,
  awardIds = __rt_2,
  id = 1,
  res_name = "persicaria_avg"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(wechat_activity) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(wechat_activity, {__index = __rawdata})
return wechat_activity
