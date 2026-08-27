local __rt_1 = {1, 2}
local __rt_2 = {2}
local __rt_3 = {"5002"}
local delivery_buff = {
  {
    buff_time = 5,
    buff_type = 1,
    feature_value = {0.5, 0.8},
    icon = "buff_speedUp",
    name = 512149,
    perform_value_dic = {"5001"}
  },
  {
    des = 477194,
    feature_value = {-0.5, -1},
    id = 2
  },
  {
    des = 415617,
    id = 3,
    name = 440984
  }
}
local __default_values = {
  buff_time = -1,
  buff_type = 2,
  conflict_type = 0,
  des = 279968,
  feature = __rt_1,
  feature_value = {-0.5, -0.8},
  icon = "buff_speedDown",
  id = 1,
  is_show = true,
  name = 111467,
  perform_type_list = __rt_2,
  perform_value_dic = __rt_3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(delivery_buff) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(delivery_buff, {__index = __rawdata})
return delivery_buff
