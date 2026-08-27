local delivery_goods_spawn = {
  {price = 10, replenishment_time = 10},
  {
    goods_spawn_id = 2,
    price = 10,
    replenishment_time = 10
  },
  [100] = {
    goods_spawn_id = 100,
    price = 10,
    replenishment_time = 12
  },
  [101] = {
    goods_spawn_id = 101,
    icon = "Goods_101",
    price = 15,
    replenishment_time = 10
  },
  [102] = {
    goods_spawn_id = 102,
    icon = "Goods_102",
    price = 50,
    replenishment_time = 12
  },
  [103] = {
    goods_spawn_id = 103,
    icon = "Goods_103",
    price = 50,
    replenishment_time = 12
  },
  [104] = {goods_spawn_id = 104, icon = "Goods_104"},
  [105] = {goods_spawn_id = 105, icon = "Goods_105"},
  [106] = {
    goods_spawn_id = 106,
    icon = "Goods_106",
    price = 50,
    replenishment_time = 12
  },
  [107] = {
    goods_spawn_id = 107,
    icon = "Goods_107",
    price = 80
  },
  [108] = {goods_spawn_id = 108, icon = "Goods_108"},
  [109] = {goods_spawn_id = 109, icon = "Goods_109"}
}
local __default_values = {
  goods_spawn_id = 1,
  icon = "Goods_100",
  price = 30,
  replenishment_time = 15,
  weight = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(delivery_goods_spawn) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(delivery_goods_spawn, {__index = __rawdata})
return delivery_goods_spawn
