local __rt_1 = {
  [1217] = 1
}
local __rt_2 = {
  [1224] = 1
}
local activity_tech_type = {
  [5] = {
    activity_tech_item = 1212,
    activity_tech_type = 5,
    return_tech_item = {
      [1213] = 1
    }
  },
  [6] = {activity_tech_type = 6},
  [7] = {
    activity_tech_item = 1223,
    activity_tech_type = 7,
    return_tech_item = __rt_2
  },
  [9] = {
    activity_tech_item = 1227,
    activity_tech_type = 9,
    common_des = 6,
    itemNoEnoughTip = 9311,
    resetNoEnoughTip = 9312,
    return_tech_item = {
      [1228] = 1
    }
  },
  [11] = {
    activity_tech_item = 1233,
    common_des = 11,
    itemNoEnoughTip = 20007,
    resetNoEnoughTip = 20008,
    return_tech_item = {
      [1234] = 1
    }
  },
  [12] = {
    activity_tech_type = 12,
    itemNoEnoughTip = 24012,
    resetNoEnoughTip = 24013
  },
  [13] = {
    activity_tech_item = 1223,
    activity_tech_type = 13,
    return_tech_item = __rt_2
  },
  [40001] = {
    activity_tech_item = 1237,
    activity_tech_type = 40001,
    itemNoEnoughTip = 20100,
    resetNoEnoughTip = 20101,
    return_tech_item = {
      [1238] = 1
    },
    tech_special_branch = 37
  }
}
local __default_values = {
  activity_tech_item = 1216,
  activity_tech_type = 11,
  common_des = 0,
  itemNoEnoughTip = 0,
  resetNoEnoughTip = 0,
  return_tech_item = __rt_1,
  tech_special_branch = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_tech_type) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_tech_type, {__index = __rawdata})
return activity_tech_type
