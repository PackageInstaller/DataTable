local warchess_icon_res = {
  {
    res_name = "LevelTriggerIcon_5"
  },
  {
    icon_id = 2,
    res_name = "LevelTriggerIcon_6"
  },
  {
    icon_id = 3,
    res_name = "LevelTriggerIcon_8"
  },
  {
    icon_id = 4,
    res_name = "LevelTriggerIcon_7"
  },
  {
    icon_id = 5,
    res_name = "LevelTriggerIcon_9"
  },
  {icon_id = 6},
  {
    icon_id = 7,
    res_name = "LevelTriggerIcon_11"
  },
  {
    icon_id = 8,
    res_name = "LevelTriggerIcon_12"
  },
  {
    icon_id = 9,
    res_name = "LevelTriggerIcon_13"
  },
  {
    icon_id = 10,
    res_name = "LevelTriggerIcon_14"
  },
  {
    icon_id = 11,
    res_name = "LevelTriggerIcon_15"
  }
}
local __default_values = {
  icon_id = 1,
  res_name = "LevelTriggerIcon_10"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_icon_res) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_icon_res, {__index = __rawdata})
return warchess_icon_res
