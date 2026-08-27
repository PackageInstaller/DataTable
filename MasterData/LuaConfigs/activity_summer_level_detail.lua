local __rt_1 = {
  [1202] = {maxValue = 26, minValue = 22},
  [1204] = {maxValue = 600, minValue = 500}
}
local __rt_2 = {
  [1202] = {maxValue = 38, minValue = 34},
  [1204] = {maxValue = 1000, minValue = 840}
}
local __rt_3 = {
  [1202] = {maxValue = 54, minValue = 46},
  [1204] = {maxValue = 1490, minValue = 1290}
}
local __rt_4 = {
  [1202] = {maxValue = 64, minValue = 56},
  [1204] = {maxValue = 1940, minValue = 1660}
}
local __rt_5 = {
  [1202] = {maxValue = 81, minValue = 69},
  [1204] = {maxValue = 2610, minValue = 2250}
}
local activity_summer_level_detail = {
  [35001] = {},
  [35002] = {
    drop_show = __rt_2,
    id = 35002,
    level_des = 54748,
    level_num = 2
  },
  [35003] = {
    drop_show = __rt_3,
    id = 35003,
    level_des = 33143,
    level_num = 3
  },
  [35004] = {
    drop_show = __rt_4,
    id = 35004,
    level_des = 237021,
    level_num = 4
  },
  [35005] = {
    drop_show = __rt_5,
    id = 35005,
    level_des = 504107,
    level_num = 5
  },
  [35201] = {id = 35201, main_id = 2},
  [35202] = {
    drop_show = __rt_2,
    id = 35202,
    level_des = 54748,
    level_num = 2,
    main_id = 2
  },
  [35203] = {
    drop_show = __rt_3,
    id = 35203,
    level_des = 33143,
    level_num = 3,
    main_id = 2
  },
  [35204] = {
    drop_show = __rt_4,
    id = 35204,
    level_des = 237021,
    level_num = 4,
    main_id = 2
  },
  [35205] = {
    drop_show = __rt_5,
    id = 35205,
    level_des = 504107,
    level_num = 5,
    main_id = 2
  }
}
local __default_values = {
  drop_show = __rt_1,
  id = 35001,
  level_des = 125855,
  level_num = 1,
  level_pic = "ActWinDun21",
  main_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_summer_level_detail) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  level_list = {
    35201,
    35001,
    35202,
    35002,
    35003,
    35203,
    35004,
    35204,
    35205,
    35005
  }
}
setmetatable(activity_summer_level_detail, {__index = __rawdata})
return activity_summer_level_detail
