local __rt_1 = {400016, 1024}
local __rt_2 = {1, 200}
local __rt_3 = {420016, 1024}
local __rt_4 = {1, 300}
local __rt_5 = {
  410018,
  1024,
  1025
}
local __rt_6 = {
  1,
  500,
  1000
}
local __rt_7 = {
  721007,
  1024,
  1025
}
local __rt_8 = {
  1,
  1000,
  2000
}
local __rt_9 = {
  1018,
  1024,
  1025
}
local __rt_10 = {
  300,
  1500,
  3000
}
local activity_winter_challenge_award = {
  {
    {
      need_point = 800,
      rewardIds = __rt_1,
      rewardNums = __rt_2
    },
    {
      phase = 2,
      rewardIds = __rt_3,
      rewardNums = __rt_4
    },
    {
      need_point = 2400,
      phase = 3,
      rewardIds = __rt_5,
      rewardNums = __rt_6
    },
    {
      need_point = 3000,
      phase = 4,
      rewardIds = __rt_7
    },
    {
      need_point = 3600,
      phase = 5,
      rewardNums = __rt_10
    }
  },
  {
    {
      id = 2,
      need_point = 800,
      rewardIds = __rt_1,
      rewardNums = __rt_2
    },
    {
      id = 2,
      phase = 2,
      rewardIds = __rt_3,
      rewardNums = __rt_4
    },
    {
      id = 2,
      need_point = 2400,
      phase = 3,
      rewardIds = __rt_5,
      rewardNums = __rt_6
    },
    {
      id = 2,
      need_point = 3000,
      phase = 4,
      rewardIds = __rt_7
    },
    {
      id = 2,
      need_point = 3600,
      phase = 5,
      rewardNums = __rt_10
    }
  }
}
local __default_values = {
  id = 1,
  need_point = 1600,
  phase = 1,
  rewardIds = __rt_9,
  rewardNums = __rt_8
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_winter_challenge_award) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_winter_challenge_award, {__index = __rawdata})
return activity_winter_challenge_award
