local hero_vow_no_audio = {
  [1076] = {},
  [1077] = {hero_id = 1077},
  [1078] = {hero_id = 1078}
}
local __default_values = {hero_id = 1076}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(hero_vow_no_audio) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(hero_vow_no_audio, {__index = __rawdata})
return hero_vow_no_audio
