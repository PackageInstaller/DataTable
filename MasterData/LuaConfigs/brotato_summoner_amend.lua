local brotato_summoner_amend = {
  [47] = {},
  [58] = {id = 58},
  [59] = {id = 59},
  [60] = {id = 60},
  [79] = {id = 79}
}
local __default_values = {id = 47, move_speed_factor = -900}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(brotato_summoner_amend) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(brotato_summoner_amend, {__index = __rawdata})
return brotato_summoner_amend
