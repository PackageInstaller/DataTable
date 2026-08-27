local activity_mashup_main = {
  {}
}
local __default_values = {
  activity_id = 1,
  final_award = 420032,
  rule_des = 24011,
  rule_title = 24010,
  task_id = 19028
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_mashup_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_mashup_main, {__index = __rawdata})
return activity_mashup_main
