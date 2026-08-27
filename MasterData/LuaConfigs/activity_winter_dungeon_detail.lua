local __rt_1 = {
  [1024] = {maxValue = 32, minValue = 28},
  [1025] = {maxValue = 160, minValue = 130}
}
local __rt_2 = {
  [1024] = {maxValue = 37, minValue = 33},
  [1025] = {maxValue = 190, minValue = 160}
}
local __rt_3 = {
  [1024] = {maxValue = 42, minValue = 38},
  [1025] = {maxValue = 230, minValue = 190}
}
local __rt_4 = {
  [1024] = {maxValue = 47, minValue = 43},
  [1025] = {maxValue = 270, minValue = 230}
}
local __rt_5 = {
  [1024] = {maxValue = 52, minValue = 48},
  [1025] = {maxValue = 330, minValue = 270}
}
local __rt_6 = {}
local activity_winter_dungeon_detail = {
  [28001] = {
    drop_show = __rt_1,
    level_des = 33510,
    level_num = "CT-1",
    level_pic = "ActWinDun21"
  },
  [28002] = {
    drop_show = __rt_2,
    id = 28002,
    level_des = 26664,
    level_num = "CT-2",
    level_pic = "ActWinDun21"
  },
  [28003] = {
    drop_show = __rt_3,
    id = 28003,
    level_des = 160040,
    level_num = "CT-3",
    level_pic = "ActWinDun21"
  },
  [28004] = {
    drop_show = __rt_4,
    id = 28004,
    level_des = 51309,
    level_num = "CT-4",
    level_pic = "ActWinDun21"
  },
  [28005] = {
    drop_show = __rt_5,
    id = 28005,
    level_des = 151228,
    level_num = "CT-5",
    level_pic = "ActWinDun21"
  },
  [28006] = {
    id = 28006,
    level_des = 444384,
    level_pic = "ActWinDun21"
  },
  [28007] = {id = 28007},
  [28008] = {id = 28008},
  [28009] = {id = 28009},
  [28010] = {id = 28010},
  [28011] = {id = 28011},
  [28012] = {id = 28012},
  [28101] = {
    drop_show = __rt_1,
    id = 28101,
    level_des = 33510,
    level_num = "CT-1",
    level_pic = "ActWinDun21"
  },
  [28102] = {
    drop_show = __rt_2,
    id = 28102,
    level_des = 26664,
    level_num = "CT-2",
    level_pic = "ActWinDun21"
  },
  [28103] = {
    drop_show = __rt_3,
    id = 28103,
    level_des = 160040,
    level_num = "CT-3",
    level_pic = "ActWinDun21"
  },
  [28104] = {
    drop_show = __rt_4,
    id = 28104,
    level_des = 51309,
    level_num = "CT-4",
    level_pic = "ActWinDun21"
  },
  [28105] = {
    drop_show = __rt_5,
    id = 28105,
    level_des = 151228,
    level_num = "CT-5",
    level_pic = "ActWinDun21"
  },
  [28106] = {
    id = 28106,
    level_des = 190115,
    level_pic = "ActWinDun21"
  },
  [28107] = {id = 28107},
  [28108] = {id = 28108},
  [28109] = {id = 28109},
  [28110] = {id = 28110},
  [28111] = {id = 28111},
  [28112] = {id = 28112}
}
local __default_values = {
  chip_select_max = 1,
  drop_show = __rt_6,
  id = 28001,
  level_des = "",
  level_num = "CHALLENGE",
  level_pic = ""
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_winter_dungeon_detail) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_winter_dungeon_detail, {__index = __rawdata})
return activity_winter_dungeon_detail
