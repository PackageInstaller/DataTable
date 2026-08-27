local __rt_1 = {
  3755,
  3185,
  2450,
  0
}
local __rt_2 = {
  4950,
  2750,
  2200,
  0
}
local hero_score = {
  {attribute_id = 103, attribute_name = 219873},
  {
    attribute_id = 104,
    attribute_name = 420609,
    id = 2,
    score = __rt_2,
    sortId = 4,
    upper_limit = 5500
  },
  {
    attribute_id = 127,
    attribute_name = 43180,
    id = 3,
    score = __rt_2,
    sortId = 5,
    upper_limit = 5500
  },
  {
    id = 4,
    score = {
      130000,
      96000,
      80000,
      0
    },
    sortId = 3,
    upper_limit = 160000
  },
  {
    attribute_id = 126,
    attribute_name = 3859,
    id = 5,
    sortId = 2
  }
}
local __default_values = {
  attribute_id = 102,
  attribute_name = 132428,
  id = 1,
  score = __rt_1,
  sortId = 1,
  upper_limit = 4900
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(hero_score) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(hero_score, {__index = __rawdata})
return hero_score
