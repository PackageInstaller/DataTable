local player_familyName = {
  {family_name = 94672},
  {family_name = 119549, id = 2},
  {family_name = 348640, id = 3},
  {family_name = 207418, id = 4},
  {family_name = 368356, id = 5},
  {family_name = 251417, id = 6},
  {family_name = 474932, id = 7},
  {family_name = 153993, id = 8},
  {family_name = 427329, id = 9},
  {family_name = 501742, id = 10},
  {family_name = 358270, id = 11},
  {family_name = 225084, id = 12},
  {family_name = 34475, id = 13},
  {family_name = 96895, id = 14},
  {family_name = 143850, id = 15},
  {family_name = 196319, id = 16},
  {family_name = 461103, id = 17},
  {family_name = 93929, id = 18},
  {family_name = 373571, id = 19},
  {family_name = 258014, id = 20},
  {family_name = 133748, id = 21},
  {family_name = 335279, id = 22},
  {family_name = 344198, id = 23},
  {family_name = 153243, id = 24},
  {family_name = 166693, id = 25},
  {family_name = 19482, id = 26},
  {family_name = 66921, id = 27},
  {family_name = 240926, id = 28},
  {family_name = 517949, id = 29},
  {family_name = 42160, id = 30},
  {family_name = 17833, id = 31},
  {family_name = 509396, id = 32},
  {id = 33},
  {family_name = 36080, id = 34},
  {family_name = 213446, id = 35},
  {family_name = 196927, id = 36}
}
local __default_values = {family_name = 109544, id = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(player_familyName) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(player_familyName, {__index = __rawdata})
return player_familyName
