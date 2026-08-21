local key = {
  CoverBaseSpine = 1,
  IdleAnim = 2,
  DrawOnceAnim = 3,
  DrawOnceAnimTime = 4,
  DrawMultiAnim = 5,
  DrawMultiAnimTime = 6
}
local common = {
  "ying_ui_spine_idle",
  "3163"
}
local config = {
  {
    common[1],
    "1_idle",
    "1_1",
    1893,
    "1_10",
    common[2]
  },
  {
    common[1],
    "2_idle",
    "2_1",
    1893,
    "2_10",
    common[2]
  },
  {
    common[1],
    "3_idle",
    "3_1",
    1893,
    "3_10",
    common[2]
  },
  {
    common[1],
    "4_idle",
    "4_1",
    1893,
    "4_10",
    common[2]
  },
  {
    common[1],
    "5_idle",
    "5_1",
    1893,
    "5_10",
    common[2]
  }
}
return config, "BoxIndex", key
