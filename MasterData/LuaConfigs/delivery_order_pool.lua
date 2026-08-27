local delivery_order_pool = {
  {},
  {
    order_id_list = {
      20,
      21,
      22
    },
    pool_id = 2,
    weight_value_list = {
      60,
      30,
      30
    }
  },
  {
    cd_time = 15,
    first_cd_time = 10,
    order_id_list = {
      30,
      31,
      32,
      33
    },
    pool_id = 3,
    weight_value_list = {
      50,
      50,
      30,
      30
    }
  }
}
local __default_values = {
  cd_time = 8,
  first_cd_time = 6,
  order_id_list = {10, 11},
  pool_id = 1,
  weight_value_list = {40, 30}
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(delivery_order_pool) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(delivery_order_pool, {__index = __rawdata})
return delivery_order_pool
