local activity_instrument_reward = {
  {
    {
      rewardIds = {5007, 1003}
    },
    {
      level = 2,
      point = 30,
      rewardNums = {50, 500}
    },
    {
      level = 3,
      point = 50,
      rewardIds = {1504, 1920},
      rewardNums = {5, 2000}
    },
    {
      level = 4,
      point = 80,
      rewardIds = {5007, 3002},
      rewardNums = {5, 30}
    }
  }
}
local __default_values = {
  activity_id = 1,
  level = 1,
  point = 15,
  rewardIds = {1006, 1503},
  rewardNums = {3, 10000}
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_instrument_reward) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_instrument_reward, {__index = __rawdata})
return activity_instrument_reward
