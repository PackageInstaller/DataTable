local key = {
  ID = 1,
  ComponentID = 2,
  Level = 3,
  Rounds = 4,
  Music = 5,
  Dance = 6,
  Perform = 7,
  TrainContent = 8,
  TrainResultA = 9,
  TrainResultB = 10
}
local common = {
  {
    "str_n25_idol_y_lesson_1",
    "str_n25_idol_y_lesson_4",
    "str_n25_idol_y_lesson_7"
  },
  {
    "str_n25_idol_y_lesson_2_learn",
    "str_n25_idol_y_lesson_5_learn",
    "str_n25_idol_y_lesson_8_learn"
  },
  {
    "str_n25_idol_y_lesson_1_desc",
    "str_n25_idol_y_lesson_4_desc",
    "str_n25_idol_y_lesson_7_desc"
  },
  {
    "str_n25_idol_y_lesson_2",
    "str_n25_idol_y_lesson_5",
    "str_n25_idol_y_lesson_8"
  },
  {
    "str_n25_idol_y_lesson_2_desc",
    "str_n25_idol_y_lesson_5_desc",
    "str_n25_idol_y_lesson_8_desc"
  },
  {
    "str_n25_idol_y_lesson_3",
    "str_n25_idol_y_lesson_6",
    "str_n25_idol_y_lesson_9"
  },
  {
    "str_n25_idol_y_lesson_3_learn",
    "str_n25_idol_y_lesson_6_learn",
    "str_n25_idol_y_lesson_9_learn"
  },
  {
    "str_n25_idol_y_lesson_3_desc",
    "str_n25_idol_y_lesson_6_desc",
    "str_n25_idol_y_lesson_9_desc"
  }
}
local config = {
  {
    1,
    107610808,
    1,
    0,
    200,
    200,
    200,
    common[1],
    common[2],
    common[3]
  },
  {
    2,
    107610808,
    2,
    5,
    220,
    220,
    220,
    common[4],
    common[2],
    common[5]
  },
  {
    3,
    107610808,
    3,
    9,
    240,
    240,
    240,
    common[6],
    common[7],
    common[8]
  },
  {
    4,
    121210808,
    1,
    0,
    200,
    200,
    200,
    common[1],
    common[2],
    common[3]
  },
  {
    5,
    121210808,
    2,
    3,
    220,
    220,
    220,
    common[4],
    common[2],
    common[5]
  },
  {
    6,
    121210808,
    3,
    6,
    240,
    240,
    240,
    common[6],
    common[7],
    common[8]
  }
}
return config, "ID", key
