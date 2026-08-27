local __rt_1 = {}
local __rt_2 = {
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31
}
local dorm_action = {
  [1001] = {action_name = "StandWalk", type = 0},
  [1002] = {
    action_name = "Dorm_Sit",
    exit_trigger = "DormExitSit",
    final_action = "Dorm_Sit_Loop",
    id = 1002,
    interact_action_type = 5,
    interact_point_type = 1
  },
  [1003] = {
    action_name = "Dorm_Lie_Start",
    exit_trigger = "DormExitLie",
    final_action = "Dorm_Lie_Loop",
    id = 1003,
    interact_action_type = 15,
    interact_point_type = 2
  },
  [1004] = {
    action_name = "StandWalk",
    id = 1004,
    interact_point_type = 3,
    type = 3
  },
  [1005] = {
    action_name = "StandWalk2",
    id = 1005,
    type = 2
  },
  [2001] = {
    action_name = "littleManStand",
    emoji = __rt_2,
    id = 2001,
    type = 0
  },
  [2004] = {
    action_name = "littleManWalk",
    emoji = __rt_2,
    id = 2004,
    type = 2
  },
  [3001] = {
    action_name = "etj2018_deco_005",
    final_action = "etj2018_deco_005",
    id = 3001,
    interact_point_type = 4
  },
  [3002] = {
    action_name = "etj2018_deco_004",
    final_action = "etj2018_deco_004",
    id = 3002,
    interact_point_type = 5
  },
  [3003] = {
    action_name = "etj2018_deco_011",
    final_action = "etj2018_deco_011",
    id = 3003,
    interact_point_type = 6
  },
  [3004] = {
    action_name = "etj2018_deco_009",
    final_action = "etj2018_deco_009",
    id = 3004,
    interact_point_type = 7
  },
  [3005] = {
    action_name = "srt2022_drumset",
    final_action = "srt2022_drumset",
    id = 3005,
    interact_point_type = 8
  },
  [3006] = {
    action_name = "dwc2022_deco_04",
    final_action = "dwc2022_deco_04",
    id = 3006,
    interact_point_type = 9
  },
  [3007] = {
    action_name = "dwc2022_deco_05",
    final_action = "dwc2022_deco_05",
    id = 3007,
    interact_point_type = 10
  },
  [3008] = {
    action_name = "dwc2022_table_01",
    final_action = "dwc2022_table_01",
    id = 3008,
    interact_point_type = 11
  },
  [3009] = {
    action_name = "dwc2022_table_02",
    final_action = "dwc2022_table_02",
    id = 3009,
    interact_point_type = 12
  },
  [3010] = {
    action_name = "anniversary1_bar",
    final_action = "anniversary1_bar",
    id = 3010,
    interact_point_type = 13
  },
  [3011] = {
    action_name = "anniversary2_table",
    final_action = "anniversary2_table@interact_loop",
    id = 3011,
    interact_point_type = 14
  },
  [3012] = {
    action_name = "anniversary3_pool",
    final_action = "anniversary3_pool@interact_loop",
    id = 3012,
    interact_point_type = 15
  },
  [3013] = {
    action_name = "anniversary4_chair",
    final_action = "anniversary4_chair@interact_loop",
    id = 3013,
    interact_point_type = 16
  },
  [4001] = {id = 4001, type = 0},
  [4002] = {id = 4002},
  [4003] = {
    emoji = __rt_2,
    id = 4003,
    type = 2
  },
  [4004] = {
    emoji = __rt_2,
    id = 4004,
    type = 3
  },
  [4005] = {
    emoji = __rt_2,
    id = 4005,
    type = 4
  }
}
local __default_values = {
  action_name = "StandRun",
  emoji = __rt_1,
  exit_trigger = "",
  final_action = "",
  id = 1001,
  interact_action_type = 0,
  interact_point_type = 0,
  trans_time = 0.25,
  type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(dorm_action) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(dorm_action, {__index = __rawdata})
return dorm_action
