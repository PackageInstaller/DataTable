local key = {
  ID = 1,
  ComponentID = 2,
  TimeTransform = 3,
  GroupType = 4,
  Priority = 5,
  StartTime = 6,
  EndTime = 7,
  Reward = 8,
  AcceptCondition = 9,
  GroupIcon = 10,
  GroupTitle = 11,
  GroupContent = 12
}
local common = {
  {
    {3000003, 30}
  },
  "str_activity_double_drop_activity_name",
  "2022-07-21 09:00:00",
  "2138-01-01 04:00:00",
  "2022-07-22 05:00:00",
  "2022-07-23 05:00:00",
  "2022-08-25 04:00:00",
  "2022-08-26 04:00:00",
  "2022-08-27 04:00:00",
  "2022-10-20 05:00:00",
  "2022-10-21 05:00:00",
  "2022-10-22 05:00:00",
  "2022-11-24 09:00:00",
  "2022-11-25 09:00:00",
  "2022-11-26 09:00:00"
}
local config = {
  {
    1,
    0,
    1,
    1,
    999999,
    nil,
    nil,
    {
      {3000003, 100},
      {5132003, 1},
      {5131003, 1}
    },
    nil,
    "N17_task_bg01",
    "str_homeland_group_title_1",
    common[2]
  },
  {
    2,
    0,
    1,
    1,
    999999,
    nil,
    nil,
    {
      {3000003, 100},
      {5134013, 1},
      {5133003, 1},
      {5121001, 1}
    },
    nil,
    "N17_task_bg02",
    "str_homeland_group_title_2",
    common[2]
  },
  {
    3,
    0,
    1,
    1,
    999999,
    nil,
    nil,
    {
      {3000003, 100},
      {5143001, 1},
      {5121002, 1}
    },
    nil,
    "N17_task_bg03",
    "str_homeland_group_title_3",
    common[2]
  },
  {
    4,
    0,
    1,
    1,
    999999,
    nil,
    nil,
    {
      {3000003, 100},
      {5141005, 1},
      {5121003, 1},
      {5403001, 2}
    },
    nil,
    "N17_task_bg04",
    "str_homeland_group_title_4",
    common[2]
  },
  {
    5,
    0,
    0,
    3,
    1,
    common[3],
    common[4],
    {
      {5134027, 1},
      {3000003, 30},
      {5002101, 30},
      {5003101, 10}
    },
    nil,
    "N19_chuanshanjia_taskbg03",
    "str_homeland_group_title_101",
    "str_homeland_group_review_101"
  },
  {
    6,
    0,
    0,
    3,
    1,
    common[3],
    common[4],
    {
      {5134028, 1},
      {3000003, 30},
      {5002201, 10},
      {5003101, 10}
    },
    nil,
    "N19_chuanshanjia_taskbg04",
    "str_homeland_group_title_102",
    "str_homeland_group_review_102"
  },
  {
    7,
    0,
    0,
    3,
    1,
    common[5],
    common[4],
    {
      {5134015, 1},
      {3000003, 30},
      {5000001, 10},
      {3000018, 50000}
    },
    nil,
    "N19_chuanshanjia_taskbg06",
    "str_homeland_group_title_103",
    "str_homeland_group_review_103"
  },
  {
    8,
    0,
    0,
    3,
    1,
    common[5],
    common[4],
    {
      {5134036, 1},
      {3000003, 30},
      {5002101, 50},
      {5003102, 10}
    },
    nil,
    "N19_chuanshanjia_taskbg05",
    "str_homeland_group_title_104",
    "str_homeland_group_review_104"
  },
  {
    9,
    0,
    0,
    3,
    1,
    common[6],
    common[4],
    {
      {5134017, 1},
      {3000003, 30},
      {5002201, 20},
      {5003102, 10}
    },
    nil,
    "N19_chuanshanjia_taskbg02",
    "str_homeland_group_title_105",
    "str_homeland_group_review_105"
  },
  {
    10,
    0,
    0,
    3,
    1,
    common[6],
    common[4],
    {
      {5134026, 1},
      {3000003, 30},
      {5000001, 20},
      {3000018, 100000}
    },
    nil,
    "N19_chuanshanjia_taskbg01",
    "str_homeland_group_title_106",
    "str_homeland_group_review_106"
  },
  {
    11,
    0,
    0,
    3,
    2,
    common[7],
    common[4],
    common[1],
    nil,
    "N19_yyqy_taskbg05",
    "str_homeland_group_title_201",
    "str_homeland_group_review_201"
  },
  {
    12,
    0,
    0,
    3,
    2,
    common[7],
    common[4],
    {
      {3000003, 30},
      {5272007, 1}
    },
    nil,
    "N19_yyqy_taskbg02",
    "str_homeland_group_title_202",
    "str_homeland_group_review_202"
  },
  {
    13,
    0,
    0,
    3,
    2,
    common[8],
    common[4],
    common[1],
    nil,
    "N19_yyqy_taskbg03",
    "str_homeland_group_title_203",
    "str_homeland_group_review_203"
  },
  {
    14,
    0,
    0,
    3,
    2,
    common[8],
    common[4],
    {
      {3000003, 30},
      {5272010, 1},
      {5272011, 1}
    },
    nil,
    "N19_yyqy_taskbg04",
    "str_homeland_group_title_204",
    "str_homeland_group_review_204"
  },
  {
    15,
    0,
    0,
    3,
    2,
    common[9],
    common[4],
    common[1],
    nil,
    "N19_yyqy_taskbg06",
    "str_homeland_group_title_205",
    "str_homeland_group_review_205"
  },
  {
    16,
    0,
    0,
    3,
    2,
    common[9],
    common[4],
    {
      {3000003, 30},
      {5272012, 1},
      {5272004, 1}
    },
    nil,
    "N19_yyqy_taskbg01",
    "str_homeland_group_title_206",
    "str_homeland_group_review_206"
  },
  {
    17,
    0,
    0,
    3,
    3,
    common[10],
    common[4],
    {
      {3000003, 30},
      {5273010, 1},
      {5273011, 1}
    },
    nil,
    "qy_dyqy_taskbg01",
    "str_homeland_group_title_301",
    "str_homeland_group_review_301"
  },
  {
    18,
    0,
    0,
    3,
    3,
    common[10],
    common[4],
    {
      {3000003, 30},
      {5273013, 1},
      {5273016, 1}
    },
    nil,
    "qy_dyqy_taskbg02",
    "str_homeland_group_title_302",
    "str_homeland_group_review_302"
  },
  {
    19,
    0,
    0,
    3,
    3,
    common[11],
    common[4],
    {
      {3000003, 30},
      {5273001, 1},
      {5273002, 1}
    },
    nil,
    "qy_dyqy_taskbg03",
    "str_homeland_group_title_303",
    "str_homeland_group_review_303"
  },
  {
    20,
    0,
    0,
    3,
    3,
    common[11],
    common[4],
    {
      {3000003, 30},
      {5273004, 1},
      {5273007, 1}
    },
    nil,
    "qy_dyqy_taskbg04",
    "str_homeland_group_title_304",
    "str_homeland_group_review_304"
  },
  {
    21,
    0,
    0,
    3,
    3,
    common[12],
    common[4],
    {
      {3000003, 30},
      {5273019, 1},
      {5273020, 1}
    },
    nil,
    "qy_dyqy_taskbg05",
    "str_homeland_group_title_305",
    "str_homeland_group_review_305"
  },
  {
    22,
    0,
    0,
    3,
    3,
    common[12],
    common[4],
    {
      {3000003, 30},
      {5273022, 1},
      {5273025, 1}
    },
    nil,
    "qy_dyqy_taskbg06",
    "str_homeland_group_title_306",
    "str_homeland_group_review_306"
  },
  {
    23,
    0,
    0,
    3,
    4,
    common[13],
    common[4],
    {
      {3000003, 30},
      {5271002, 1}
    },
    nil,
    "qy_tyyj_taskbg01",
    "str_homeland_group_title_401",
    "str_homeland_group_review_401"
  },
  {
    24,
    0,
    0,
    3,
    4,
    common[13],
    common[4],
    common[1],
    nil,
    "qy_tyyj_taskbg02",
    "str_homeland_group_title_402",
    "str_homeland_group_review_402"
  },
  {
    25,
    0,
    0,
    3,
    4,
    common[14],
    common[4],
    {
      {3000003, 30},
      {5272013, 1}
    },
    nil,
    "qy_tyyj_taskbg03",
    "str_homeland_group_title_403",
    "str_homeland_group_review_403"
  },
  {
    26,
    0,
    0,
    3,
    4,
    common[14],
    common[4],
    {
      {3000003, 30},
      {5272014, 1}
    },
    nil,
    "qy_tyyj_taskbg04",
    "str_homeland_group_title_404",
    "str_homeland_group_review_404"
  },
  {
    27,
    0,
    0,
    3,
    4,
    common[15],
    common[4],
    common[1],
    nil,
    "qy_tyyj_taskbg05",
    "str_homeland_group_title_405",
    "str_homeland_group_review_405"
  },
  {
    28,
    0,
    0,
    3,
    4,
    common[15],
    common[4],
    {
      {3000003, 30},
      {5272015, 1}
    },
    nil,
    "qy_tyyj_taskbg06",
    "str_homeland_group_title_406",
    "str_homeland_group_review_406"
  }
}
return config, "ID", key
