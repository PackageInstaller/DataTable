local key = {
  ID = 1,
  Type = 2,
  Turn = 3,
  Fans = 4,
  Spine = 5,
  ConcertTitle = 6,
  BeforeStory = 7,
  AfterStory = 8,
  SuccDesc1 = 9,
  SuccDesc2 = 10,
  FailDesc1 = 11,
  FailDesc2 = 12
}
local common = {
  "n25_g_geerdi_spine_idle",
  "str_n25_idol_y_concert_succ_desc_0",
  "str_n25_idol_y_concert_fail_desc_0"
}
local config = {
  {
    1,
    1,
    7,
    100000,
    common[1],
    "str_n25_idol_y_concert_type1",
    50370201,
    50370301,
    common[2],
    "str_n25_idol_y_concert_succ_desc_1",
    common[3],
    "str_n25_idol_y_concert_fail_desc_1"
  },
  {
    2,
    1,
    14,
    180000,
    common[1],
    "str_n25_idol_y_concert_type2",
    50370401,
    50370501,
    common[2],
    "str_n25_idol_y_concert_succ_desc_2",
    common[3],
    "str_n25_idol_y_concert_fail_desc_2"
  },
  {
    3,
    2,
    21,
    0,
    common[1],
    "str_n25_idol_y_concert_type3",
    50370601,
    50370701,
    common[2],
    "str_n25_idol_y_concert_succ_desc_3"
  }
}
return config, "ID", key
