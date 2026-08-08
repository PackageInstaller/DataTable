local raw = {
  [1] = ProtobufI("ActivityDungeon", {
    activityId = 2001,
    dungeonId = {
      [1] = 52101,
      [2] = 52102,
      [3] = 52103,
      [4] = 52104,
      [5] = 52105,
      [6] = 52106,
      [7] = 52107,
      [8] = 52108,
      [9] = 52109,
      [10] = 52110
    },
    multipleDay = {},
    multipleActivityId = 2101,
    category = 1
  }),
  [2] = ProtobufI("ActivityDungeon", {
    activityId = 2002,
    dungeonId = {
      [1] = 52201,
      [2] = 52202,
      [3] = 52203,
      [4] = 52204,
      [5] = 52205,
      [6] = 52206,
      [7] = 52207,
      [8] = 52208,
      [9] = 52209,
      [10] = 52210
    },
    multipleDay = {},
    multipleActivityId = 2102,
    category = 1
  }),
  [3] = ProtobufI("ActivityDungeon", {
    activityId = 2003,
    dungeonId = {
      [1] = 52301,
      [2] = 52302,
      [3] = 52303,
      [4] = 52304,
      [5] = 52305,
      [6] = 52306,
      [7] = 52307,
      [8] = 52308,
      [9] = 52309,
      [10] = 52310
    },
    multipleDay = {},
    multipleActivityId = 2103,
    category = 1
  }),
  [4] = ProtobufI("ActivityDungeon", {
    activityId = 2101,
    dungeonId = {
      [1] = 52101,
      [2] = 52102,
      [3] = 52103,
      [4] = 52104,
      [5] = 52105,
      [6] = 52106,
      [7] = 52107,
      [8] = 52108,
      [9] = 52109,
      [10] = 52110
    },
    multipleDay = {},
    category = 1
  }),
  [5] = ProtobufI("ActivityDungeon", {
    activityId = 2102,
    dungeonId = {
      [1] = 52201,
      [2] = 52202,
      [3] = 52203,
      [4] = 52204,
      [5] = 52205,
      [6] = 52206,
      [7] = 52207,
      [8] = 52208,
      [9] = 52209,
      [10] = 52210
    },
    multipleDay = {},
    category = 1
  }),
  [6] = ProtobufI("ActivityDungeon", {
    activityId = 2103,
    dungeonId = {
      [1] = 52301,
      [2] = 52302,
      [3] = 52303,
      [4] = 52304,
      [5] = 52305,
      [6] = 52306,
      [7] = 52307,
      [8] = 52308,
      [9] = 52309,
      [10] = 52310
    },
    multipleDay = {},
    category = 1
  }),
  [7] = ProtobufI("ActivityDungeon", {
    activityId = 2004,
    dungeonId = {
      [1] = 52401,
      [2] = 52402,
      [3] = 52403,
      [4] = 52404,
      [5] = 52405
    },
    multipleDay = {},
    category = 2
  })
}
local indexed = {
  [2001] = 1,
  [2002] = 2,
  [2003] = 3,
  [2004] = 7,
  [2101] = 4,
  [2102] = 5,
  [2103] = 6
}
return {raw, indexed}
