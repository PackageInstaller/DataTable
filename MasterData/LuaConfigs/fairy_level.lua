local fairy_level = {
  {exp = 50},
  {exp = 80, level = 2},
  {exp = 110, level = 3},
  {exp = 140, level = 4},
  {exp = 170, level = 5},
  {exp = 210, level = 6},
  {exp = 250, level = 7},
  {exp = 290, level = 8},
  {exp = 330, level = 9},
  {exp = 370, level = 10},
  {exp = 420, level = 11},
  {exp = 470, level = 12},
  {exp = 520, level = 13},
  {exp = 580, level = 14},
  {exp = 640, level = 15},
  {exp = 700, level = 16},
  {exp = 770, level = 17},
  {exp = 840, level = 18},
  {exp = 920, level = 19},
  {level = 20},
  {exp = 1090, level = 21},
  {exp = 1180, level = 22},
  {exp = 1280, level = 23},
  {exp = 1380, level = 24},
  {exp = 1490, level = 25},
  {exp = 1600, level = 26},
  {exp = 1720, level = 27},
  {exp = 1850, level = 28},
  {exp = 1990, level = 29},
  {exp = 2130, level = 30},
  {exp = 2280, level = 31},
  {exp = 2440, level = 32},
  {exp = 2610, level = 33},
  {exp = 2790, level = 34},
  {exp = 2980, level = 35},
  {exp = 3180, level = 36},
  {exp = 3400, level = 37},
  {exp = 3630, level = 38},
  {exp = 3870, level = 39},
  {exp = 4230, level = 40},
  {exp = 4710, level = 41},
  {exp = 5320, level = 42},
  {exp = 6060, level = 43},
  {exp = 6950, level = 44},
  {exp = 7990, level = 45},
  {exp = 9190, level = 46},
  {exp = 10570, level = 47},
  {exp = 12130, level = 48},
  {exp = 13880, level = 49},
  {exp = 999999, level = 50}
}
local __default_values = {exp = 1000, level = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(fairy_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(fairy_level, {__index = __rawdata})
return fairy_level
