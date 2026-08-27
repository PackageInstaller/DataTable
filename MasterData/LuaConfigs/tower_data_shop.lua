local __rt_1 = {
  1000,
  0,
  0
}
local __rt_2 = {
  600,
  400,
  0
}
local __rt_3 = {
  300,
  600,
  100
}
local __rt_4 = {
  300,
  400,
  300
}
local tower_data_shop = {
  [400] = {
    {
      exp = 0,
      function_drop_ratio = __rt_1,
      function_limit_bonus = 0,
      level = 1,
      system_id = 400
    },
    {
      exp = 60,
      function_drop_ratio = __rt_2,
      function_limit_bonus = 3,
      level = 2,
      system_id = 400
    },
    {
      exp = 120,
      function_drop_ratio = __rt_3,
      function_limit_bonus = 3,
      level = 3,
      system_id = 400
    },
    {
      exp = 180,
      function_drop_ratio = __rt_4,
      function_limit_bonus = 3,
      level = 4,
      system_id = 400
    }
  },
  [2201] = {
    {
      exp = 0,
      function_drop_ratio = __rt_1,
      function_limit_bonus = 0,
      level = 1,
      system_id = 2201
    },
    {
      exp = 60,
      function_drop_ratio = __rt_2,
      function_limit_bonus = 3,
      level = 2,
      system_id = 2201
    },
    {
      exp = 120,
      function_drop_ratio = __rt_3,
      function_limit_bonus = 3,
      level = 3,
      system_id = 2201
    },
    {
      exp = 180,
      function_drop_ratio = __rt_4,
      function_limit_bonus = 3,
      level = 4,
      system_id = 2201
    }
  }
}
local __default_values = {maxLevel = 4}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(tower_data_shop) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(tower_data_shop, {__index = __rawdata})
return tower_data_shop
