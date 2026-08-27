local activity_general_gift_item = {
  [50001] = {}
}
local __default_values = {
  activity_id = 50001,
  gift_limit = 5,
  gift_send_reward = {
    [8103] = 1
  },
  item_receive = {
    1252,
    1253,
    1254,
    1255,
    1256
  },
  item_send = {
    1247,
    1248,
    1249,
    1250,
    1251
  },
  waiting_limit = 20
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_general_gift_item) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_general_gift_item, {__index = __rawdata})
return activity_general_gift_item
