local audio_category = {
  {},
  {
    aisac = "SFX",
    category = "SFX",
    id = 2
  },
  {
    aisac = "Voice",
    category = "Voice",
    id = 3
  }
}
local __default_values = {
  aisac = "Music",
  category = "Music",
  id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(audio_category) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(audio_category, {__index = __rawdata})
return audio_category
