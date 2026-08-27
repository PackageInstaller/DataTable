local __rt_1 = {}
local act_general_repeat_dg_story = {
  [45001] = {
    {
      pre_condition = __rt_1,
      pre_para1 = __rt_1,
      pre_para2 = __rt_1
    },
    {id = 2, story_id = 4500131}
  }
}
local __default_values = {
  act_id = 45001,
  id = 1,
  pre_condition = {7},
  pre_para1 = {49005},
  pre_para2 = {1},
  story_id = 4500130
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(act_general_repeat_dg_story) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {__basemetatable = base}
setmetatable(act_general_repeat_dg_story, {__index = __rawdata})
return act_general_repeat_dg_story
