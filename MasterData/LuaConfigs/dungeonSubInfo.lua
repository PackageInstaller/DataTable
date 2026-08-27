local dungeonSubInfo = {
  {
    icon = "matDg_limit",
    name_en = "POTENTIAL TRAINING",
    text = 472181
  },
  {
    icon = "matDg_skill",
    name_en = "SKILL TRAINING",
    stage_type = 2,
    text = 510297
  },
  {stage_type = 3, text = 58972},
  {stage_type = 4, text = 95138},
  {stage_type = 5, text = 341036},
  {stage_type = 6, text = 154156},
  {
    icon = "matDg_ath",
    stage_type = 7,
    text = 413024
  },
  {
    icon = "matDg_ath",
    img_bottom_idx = 1,
    stage_type = 8,
    text = 292691
  },
  {stage_type = 9},
  {
    icon = "matDg_ath",
    img_bottom_idx = 2,
    stage_type = 10,
    text = 373722
  },
  {
    icon = "matDg_ath",
    img_bottom_idx = 3,
    stage_type = 11,
    text = 290389
  }
}
local __default_values = {
  icon = "",
  img_bottom_idx = 0,
  name_en = "TEST",
  stage_type = 1,
  text = 147141
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dungeonSubInfo) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dungeonSubInfo, {__index = __rawdata})
return dungeonSubInfo
