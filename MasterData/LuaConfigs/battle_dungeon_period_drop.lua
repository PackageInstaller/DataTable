local battle_dungeon_period_drop = {
  {}
}
local __default_values = {
  drop_times = 20,
  dungeon_type = {
    29,
    41,
    42,
    43,
    44
  },
  id = 1,
  reset_times_point = 2,
  save_id = 29
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(battle_dungeon_period_drop) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  dgTypeDic = {
    [29] = 1,
    [41] = 1,
    [42] = 1,
    [43] = 1,
    [44] = 1
  }
}
setmetatable(battle_dungeon_period_drop, {__index = __rawdata})
return battle_dungeon_period_drop
