local tiny_game_instrument = {
  {}
}
local __default_values = {
  id = 1,
  instru_avg = 2400322,
  instru_guide_id = 51,
  instru_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(tiny_game_instrument) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(tiny_game_instrument, {__index = __rawdata})
return tiny_game_instrument
