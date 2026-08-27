local __rt_1 = {1002}
local __rt_2 = {1000}
local __rt_3 = {}
local month_card = {
  {
    daily_award_nums = {80},
    discount_price = 100002,
    first_award_nums = {300}
  },
  {
    duration_days = 7,
    first_award_nums = {450},
    id = 2,
    max_days = 7,
    popup_id = 41,
    pre_condition = {34},
    pre_para1 = {-1},
    pre_para2 = {1692287999},
    price = 100003,
    remind_time = 3
  },
  {
    daily_award_ids = {1007},
    daily_award_nums = {200},
    first_award_ids = {5010},
    id = 3,
    price = 100538,
    privilege_id = {
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    },
    rule_id = 19
  }
}
local __default_values = {
  daily_award_ids = __rt_1,
  daily_award_nums = {150},
  discount_price = 0,
  duration_days = 30,
  first_award_ids = __rt_2,
  first_award_nums = {2},
  id = 1,
  max_days = 60,
  pay_item = __rt_3,
  pay_type = 0,
  popup_id = 0,
  pre_condition = __rt_3,
  pre_para1 = __rt_3,
  pre_para2 = __rt_3,
  price = 100001,
  privilege_id = __rt_3,
  remind_time = 5,
  rule_id = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(month_card) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(month_card, {__index = __rawdata})
return month_card
