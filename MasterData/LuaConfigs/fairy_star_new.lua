local __rt_1 = {1922, 1003}
local __rt_2 = {}
local fairy_star_new = {
  {
    starUpItemNums = {20, 10000}
  },
  {
    cost = {
      [1003] = 30000,
      [1922] = 50
    },
    level_max = 20,
    rank = 2,
    recycle_reward = {
      [1920] = 1630
    },
    starUpItemNums = {50, 30000}
  },
  {
    cost = {
      [1003] = 60000,
      [1922] = 100
    },
    level_max = 30,
    rank = 3,
    recycle_reward = {
      [1920] = 7860
    },
    res_level = 2,
    skill_slot = 2
  },
  {
    cost = {
      [1003] = 100000,
      [1922] = 200
    },
    level_max = 40,
    rank = 4,
    recycle_reward = {
      [1920] = 22440
    },
    res_level = 2,
    skill_slot = 2,
    starUpItemNums = {200, 100000}
  },
  {
    cost = {
      [1003] = 2000000,
      [1922] = 1000
    },
    level_max = 50,
    rank = 5,
    recycle_reward = {
      [1920] = 51750
    },
    res_level = 3,
    skill_slot = 3,
    starUpItemNums = {1000, 2000000},
    tran_cost = {
      [1923] = 1
    }
  }
}
local __default_values = {
  cost = {
    [1003] = 10000,
    [1922] = 20
  },
  level_max = 10,
  rank = 1,
  recycle_reward = {
    [1920] = 100
  },
  res_level = 1,
  skill_slot = 1,
  starUpItemIds = __rt_1,
  starUpItemNums = {100, 60000},
  tran_cost = __rt_2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(fairy_star_new) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(fairy_star_new, {__index = __rawdata})
return fairy_star_new
