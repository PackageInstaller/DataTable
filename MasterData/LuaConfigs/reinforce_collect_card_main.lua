local reinforce_collect_card_main = {
  {}
}
local __default_values = {
  activity_id = 59001,
  collect_guide_id = 5900105,
  collect_name = 23041,
  collect_rule = 27,
  id = 1,
  star_score1 = 1,
  star_score2 = 3,
  star_score3 = 6
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(reinforce_collect_card_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(reinforce_collect_card_main, {__index = __rawdata})
return reinforce_collect_card_main
