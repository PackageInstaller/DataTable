local activity_spring_level = {
  {},
  {
    dungeon_levels = {
      240004,
      240005,
      240006
    },
    id = 2,
    ranklist_id = 69
  },
  {
    dungeon_levels = {
      240031,
      240032,
      240033
    },
    id = 3,
    ranklist_id = 38
  }
}
local __default_values = {
  dungeon_levels = {
    240001,
    240002,
    240003
  },
  id = 1,
  pic_small = "ActCarnival22Rouge_small",
  ranklist_id = 24
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_spring_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_spring_level, {__index = __rawdata})
return activity_spring_level
