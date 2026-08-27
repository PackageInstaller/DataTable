local activity_answer_main = {
  {},
  {
    id = 2,
    rule_des = 7807,
    tips_id = 7805
  },
  {
    id = 3,
    rule_des = 7807,
    tips_id = 7806
  },
  {id = 4},
  {
    id = 5,
    rule_des = 7808,
    tips_id = 7809
  },
  {id = 6}
}
local __default_values = {
  id = 1,
  rule_des = 7801,
  rule_title = 7800,
  tips_id = 7802,
  wrong_cd = 3
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_answer_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_answer_main, {__index = __rawdata})
return activity_answer_main
