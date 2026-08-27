local pay_gift_pop_des = {
  {des = 328717},
  {group_pop = 2, name = 384661},
  {group_pop = 3, name = 13808},
  {group_pop = 4, name = 420649},
  {group_pop = 5},
  {group_pop = 6, name = 420649}
}
local __default_values = {
  des = "",
  group_pop = 1,
  name = 35932
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(pay_gift_pop_des) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  popGroup = {
    {220, 221},
    {
      236,
      237,
      238
    },
    {
      246,
      245,
      244
    },
    {
      249,
      250,
      251
    },
    {252, 254},
    {
      337,
      345,
      358,
      347
    }
  }
}
setmetatable(pay_gift_pop_des, {__index = __rawdata})
return pay_gift_pop_des
