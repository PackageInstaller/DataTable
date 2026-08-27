local activity_23steinsgate_main = {
  {}
}
local __default_values = {
  activity_id = 45001,
  brotato_sector = 450014,
  game_brotato = 3,
  id = 1,
  jump_activity_id = {1203, 41001},
  level_sector = {450012, 450011},
  linecast_off = {33, 17},
  outline_obj = {
    7,
    8,
    32
  },
  shop_list = {
    2045,
    2046,
    2047,
    2048
  },
  story_sector = 450013,
  token_item = {1087}
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_23steinsgate_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_23steinsgate_main, {__index = __rawdata})
return activity_23steinsgate_main
