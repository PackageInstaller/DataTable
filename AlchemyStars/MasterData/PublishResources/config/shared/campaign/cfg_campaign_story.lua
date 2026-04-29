local key = {
  StoryID = 1,
  NeedMissionList = 2,
  RewardList = 3,
  StarPoint = 4,
  Title = 5,
  Des = 6,
  Icon = 7,
  PreStoryID = 8,
  ComponentID = 9
}
local common = {
  {
    {3000003, 100},
    {3410602, 5},
    {3000002, 3000}
  },
  {
    {3000003, 100},
    {3203023, 2},
    {3202021, 5}
  },
  {
    {3000003, 100},
    {3100015, 3},
    {3000002, 5000}
  },
  {
    {3000003, 100},
    {3203031, 2},
    {3202032, 5}
  },
  {
    {3661103, 1},
    {3400043, 1},
    {3000002, 10000}
  },
  {
    {3000003, 50},
    {3100014, 5},
    {3000002, 3000}
  },
  {
    {3000003, 50}
  },
  {
    {3000003, 30},
    {3100014, 3},
    {3000002, 3000}
  },
  {
    {3000003, 30},
    {3410203, 3},
    {3410202, 5}
  },
  {
    {3000003, 30},
    {3100014, 4},
    {3000002, 5000}
  },
  {
    {3000003, 30},
    {3100014, 5},
    {3000002, 3000}
  },
  "str_sakura_story_name_1",
  "str_sakura_story_desc_1",
  "spirit_1300531_video",
  "str_sakura_story_name_2",
  "str_sakura_story_desc_2",
  "spirit_1500331_video",
  "str_sakura_story_name_3",
  "str_sakura_story_desc_3",
  "spirit_1400321_video",
  "str_sakura_story_name_4",
  "str_sakura_story_desc_4",
  "spirit_1300521_video",
  "str_sakura_story_name_5",
  "str_sakura_story_desc_5",
  "spirit_1300471_video",
  "str_summer_activity_two_story_name_1",
  "str_summer_activity_two_story_desc_1",
  "str_summer_activity_two_story_name_2",
  "str_summer_activity_two_story_desc_2",
  "str_summer_activity_two_story_name_3",
  "str_summer_activity_two_story_desc_3",
  "str_summer_activity_two_story_name_4",
  "str_summer_activity_two_story_desc_4",
  "str_summer_activity_two_story_name_5",
  "str_summer_activity_two_story_desc_5",
  "str_summer_activity_two_story_name_6",
  "str_summer_activity_two_story_desc_6",
  "str_summer_activity_two_story_name_7",
  "str_summer_activity_two_story_desc_7"
}
local empty = {}
local config = {
  [50030101] = {
    50030101,
    empty,
    common[1],
    nil,
    common[12],
    common[13],
    common[14]
  },
  [50030201] = {
    50030201,
    empty,
    common[2],
    nil,
    common[15],
    common[16],
    common[17]
  },
  [50030301] = {
    50030301,
    empty,
    common[3],
    nil,
    common[18],
    common[19],
    common[20]
  },
  [50030401] = {
    50030401,
    empty,
    common[4],
    nil,
    common[21],
    common[22],
    common[23]
  },
  [50030501] = {
    50030501,
    empty,
    common[5],
    nil,
    common[24],
    common[25],
    common[26]
  },
  [50050001] = {
    50050001,
    empty,
    common[6],
    nil,
    common[27],
    common[28],
    common[23],
    nil,
    100401101
  },
  [50050101] = {
    50050101,
    {5041005},
    {
      {3000003, 50},
      {3203043, 2},
      {3202042, 3}
    },
    nil,
    common[29],
    common[30],
    common[26],
    50050001,
    100401101
  },
  [50050201] = {
    50050201,
    {5042005},
    common[6],
    nil,
    common[31],
    common[32],
    common[23],
    50050101,
    100401101
  },
  [50050301] = {
    50050301,
    {5043005},
    {
      {3000003, 50},
      {3203021, 2},
      {3202023, 3}
    },
    nil,
    common[33],
    common[34],
    common[26],
    50050201,
    100401101
  },
  [50050401] = {
    50050401,
    {5044005},
    common[6],
    nil,
    common[35],
    common[36],
    common[23],
    50050301,
    100401101
  },
  [50050501] = {
    50050501,
    {5045005},
    {
      {3000003, 50},
      {3203013, 2},
      {3202012, 3}
    },
    nil,
    common[37],
    common[38],
    common[26],
    50050401,
    100401101
  },
  [50050601] = {
    50050601,
    {5046001},
    {
      {3000003, 100},
      {3400043, 1},
      {3000002, 10000}
    },
    nil,
    common[39],
    common[40],
    common[26],
    50050501,
    100401101
  },
  [50070101] = {
    50070101,
    empty,
    common[1],
    nil,
    common[12],
    common[13],
    common[14]
  },
  [50070201] = {
    50070201,
    empty,
    common[2],
    nil,
    common[15],
    common[16],
    common[17]
  },
  [50070301] = {
    50070301,
    empty,
    common[3],
    nil,
    common[18],
    common[19],
    common[20]
  },
  [50070401] = {
    50070401,
    empty,
    common[4],
    nil,
    common[21],
    common[22],
    common[23]
  },
  [50070501] = {
    50070501,
    empty,
    common[5],
    nil,
    common[24],
    common[25],
    common[26]
  },
  [50091401] = {
    50091401,
    empty,
    nil,
    nil,
    common[24],
    common[25],
    common[26]
  },
  [50150101] = {
    50150101,
    empty,
    {
      {3000003, 50},
      {3100014, 3},
      {3000002, 3000}
    },
    nil,
    common[12],
    common[13],
    common[14]
  },
  [50150201] = {
    50150201,
    empty,
    {
      {3000003, 50},
      {3410103, 3},
      {3410102, 5}
    },
    nil,
    common[15],
    common[16],
    common[17]
  },
  [50150301] = {
    50150301,
    empty,
    {
      {3000003, 50},
      {3100014, 4},
      {3000002, 3000}
    },
    nil,
    common[18],
    common[19],
    common[20]
  },
  [50150401] = {
    50150401,
    empty,
    {
      {3000003, 50},
      {3410403, 2},
      {3410402, 5}
    },
    nil,
    common[21],
    common[22],
    common[23]
  },
  [50150501] = {
    50150501,
    empty,
    common[6],
    nil,
    common[24],
    common[25],
    common[26]
  },
  [50150601] = {
    50150601,
    empty,
    {
      {3000003, 50},
      {3500001, 300},
      {3000002, 5000}
    },
    nil,
    common[24],
    common[25],
    common[26]
  },
  [50150003] = {
    50150003,
    empty,
    common[7]
  },
  [50150004] = {
    50150004,
    empty,
    common[7]
  },
  [50150005] = {
    50150005,
    empty,
    {
      {4090544, 1},
      {6400030, 1}
    }
  },
  [150150101] = {
    150150101,
    empty,
    common[8],
    1,
    common[27],
    common[28],
    common[23]
  },
  [150150201] = {
    150150201,
    empty,
    common[9],
    1,
    common[27],
    common[28],
    common[23]
  },
  [150150301] = {
    150150301,
    empty,
    common[10],
    1,
    common[27],
    common[28],
    common[23]
  },
  [150150401] = {
    150150401,
    empty,
    common[9],
    1,
    common[27],
    common[28],
    common[23]
  },
  [150150501] = {
    150150501,
    empty,
    {
      {3000003, 30},
      {3100014, 5},
      {3000002, 10000}
    },
    1,
    common[27],
    common[28],
    common[23]
  },
  [150150601] = {
    150150601,
    empty,
    common[9],
    1,
    common[27],
    common[28],
    common[23]
  },
  [150030101] = {
    150030101,
    empty,
    common[8],
    22,
    common[12],
    common[13],
    common[14]
  },
  [150030201] = {
    150030201,
    empty,
    {
      {3000003, 30},
      {3410203, 3},
      {3410302, 5}
    },
    1,
    common[15],
    common[16],
    common[17]
  },
  [150030301] = {
    150030301,
    empty,
    common[10],
    1,
    common[18],
    common[19],
    common[20]
  },
  [150030401] = {
    150030401,
    empty,
    {
      {3000003, 30},
      {3410303, 3},
      {3410202, 5}
    },
    1,
    common[21],
    common[22],
    common[23]
  },
  [150030501] = {
    150030501,
    empty,
    {
      {3000003, 30},
      {3100014, 5},
      {3000002, 1000}
    },
    1,
    common[24],
    common[25],
    common[26]
  },
  [150050001] = {
    150050001,
    empty,
    common[11],
    1,
    common[27],
    common[28],
    common[23]
  },
  [150050101] = {
    150050101,
    empty,
    {
      {3000003, 30},
      {3410403, 2},
      {3410402, 3}
    },
    1,
    common[29],
    common[30],
    common[26],
    150050001
  },
  [150050201] = {
    150050201,
    empty,
    common[11],
    1,
    common[31],
    common[32],
    common[23],
    150050101
  },
  [150050301] = {
    150050301,
    empty,
    {
      {3000003, 30},
      {3410203, 2},
      {3410202, 3}
    },
    1,
    common[33],
    common[34],
    common[26],
    150050201
  },
  [150050401] = {
    150050401,
    empty,
    common[11],
    1,
    common[35],
    common[36],
    common[23],
    150050301
  },
  [150050501] = {
    150050501,
    empty,
    {
      {3000003, 30},
      {3410103, 2},
      {3410102, 3}
    },
    1,
    common[37],
    common[38],
    common[26],
    150050401
  },
  [150050601] = {
    150050601,
    empty,
    {
      {3000003, 30},
      {3400043, 1},
      {3000002, 10000}
    },
    1,
    common[39],
    common[40],
    common[26],
    150050501
  },
  [150091401] = {
    150091401,
    empty,
    nil,
    100,
    common[24],
    common[25],
    common[26]
  }
}
return config, "StoryID", key
