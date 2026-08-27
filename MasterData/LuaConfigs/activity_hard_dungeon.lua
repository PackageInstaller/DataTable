local activity_hard_dungeon = {
  [40002] = {}
}
local __default_values = {
  activity_id = 40002,
  dungeon_id = {
    49501,
    49502,
    49503,
    49504,
    49505
  },
  dungeon_type = 1,
  rank_id = 70
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_hard_dungeon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_hard_dungeon, {__index = __rawdata})
return activity_hard_dungeon
