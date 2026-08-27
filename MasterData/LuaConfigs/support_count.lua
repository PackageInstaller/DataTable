local __rt_1 = {3}
local __rt_2 = {1110}
local __rt_3 = {}
local support_count = {
  {},
  {id = 2},
  {id = 3}
}
local __default_values = {
  id = 1,
  pre_condition = __rt_1,
  pre_para1 = __rt_2,
  pre_para2 = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(support_count) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(support_count, {__index = __rawdata})
return support_count
