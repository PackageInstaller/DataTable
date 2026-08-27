local activity_divergent_hero = {
  [1071] = {}
}
local __default_values = {
  avg_id = 3700100,
  chip_num = {
    [2571] = 240
  },
  hero_id = 1071,
  test_stage = 370011
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_divergent_hero) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_divergent_hero, {__index = __rawdata})
return activity_divergent_hero
