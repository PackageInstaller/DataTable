local act_general_repeat_dg_dg = {
  [45001] = {}
}
local __default_values = {
  act_id = 45001,
  level_title = 397052,
  level_title_en = "Special Training",
  pre_condition = {3},
  pre_para1 = {450012106},
  pre_para2 = {}
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(act_general_repeat_dg_dg) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(act_general_repeat_dg_dg, {__index = __rawdata})
return act_general_repeat_dg_dg
