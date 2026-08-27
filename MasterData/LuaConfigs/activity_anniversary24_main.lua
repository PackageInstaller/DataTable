local activity_anniversary24_main = {
  {}
}
local __default_values = {
  activity_id = 59001,
  farm_stage_arrange = 15,
  hard_stage = 590011,
  id = 1,
  jump_activity_id = {1206, 0},
  normal_sector = 590012,
  shop_list = {
    2064,
    2065,
    2066,
    2067
  },
  story_stage = 0,
  token_item = {
    1281,
    1282,
    1283
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_anniversary24_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_anniversary24_main, {__index = __rawdata})
return activity_anniversary24_main
