local fairy_skill_weight = {
  {
    name = "S",
    rate_show = 50,
    skill_level = 4
  },
  {
    rate_show = 500,
    skill_level = 3,
    skill_rarity = 2
  },
  {
    name = "B",
    skill_level = 2,
    skill_rarity = 3
  },
  {
    name = "C",
    rate_show = 7450,
    skill_rarity = 4
  }
}
local __default_values = {
  name = "A",
  rate_show = 2000,
  skill_level = 1,
  skill_rarity = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(fairy_skill_weight) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(fairy_skill_weight, {__index = __rawdata})
return fairy_skill_weight
