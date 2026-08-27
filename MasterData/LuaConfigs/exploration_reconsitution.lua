local __rt_1 = {
  0,
  20,
  30
}
local __rt_2 = {
  1,
  5,
  -1
}
local exploration_reconsitution = {
  {},
  {type = 2},
  {type = 3}
}
local __default_values = {
  costId = 1,
  costNums = __rt_1,
  times = __rt_2,
  type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(exploration_reconsitution) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_reconsitution, {__index = __rawdata})
return exploration_reconsitution
