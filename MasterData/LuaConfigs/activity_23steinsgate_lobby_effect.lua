local activity_23steinsgate_lobby_effect = {
  [8] = {lobby_index = 8},
  [9] = {effect_para = 2, lobby_index = 9},
  [25] = {},
  [28] = {effect_para = 2, lobby_index = 28}
}
local __default_values = {effect_para = 1, lobby_index = 25}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_23steinsgate_lobby_effect) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_23steinsgate_lobby_effect, {__index = __rawdata})
return activity_23steinsgate_lobby_effect
