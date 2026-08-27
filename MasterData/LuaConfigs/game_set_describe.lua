local __rt_1 = {512818, 233171}
local __rt_2 = {410728, 341131}
local game_set_describe = {
  {
    name = "skill",
    option_group_name = __rt_1,
    setting_name = 27027
  },
  {
    id = 2,
    name = "function",
    option_group_name = __rt_1,
    setting_name = 291054
  },
  {
    defalt_detail = 2,
    id = 3,
    name = "open_ultimateSkill",
    option_group_name = {
      410728,
      136238,
      341131
    },
    setting_name = 181771
  },
  {
    id = 4,
    name = "quick_move",
    setting_name = 37119
  },
  {
    id = 5,
    name = "quick_interaction"
  },
  [7] = {id = 7, setting_name = 310027},
  [8] = {
    defalt_detail = 1,
    id = 8,
    name = "open_fairyIntro",
    setting_name = 401072
  }
}
local __default_values = {
  defalt_detail = 0,
  id = 1,
  name = "auto_ultimateSkill",
  option_group_name = __rt_2,
  setting_name = 175490
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(game_set_describe) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(game_set_describe, {__index = __rawdata})
return game_set_describe
