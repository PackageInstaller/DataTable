local key = {ID = 1, ConditionStr = 2}
local common = {
  "str_level_complete_condition_1",
  "str_level_complete_condition_2",
  "str_level_complete_condition_3",
  "str_level_complete_condition_10"
}
local config = {
  {
    1,
    common[1]
  },
  {
    2,
    common[2]
  },
  {
    3,
    common[1]
  },
  [5] = {
    5,
    common[3]
  },
  [7] = {
    7,
    "str_level_complete_condition_7"
  },
  [8] = {
    8,
    "str_level_complete_condition_8"
  },
  [9] = {
    9,
    "str_level_complete_condition_9"
  },
  [10] = {
    10,
    common[4]
  },
  [11] = {
    11,
    "str_level_complete_condition_11"
  },
  [12] = {
    12,
    "str_level_complete_condition_12"
  },
  [13] = {
    13,
    "str_level_complete_condition_13"
  },
  [14] = {
    14,
    "str_level_complete_condition_14"
  },
  [15] = {
    15,
    "str_level_complete_condition_15"
  },
  [16] = {
    16,
    common[1]
  },
  [17] = {
    17,
    common[4]
  },
  [18] = {
    18,
    common[3]
  },
  [19] = {
    19,
    "str_level_complete_condition_19"
  },
  [21] = {
    21,
    "str_level_complete_condition_21"
  },
  [22] = {
    22,
    "str_level_complete_condition_22"
  },
  [23] = {
    23,
    "str_level_complete_condition_23"
  },
  [24] = {
    24,
    "str_level_complete_condition_24"
  },
  [25] = {
    25,
    "str_level_complete_condition_25"
  },
  [27] = {
    27,
    "str_level_complete_condition_27"
  },
  [28] = {
    28,
    "str_level_complete_condition_28"
  },
  [29] = {
    29,
    "str_level_complete_condition_29"
  },
  [30] = {
    30,
    "str_level_complete_condition_30"
  },
  [31] = {
    31,
    common[2]
  }
}
return config, "ID", key
