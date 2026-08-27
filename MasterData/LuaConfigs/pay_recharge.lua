local __rt_1 = {1000, 1001}
local __rt_2 = {}
local __rt_3 = {980, 580}
local __rt_4 = {1980, 1280}
local pay_recharge = {
  [100101] = {
    doubleRewardNumList = {60, 60},
    rewardIdList = {1000},
    rewardNumList = {60}
  },
  [100102] = {
    doubleRewardNumList = {300, 300},
    price = 100102,
    rewardNumList = {300, 30}
  },
  [100103] = {
    doubleRewardNumList = {980, 980},
    price = 100103,
    rewardNumList = {980, 150}
  },
  [100104] = {
    doubleRewardNumList = {1980, 1980},
    price = 100104,
    rewardNumList = {1980, 350}
  },
  [100105] = {
    doubleRewardNumList = {3280, 3280},
    price = 100105,
    rewardNumList = {3280, 720}
  },
  [100106] = {
    doubleRewardNumList = {6480, 6480},
    price = 100106,
    rewardNumList = {6480, 2000}
  },
  [100107] = {
    doubleRewardIdList = __rt_2,
    limitedRewardIdList = __rt_1,
    limitedRewardNumList = __rt_3,
    price = 100107,
    rewardIdList = __rt_2
  },
  [100108] = {
    doubleRewardIdList = __rt_2,
    limitedRewardIdList = __rt_1,
    limitedRewardNumList = __rt_4,
    price = 100108,
    rewardIdList = __rt_2
  },
  [100109] = {
    doubleRewardIdList = __rt_2,
    limitedRewardIdList = __rt_1,
    limitedRewardNumList = __rt_3,
    price = 100109,
    rewardIdList = __rt_2
  },
  [100110] = {
    doubleRewardIdList = __rt_2,
    limitedRewardIdList = __rt_1,
    limitedRewardNumList = __rt_4,
    price = 100110,
    rewardIdList = __rt_2
  },
  [100111] = {
    doubleRewardIdList = __rt_2,
    limitedRewardIdList = __rt_1,
    limitedRewardNumList = __rt_3,
    price = 100111,
    rewardIdList = __rt_2
  }
}
local __default_values = {
  doubleRewardIdList = __rt_1,
  doubleRewardNumList = __rt_2,
  limitedRewardIdList = __rt_2,
  limitedRewardNumList = __rt_2,
  price = 100101,
  rewardIdList = __rt_1,
  rewardNumList = __rt_2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(pay_recharge) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(pay_recharge, {__index = __rawdata})
return pay_recharge
