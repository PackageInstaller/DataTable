local activity_hazegift_reward = {
  {
    {score = 20},
    {
      display_reward = "2046=1",
      reward_stage = 2,
      score = 80,
      task = 19302
    },
    {reward_stage = 3, task = 19303},
    {
      display_reward = "911=1|8256=5",
      reward_stage = 4,
      score = 200,
      task = 19304
    },
    {
      reward_stage = 5,
      score = 240,
      task = 19305
    },
    {
      reward_stage = 6,
      score = 280,
      task = 19306
    },
    {
      display_reward = "8254=1|8256=5",
      reward_stage = 7,
      score = 320,
      task = 19307
    }
  }
}
local __default_values = {
  display_reward = "",
  id = 1,
  reward_stage = 1,
  score = 150,
  task = 19301
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_hazegift_reward) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  fixed_reward = {
    {
      {
        id = 2046,
        num = 1,
        task = 19302
      },
      {
        id = 911,
        num = 1,
        task = 19304
      },
      {
        id = 8256,
        num = 5,
        task = 19304
      },
      {
        id = 8254,
        num = 1,
        task = 19307
      },
      {
        id = 8256,
        num = 5,
        task = 19307
      }
    }
  },
  taskIdList = {
    {
      19301,
      19302,
      19303,
      19304,
      19305,
      19306,
      19307
    }
  }
}
setmetatable(activity_hazegift_reward, {__index = __rawdata})
return activity_hazegift_reward
