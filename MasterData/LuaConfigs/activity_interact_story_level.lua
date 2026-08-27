local __rt_1 = {}
local __rt_2 = {
  8237,
  1504,
  1502,
  8205
}
local __rt_3 = {
  5,
  5,
  3,
  5
}
local activity_interact_story_level = {
  [24003] = {
    {avg_1 = 2400300, level = 2},
    {
      id = 2,
      level = 5,
      reward_ids = {
        3001,
        8220,
        1501,
        8205
      },
      reward_nums = {
        1,
        5,
        2000,
        5
      }
    },
    {
      id = 3,
      level = 8,
      reward_ids = {
        8128,
        1018,
        1502,
        8205
      },
      reward_nums = {
        5,
        100,
        3,
        5
      }
    },
    {
      id = 4,
      reward_ids = {
        8237,
        1504,
        1501,
        8205
      },
      reward_nums = {
        5,
        5,
        2000,
        5
      }
    },
    {
      id = 5,
      level = 14,
      reward_ids = {
        3001,
        1018,
        1502,
        8205
      },
      reward_nums = {
        1,
        100,
        3,
        5
      }
    },
    {
      id = 6,
      level = 16,
      reward_ids = {
        8128,
        6003,
        1501,
        8205
      },
      reward_nums = {
        5,
        3,
        2000,
        5
      }
    },
    {id = 7, level = 20},
    {
      id = 8,
      level = 24,
      reward_ids = {
        400066,
        1018,
        1501,
        8205
      },
      reward_nums = {
        1,
        100,
        2000,
        5
      }
    },
    {
      id = 9,
      level = 28,
      reward_ids = {
        3001,
        1504,
        1502,
        8205
      },
      reward_nums = {
        1,
        5,
        3,
        5
      }
    },
    {
      id = 10,
      level = 32,
      reward_ids = {
        8237,
        1018,
        1501,
        8205
      },
      reward_nums = {
        5,
        100,
        2000,
        5
      }
    },
    {
      final_step = 4,
      id = 11,
      level = 36,
      reward_ids = {8238},
      reward_nums = {1}
    }
  }
}
local __default_values = {
  activity_id = 24003,
  avg_1 = 0,
  avg_2 = __rt_1,
  final_step = 0,
  id = 1,
  level = 11,
  reward_ids = __rt_2,
  reward_nums = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_interact_story_level) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  levelMapping = {
    [24003] = {
      [2] = 1,
      [5] = 2,
      [8] = 3,
      [11] = 4,
      [14] = 5,
      [16] = 6,
      [20] = 7,
      [24] = 8,
      [28] = 9,
      [32] = 10,
      [36] = 11
    }
  },
  maxLevelDic = {
    [24003] = 36
  },
  storyLevelDic = {
    [24003] = 1
  }
}
setmetatable(activity_interact_story_level, {__index = __rawdata})
return activity_interact_story_level
