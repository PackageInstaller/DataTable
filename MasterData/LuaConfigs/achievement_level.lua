local __rt_1 = {}
local __rt_2 = {3}
local __rt_3 = {1007}
local __rt_4 = {10}
local __rt_5 = {
  1002,
  3001,
  3005
}
local __rt_6 = {
  100,
  1,
  1
}
local __rt_7 = {
  100,
  5,
  1
}
local __rt_8 = {
  500,
  1,
  1
}
local __rt_9 = {20}
local __rt_10 = {
  1002,
  3001,
  1003
}
local __rt_11 = {
  100,
  1,
  50000
}
local __rt_12 = {30}
local __rt_13 = {
  1002,
  3001,
  1502
}
local __rt_14 = {40}
local __rt_15 = {50}
local __rt_16 = {
  100,
  1,
  2
}
local __rt_17 = {
  1002,
  3001,
  6003
}
local __rt_18 = {60}
local __rt_19 = {70}
local __rt_20 = {80}
local __rt_21 = {
  100,
  1,
  3
}
local __rt_22 = {90}
local achievement_level = {
  {
    exp = 200,
    icon = "icon_qingtong1",
    logic = __rt_1,
    para1 = __rt_1,
    para2 = __rt_1,
    rewardIds = __rt_1,
    rewardNums = __rt_1
  },
  {
    icon = "icon_qingtong2",
    id = 2
  },
  {
    icon = "icon_qingtong3",
    id = 3,
    rewardNums = __rt_7
  },
  {
    icon = "icon_qingtong4",
    id = 4,
    rewardNums = __rt_8
  },
  {
    icon = "icon_qingtong5",
    id = 5,
    rewardIds = {
      1002,
      3001,
      400002
    }
  },
  {
    icon = "icon_hj1",
    id = 6,
    para2 = __rt_9,
    rewardNums = __rt_8
  },
  {
    icon = "icon_hj2",
    id = 7,
    para2 = __rt_9,
    rewardIds = __rt_10,
    rewardNums = __rt_11
  },
  {
    icon = "icon_hj3",
    id = 8,
    para2 = __rt_9
  },
  {
    icon = "icon_hj4",
    id = 9,
    para2 = __rt_12
  },
  {
    icon = "icon_hj5",
    id = 10,
    para2 = __rt_12,
    rewardIds = {
      1002,
      3001,
      400003
    },
    rewardNums = __rt_7
  },
  {
    icon = "icon_bj1",
    id = 11,
    para2 = __rt_12,
    rewardIds = __rt_13,
    rewardNums = {
      100,
      1,
      5
    }
  },
  {
    icon = "icon_bj2",
    id = 12,
    para2 = __rt_14
  },
  {
    icon = "icon_bj3",
    id = 13,
    para2 = __rt_14,
    rewardNums = __rt_8
  },
  {
    icon = "icon_bj4",
    id = 14,
    para2 = __rt_14,
    rewardIds = __rt_10,
    rewardNums = __rt_11
  },
  {
    icon = "icon_bj5",
    id = 15,
    para2 = __rt_15
  },
  {
    icon = "icon_zs1",
    id = 16,
    para2 = __rt_15,
    rewardNums = __rt_16
  },
  {
    icon = "icon_zs2",
    id = 17,
    para2 = __rt_15,
    rewardIds = __rt_17
  },
  {
    icon = "icon_zs3",
    id = 18,
    para2 = __rt_18,
    rewardNums = __rt_16
  },
  {
    icon = "icon_zs4",
    id = 19,
    para2 = __rt_18,
    rewardIds = __rt_13,
    rewardNums = {
      100,
      1,
      10
    }
  },
  {
    id = 20,
    para2 = __rt_18,
    rewardIds = {
      1002,
      3001,
      400004
    }
  },
  {
    id = 21,
    para2 = __rt_19,
    rewardNums = __rt_16
  },
  {
    id = 22,
    para2 = __rt_19,
    rewardNums = {
      500,
      1,
      2
    }
  },
  {
    exp = 750,
    id = 23,
    para2 = __rt_19,
    rewardNums = __rt_16
  },
  {
    exp = 750,
    id = 24,
    para2 = __rt_20,
    rewardNums = __rt_21
  },
  {
    exp = 750,
    id = 25,
    para2 = __rt_20,
    rewardIds = __rt_17
  },
  {
    exp = 750,
    id = 26,
    para2 = __rt_20,
    rewardNums = {
      100,
      5,
      3
    }
  },
  {
    exp = 750,
    id = 27,
    para2 = __rt_22,
    rewardNums = __rt_21
  },
  {
    exp = 850,
    id = 28,
    para2 = __rt_22,
    rewardNums = __rt_21
  },
  {
    exp = 1000,
    id = 29,
    para2 = __rt_22,
    rewardIds = __rt_17,
    rewardNums = __rt_16
  },
  {
    exp = 0,
    id = 30,
    para2 = {100},
    rewardIds = {
      1002,
      3001,
      400005
    },
    rewardNums = __rt_8
  }
}
local __default_values = {
  exp = 500,
  icon = "icon_zs5",
  id = 1,
  logic = __rt_2,
  para1 = __rt_3,
  para2 = __rt_4,
  para3 = __rt_1,
  rewardIds = __rt_5,
  rewardNums = __rt_6
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(achievement_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxLevel = 30}
setmetatable(achievement_level, {__index = __rawdata})
return achievement_level
