local __rt_1 = {2}
local __rt_2 = {}
local __rt_3 = {1}
local __rt_4 = {
  59,
  59,
  59
}
local __rt_5 = {
  1,
  1,
  1
}
local month_card_privilege = {
  {
    logic = {26},
    para1 = {1400},
    para2 = __rt_1,
    para3 = __rt_2
  },
  {
    id = 2,
    logic = {58},
    para1 = __rt_3,
    para2 = {5},
    para3 = __rt_2
  },
  {
    id = 3,
    para2 = {
      1,
      4,
      7
    }
  },
  {
    id = 4,
    para1 = {
      19,
      19,
      19
    },
    para2 = {
      2,
      5,
      7
    }
  },
  {
    id = 5,
    para1 = {
      11,
      11,
      11
    },
    para2 = {
      3,
      6,
      7
    }
  },
  {
    id = 6,
    logic = {
      59,
      59,
      59,
      59,
      59
    },
    para1 = {
      14,
      15,
      16,
      17,
      18
    },
    para2 = {
      1,
      2,
      3,
      4,
      5
    },
    para3 = {
      1,
      1,
      1,
      1,
      1
    }
  },
  {
    id = 7,
    logic = {60},
    para1 = {50},
    para2 = __rt_2,
    para3 = __rt_2
  },
  {
    id = 8,
    logic = {61},
    para1 = {301},
    para2 = __rt_3,
    para3 = __rt_1
  },
  {
    id = 9,
    logic = {59},
    para1 = {500},
    para3 = __rt_1
  }
}
local __default_values = {
  id = 1,
  logic = __rt_4,
  para1 = {
    10,
    10,
    10
  },
  para2 = {0},
  para3 = __rt_5
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(month_card_privilege) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(month_card_privilege, {__index = __rawdata})
return month_card_privilege
