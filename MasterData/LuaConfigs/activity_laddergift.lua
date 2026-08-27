local __rt_1 = {
  373,
  374,
  375
}
local activity_laddergift = {
  {
    activity_name = 433385,
    group_id = {
      319,
      320,
      321
    },
    reward_des = 221202,
    reward_pic = "LadderGift_BG1",
    reward_tips = 273988,
    skin_id = 306703
  },
  {
    activity_name = 215875,
    group_id = {
      339,
      340,
      341,
      342,
      343
    },
    id = 2,
    is_pop = false,
    pop_time = 0,
    reward_des = 495300,
    reward_pic = "LadderGift_BG2",
    reward_tips = 78433,
    skin_id = 0
  },
  {id = 3},
  {
    activity_name = 19511,
    group_id = {
      427,
      428,
      429
    },
    id = 4,
    reward_des = 89477,
    reward_pic = "LadderGift_BG4",
    skin_id = 305807
  },
  {id = 5},
  {
    activity_name = 17790,
    group_id = {
      482,
      483,
      484
    },
    id = 6,
    reward_des = 89862,
    reward_pic = "LadderGift_BG5",
    skin_id = 303708
  }
}
local __default_values = {
  activity_name = 9674,
  group_id = __rt_1,
  id = 1,
  is_pop = true,
  pop_time = 259200,
  reward_des = 131282,
  reward_pic = "LadderGift_BG3",
  reward_tips = 199136,
  skin_id = 307104,
  tip_des = 104897
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_laddergift) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_laddergift, {__index = __rawdata})
return activity_laddergift
