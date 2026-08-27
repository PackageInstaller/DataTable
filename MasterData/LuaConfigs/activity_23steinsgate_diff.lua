local __rt_1 = {}
local activity_23steinsgate_diff = {
  [450011] = {
    difficulty_id = 2,
    difficulty_name = 65844,
    sort = 2
  },
  [450012] = {
    difficulty_desc = 360319,
    difficulty_name_en = "NORMAL MODE",
    pre_condition = __rt_1,
    pre_para1 = __rt_1,
    sector_id = 450012
  }
}
local __default_values = {
  difficulty_desc = 144507,
  difficulty_id = 1,
  difficulty_name = 59556,
  difficulty_name_en = "HARD MODE",
  pre_condition = {3},
  pre_para1 = {5110},
  pre_para2 = __rt_1,
  sector_id = 450011,
  sort = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_23steinsgate_diff) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_23steinsgate_diff, {__index = __rawdata})
return activity_23steinsgate_diff
