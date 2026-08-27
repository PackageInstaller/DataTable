local activity_instrument_main = {
  {}
}
local __default_values = {
  BG_pos = {
    0,
    299,
    -143
  },
  click_score = 15,
  combo_score = 10,
  friend_rank = 1,
  hero_id = 1046,
  id = 1,
  instru_guide_id = 51,
  instru_id = 2,
  post_range = 200,
  pre_range = 500,
  skin_id = 304602,
  skin_type = 2,
  task_item = 1259,
  task_rule_id = 53003,
  task_rule_title = 53002,
  task_type = 1950,
  type_difficulty = 2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_instrument_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_instrument_main, {__index = __rawdata})
return activity_instrument_main
