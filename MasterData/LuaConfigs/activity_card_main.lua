local __rt_1 = {
  1,
  2,
  3,
  4,
  5
}
local __rt_2 = {}
local __rt_3 = {4}
local __rt_4 = {41}
local __rt_5 = {
  6,
  7,
  8,
  9,
  10
}
local __rt_6 = {39007}
local activity_card_main = {
  {
    pre_para1 = {1695888000},
    pre_para2 = {1697702399},
    rank_diff = {
      7,
      8,
      9
    },
    rank_unlock_condition = {12},
    resource_item_id = {1079, 39005},
    tickets_id = 39005,
    tips_id = 58
  },
  {
    id = 2,
    rank_id = 66,
    resource_item_id = {1087, 39007},
    revert_pre_para1 = {36002},
    reward_item_id = 1087,
    tips_id = 58
  },
  {
    id = 3,
    rank_id = 75,
    revert_pre_para1 = {36003},
    reward_bp_id = 1,
    reward_item_id = 1260
  },
  {
    id = 4,
    rank_id = 87,
    revert_pre_para1 = {36004},
    reward_bp_id = 2,
    reward_item_id = 1265
  },
  {
    id = 5,
    rank_id = 95,
    revert_pre_para1 = {36005},
    reward_bp_id = 3,
    reward_item_id = 1286
  }
}
local __default_values = {
  dungeon_id = 50001,
  guide_id = 700001,
  id = 1,
  normal_diff = __rt_1,
  pre_para1 = __rt_2,
  pre_para2 = __rt_2,
  pre_para3 = __rt_2,
  rank_diff = __rt_5,
  rank_id = 44,
  rank_unlock_condition = __rt_2,
  resource_item_id = __rt_6,
  revert_pre_para1 = {36001},
  revert_pre_para2 = __rt_3,
  revert_pre_para3 = __rt_2,
  revert_unlock_condition = __rt_4,
  reward_bp_id = 0,
  reward_item_id = 1079,
  score_item_id = 39003,
  tickets_id = 39007,
  tickets_num = 1,
  timed_tickets_id = 39006,
  timed_tickets_num = 1,
  tips_id = 66
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_card_main) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  cardRankId2ActIdMap = {
    [44] = 1,
    [66] = 2,
    [75] = 3,
    [87] = 4,
    [95] = 5
  }
}
setmetatable(activity_card_main, {__index = __rawdata})
return activity_card_main
