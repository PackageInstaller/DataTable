local __rt_1 = {
  13007,
  0,
  0
}
local __rt_2 = {
  13008,
  0,
  0
}
local sector_act_des_cover = {
  [6] = {
    act_name = 247873,
    act_name_en = "COPLEY",
    act_tip_long = {
      13010,
      0,
      0
    },
    act_tip_short = {
      13011,
      0,
      0
    },
    normal_tip_long = {
      13000,
      0,
      0
    },
    normal_tip_short = {
      154,
      0,
      0
    },
    sector_id = 6
  },
  [90011] = {
    act_name = 247873,
    act_name_en = "COPLEY",
    sector_id = 90011
  },
  [110013] = {},
  [130031] = {sector_id = 130031},
  [140021] = {sector_id = 140021},
  [250021] = {sector_id = 250021},
  [330021] = {sector_id = 330021},
  [330041] = {sector_id = 330041},
  [400021] = {sector_id = 400021},
  [600071] = {sector_id = 600071}
}
local __default_values = {
  act_name = "",
  act_name_en = "",
  act_tip_long = __rt_1,
  act_tip_short = __rt_2,
  normal_tip_long = __rt_1,
  normal_tip_short = __rt_2,
  sector_id = 110013
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_act_des_cover) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_act_des_cover, {__index = __rawdata})
return sector_act_des_cover
