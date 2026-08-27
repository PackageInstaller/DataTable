local __rt_1 = {15, 25}
local ath_affix_lv = {
  {exp = 60},
  {
    exp = 70,
    level = 2,
    promote = 1600
  },
  {
    exp = 80,
    level = 3,
    promote = 2300
  },
  {
    exp = 90,
    level = 4,
    promote = 3100
  },
  {
    exp = 100,
    level = 5,
    promote = 4000
  },
  {level = 6, promote = 5000}
}
local __default_values = {
  base_section = __rt_1,
  base_success = 10000,
  density = 20,
  exp = -1,
  level = 1,
  promote = 1000,
  unit_section = 4
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(ath_affix_lv) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base, maxAffixLevel = 6}
setmetatable(ath_affix_lv, {__index = __rawdata})
return ath_affix_lv
