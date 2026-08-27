local fairy_data = {
  {
    audio_perform = 1293,
    name = 146640,
    suitability = 1,
    time_lvup = 1.5
  },
  {
    audio_perform = 1294,
    id = 2,
    item_id = 6102,
    name = 186977,
    skill_list = 2,
    src_id = 2001,
    suitability = 2,
    time_lvup = 2
  },
  {
    audio_perform = 1291,
    id = 3,
    item_id = 6103,
    name = 335946,
    skill_list = 3,
    src_id = 3001,
    suitability = 3
  },
  {
    id = 4,
    item_id = 6104,
    skill_list = 4,
    src_id = 4001
  },
  {
    id = 5,
    item_id = 6113,
    name = 82606,
    skill_list = 5,
    src_id = 5001
  }
}
local __default_values = {
  audio_perform = 1292,
  id = 1,
  is_locked = false,
  item_id = 6101,
  name = 115752,
  skill_list = 1,
  src_id = 1001,
  suitability = 4,
  time_lvup = 3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(fairy_data) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(fairy_data, {__index = __rawdata})
return fairy_data
