local activity_carnival24_main = {
  {}
}
local __default_values = {
  activity_id = 56001,
  bp_item = 1264,
  fragment_avg = 5600102,
  fragment_guide = 5600101,
  id = 1,
  jump_activity_id = {1205},
  memory_rule = 23,
  second_id = 57001,
  second_time = 0,
  shop_list = {
    2057,
    2058,
    2059
  },
  story_stage = 560012,
  token_item = {
    1263,
    1262,
    1261,
    290000
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_carnival24_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_carnival24_main, {__index = __rawdata})
return activity_carnival24_main
