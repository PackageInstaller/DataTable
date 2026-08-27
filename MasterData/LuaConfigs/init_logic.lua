local __rt_1 = {1007}
local __rt_2 = {}
local __rt_3 = {3}
local __rt_4 = {22}
local __rt_5 = {16}
local __rt_6 = {1}
local init_logic = {
  {
    logic = {25},
    para2 = {334}
  },
  {
    id = 2,
    logic = __rt_3,
    para2 = {150}
  },
  [4] = {
    id = 4,
    logic = __rt_3,
    para1 = {3005},
    para2 = {40}
  },
  [6] = {
    id = 6,
    logic = __rt_3,
    para1 = {1201},
    para2 = {500}
  },
  [7] = {
    id = 7,
    logic = __rt_4,
    para1 = __rt_5,
    para2 = {1000}
  },
  [8] = {
    id = 8,
    logic = __rt_4,
    para1 = {8},
    para2 = {20}
  },
  [10] = {id = 10, para1 = __rt_6},
  [11] = {
    id = 11,
    para1 = {2}
  },
  [12] = {id = 12, para1 = __rt_3},
  [13] = {
    id = 13,
    para1 = {4}
  },
  [14] = {
    id = 14,
    para1 = {5}
  },
  [15] = {
    id = 15,
    para1 = {6}
  }
}
local __default_values = {
  id = 1,
  logic = __rt_5,
  para1 = __rt_1,
  para2 = __rt_6,
  para3 = __rt_2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(init_logic) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(init_logic, {__index = __rawdata})
return init_logic
