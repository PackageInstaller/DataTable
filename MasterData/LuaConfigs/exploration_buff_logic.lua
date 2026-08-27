local exploration_buff_logic = {
  {event_show = false},
  {logic_id = 2},
  {logic_id = 3},
  {event_show = false, logic_id = 4},
  {event_show = false, logic_id = 5},
  [8] = {logic_id = 8},
  [9] = {logic_id = 9},
  [10] = {event_show = false, logic_id = 10},
  [11] = {event_show = false, logic_id = 11},
  [12] = {event_show = false, logic_id = 12},
  [13] = {event_show = false, logic_id = 13},
  [14] = {event_show = false, logic_id = 14},
  [15] = {logic_id = 15},
  [16] = {logic_id = 16},
  [17] = {logic_id = 17},
  [18] = {logic_id = 18},
  [19] = {event_show = false, logic_id = 19},
  [20] = {event_show = false, logic_id = 20},
  [21] = {event_show = false, logic_id = 21},
  [22] = {event_show = false, logic_id = 22},
  [23] = {event_show = false, logic_id = 23},
  [24] = {event_show = false, logic_id = 24},
  [25] = {event_show = false, logic_id = 25},
  [26] = {event_show = false, logic_id = 26},
  [27] = {logic_id = 27},
  [28] = {event_show = false, logic_id = 28},
  [30] = {logic_id = 30},
  [31] = {logic_id = 31},
  [36] = {logic_id = 36},
  [37] = {event_show = false, logic_id = 37},
  [39] = {logic_id = 39},
  [41] = {event_show = false, logic_id = 41},
  [42] = {event_show = false, logic_id = 42},
  [43] = {event_show = false, logic_id = 43},
  [44] = {event_show = false, logic_id = 44},
  [45] = {logic_id = 45},
  [46] = {logic_id = 46},
  [47] = {event_show = false, logic_id = 47},
  [48] = {logic_id = 48},
  [49] = {logic_id = 49},
  [50] = {logic_id = 50},
  [51] = {logic_id = 51},
  [52] = {logic_id = 52},
  [53] = {logic_id = 53},
  [54] = {logic_id = 54},
  [55] = {logic_id = 55},
  [56] = {logic_id = 56},
  [57] = {logic_id = 57},
  [58] = {logic_id = 58},
  [59] = {logic_id = 59},
  [60] = {logic_id = 60},
  [62] = {logic_id = 62},
  [63] = {logic_id = 63},
  [64] = {logic_id = 64},
  [65] = {logic_id = 65},
  [66] = {logic_id = 66},
  [67] = {logic_id = 67},
  [68] = {logic_id = 68},
  [69] = {logic_id = 69},
  [70] = {logic_id = 70},
  [71] = {logic_id = 71},
  [72] = {logic_id = 72},
  [73] = {logic_id = 73}
}
local __default_values = {event_show = true, logic_id = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(exploration_buff_logic) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_buff_logic, {__index = __rawdata})
return exploration_buff_logic
