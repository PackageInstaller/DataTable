local activity_explore_main = {
  {}
}
local __default_values = {
  group_id = {1, 2},
  id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_explore_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_explore_main, {__index = __rawdata})
return activity_explore_main
