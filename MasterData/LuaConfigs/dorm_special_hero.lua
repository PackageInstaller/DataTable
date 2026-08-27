local dorm_special_hero = {
  {}
}
local __default_values = {
  ai_id = 1001,
  dorm_move_spd = 0.9,
  greet_action = "Dorm_Talk",
  id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dorm_special_hero) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_special_hero, {__index = __rawdata})
return dorm_special_hero
