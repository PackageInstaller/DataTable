local activity_blackhole_main = {
  {
    buffrule_des = 7510,
    rank_id = 45,
    rule_des = 7509
  },
  {
    buffrule_des = 7512,
    id = 2,
    rule_des = 7511
  },
  {
    buffrule_des = 7514,
    id = 3,
    rule_des = 7513
  },
  {
    buffrule_des = 7516,
    id = 4,
    rule_des = 7515
  },
  {
    buffrule_des = 7518,
    id = 5,
    rule_des = 7517
  },
  {id = 6},
  {
    buffrule_des = 7522,
    id = 7,
    rule_des = 7521
  },
  {id = 8}
}
local __default_values = {
  buffrule_des = 7520,
  id = 1,
  rank_id = 0,
  rule_des = 7519,
  rule_title = 7508
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_blackhole_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_blackhole_main, {__index = __rawdata})
return activity_blackhole_main
