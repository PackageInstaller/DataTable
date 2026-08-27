local __rt_1 = {
  1,
  5,
  10,
  -1
}
local __rt_2 = {
  500,
  500,
  500,
  500
}
local exploration_shop = {
  {},
  {id = 2},
  {id = 3},
  {id = 4},
  {id = 5},
  {id = 6},
  {
    discount_level = {
      1,
      2,
      3,
      -1
    },
    discount_scale = {
      1000,
      500,
      334,
      334
    },
    id = 7
  },
  {id = 8},
  {id = 9},
  {id = 10, increase_fresh_price = 10}
}
local __default_values = {
  currency = 1,
  discount_level = __rt_1,
  discount_scale = __rt_2,
  id = 1,
  increase_fresh_price = 5,
  init_fresh_price = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(exploration_shop) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(exploration_shop, {__index = __rawdata})
return exploration_shop
