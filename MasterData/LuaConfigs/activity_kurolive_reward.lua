local activity_kurolive_reward = {
  {
    item_id = 8275,
    rewardIds = {1808, 1803},
    rewardNums = {5, 10}
  },
  {
    icon = "Icon_2",
    id = 2,
    name = 443021,
    rewardIds = {
      1008,
      1004,
      1101
    },
    rewardNums = {
      50,
      600,
      500
    }
  },
  {
    icon = "Icon_3",
    id = 3,
    item_id = 8268,
    name = 508089,
    rewardIds = {
      1113,
      1101,
      1107
    },
    rewardNums = {
      400,
      400,
      400
    }
  },
  {
    icon = "Icon_4",
    id = 4,
    item_id = 8269,
    name = 513533,
    rewardIds = {
      1803,
      3115,
      1113
    },
    rewardNums = {
      50,
      40,
      300
    }
  },
  {
    icon = "Icon_5",
    id = 5,
    item_id = 8270,
    name = 74586,
    rewardIds = {
      1114,
      1102,
      1108
    },
    rewardNums = {
      200,
      200,
      200
    }
  },
  {
    icon = "Icon_6",
    id = 6,
    item_id = 8271,
    name = 499040,
    rewardIds = {3107, 3115}
  },
  {
    icon = "Icon_7",
    id = 7,
    item_id = 8272,
    name = 249098,
    rewardNums = {
      500,
      10,
      300
    }
  }
}
local __default_values = {
  icon = "Icon_1",
  id = 1,
  item_id = 8267,
  name = 100302,
  rewardIds = {
    1004,
    3107,
    1107
  },
  rewardNums = {15, 40}
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_kurolive_reward) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_kurolive_reward, {__index = __rawdata})
return activity_kurolive_reward
