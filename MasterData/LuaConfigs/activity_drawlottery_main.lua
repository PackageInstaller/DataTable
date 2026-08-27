local __rt_1 = {
  bgPosX = 67,
  bgPosY = -130,
  live2dPosX = 246,
  live2dPosY = 222
}
local activity_drawlottery_main = {
  {},
  {
    activity_des = 7927,
    id = 2,
    lottery_exclude = 171,
    score_id = 1284,
    task_rule_id = 7926
  }
}
local __default_values = {
  activity_des = 7913,
  hero_id = 1016,
  id = 1,
  lottery_exclude = 0,
  mail_id = 191,
  posData = __rt_1,
  score_id = 1245,
  skin_id = 301605,
  skin_type = 2,
  task_rule_id = 7912,
  task_rule_title = 7911,
  task_type = 1940,
  title = 499585
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_drawlottery_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_drawlottery_main, {__index = __rawdata})
return activity_drawlottery_main
