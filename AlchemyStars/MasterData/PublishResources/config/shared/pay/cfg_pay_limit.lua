local key = {
  ID = 1,
  AgeDes = 2,
  LimitDes = 3,
  AgeBegin = 4,
  AgeEnd = 5,
  LimitCount = 6
}
local config = {
  {
    1,
    "str_pay_age_under16",
    "str_pay_age_under16_des",
    0,
    15,
    100
  },
  {
    2,
    "str_pay_age_between_16_20",
    "str_pay_age_between_16_20_des",
    16,
    19,
    1000
  },
  {
    3,
    "str_pay_age_above_20",
    "str_pay_age_above_20_des",
    20,
    999,
    0
  }
}
return config, "ID", key
