local __rt_1 = {3}
local __rt_2 = {3106}
local __rt_3 = {}
local factory = {
  {model = 1, name = 263351},
  {
    id = 2,
    intro = 24504,
    name = 323753
  },
  {
    id = 3,
    intro = 385725,
    model = 3,
    name = 64102,
    pre_para1 = {3112}
  },
  {
    id = 4,
    intro = 222658,
    name = 384123,
    pre_para1 = {4114}
  },
  {
    id = 5,
    intro = 59591,
    name = 266552,
    pre_para1 = {4115}
  },
  {
    id = 6,
    intro = 420812,
    is_open = 0,
    model = 0,
    order_limit = 0,
    pre_condition = __rt_3,
    pre_para1 = __rt_3
  },
  {
    id = 7,
    intro = 257745,
    is_open = 0,
    model = 0,
    order_limit = 0,
    pre_condition = __rt_3,
    pre_para1 = __rt_3
  }
}
local __default_values = {
  id = 1,
  intro = 187571,
  is_open = 1,
  model = 2,
  name = 499501,
  order_limit = 1,
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
for k, v in pairs(factory) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(factory, {__index = __rawdata})
return factory
