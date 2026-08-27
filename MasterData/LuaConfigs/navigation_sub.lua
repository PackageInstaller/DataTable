local __rt_1 = {}
local __rt_2 = {5}
local navigation_sub = {
  {
    img = "ICON_headquaters",
    name = 420736,
    pre_condition = __rt_1,
    red_dot_path = "Main.MainSide"
  },
  {
    id = 2,
    img = "ICON_herodata",
    jump_is_cover = true,
    jump_target = 7,
    marker = 300,
    name = 93396,
    pre_para1 = {500},
    red_dot_path = "Main.HeroWindow"
  },
  {
    id = 3,
    img = "ICON_lottery",
    jump_target = 108,
    marker = 13,
    name = 521100,
    pre_para1 = {600},
    red_dot_path = "Main.Lottery",
    special = {1}
  },
  {
    id = 4,
    img = "ICON_fairy",
    jump_arg = {0},
    jump_target = 116,
    marker = 3952,
    name = 40311,
    pre_para1 = {5800},
    red_dot_path = "Main.Fairy"
  },
  [11] = {
    id = 11,
    img = "ICON_exploration",
    jump_target = 8,
    marker = 76,
    name = 224855,
    pre_para1 = {400},
    red_dot_path = "Main.Sector",
    special = {4}
  },
  [12] = {
    id = 12,
    img = "ICON_shop",
    jump_arg = {601},
    jump_target = 105,
    marker = 1800,
    name = 277829,
    pre_para1 = {610},
    red_dot_path = "Main.ShopWindow"
  },
  [13] = {
    id = 13,
    img = "ICON_milestone",
    jump_target = 118,
    marker = 4130,
    name = 119896,
    pre_para1 = {510},
    red_dot_path = "Main.Milestone"
  },
  [14] = {
    id = 14,
    img = "ICON_oasis",
    jump_target = 9,
    marker = 1500,
    pre_para1 = {300},
    red_dot_path = "Main.Oasis",
    special = {3}
  },
  [15] = {
    id = 15,
    img = "ICON_formation",
    jump_target = 119,
    marker = 80,
    name = 119392,
    pre_para1 = {6200}
  },
  [16] = {
    id = 16,
    jump_arg = {0, 0},
    jump_target = 109,
    marker = 2000,
    name = 330816,
    pre_condition = __rt_1,
    red_dot_path = "Main.ActivityInHome"
  },
  [22] = {
    id = 22,
    img = "ICON_factory",
    jump_is_cover = true,
    jump_target = 10,
    marker = 1300,
    name = 512101,
    pre_para1 = {900},
    red_dot_path = "Main.Factory"
  },
  [23] = {
    id = 23,
    img = "ICON_dormitory",
    jump_target = 23,
    marker = 62,
    name = 143955,
    pre_para1 = {1100},
    red_dot_path = "Main.Dorm"
  },
  [24] = {
    id = 24,
    img = "ICON_storage",
    jump_is_cover = true,
    jump_target = 110,
    marker = 2002,
    name = 431198,
    pre_para1 = {801},
    red_dot_path = "Main.Warehouse",
    red_dot_show = 1
  }
}
local __default_values = {
  force_lock = false,
  id = 1,
  img = "ICON_activity",
  jump_arg = __rt_1,
  jump_is_cover = false,
  jump_target = 0,
  marker = 0,
  name = 104709,
  pre_condition = __rt_2,
  pre_para1 = __rt_1,
  pre_para2 = __rt_1,
  red_dot_path = "",
  red_dot_show = 0,
  special = __rt_1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(navigation_sub) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(navigation_sub, {__index = __rawdata})
return navigation_sub
