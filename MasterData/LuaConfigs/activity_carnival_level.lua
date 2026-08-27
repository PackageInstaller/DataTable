local activity_carnival_level = {
  {ranklist_id = 7},
  {
    dungeon_levels = {
      33011,
      33012,
      33013
    },
    id = 2
  }
}
local __default_values = {
  dungeon_levels = {
    33001,
    33002,
    33003
  },
  id = 1,
  pic_small = "ActCarnival22Rouge_small",
  ranklist_id = 29
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_carnival_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_carnival_level, {__index = __rawdata})
return activity_carnival_level
