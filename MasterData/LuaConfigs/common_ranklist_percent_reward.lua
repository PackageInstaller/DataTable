local __rt_1 = {
  610015,
  600015,
  620007,
  8237,
  1003
}
local __rt_2 = {
  6103,
  1504,
  600023,
  610023,
  620016,
  1003
}
local __rt_3 = {
  6103,
  1504,
  600023,
  1003
}
local __rt_4 = {
  400080,
  400081,
  400082,
  6104,
  1504,
  1920
}
local __rt_5 = {
  600107,
  610107,
  620023,
  1920,
  1504,
  1503
}
local common_ranklist_percent_reward = {
  [38] = {
    {rank_id = 38, rewardIds = __rt_1},
    {
      id = 2,
      percent = 30,
      rank_id = 38,
      rewardIds = __rt_1,
      rewardNums = {
        1,
        1,
        1,
        8,
        75000
      }
    },
    {
      id = 3,
      percent = 50,
      rank_id = 38,
      rewardIds = {
        610015,
        600015,
        8237,
        1003
      },
      rewardNums = {
        1,
        1,
        6,
        50000
      }
    },
    {
      id = 4,
      percent = 80,
      rank_id = 38,
      rewardIds = {
        600015,
        8237,
        1003
      },
      rewardNums = {
        1,
        4,
        20000
      }
    }
  },
  [44] = {
    {
      percent = 5,
      rank_id = 44,
      rewardIds = __rt_2,
      rewardNums = {
        10,
        30,
        1,
        1,
        1,
        100000
      }
    },
    {
      id = 2,
      rank_id = 44,
      rewardIds = __rt_2,
      rewardNums = {
        8,
        25,
        1,
        1,
        1,
        80000
      }
    },
    {
      id = 3,
      percent = 40,
      rank_id = 44,
      rewardIds = {
        6103,
        1504,
        600023,
        610023,
        1003
      },
      rewardNums = {
        6,
        20,
        1,
        1,
        60000
      }
    },
    {
      id = 4,
      percent = 60,
      rank_id = 44,
      rewardIds = __rt_3,
      rewardNums = {
        4,
        15,
        1,
        40000
      }
    },
    {
      id = 5,
      percent = 90,
      rank_id = 44,
      rewardIds = __rt_3,
      rewardNums = {
        2,
        10,
        1,
        30000
      }
    }
  },
  [45] = {
    {
      percent = 10,
      rank_id = 45,
      rewardIds = __rt_4,
      rewardNums = {
        1,
        1,
        1,
        10,
        15,
        2000
      }
    },
    {
      id = 2,
      percent = 30,
      rank_id = 45,
      rewardIds = __rt_4,
      rewardNums = {
        1,
        1,
        1,
        8,
        12,
        1500
      }
    },
    {
      id = 3,
      percent = 50,
      rank_id = 45,
      rewardIds = __rt_4,
      rewardNums = {
        1,
        1,
        1,
        6,
        10,
        1000
      }
    },
    {
      id = 4,
      percent = 70,
      rank_id = 45,
      rewardIds = {
        400080,
        400081,
        6104,
        1504,
        1920
      },
      rewardNums = {
        1,
        1,
        4,
        8,
        500
      }
    },
    {
      id = 5,
      percent = 90,
      rank_id = 45,
      rewardIds = {
        400080,
        6104,
        1504,
        1920
      },
      rewardNums = {
        1,
        2,
        5,
        200
      }
    }
  },
  [70] = {
    {
      percent = 10,
      rewardNums = {
        1,
        1,
        1,
        10000,
        30,
        1500
      }
    },
    {
      id = 2,
      rewardNums = {
        1,
        1,
        1,
        8000,
        25,
        1000
      }
    },
    {
      id = 3,
      percent = 30,
      rewardNums = {
        1,
        1,
        1,
        6000,
        20,
        800
      }
    },
    {
      id = 4,
      percent = 50,
      rewardNums = {
        1,
        1,
        1,
        5000,
        15,
        600
      }
    },
    {
      id = 5,
      percent = 70,
      rewardIds = {
        600107,
        610107,
        1920,
        1504,
        1503
      },
      rewardNums = {
        1,
        1,
        5000,
        10,
        300
      }
    },
    {
      id = 6,
      percent = 90,
      rewardIds = {
        600107,
        1920,
        1504
      },
      rewardNums = {
        1,
        3000,
        5
      }
    }
  }
}
local __default_values = {
  id = 1,
  percent = 20,
  rank_id = 70,
  rewardIds = __rt_5,
  rewardNums = {
    1,
    1,
    1,
    10,
    100000
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(common_ranklist_percent_reward) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(common_ranklist_percent_reward, {__index = __rawdata})
return common_ranklist_percent_reward
