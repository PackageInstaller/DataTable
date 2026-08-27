local __rt_1 = {
  5,
  5,
  5
}
local __rt_2 = {
  0,
  2,
  4,
  8,
  15
}
local __rt_3 = {
  1,
  6,
  9,
  12,
  15,
  19,
  -1
}
local __rt_4 = {
  0,
  1,
  2,
  3,
  5,
  15,
  30
}
local warchess_shop_rare = {
  {
    upgrade_level = {
      1,
      5,
      6,
      7,
      -1
    },
    upgrade_scale = __rt_2
  },
  {
    id = 2,
    upgrade_level = {
      1,
      7,
      8,
      9,
      -1
    },
    upgrade_scale = __rt_2
  },
  {id = 3},
  {buy_coin = 60, id = 4},
  {
    buy_coin = 60,
    id = 5,
    upgrade_level = {
      1,
      9,
      11,
      13,
      15,
      20,
      -1
    }
  },
  {
    buy_coin = 60,
    id = 6,
    upgrade_level = {
      1,
      9,
      11,
      13,
      15,
      17,
      20,
      -1
    },
    upgrade_scale = {
      0,
      1,
      2,
      3,
      5,
      8,
      15,
      30
    }
  }
}
local __default_values = {
  buff_price = __rt_1,
  buy_coin = 40,
  buy_coin_decrease = 0,
  id = 1,
  item2 = 12,
  upgrade_level = __rt_3,
  upgrade_scale = __rt_4
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_shop_rare) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_shop_rare, {__index = __rawdata})
return warchess_shop_rare
