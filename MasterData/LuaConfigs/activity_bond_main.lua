local activity_bond_main = {
  {}
}
local __default_values = {
  ban_hero = {1045},
  formation_rule = 12,
  id = 1,
  rule_id = 9720,
  rule_title = 9719,
  season_buff_id = 5210001,
  season_rule = 154177
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_bond_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_bond_main, {__index = __rawdata})
return activity_bond_main
