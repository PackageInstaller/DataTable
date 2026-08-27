local __rt_1 = {
  1002,
  2502,
  5001
}
local __rt_2 = {
  50,
  2,
  3
}
local __rt_3 = {3003}
local __rt_4 = {
  1002,
  2504,
  5002
}
local __rt_5 = {3004}
local __rt_6 = {5}
local __rt_7 = {10}
local __rt_8 = {15}
local __rt_9 = {
  1002,
  2514,
  5002
}
local __rt_10 = {3006}
local __rt_11 = {
  1002,
  2512,
  5002
}
local __rt_12 = {3007}
local __rt_13 = {
  1002,
  2517,
  5002
}
local __rt_14 = {3008}
local sector_achievement = {
  {
    {
      achivRewardIds = __rt_1,
      conditionNums = {4}
    },
    {
      achivRewardIds = __rt_1,
      achivRewardNums = {
        50,
        3,
        10
      },
      conditionNums = {8},
      id = 2
    },
    {
      achivRewardIds = {
        1002,
        2502,
        5002
      },
      achivRewardNums = {
        100,
        5,
        3
      },
      conditionNums = {12},
      id = 3
    }
  },
  {
    {conditionIds = __rt_5, conditionNums = __rt_6},
    {
      achivRewardNums = {
        50,
        3,
        6
      },
      conditionIds = __rt_5,
      id = 2
    },
    {
      achivRewardNums = {
        100,
        5,
        8
      },
      conditionIds = __rt_5,
      conditionNums = __rt_8,
      id = 3
    }
  },
  {
    {
      achivRewardIds = __rt_9,
      achivRewardNums = {
        50,
        2,
        6
      },
      conditionIds = __rt_10,
      conditionNums = __rt_6
    },
    {
      achivRewardIds = __rt_9,
      achivRewardNums = {
        50,
        3,
        9
      },
      conditionIds = __rt_10,
      id = 2
    },
    {
      achivRewardIds = __rt_9,
      achivRewardNums = {
        100,
        5,
        11
      },
      conditionIds = __rt_10,
      conditionNums = __rt_8,
      id = 3
    }
  },
  {
    {
      achivRewardIds = __rt_11,
      achivRewardNums = {
        50,
        2,
        11
      },
      conditionIds = __rt_12,
      conditionNums = __rt_6
    },
    {
      achivRewardIds = __rt_11,
      achivRewardNums = {
        50,
        3,
        18
      },
      conditionIds = __rt_12,
      id = 2
    },
    {
      achivRewardIds = __rt_11,
      achivRewardNums = {
        100,
        5,
        21
      },
      conditionIds = __rt_12,
      conditionNums = __rt_8,
      id = 3
    }
  },
  {
    {
      achivRewardIds = __rt_13,
      achivRewardNums = {
        50,
        2,
        17
      },
      conditionIds = __rt_14,
      conditionNums = __rt_6
    },
    {
      achivRewardIds = __rt_13,
      achivRewardNums = {
        50,
        3,
        25
      },
      conditionIds = __rt_14,
      id = 2
    },
    {
      achivRewardIds = __rt_13,
      achivRewardNums = {
        100,
        5,
        30
      },
      conditionIds = __rt_14,
      conditionNums = __rt_8,
      id = 3
    }
  }
}
local __default_values = {
  achivRewardIds = __rt_4,
  achivRewardNums = __rt_2,
  conditionIds = __rt_3,
  conditionNums = __rt_7,
  id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_achievement) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_achievement, {__index = __rawdata})
return sector_achievement
