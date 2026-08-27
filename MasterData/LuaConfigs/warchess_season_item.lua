local __rt_1 = {114, 1}
local __rt_2 = {115, 5}
local warchess_season_item = {
  {is_show_in_battle = false, name = 149793},
  {
    id = 2,
    param = {
      0,
      10,
      112,
      1215
    },
    ui_type = 2
  },
  {
    id = 3,
    name = 50360,
    param = {
      0,
      10,
      113,
      1225
    },
    ui_type = 3
  }
}
local __default_values = {
  ex_arg1 = __rt_1,
  ex_arg2 = __rt_2,
  id = 1,
  is_show_in_battle = true,
  logic_type = 1,
  name = 110959,
  param = {
    0,
    10,
    104,
    1208
  },
  ui_type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_season_item) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_season_item, {__index = __rawdata})
return warchess_season_item
