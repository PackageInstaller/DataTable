local __rt_1 = {1006, 1504}
local __rt_2 = {50, 5}
local __rt_3 = {1087, 1504}
local __rt_4 = {200, 5}
local __rt_5 = {500, 5}
local __rt_6 = {1094, 1504}
local tiny_game_brotato_reward = {
  [2] = {
    {brotato_id = 2, point = 10},
    {
      brotato_id = 2,
      level = 2,
      point = 25,
      rewardIds = {1006, 1018},
      rewardNums = {50, 100}
    },
    {
      brotato_id = 2,
      level = 3,
      point = 50
    },
    {
      brotato_id = 2,
      level = 4,
      point = 75,
      rewardIds = {1006, 8237}
    },
    {brotato_id = 2, level = 5}
  },
  [3] = {
    {
      brotato_id = 3,
      point = 10,
      rewardIds = __rt_3,
      rewardNums = __rt_4
    },
    {
      brotato_id = 3,
      level = 2,
      point = 25,
      rewardIds = {1087, 2576},
      rewardNums = __rt_4
    },
    {
      brotato_id = 3,
      level = 3,
      point = 50,
      rewardIds = __rt_3,
      rewardNums = __rt_4
    },
    {
      brotato_id = 3,
      level = 4,
      point = 75,
      rewardIds = {1087, 3002},
      rewardNums = {200, 10}
    },
    {
      brotato_id = 3,
      level = 5,
      rewardIds = __rt_3,
      rewardNums = __rt_4
    }
  },
  [4] = {
    {
      brotato_id = 4,
      point = 10,
      rewardIds = {1093, 1504},
      rewardNums = __rt_5
    },
    {
      brotato_id = 4,
      level = 2,
      point = 25,
      rewardIds = {1093, 2581},
      rewardNums = __rt_5
    },
    {
      brotato_id = 4,
      level = 3,
      point = 50,
      rewardIds = __rt_6
    },
    {
      brotato_id = 4,
      level = 4,
      point = 75,
      rewardIds = {1093, 3002},
      rewardNums = {500, 10}
    },
    {
      brotato_id = 4,
      level = 5,
      rewardIds = __rt_6
    }
  },
  [6] = {
    {
      point = 25,
      rewardIds = {3002, 1018},
      rewardNums = {5, 50}
    },
    {
      level = 2,
      point = 50,
      rewardIds = {3005, 1504},
      rewardNums = {5, 5}
    },
    {
      level = 3,
      point = 75,
      rewardIds = {1006, 1503},
      rewardNums = {50, 200}
    },
    {
      level = 4,
      rewardIds = {6003, 1504},
      rewardNums = {2, 5}
    },
    {
      level = 5,
      point = 125,
      rewardIds = {3002, 1920},
      rewardNums = {5, 500}
    },
    {
      level = 6,
      point = 150,
      rewardIds = {1018, 1504}
    },
    {
      level = 7,
      point = 175,
      rewardIds = {6003, 1503},
      rewardNums = {3, 300}
    }
  }
}
local __default_values = {
  brotato_id = 6,
  level = 1,
  point = 100,
  rewardIds = __rt_1,
  rewardNums = __rt_2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(tiny_game_brotato_reward) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(tiny_game_brotato_reward, {__index = __rawdata})
return tiny_game_brotato_reward
