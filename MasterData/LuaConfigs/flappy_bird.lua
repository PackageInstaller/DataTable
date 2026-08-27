local __rt_1 = {count = 200, itemId = 1024}
local __rt_2 = {
  {count = 1, itemId = 721008},
  {count = 5, itemId = 2547},
  __rt_1
}
local __rt_3 = {
  {
    {count = 1, itemId = 410019},
    {count = 100, itemId = 1024},
    {count = 200, itemId = 1026}
  },
  {
    {count = 200, itemId = 1018},
    __rt_1,
    {count = 300, itemId = 1026}
  },
  {
    {count = 1, itemId = 721009},
    {count = 300, itemId = 1024},
    {count = 500, itemId = 1026}
  }
}
local __rt_4 = {
  30,
  60,
  100
}
local __rt_5 = {}
local __rt_6 = {count = 200, itemId = 1062}
local __rt_7 = {count = 500, itemId = 1223}
local __rt_8 = {count = 1, itemId = 420025}
local __rt_9 = {count = 5, itemId = 2564}
local __rt_10 = {count = 1000, itemId = 1223}
local __rt_11 = {count = 1, itemId = 721410}
local __rt_12 = {count = 1500, itemId = 1223}
local __rt_13 = {count = 5, itemId = 1504}
local __rt_14 = {count = 200, itemId = 1098}
local flappy_bird = {
  {},
  {
    bird_id = 2,
    firstAwards = __rt_5,
    join_rewards = "",
    join_rewards_score = 0,
    progress_award_data = __rt_5,
    progress_precent = __rt_5,
    progress_precent_review = ""
  },
  {bird_id = 3},
  {
    bird_id = 4,
    firstAwards = {
      __rt_6,
      __rt_7,
      __rt_8
    },
    join_rewards_score = 5000,
    progress_award_data = {
      {
        {count = 100, itemId = 1062},
        __rt_7,
        __rt_9
      },
      {
        {count = 150, itemId = 1062},
        __rt_10,
        __rt_11
      },
      {
        __rt_6,
        __rt_12,
        __rt_13
      }
    }
  },
  {
    bird_id = 5,
    firstAwards = {
      __rt_14,
      __rt_7,
      __rt_8
    },
    join_rewards_score = 5000,
    progress_award_data = {
      {
        {count = 100, itemId = 1098},
        __rt_7,
        __rt_9
      },
      {
        {count = 150, itemId = 1098},
        __rt_10,
        __rt_11
      },
      {
        __rt_14,
        __rt_12,
        __rt_13
      }
    }
  }
}
local __default_values = {
  bird_id = 1,
  firstAwards = __rt_2,
  join_rewards_score = 10,
  progress_award_data = __rt_3,
  progress_precent = __rt_4
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(flappy_bird) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(flappy_bird, {__index = __rawdata})
return flappy_bird
