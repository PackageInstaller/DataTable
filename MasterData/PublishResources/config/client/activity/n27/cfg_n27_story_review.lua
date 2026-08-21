local key = {
  ID = 1,
  Name = 2,
  StageIndexTitle = 3,
  FullName = 4,
  Des = 5,
  StoryList = 6
}
local common = {
  "str_n27_poststation_title",
  "str_n20_2_Index",
  "str_n27_poststation_mission_title_1",
  "str_n20_4_Index",
  "str_n27_poststation_review_1",
  "str_n27_poststation_mission_title_2",
  "str_n20_5_Index",
  "str_n27_poststation_review_2",
  "str_n27_poststation_mission_title_3",
  "str_n20_6_Index",
  "str_n27_poststation_review_3",
  "str_n27_poststation_mission_title_4",
  "str_n20_7_Index",
  "str_n27_poststation_review_4",
  "str_n27_poststation_mission_title_5",
  "str_n20_8_Index",
  "str_n27_poststation_review_5",
  "str_n27_poststation_mission_title_6",
  "str_n27_poststation_review_6",
  {
    {50420101, 1}
  },
  {
    {50420201, 1}
  },
  {
    {50420301, 1}
  },
  {
    {50420401, 1}
  },
  {
    {50420501, 1}
  },
  {
    {50420601, 1},
    {50420602, 2}
  }
}
local config = {
  [0] = {
    0,
    common[1],
    common[2],
    common[1],
    "str_n27_poststation_review",
    {
      {50420001, 1}
    }
  },
  [1] = {
    1,
    common[3],
    common[4],
    common[3],
    common[5],
    common[20]
  },
  [2] = {
    2,
    common[6],
    common[7],
    common[6],
    common[8],
    common[21]
  },
  [3] = {
    3,
    common[9],
    common[10],
    common[9],
    common[11],
    common[22]
  },
  [4] = {
    4,
    common[12],
    common[13],
    common[12],
    common[14],
    common[23]
  },
  [5] = {
    5,
    common[15],
    common[16],
    common[15],
    common[17],
    common[24]
  },
  [6] = {
    6,
    common[18],
    "str_n20_9_Index",
    common[18],
    common[19],
    common[25]
  },
  [101] = {
    101,
    common[3],
    common[2],
    common[3],
    common[5],
    common[20]
  },
  [102] = {
    102,
    common[6],
    common[4],
    common[6],
    common[8],
    common[21]
  },
  [103] = {
    103,
    common[9],
    common[7],
    common[9],
    common[11],
    common[22]
  },
  [104] = {
    104,
    common[12],
    common[10],
    common[12],
    common[14],
    common[23]
  },
  [105] = {
    105,
    common[15],
    common[13],
    common[15],
    common[17],
    common[24]
  },
  [106] = {
    106,
    common[18],
    common[16],
    common[18],
    common[19],
    common[25]
  }
}
return config, "ID", key
