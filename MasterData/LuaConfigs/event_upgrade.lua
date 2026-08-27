local __rt_1 = {820}
local __rt_2 = {0}
local __rt_3 = {1}
local event_upgrade = {
  {},
  {id = 2, replace_txt = 300002},
  {
    auto_choice_arg = {},
    auto_choice_type = 0,
    id = 3,
    prices = {
      0,
      30,
      60,
      80,
      100
    },
    refresh_times = {
      1,
      2,
      3,
      4,
      -1
    },
    replace_txt = 300003
  },
  {
    describe = 229199,
    id = 4,
    replace_txt = 300004
  },
  {
    describe = 35590,
    id = 5,
    replace_txt = 300005
  },
  {id = 6, replace_txt = 300006}
}
local __default_values = {
  auto_choice_arg = __rt_1,
  auto_choice_type = 5,
  auto_priority = 2,
  choice_color = false,
  currency = 1,
  describe = 136673,
  icon = "event_icon_func",
  id = 1,
  prices = __rt_2,
  refresh_times = __rt_3,
  replace_txt = 300001
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(event_upgrade) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(event_upgrade, {__index = __rawdata})
return event_upgrade
