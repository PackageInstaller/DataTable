local __rt_1 = {
  20,
  35,
  50
}
local __rt_2 = {
  20,
  50,
  80
}
local __rt_3 = {
  10,
  25,
  40
}
local __rt_4 = {}
local __rt_5 = {
  5,
  10,
  15
}
local __rt_6 = {
  5,
  5,
  5
}
local __rt_7 = {300, 60}
local exploration_type = {
  [400] = {id = 400},
  [1800] = {store_pool = 6},
  [1802] = {id = 1802},
  [1900] = {id = 1900},
  [2200] = {id = 2200},
  [2201] = {
    chip_buff_price = __rt_5,
    chip_level_price = __rt_5,
    chip_return_price = __rt_6,
    id = 2201,
    interest = {100, 25},
    interest_open = true,
    store_pool = 7
  },
  [2202] = {
    chip_buff_price = __rt_5,
    chip_level_price = __rt_5,
    chip_return_price = __rt_6,
    id = 2202,
    interest = __rt_7,
    interest_open = true,
    store_pool = 7
  },
  [2203] = {
    chip_level_price = {
      10,
      25,
      60
    },
    chip_return_price = __rt_6,
    id = 2203,
    interest = __rt_7,
    interest_open = true,
    store_pool = 9
  },
  [2204] = {
    chip_level_price = {
      10,
      30,
      60
    },
    chip_return_price = __rt_6,
    id = 2204,
    step_add_function_price = {
      [3] = 2,
      [5] = 5,
      [7] = 7,
      [9] = 10,
      [11] = 15,
      [13] = 20,
      [15] = 25,
      [17] = 30,
      [19] = 32,
      [21] = 35,
      [23] = 40
    },
    store_pool = 9
  }
}
local __default_values = {
  act_func_price = "1=20|2=35|3=50",
  chip_act_level_price = __rt_1,
  chip_buff_price = __rt_2,
  chip_level_price = __rt_2,
  chip_return_price = __rt_3,
  id = 1800,
  interest = __rt_4,
  interest_open = false,
  refresh_add_func_price = __rt_4,
  refresh_command_skill_tree = true,
  step_add_function_price = __rt_4,
  store_pool = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(exploration_type) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_type, {__index = __rawdata})
return exploration_type
