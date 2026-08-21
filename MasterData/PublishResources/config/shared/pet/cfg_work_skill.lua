local key = {
  ID = 1,
  Name = 2,
  Desc = 3,
  Icon = 4,
  WorkEffect = 5,
  RoomType = 6,
  Level = 7
}
local common = {
  "icon_1001_work"
}
local config = {
  [1001] = {
    1001,
    "str_skill_work_skill_name_1001",
    "str_skill_work_skill_desc_1001",
    common[1],
    {
      1,
      200,
      0
    },
    1,
    1
  },
  [2001] = {
    2001,
    "str_skill_work_skill_name_2001",
    "str_skill_work_skill_desc_2001",
    "icon_2001_work",
    {
      2,
      0,
      0.05
    },
    2,
    1
  },
  [3001] = {
    3001,
    "str_skill_work_skill_name_3001",
    "str_skill_work_skill_desc_3001",
    common[1],
    {
      3,
      10,
      0
    },
    5,
    1
  },
  [4001] = {
    4001,
    "str_skill_work_skill_name_4001",
    "str_skill_work_skill_desc_4001",
    "icon_4001_work",
    {
      4,
      0,
      -0.2
    },
    5,
    1
  },
  [5001] = {
    5001,
    "str_skill_work_skill_name_5001",
    "str_skill_work_skill_desc_5001",
    "icon_5001_work",
    {
      5,
      0,
      -0.1
    },
    4,
    1
  },
  [6001] = {
    6001,
    "str_skill_work_skill_name_6001",
    "str_skill_work_skill_desc_6001",
    "icon_6001_work",
    {
      6,
      0,
      -0.1
    },
    3,
    1
  },
  [7001] = {
    7001,
    "str_skill_work_skill_name_7001",
    "str_skill_work_skill_desc_7001",
    "icon_7001_work",
    {
      18,
      0,
      -0.1
    },
    6,
    1
  },
  [8001] = {
    8001,
    "str_skill_work_skill_name_8001",
    "str_skill_work_skill_desc_8001",
    "icon_8001_work",
    {
      15,
      0,
      -0.2
    },
    9,
    1
  },
  [9001] = {
    9001,
    "str_skill_work_skill_name_9001",
    "str_skill_work_skill_desc_9001",
    "icon_9001_work",
    {
      16,
      -3600,
      0
    },
    10,
    1
  },
  [10001] = {
    10001,
    "str_skill_work_skill_name_10001",
    "str_skill_work_skill_desc_10001",
    common[1],
    {
      17,
      0,
      0.02
    },
    1,
    1
  },
  [11001] = {
    11001,
    "str_skill_work_skill_name_11001",
    "str_skill_work_skill_desc_11001",
    "icon_11001_work",
    {
      20,
      -3600,
      0
    },
    11,
    1
  }
}
return config, "ID", key
