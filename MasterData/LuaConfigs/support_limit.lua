local support_limit = {
  {is_limited = true},
  {id = 2},
  {id = 3},
  {id = 4},
  {id = 5},
  {id = 6},
  {id = 7, is_open = false},
  {id = 8},
  [10] = {id = 10, is_open = false},
  [11] = {id = 11, is_open = false},
  [12] = {id = 12, is_open = false},
  [18] = {id = 18},
  [22] = {id = 22},
  [27] = {id = 27},
  [10001] = {id = 10001, is_open = false},
  [10002] = {id = 10002, is_open = false},
  [10003] = {id = 10003, is_open = false},
  [10004] = {id = 10004},
  [10005] = {id = 10005},
  [10006] = {id = 10006, is_open = false},
  [10007] = {id = 10007},
  [10008] = {id = 10008},
  [10009] = {id = 10009, is_open = false}
}
local __default_values = {
  id = 1,
  is_limited = false,
  is_open = true
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(support_limit) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(support_limit, {__index = __rawdata})
return support_limit
