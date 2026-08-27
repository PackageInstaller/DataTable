local activity_white_day_event = {
  {},
  {id = 2},
  {id = 3}
}
local __default_values = {event_des = 385732, id = 1}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_white_day_event) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  taskId2TypeDic = {
    [8200] = 1,
    [8201] = 1,
    [8202] = 1,
    [8203] = 1,
    [8204] = 1,
    [8205] = 1,
    [8206] = 1,
    [8207] = 1,
    [8208] = 1,
    [8209] = 1,
    [8359] = 3,
    [8360] = 3,
    [8361] = 3,
    [8362] = 3,
    [8363] = 3,
    [8364] = 3,
    [8365] = 3,
    [8366] = 3,
    [8367] = 3,
    [8368] = 3,
    [9200] = 2,
    [9201] = 2,
    [9202] = 2,
    [9203] = 2,
    [9204] = 2,
    [9205] = 2,
    [9206] = 2,
    [9207] = 2,
    [9208] = 2,
    [9209] = 2
  }
}
setmetatable(activity_white_day_event, {__index = __rawdata})
return activity_white_day_event
