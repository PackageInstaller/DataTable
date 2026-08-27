local activity_23steinsgate_line = {
  {id = 1},
  {digit = "16.130246", id = 2},
  {digit = "16.571024", id = 3},
  {digit = "15.523299", id = 4},
  {digit = "15.456903", id = 5},
  {digit = "15.409420", id = 6},
  [0] = {digit = "16.428596"}
}
local __default_values = {digit = "---------", id = 0}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_23steinsgate_line) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_23steinsgate_line, {__index = __rawdata})
return activity_23steinsgate_line
