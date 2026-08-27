local __rt_1 = {1}
local activity_hallowmas_main = {
  {cir_des = 53939},
  {
    cir_reward_ids = {8228},
    env_id = {
      1,
      2,
      3
    },
    first_avg = 2200131,
    first_guide = 40201,
    guide_id = 32,
    id = 2,
    score_buy_time = 1702712834,
    score_token = 1211,
    story_stage = 220013,
    task_daily_releast = 2,
    task_limit = 8,
    task_time = 1671696000,
    tech_id = 5,
    tech_special_branch = 12,
    warchess_season_id = 2
  }
}
local __default_values = {
  ban_guide_tip = 8704,
  cir_des = 115743,
  cir_reward_ids = {8227},
  cir_reward_nums = __rt_1,
  clear_tip = 8701,
  daily_task_refresh_max = 1,
  env_id = {0},
  first_avg = 2200101,
  first_guide = 40101,
  guide_id = 29,
  guide_stage = 220012,
  id = 1,
  max_save = 3,
  score_buy_time = 1668632400,
  score_daily_limit = 2400,
  score_limit_tip = 9,
  score_token = 1206,
  story_stage = 220011,
  task_daily_releast = 1,
  task_limit = 3,
  task_rule_id = 9,
  task_time = 1668067200,
  tech_id = 0,
  tech_special_branch = 0,
  warchess_season_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_hallowmas_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_hallowmas_main, {__index = __rawdata})
return activity_hallowmas_main
