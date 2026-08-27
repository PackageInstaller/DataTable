local activity_monster_card = {
  [40002] = {},
  [56001] = {
    activity_id = 56001,
    rule_id = 24,
    sector_id = 560011
  }
}
local __default_values = {
  activity_id = 40002,
  dungeon_id = -1,
  max_equip = 5,
  rule_id = 20,
  sector_id = 400022,
  warchess_season_id = -1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_monster_card) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_monster_card, {__index = __rawdata})
return activity_monster_card
