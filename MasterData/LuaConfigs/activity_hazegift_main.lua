local activity_hazegift_main = {
  {}
}
local __default_values = {
  activity_des = 7910,
  hero_id = 1046,
  id = 1,
  score_id = 1244,
  shop_id = 706,
  task_rule_id = 7909,
  task_rule_title = 7908
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_hazegift_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_hazegift_main, {__index = __rawdata})
return activity_hazegift_main
