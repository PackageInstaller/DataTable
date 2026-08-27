local offline_push = {
  {
    para1 = {
      5,
      0,
      0
    },
    para2 = 1,
    title = 316284
  },
  {
    context = 74460,
    id = 2,
    type = 2
  }
}
local __default_values = {
  context = 355328,
  id = 1,
  para1 = 1007,
  para2 = "",
  title = 164164,
  type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(offline_push) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(offline_push, {__index = __rawdata})
return offline_push
