local activity_23steinsgate_interact_icon = {
  [2] = {interact_id = 2},
  [3] = {interact_id = 3},
  [4] = {interact_id = 4},
  [5] = {interact_id = 5},
  [6] = {interact_id = 6},
  [7] = {interact_id = 7},
  [8] = {interact_id = 8},
  [9] = {interact_id = 9},
  [10] = {},
  [11] = {interact_id = 11},
  [12] = {interact_id = 12},
  [13] = {interact_id = 13},
  [14] = {interact_id = 14},
  [15] = {interact_id = 15},
  [16] = {interact_id = 16, is_talk = false},
  [17] = {interact_id = 17},
  [18] = {interact_id = 18},
  [19] = {interact_id = 19},
  [20] = {interact_id = 20},
  [21] = {interact_id = 21},
  [22] = {interact_id = 22},
  [23] = {interact_id = 23},
  [24] = {interact_id = 24},
  [25] = {interact_id = 25},
  [26] = {interact_id = 26},
  [27] = {interact_id = 27},
  [28] = {interact_id = 28},
  [29] = {interact_id = 29},
  [30] = {interact_id = 30},
  [31] = {interact_id = 31},
  [32] = {interact_id = 32, is_talk = false},
  [33] = {interact_id = 33}
}
local __default_values = {interact_id = 10, is_talk = true}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_23steinsgate_interact_icon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_23steinsgate_interact_icon, {__index = __rawdata})
return activity_23steinsgate_interact_icon
