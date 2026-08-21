local key = {
  ID = 1,
  ComponentID = 2,
  NeedMissionId = 3,
  MainMission = 4,
  Desc = 5,
  BgSpine = 6,
  MapBg = 7,
  BranchMission = 8
}
local config = {
  {
    1,
    110503206,
    0,
    {
      1,
      2,
      3,
      4
    },
    "str_n32_multiline_desc_1",
    "shuijingqiubai1_n31_spine_idle",
    "n32_dzm_dt_di11",
    {
      17,
      18,
      19
    }
  },
  {
    2,
    110503206,
    5321004,
    {
      5,
      6,
      7,
      8,
      9,
      10
    },
    "str_n32_multiline_desc_2",
    "shuijingqiuhei1_n31_spine_idle",
    "n32_dzm_dt_di17",
    {
      20,
      21,
      22
    }
  },
  {
    3,
    110503206,
    5321010,
    {
      11,
      12,
      13,
      14,
      15,
      16
    },
    "str_n32_multiline_desc_3",
    "shuijingqiuhei_n31_spine_idle",
    "n32_dzm_dt_di18",
    {23, 24}
  }
}
return config, "ID", key
