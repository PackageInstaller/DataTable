local battle_dungeon_dungeon = {
  {},
  {dungeon_type = 2},
  {dungeon_type = 3},
  {dungeon_type = 4},
  [6] = {dungeon_type = 6},
  [7] = {dungeon_type = 7},
  [8] = {dungeon_type = 8},
  [9] = {dungeon_type = 9},
  [10] = {dungeon_type = 10},
  [11] = {dungeon_type = 11},
  [12] = {dungeon_type = 12, share_twice = 1},
  [14] = {dungeon_type = 14},
  [15] = {dungeon_type = 15},
  [16] = {dungeon_type = 16},
  [17] = {dungeon_type = 17},
  [18] = {dungeon_type = 18},
  [19] = {dungeon_type = 19},
  [20] = {dungeon_type = 20},
  [21] = {dungeon_type = 21},
  [22] = {dungeon_type = 22},
  [23] = {dungeon_type = 23},
  [24] = {dungeon_type = 24},
  [25] = {dungeon_type = 25},
  [26] = {dungeon_type = 26},
  [27] = {dungeon_type = 27},
  [28] = {dungeon_type = 28},
  [29] = {dungeon_type = 29, share_twice = 1},
  [30] = {dungeon_type = 30},
  [31] = {dungeon_type = 31},
  [32] = {dungeon_type = 32},
  [33] = {dungeon_type = 33},
  [34] = {dungeon_type = 34},
  [35] = {dungeon_type = 35},
  [36] = {dungeon_type = 36},
  [37] = {dungeon_type = 37},
  [38] = {dungeon_type = 38},
  [39] = {dungeon_type = 39},
  [40] = {dungeon_type = 40},
  [41] = {dungeon_type = 41, share_twice = 1},
  [42] = {dungeon_type = 42, share_twice = 1},
  [43] = {dungeon_type = 43, share_twice = 1},
  [44] = {dungeon_type = 44, share_twice = 1},
  [45] = {dungeon_type = 45},
  [46] = {dungeon_type = 46},
  [47] = {dungeon_type = 47},
  [48] = {dungeon_type = 48},
  [49] = {dungeon_type = 49},
  [50] = {dungeon_type = 50},
  [51] = {dungeon_type = 51},
  [52] = {dungeon_type = 52},
  [53] = {dungeon_type = 53},
  [54] = {dungeon_type = 54},
  [55] = {dungeon_type = 55},
  [56] = {dungeon_type = 56},
  [57] = {dungeon_type = 57},
  [500] = {dungeon_type = 500},
  [501] = {dungeon_type = 501},
  [502] = {dungeon_type = 502},
  [503] = {dungeon_type = 503},
  [504] = {dungeon_type = 504},
  [505] = {dungeon_type = 505}
}
local __default_values = {dungeon_type = 1, share_twice = 0}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(battle_dungeon_dungeon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(battle_dungeon_dungeon, {__index = __rawdata})
return battle_dungeon_dungeon
