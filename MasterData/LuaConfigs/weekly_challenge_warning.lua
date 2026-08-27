local weekly_challenge_warning = {
  {warning_level = 301},
  {monster_level = 2, warning_level = 401},
  {monster_level = 3, warning_level = 501},
  {monster_level = 4, warning_level = 601},
  {monster_level = 5, warning_level = 701},
  {monster_level = 6, warning_level = 801},
  {monster_level = 7, warning_level = 901},
  {monster_level = 8}
}
local __default_values = {monster_level = 1, warning_level = 1001}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(weekly_challenge_warning) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(weekly_challenge_warning, {__index = __rawdata})
return weekly_challenge_warning
