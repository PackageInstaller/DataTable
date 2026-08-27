local __rt_1 = {
  603.9999,
  30,
  0
}
local __rt_2 = {1188, 1020}
local __rt_3 = {}
local __rt_4 = {3, 7}
local activity_blackhole_ui_config = {
  {
    BG_name = "UI_EventBlackHoleHero_1"
  },
  {id = 2},
  {id = 3},
  {id = 4},
  {
    id = 5,
    tag_id = {1, 2}
  },
  {id = 6, tag_id = __rt_4},
  {
    id = 7,
    tag_id = {4, 8}
  },
  {id = 8, tag_id = __rt_4}
}
local __default_values = {
  BG_name = "UI_EventBlackHoleHero_2",
  BG_pos = __rt_1,
  BG_size = __rt_2,
  cn_name = 205192,
  en_name = [[
MASS
DETERMINATION]],
  id = 1,
  rank_des = 363711,
  tag_id = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_blackhole_ui_config) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_blackhole_ui_config, {__index = __rawdata})
return activity_blackhole_ui_config
