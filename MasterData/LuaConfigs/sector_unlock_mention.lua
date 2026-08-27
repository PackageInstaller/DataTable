local sector_unlock_mention = {
  [10] = {focus_priority = 2},
  [20] = {focus_priority = 5, id = 20},
  [30] = {focus_priority = 8, id = 30},
  [40] = {focus_priority = 9, id = 40},
  [50] = {focus_priority = 11, id = 50},
  [60] = {focus_priority = 12, id = 60},
  [1000] = {id = 1000},
  [1100130] = {focus_priority = 13, id = 1100130},
  [1300310] = {focus_priority = 14, id = 1300310},
  [1400210] = {focus_priority = 15, id = 1400210},
  [2500210] = {focus_priority = 16, id = 2500210},
  [3300210] = {focus_priority = 17, id = 3300210},
  [5900210] = {focus_priority = 19, id = 5900210},
  [6000710] = {focus_priority = 18, id = 6000710}
}
local __default_values = {focus_priority = 1, id = 10}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_unlock_mention) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_unlock_mention, {__index = __rawdata})
return sector_unlock_mention
