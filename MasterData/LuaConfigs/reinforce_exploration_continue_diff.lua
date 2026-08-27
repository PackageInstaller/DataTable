local __rt_1 = {}
local reinforce_exploration_continue_diff = {
  [59001] = {
    {base_combat = 6000, des_tex = 289986},
    {
      combat_bonus = 13,
      diff_id = 2,
      difficulty_name = "02",
      infinite_coe = 40,
      stage_id = 590013102
    },
    {
      base_combat = 45000,
      combat_bonus = 16,
      des_tex = 185601,
      diff_id = 3,
      difficulty_name = "03",
      infinite_coe = 80,
      stage_id = 590013103
    },
    {
      base_combat = 65000,
      combat_bonus = 18,
      des_tex = 494962,
      diff_id = 4,
      difficulty_name = "04",
      infinite_coe = 130,
      stage_id = 590013104
    },
    {
      base_combat = 75000,
      combat_bonus = 20,
      des_tex = 72433,
      diff_id = 5,
      difficulty_name = "05",
      infinite_coe = 145,
      pre_condition = {3},
      pre_para1 = {590013104},
      stage_id = 590013105
    }
  }
}
local __default_values = {
  base_combat = 25000,
  chip_id = 1,
  combat_bonus = 10,
  des_tex = 183460,
  diff_id = 1,
  difficulty_name = "01",
  id = 59001,
  infinite_coe = 10,
  pre_condition = __rt_1,
  pre_para1 = __rt_1,
  pre_para2 = __rt_1,
  stage_id = 590013101
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(reinforce_exploration_continue_diff) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  rfEpStageIdDic = {
    [590013101] = 59001,
    [590013102] = 59001,
    [590013103] = 59001,
    [590013104] = 59001,
    [590013105] = 59001
  }
}
setmetatable(reinforce_exploration_continue_diff, {__index = __rawdata})
return reinforce_exploration_continue_diff
