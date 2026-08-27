local warchess_tower_shop_drop = {
  {},
  {tower_id = 2},
  {tower_id = 3},
  {tower_id = 4},
  {tower_id = 5},
  {tower_id = 6},
  {tower_id = 7},
  {tower_id = 8},
  {tower_id = 9},
  {tower_id = 10},
  {tower_id = 11},
  {tower_id = 12},
  {tower_id = 13},
  {stage_id = 13, tower_id = 14},
  {stage_id = 13, tower_id = 15},
  {stage_id = 13, tower_id = 16},
  {stage_id = 13, tower_id = 17},
  {stage_id = 13, tower_id = 18},
  {stage_id = 13, tower_id = 19},
  {stage_id = 13, tower_id = 20},
  {stage_id = 13, tower_id = 21},
  {stage_id = 22, tower_id = 22},
  {stage_id = 23, tower_id = 23},
  {stage_id = 24, tower_id = 24},
  {stage_id = 24, tower_id = 25},
  {stage_id = 22, tower_id = 26},
  {stage_id = 23, tower_id = 27},
  {stage_id = 24, tower_id = 28},
  {stage_id = 24, tower_id = 29},
  {stage_id = 22, tower_id = 30},
  {stage_id = 23, tower_id = 31},
  {stage_id = 24, tower_id = 32},
  {stage_id = 24, tower_id = 33},
  {tower_id = 34},
  {tower_id = 35},
  {tower_id = 36},
  {tower_id = 37},
  {stage_id = 13, tower_id = 38},
  {stage_id = 13, tower_id = 39},
  {stage_id = 13, tower_id = 40},
  {stage_id = 13, tower_id = 41},
  {stage_id = 13, tower_id = 42},
  {stage_id = 13, tower_id = 43},
  {stage_id = 13, tower_id = 44},
  {stage_id = 13, tower_id = 45}
}
local __default_values = {stage_id = 0, tower_id = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_tower_shop_drop) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_tower_shop_drop, {__index = __rawdata})
return warchess_tower_shop_drop
