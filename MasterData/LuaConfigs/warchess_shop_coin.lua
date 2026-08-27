local __rt_1 = {
  25,
  50,
  80
}
local __rt_2 = {
  50,
  100,
  160
}
local __rt_3 = {
  15,
  30,
  54
}
local __rt_4 = {
  50,
  100,
  180
}
local warchess_shop_coin = {
  {
    discard_scale = 500,
    discount_scale = 500,
    function_over_payback = __rt_1
  },
  {
    discard_scale = 500,
    discount_scale = 500,
    function_over_payback = __rt_1,
    id = 2
  },
  {
    function_over_payback = {
      15,
      30,
      50
    },
    id = 3
  },
  {
    buy_rare = 80,
    function_price = __rt_4,
    id = 4
  },
  {
    buy_rare = 80,
    function_price = __rt_4,
    id = 5
  },
  {
    buy_rare = 80,
    function_price = __rt_4,
    id = 6
  }
}
local __default_values = {
  battle_times_limit = 3,
  buy_rare = 60,
  buy_rare_increase = 0,
  discard_scale = 300,
  discount_scale = 300,
  function_over_payback = __rt_3,
  function_price = __rt_2,
  id = 1,
  increase_fresh_price = 15,
  init_fresh_price = 0,
  item1 = 13
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_shop_coin) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_shop_coin, {__index = __rawdata})
return warchess_shop_coin
