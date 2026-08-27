local __rt_1 = {
  233,
  142,
  11
}
local reinforce_card_color_group = {
  {}
}
local __default_values = {
  frame_color = __rt_1,
  group_id = 1,
  text_color = __rt_1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(reinforce_card_color_group) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(reinforce_card_color_group, {__index = __rawdata})
return reinforce_card_color_group
