local sign_minigame_text = {
  {content = 191306},
  {content = 491797, id = 2},
  {content = 361417, id = 3},
  {content = 28963, id = 4},
  {content = 284698, id = 5},
  {content = 209006, id = 6},
  {content = 232576, id = 7},
  {content = 179967, id = 8},
  {content = 155980, id = 9},
  {content = 167856, id = 10},
  {content = 181584, id = 11},
  {content = 793, id = 12},
  {content = 391236, id = 13},
  {id = 14},
  {content = 218139, id = 15}
}
local __default_values = {content = 114176, id = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sign_minigame_text) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sign_minigame_text, {__index = __rawdata})
return sign_minigame_text
