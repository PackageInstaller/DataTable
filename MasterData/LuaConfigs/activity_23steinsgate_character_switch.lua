local activity_23steinsgate_character_switch = {
  [3] = {},
  [41] = {
    id = 2,
    storyline_id = 41,
    user_before_obj = "2023STEINS_rintaro",
    user_before_parent = "STAGE_7"
  }
}
local __default_values = {
  id = 1,
  storyline_id = 3,
  user_before_obj = "2023STEINS_professor",
  user_before_parent = "STAGE_2"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_23steinsgate_character_switch) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_23steinsgate_character_switch, {__index = __rawdata})
return activity_23steinsgate_character_switch
