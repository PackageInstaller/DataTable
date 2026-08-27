local __rt_1 = {}
local __rt_2 = {
  400013,
  400012,
  400011,
  8109
}
local weekly_challenge_rank_reward = {
  {
    {reward = "", type = 1},
    {
      order = 2,
      reward = "",
      score = 50
    },
    {order = 3, reward = ""},
    {
      order = 4,
      reward = "",
      score = 300
    },
    {
      order = 5,
      reward = "",
      score = 500
    },
    {
      order = 6,
      reward = "",
      score = 1000
    }
  },
  {
    {
      id = 2,
      rewardIds = __rt_2,
      rewardNums = {
        1,
        1,
        1,
        15
      },
      type = 1
    },
    {
      id = 2,
      order = 2,
      rewardIds = __rt_2,
      rewardNums = {
        1,
        1,
        1,
        12
      },
      score = 50
    },
    {
      id = 2,
      order = 3,
      rewardIds = __rt_2,
      rewardNums = {
        1,
        1,
        1,
        10
      }
    },
    {
      id = 2,
      order = 4,
      rewardIds = __rt_2,
      rewardNums = {
        1,
        1,
        1,
        8
      },
      score = 200
    },
    {
      id = 2,
      order = 5,
      rewardIds = {
        400012,
        400011,
        8109
      },
      rewardNums = {
        1,
        1,
        8
      },
      score = 500
    },
    {
      id = 2,
      order = 6,
      rewardIds = {400011, 8109},
      rewardNums = {1, 5},
      score = 1000
    }
  }
}
local __default_values = {
  id = 1,
  order = 1,
  rewardIds = __rt_1,
  rewardNums = __rt_1,
  score = 100,
  type = 2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(weekly_challenge_rank_reward) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  isHaveReward = {false, true}
}
setmetatable(weekly_challenge_rank_reward, {__index = __rawdata})
return weekly_challenge_rank_reward
