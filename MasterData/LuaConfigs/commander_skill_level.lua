local commander_skill_level = {
  {exp = 250},
  {exp = 400, skill_level = 2},
  {exp = 650, skill_level = 3},
  {exp = 850, skill_level = 4},
  {exp = 1100, skill_level = 5},
  {exp = 1450, skill_level = 6},
  {exp = 1650, skill_level = 7},
  {exp = 2050, skill_level = 8},
  {exp = 2200, skill_level = 9},
  {exp = 2450, skill_level = 10},
  {exp = 2700, skill_level = 11},
  {exp = 3100, skill_level = 12},
  {exp = 3350, skill_level = 13},
  {exp = 3750, skill_level = 14},
  {exp = 3950, skill_level = 15},
  {exp = 4200, skill_level = 16},
  {exp = 4500, skill_level = 17},
  {exp = 5050, skill_level = 18},
  {exp = 5600, skill_level = 19},
  {skill_level = 20}
}
local __default_values = {exp = 0, skill_level = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(commander_skill_level) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(commander_skill_level, {__index = __rawdata})
return commander_skill_level
