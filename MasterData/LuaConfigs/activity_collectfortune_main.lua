local activity_collectfortune_main = {
  {}
}
local __default_values = {
  BG_pos = {20, -272},
  activity_id = 50001,
  hero_id = 1027,
  id = 1,
  name = 175031,
  pool_des = 167545,
  pool_rule = 50003,
  receive_des = 154731,
  rule_des = 50002,
  rule_title = 50001,
  skin_id = 302703,
  skin_type = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_collectfortune_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_collectfortune_main, {__index = __rawdata})
return activity_collectfortune_main
