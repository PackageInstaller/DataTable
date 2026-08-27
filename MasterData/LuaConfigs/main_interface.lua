local __rt_1 = {1}
local __rt_2 = {}
local main_interface = {
  {},
  {id = 2},
  {id = 3},
  {id = 4},
  {id = 5},
  {id = 6},
  {id = 7},
  {id = 8},
  {id = 9},
  {id = 10}
}
local __default_values = {
  id = 1,
  pre_condition = __rt_1,
  pre_para1 = __rt_1,
  pre_para2 = __rt_2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(main_interface) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(main_interface, {__index = __rawdata})
return main_interface
