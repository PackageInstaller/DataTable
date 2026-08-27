local __rt_1 = {}
local __rt_2 = {
  1002,
  3001,
  3005
}
local __rt_3 = {
  100,
  1,
  2
}
local __rt_4 = {
  150,
  1,
  2
}
local __rt_5 = {
  37,
  37,
  36,
  37,
  35
}
local __rt_6 = {
  1012,
  1101,
  0,
  1107,
  0
}
local __rt_7 = {
  300,
  30,
  0,
  30,
  0
}
local __rt_8 = {
  200,
  1,
  2
}
local __rt_9 = {
  37,
  37,
  36,
  37,
  35,
  37,
  37
}
local __rt_10 = {
  1012,
  1101,
  0,
  1107,
  0,
  1113,
  1012
}
local __rt_11 = {
  300,
  30,
  0,
  30,
  0,
  30,
  300
}
local dorm_comfort = {
  {
    logic = __rt_1,
    para1 = __rt_1,
    para2 = __rt_1,
    para3 = __rt_1,
    rewardIds = __rt_1,
    rewardNums = __rt_1
  },
  {
    comfort = 100,
    level = 2,
    logic = {37},
    para1 = {1200},
    para2 = {1012},
    para3 = {300}
  },
  {
    comfort = 200,
    level = 3,
    logic = {37, 37},
    para1 = {1200, 1200},
    para2 = {1012, 1101},
    para3 = {300, 30}
  },
  {
    comfort = 500,
    level = 4,
    logic = {
      37,
      37,
      36
    },
    para1 = {
      1200,
      1200,
      1
    },
    para2 = {
      1012,
      1101,
      0
    },
    para3 = {
      300,
      30,
      0
    }
  },
  {
    comfort = 1000,
    level = 5,
    logic = {
      37,
      37,
      36,
      37
    },
    para1 = {
      1200,
      1200,
      1,
      1800
    },
    para2 = {
      1012,
      1101,
      0,
      1107
    },
    para3 = {
      300,
      30,
      0,
      30
    },
    rewardNums = __rt_4
  },
  {
    comfort = 2000,
    level = 6,
    logic = __rt_5,
    para2 = __rt_6,
    para3 = __rt_7,
    rewardNums = __rt_4
  },
  {
    comfort = 3000,
    level = 7,
    logic = __rt_5,
    para1 = {
      1200,
      1200,
      2,
      1800,
      1
    },
    para2 = __rt_6,
    para3 = __rt_7,
    rewardNums = __rt_4
  },
  {
    comfort = 5000,
    level = 8,
    logic = {
      37,
      37,
      36,
      37,
      35,
      37
    },
    para1 = {
      1200,
      1200,
      2,
      1800,
      1,
      1200
    },
    para2 = {
      1012,
      1101,
      0,
      1107,
      0,
      1113
    },
    para3 = {
      300,
      30,
      0,
      30,
      0,
      30
    },
    rewardNums = __rt_8
  },
  {
    comfort = 7500,
    level = 9,
    para1 = {
      1200,
      1200,
      2,
      1800,
      1,
      1200,
      1800
    },
    rewardNums = __rt_8
  },
  {
    comfort = 10000,
    level = 10,
    para1 = {
      1200,
      1200,
      3,
      1800,
      1,
      1200,
      1800
    },
    rewardNums = {
      500,
      1,
      2
    }
  }
}
local __default_values = {
  comfort = 0,
  level = 1,
  logic = __rt_9,
  para1 = {
    1200,
    1200,
    1,
    1800,
    1
  },
  para2 = __rt_10,
  para3 = __rt_11,
  rewardIds = __rt_2,
  rewardNums = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dorm_comfort) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  level_sort = {
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10
  },
  max_level = 10
}
setmetatable(dorm_comfort, {__index = __rawdata})
return dorm_comfort
