local activity_treasurehunt_main = {
  {}
}
local __default_values = {
  activity_id = 51001,
  bonus_story_id = 5100108,
  collectfortune_id = 50001,
  daily_amount = 1,
  daily_point = 999,
  first_amount = 1,
  first_daily_time = 1706821200,
  first_time = 1706774460,
  id = 1,
  story_stage = 510011,
  total_limit = 14,
  treasure_guide = 64
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_treasurehunt_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_treasurehunt_main, {__index = __rawdata})
return activity_treasurehunt_main
