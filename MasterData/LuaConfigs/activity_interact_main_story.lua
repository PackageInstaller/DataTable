local __rt_1 = {}
local __rt_2 = {
  2,
  3,
  4
}
local __rt_3 = {5, 6}
local __rt_4 = {7, 8}
local __rt_5 = {9}
local __rt_6 = {11, 12}
local __rt_7 = {13, 14}
local __rt_8 = {15}
local __rt_9 = {16}
local activity_interact_main_story = {
  [24001] = {
    {interact_id = __rt_1, name = 282318},
    {id = 2, interact_id = __rt_2},
    {
      id = 3,
      interact_id = __rt_3,
      name = 209843
    },
    {
      id = 4,
      interact_id = __rt_4,
      name = 303929
    },
    {id = 5, name = 454473},
    {
      id = 6,
      interact_id = __rt_6,
      name = 257809
    },
    {
      id = 7,
      interact_id = __rt_7,
      name = 62990
    },
    {
      id = 8,
      interact_id = __rt_8,
      name = 188611
    },
    {
      id = 9,
      interact_id = __rt_9,
      name = 372178
    }
  },
  [24002] = {
    {
      activity_id = 24002,
      interact_id = __rt_1,
      name = 282318
    },
    {
      activity_id = 24002,
      id = 2,
      interact_id = __rt_2
    },
    {
      activity_id = 24002,
      id = 3,
      interact_id = __rt_3,
      name = 209843
    },
    {
      activity_id = 24002,
      id = 4,
      interact_id = __rt_4,
      name = 303929
    },
    {
      activity_id = 24002,
      id = 5,
      name = 454473
    },
    {
      activity_id = 24002,
      id = 6,
      interact_id = __rt_6,
      name = 257809
    },
    {
      activity_id = 24002,
      id = 7,
      interact_id = __rt_7,
      name = 62990
    },
    {
      activity_id = 24002,
      id = 8,
      interact_id = __rt_8,
      name = 188611
    },
    {
      activity_id = 24002,
      id = 9,
      interact_id = __rt_9,
      name = 372178
    }
  },
  [24003] = {
    {
      activity_id = 24003,
      interact_id = __rt_1,
      name = 169547
    },
    {
      activity_id = 24003,
      id = 2,
      interact_id = {2},
      name = 39842
    },
    {
      activity_id = 24003,
      id = 3,
      interact_id = {3},
      name = 477188
    },
    {
      activity_id = 24003,
      id = 4,
      interact_id = {4},
      name = 121163
    },
    {
      activity_id = 24003,
      id = 5,
      interact_id = {5},
      name = 402239
    },
    {
      activity_id = 24003,
      id = 6,
      interact_id = {6},
      name = 2218
    },
    {
      activity_id = 24003,
      id = 7,
      interact_id = {7},
      name = 95762
    },
    {
      activity_id = 24003,
      id = 8,
      interact_id = {8},
      name = 266982
    },
    {
      activity_id = 24003,
      id = 9,
      name = 268019
    }
  }
}
local __default_values = {
  activity_id = 24001,
  id = 1,
  interact_id = __rt_5,
  name = 103675
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_interact_main_story) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  stageMapping = {
    [24001] = {
      [2] = 2,
      [3] = 2,
      [4] = 2,
      [5] = 3,
      [6] = 3,
      [7] = 4,
      [8] = 4,
      [9] = 5,
      [11] = 6,
      [12] = 6,
      [13] = 7,
      [14] = 7,
      [15] = 8,
      [16] = 9
    },
    [24002] = {
      [2] = 2,
      [3] = 2,
      [4] = 2,
      [5] = 3,
      [6] = 3,
      [7] = 4,
      [8] = 4,
      [9] = 5,
      [11] = 6,
      [12] = 6,
      [13] = 7,
      [14] = 7,
      [15] = 8,
      [16] = 9
    },
    [24003] = {
      [2] = 2,
      [3] = 3,
      [4] = 4,
      [5] = 5,
      [6] = 6,
      [7] = 7,
      [8] = 8,
      [9] = 9
    }
  }
}
setmetatable(activity_interact_main_story, {__index = __rawdata})
return activity_interact_main_story
