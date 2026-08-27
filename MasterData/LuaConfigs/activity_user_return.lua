local __rt_1 = {
  16,
  17,
  18
}
local __rt_2 = {1038}
local __rt_3 = {}
local __rt_4 = {1057}
local activity_user_return = {
  {inPage = 1001},
  {
    activity_avg = __rt_3,
    general_id = 2,
    id = 2,
    login_popup = 30,
    showitem_id = __rt_4,
    text_id = 2,
    window_id = 2
  },
  {
    id = 3,
    inPage = 1002,
    login_popup = 47
  },
  {
    activity_avg = __rt_3,
    general_id = 2,
    id = 4,
    login_popup = 48,
    showitem_id = __rt_4,
    text_id = 2,
    window_id = 2
  }
}
local __default_values = {
  activity_avg = __rt_1,
  general_id = 1,
  id = 1,
  inPage = 0,
  login_popup = 10,
  showitem_id = __rt_2,
  text_id = 1,
  window_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_user_return) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_user_return, {__index = __rawdata})
return activity_user_return
