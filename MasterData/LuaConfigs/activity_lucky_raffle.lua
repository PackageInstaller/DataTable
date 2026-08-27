local __rt_1 = {
  1012,
  8205,
  6003,
  1003,
  8231,
  1502
}
local __rt_2 = {
  5000,
  5,
  1,
  5000,
  1,
  1
}
local activity_lucky_raffle = {
  {
    {
      normal_raffle_image1 = "LuckyRaffle_2_6",
      normal_raffle_info1 = 88031,
      raffle_name = 405126,
      raffle_text = 265121,
      raffle_tip = 243701,
      super_raffle_image = "LuckyRaffle_1_2",
      super_raffle_info = 347401,
      super_raffle_name = 508379
    },
    {
      normal_raffle_image1 = "LuckyRaffle_2_5",
      normal_raffle_info1 = 314877,
      normal_raffle_num1 = 180780,
      raffle_id = 2,
      raffle_name = 380154,
      raffle_text = 265121,
      raffle_tip = 243701,
      super_raffle_image = "LuckyRaffle_1_5",
      super_raffle_info = 4917,
      super_raffle_name = 436349
    },
    {
      normal_raffle_image1 = "LuckyRaffle_2_2",
      normal_raffle_name1 = "G11",
      raffle_id = 3,
      super_raffle_name = 513947
    },
    {
      normal_raffle_image1 = "LuckyRaffle_2_3",
      normal_raffle_name1 = "UMP9",
      raffle_id = 4,
      raffle_name = 443995,
      super_raffle_image = "LuckyRaffle_1_3",
      super_raffle_info = 484202
    },
    {
      normal_raffle_name1 = "UMP45",
      raffle_id = 5,
      raffle_name = 237450,
      super_raffle_image = "LuckyRaffle_1_4",
      super_raffle_info = 174164,
      super_raffle_name = 41964
    },
    {
      normal_raffle_image1 = "LuckyRaffle_2_4",
      normal_raffle_name1 = 254460,
      raffle_id = 6,
      raffle_name = 488119,
      super_raffle_image = "LuckyRaffle_1_6",
      super_raffle_info = 466010,
      super_raffle_name = 269885
    }
  }
}
local __default_values = {
  activity_id = 1,
  all_reward_ids = __rt_1,
  all_reward_nums = __rt_2,
  normal_raffle_image1 = "LuckyRaffle_2_1",
  normal_raffle_image2 = "LuckyRaffle_3",
  normal_raffle_info1 = 24446,
  normal_raffle_info2 = 370261,
  normal_raffle_name1 = 139228,
  normal_raffle_name2 = 359788,
  normal_raffle_num1 = 291748,
  normal_raffle_num2 = 430155,
  normal_raffle_text1 = 51841,
  normal_raffle_text2 = 270964,
  raffle_id = 1,
  raffle_item = 1231,
  raffle_name = 16768,
  raffle_text = 77253,
  raffle_tip = 342591,
  super_raffle_image = "LuckyRaffle_1_1",
  super_raffle_info = "I+II",
  super_raffle_name = 118374,
  super_raffle_num = 456292,
  super_raffle_text = 165703
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_lucky_raffle) do
  for k1, v1 in pairs(v) do
    setmetatable(v1, base)
  end
end
local __rawdata = {
  __basemetatable = base,
  starItemDic = {
    {
      [1231] = true
    }
  }
}
setmetatable(activity_lucky_raffle, {__index = __rawdata})
return activity_lucky_raffle
