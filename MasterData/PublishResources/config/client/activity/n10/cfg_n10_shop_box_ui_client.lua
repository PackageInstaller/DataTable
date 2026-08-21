local key = {
  Sheme = 1,
  CoverBaseSpine = 2,
  IdleAnim = 3,
  DrawOnceAnim = 4,
  DrawOnceAnimTime = 5,
  DrawOnceResultAnim = 6,
  DrawOnceResultAnimTime = 7,
  DrawMultiAnim = 8,
  DrawMultiAnimTime = 9,
  DrawMultiResultAnim = 10,
  DrawMultiResultAnimTime = 11
}
local common = {
  "n10_g_spine_idle"
}
local config = {
  {
    1,
    common[1],
    "1_idle",
    "1_1",
    2333,
    "1_2",
    1933,
    "1_3",
    2333,
    "1_4",
    1933
  },
  {
    2,
    common[1],
    "2_idle",
    "2_1",
    2333,
    "2_2",
    1933,
    "2_3",
    2333,
    "2_4",
    1933
  },
  {
    3,
    common[1],
    "3_idle",
    "3_1",
    2333,
    "3_2",
    1933,
    "3_3",
    2333,
    "3_4",
    1933
  },
  {
    4,
    common[1],
    "4_idle",
    "4_1",
    2333,
    "4_2",
    1933,
    "4_3",
    2333,
    "4_4",
    1933
  },
  {
    5,
    common[1],
    "5_idle",
    "5_1",
    2333,
    "5_2",
    1933,
    "5_3",
    2333,
    "5_4",
    1933
  }
}
return config, "BoxIndex", key
