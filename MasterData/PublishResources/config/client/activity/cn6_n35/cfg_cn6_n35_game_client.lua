local key = {
  ID = 1,
  StepID = 2,
  SpineSkin = 3,
  Talk = 4,
  TalkHead = 5,
  YieldTime = 6,
  SpineAnim = 7,
  StoryID = 8
}
local common = {
  "dress",
  "below",
  "N35_xyx_tx04"
}
local config = {
  {
    1,
    7,
    "1",
    "str_cn6_n35_talk_1",
    "N35_xyx_tx02",
    5000,
    common[1]
  },
  {
    2,
    8,
    "2",
    "str_cn6_n35_talk_2",
    "N35_xyx_tx03",
    5000,
    common[2]
  },
  {
    3,
    9,
    "3",
    "str_cn6_n35_talk_3",
    common[3],
    5000,
    common[1]
  },
  {
    4,
    10,
    "4",
    "str_cn6_n35_talk_4",
    "N35_xyx_tx05",
    5000,
    common[2]
  },
  {
    5,
    11,
    "5",
    "str_cn6_n35_talk_5",
    "N35_xyx_tx06",
    5000,
    common[2]
  },
  {
    6,
    12,
    "6",
    "str_cn6_n35_talk_6",
    common[3],
    5000,
    "top",
    50640201
  }
}
return config, "ID", key
