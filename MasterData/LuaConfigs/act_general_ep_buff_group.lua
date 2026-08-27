local act_general_ep_buff_group = {
  {},
  {id = 2},
  {id = 3}
}
local __default_values = {
  buff_max = 3,
  debuff_max = 3,
  id = 1,
  rule_id = 40011,
  title_id = 40010
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(act_general_ep_buff_group) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(act_general_ep_buff_group, {__index = __rawdata})
return act_general_ep_buff_group
