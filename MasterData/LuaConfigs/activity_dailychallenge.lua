local activity_dailychallenge = {
  {},
  {
    first_avg = 1900201,
    guide_id = 60,
    id = 2,
    infinite_des_id = 8421,
    is_infinite = true,
    last_avg = 1900202,
    name = 417991,
    support_id = 10008,
    system_id = 3901,
    unlock_item = 1085,
    unlock_item_shop = 1201
  }
}
local __default_values = {
  bg = "",
  describe = "",
  first_avg = 1900101,
  guide_id = 23,
  id = 1,
  infinite_des_id = 0,
  is_infinite = false,
  last_avg = 1900102,
  name = 391550,
  normal_des_id = 8420,
  support_id = 0,
  system_id = 3900,
  unlock_item = 1047,
  unlock_item_max = 3,
  unlock_item_shop = 1200
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_dailychallenge) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_dailychallenge, {__index = __rawdata})
return activity_dailychallenge
