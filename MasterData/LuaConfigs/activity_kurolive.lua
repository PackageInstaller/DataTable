local activity_kurolive = {
  {}
}
local __default_values = {
  gift_name = 164280,
  icon = "Icon_0",
  id = 1,
  mystery_gift = 0,
  story_id = 5500101,
  task_rule_id = 55002,
  task_rule_title = 55001
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_kurolive) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_kurolive, {__index = __rawdata})
return activity_kurolive
