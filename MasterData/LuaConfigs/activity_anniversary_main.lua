local activity_anniversary_main = {
  {},
  {
    activity_id = 40002,
    brotato_id = 4,
    brotato_sector_id = 400025,
    guard_sector_id = 400023,
    id = 2,
    jump_activity_id = {1204},
    shop_list = {
      2049,
      2050,
      2051,
      2052
    },
    story_stage = 400024,
    token_item = {
      1094,
      1093,
      290000
    },
    warchess_season_id = 5
  }
}
local __default_values = {
  activity_id = 40001,
  brotato_id = 0,
  brotato_sector_id = 0,
  guard_sector_id = 0,
  handbook_type = 0,
  id = 1,
  jump_activity_id = {1203, 41001},
  shop_list = {
    2042,
    2041,
    2043,
    2044
  },
  story_stage = 400012,
  token_item = {
    1077,
    1078,
    1079
  },
  warchess_season_id = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_anniversary_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_anniversary_main, {__index = __rawdata})
return activity_anniversary_main
