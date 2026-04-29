local key = {
  AffinityLevel = 1,
  NeedAffintyExp = 2,
  PresentPetWeight = 3,
  Desc = 4
}
local config = {
  {
    1,
    0,
    10,
    "str_affinity_lv_1"
  },
  {
    2,
    100,
    10,
    "str_affinity_lv_2"
  },
  {
    3,
    300,
    10,
    "str_affinity_lv_3"
  },
  {
    4,
    600,
    10,
    "str_affinity_lv_4"
  },
  {
    5,
    1100,
    10,
    "str_affinity_lv_5"
  },
  {
    6,
    1700,
    10,
    "str_affinity_lv_6"
  },
  {
    7,
    2500,
    10,
    "str_affinity_lv_7"
  },
  {
    8,
    3500,
    10,
    "str_affinity_lv_8"
  },
  {
    9,
    4700,
    10,
    "str_affinity_lv_9"
  },
  {
    10,
    6200,
    10,
    "str_affinity_lv_10"
  }
}
return config, "AffinityLevel", key
