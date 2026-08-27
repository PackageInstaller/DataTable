local sector_career_info = {
  {info = 497680},
  {id = 2, info = 21221},
  {id = 3, info = 165705},
  {id = 4, info = 271090},
  {id = 5},
  {id = 6, info = 181876},
  {id = 7, info = 27731},
  {id = 8, info = 168285},
  {id = 9, info = 281603},
  {id = 10, info = 377032},
  {id = 11, info = 237259},
  {id = 12, info = 241018},
  [101] = {id = 101, info = 415353},
  [102] = {id = 102, info = 328718},
  [103] = {id = 103, info = 425942},
  [104] = {id = 104, info = 214248},
  [105] = {id = 105, info = 230936},
  [202] = {id = 202, info = 408966},
  [203] = {id = 203, info = 73542},
  [1031] = {id = 1031, info = 174558},
  [1041] = {id = 1041, info = 84205},
  [1042] = {id = 1042, info = 28822}
}
local __default_values = {id = 1, info = 164683}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_career_info) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_career_info, {__index = __rawdata})
return sector_career_info
