local __rt_1 = {
  251,
  250,
  247,
  255
}
local __rt_2 = {
  113,
  77,
  158,
  255
}
local monster_lable_theme = {
  {
    bg = {
      79,
      90,
      157,
      255
    },
    theme_des = 415416
  },
  {
    icon = "ICON_Label_S1T2",
    id = 2,
    theme_des = 271462
  },
  {
    bg = {
      180,
      59,
      144,
      255
    },
    icon = "ICON_Label_S1T3",
    id = 3
  },
  {
    bg = {
      190,
      136,
      70,
      255
    },
    icon = "ICON_Label_S1T4",
    id = 4,
    theme_des = 463402
  },
  {
    icon = "ICON_Label_test2",
    id = 5,
    theme_des = 239573
  }
}
local __default_values = {
  bg = __rt_2,
  color = __rt_1,
  icon = "ICON_Label_S1T1",
  id = 1,
  theme_des = 150079
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(monster_lable_theme) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(monster_lable_theme, {__index = __rawdata})
return monster_lable_theme
