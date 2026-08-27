local __rt_1 = {1, 2}
local __rt_2 = {2}
local delivery_order = {
  [10] = {expiration_time = 15, reward_num = 50},
  [11] = {
    expiration_time = 15,
    good_id_list = {100},
    good_value_list = __rt_2,
    order_id = 11,
    reward_num = 35
  },
  [20] = {
    good_id_list = {103, 105},
    order_id = 20,
    reward_num = 80
  },
  [21] = {
    good_id_list = {105},
    good_value_list = {3},
    order_id = 21
  },
  [22] = {
    good_id_list = {103},
    good_value_list = __rt_2,
    order_id = 22,
    reward_num = 60
  },
  [30] = {
    good_id_list = {107, 102},
    order_id = 30,
    reward_num = 150
  },
  [31] = {
    good_id_list = {107, 106},
    order_id = 31,
    reward_num = 150
  },
  [32] = {
    good_id_list = {102},
    good_value_list = __rt_2,
    order_id = 32
  },
  [33] = {
    good_id_list = {106},
    good_value_list = __rt_2,
    order_id = 33
  }
}
local __default_values = {
  expiration_time = 25,
  good_id_list = {100, 101},
  good_value_list = __rt_1,
  order_id = 10,
  reward_num = 100
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(delivery_order) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(delivery_order, {__index = __rawdata})
return delivery_order
