local key = {
  ID = 1,
  TimeTransform = 2,
  StoryTaskGroupTb = 3,
  CostItemNum = 4,
  LockTaskId = 5,
  UnCostTimeStart = 6,
  UnCostTimeEnd = 7,
  UnlockTime = 8,
  GroupsListTitle = 9,
  GroupsListContent = 10,
  Reward = 11
}
local common = {
  "2022-07-21 09:00:00",
  "2022-08-25 04:00:00",
  "2022-10-20 05:00:00",
  "2022-11-24 09:00:00"
}
local config = {
  {
    1,
    0,
    {
      5,
      6,
      7,
      8,
      9,
      10
    },
    1,
    nil,
    common[1],
    "2022-08-04 04:00:00",
    common[1],
    "str_homeland_storytask_grouptitle_1",
    "str_homeland_storytask_groupdate_1",
    {
      {3000003, 1},
      {5134026, 1},
      {5134017, 1},
      {5134036, 1},
      {5134015, 1},
      {5134028, 1},
      {5134027, 1}
    }
  },
  {
    2,
    0,
    {
      11,
      12,
      13,
      14,
      15,
      16
    },
    1,
    nil,
    common[2],
    "2022-09-22 04:00:00",
    common[2],
    "str_homeland_storytask_grouptitle_2",
    "str_homeland_storytask_groupdate_2",
    {
      {5271001, 1},
      {5272001, 1},
      {5272002, 1},
      {5272003, 1},
      {5272009, 1},
      {5272008, 1},
      {5272004, 1},
      {5272005, 1},
      {5272006, 1},
      {5272007, 1},
      {5272010, 1},
      {5272011, 1},
      {5272012, 1},
      {3000003, 1}
    }
  },
  {
    3,
    0,
    {
      17,
      18,
      19,
      20,
      21,
      22
    },
    1,
    nil,
    common[3],
    "2022-11-17 04:00:00",
    common[3],
    "str_homeland_storytask_grouptitle_3",
    "str_homeland_storytask_groupdate_3",
    {
      {5271003, 1},
      {5273010, 1},
      {5273011, 1},
      {5273012, 1},
      {5273013, 1},
      {5273016, 1},
      {5273001, 1},
      {5273002, 1},
      {5272003, 1},
      {5273003, 1},
      {5273004, 1},
      {5273007, 1},
      {5273019, 1},
      {5273020, 1},
      {5273021, 1},
      {5273022, 1},
      {5273025, 1},
      {3000003, 1}
    }
  },
  {
    4,
    0,
    {
      23,
      24,
      25,
      26,
      27,
      28
    },
    1,
    nil,
    common[4],
    "2022-12-15 04:00:00",
    common[4],
    "str_homeland_storytask_grouptitle_4",
    "str_homeland_storytask_groupdate_4",
    {
      {5271002, 1},
      {5272013, 1},
      {5272014, 1},
      {5272015, 1},
      {3000003, 1}
    }
  }
}
return config, "ID", key
