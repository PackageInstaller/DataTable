local __rt_1 = {1502, 3005}
local __rt_2 = {1, 5}
local __rt_3 = {1503, 8103}
local __rt_4 = {150, 5}
local __rt_5 = {6003, 5007}
local __rt_6 = {
  1,
  1,
  5
}
local __rt_7 = {
  1,
  150,
  5
}
local __rt_8 = {
  3001,
  6003,
  5007
}
local activity_answer_reward = {
  {
    [3] = {need_score = 3},
    [6] = {
      need_score = 6,
      rewardIds = __rt_3,
      rewardNums = __rt_4,
      score_reward = "1503=150|8103=5"
    },
    [10] = {
      rewardIds = __rt_5,
      score_reward = "6003=1|5007=5"
    }
  },
  {
    [3] = {
      id = 2,
      need_score = 3,
      rewardIds = {
        600014,
        1502,
        3005
      },
      rewardNums = __rt_6,
      score_reward = "600014=1|1502=1|3005=5"
    },
    [6] = {
      id = 2,
      need_score = 6,
      rewardIds = {
        610014,
        1503,
        8103
      },
      rewardNums = __rt_7,
      score_reward = "610014=1|1503=150|8103=5"
    },
    [10] = {
      id = 2,
      rewardIds = __rt_8,
      rewardNums = __rt_6,
      score_reward = "3001=1|6003=1|5007=5"
    }
  },
  {
    [3] = {
      id = 3,
      need_score = 3,
      rewardIds = {
        1018,
        1502,
        3005
      },
      rewardNums = {
        100,
        1,
        5
      },
      score_reward = "1018=100|1502=1|3005=5"
    },
    [6] = {
      id = 3,
      need_score = 6,
      rewardIds = {
        620006,
        1503,
        8103
      },
      rewardNums = __rt_7,
      score_reward = "620006=1|1503=150|8103=5"
    },
    [10] = {
      id = 3,
      rewardIds = __rt_8,
      rewardNums = __rt_6,
      score_reward = "3001=1|6003=1|5007=5"
    }
  },
  {
    [3] = {id = 4, need_score = 3},
    [6] = {
      id = 4,
      need_score = 6,
      rewardIds = __rt_3,
      rewardNums = __rt_4,
      score_reward = "1503=150|8103=5"
    },
    [10] = {
      id = 4,
      rewardIds = __rt_5,
      score_reward = "6003=1|5007=5"
    }
  },
  {
    [3] = {id = 5, need_score = 3},
    [6] = {
      id = 5,
      need_score = 6,
      rewardIds = __rt_3,
      rewardNums = __rt_4,
      score_reward = "1503=150|8103=5"
    },
    [10] = {
      id = 5,
      rewardIds = __rt_8,
      rewardNums = __rt_6,
      score_reward = "3001=1|6003=1|5007=5"
    }
  },
  {
    [3] = {id = 6, need_score = 3},
    [6] = {
      id = 6,
      need_score = 6,
      rewardIds = __rt_3,
      rewardNums = __rt_4,
      score_reward = "1503=150|8103=5"
    },
    [10] = {
      id = 6,
      rewardIds = __rt_5,
      score_reward = "6003=1|5007=5"
    }
  }
}
local __default_values = {
  id = 1,
  need_score = 10,
  rewardIds = __rt_1,
  rewardNums = __rt_2,
  score_reward = "1502=1|3005=5"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_answer_reward) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_answer_reward, {__index = __rawdata})
return activity_answer_reward
