local __rt_1 = {}
local commander_skill = {
  {
    name = 504870,
    pre_condition = __rt_1,
    pre_para1 = __rt_1
  },
  {commander_id = 2, describe = 422645}
}
local __default_values = {
  color = 1,
  commander_id = 1,
  describe = 39807,
  icon = "CommanderSkillSeries_1",
  name = 455399,
  pre_condition = {3},
  pre_para1 = {2103},
  pre_para2 = __rt_1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(commander_skill) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(commander_skill, {__index = __rawdata})
return commander_skill
