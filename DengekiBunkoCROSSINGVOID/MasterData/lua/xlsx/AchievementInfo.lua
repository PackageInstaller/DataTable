local raw = {
  [1] = ProtobufI("AchievementInfo", {
    id = 101,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 50,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 6
  }),
  [2] = ProtobufI("AchievementInfo", {
    id = 102,
    preId = 101,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 200,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 6
  }),
  [3] = ProtobufI("AchievementInfo", {
    id = 103,
    preId = 102,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 500,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [4] = ProtobufI("AchievementInfo", {
    id = 104,
    preId = 103,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 1000,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 11
  }),
  [5] = ProtobufI("AchievementInfo", {
    id = 105,
    preId = 104,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 2000,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 11
  }),
  [6] = ProtobufI("AchievementInfo", {
    id = 106,
    preId = 105,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 3500,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 11
  }),
  [7] = ProtobufI("AchievementInfo", {
    id = 107,
    preId = 106,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 5000,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 11
  }),
  [8] = ProtobufI("AchievementInfo", {
    id = 108,
    preId = 107,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 7500,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 11
  }),
  [9] = ProtobufI("AchievementInfo", {
    id = 109,
    preId = 108,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 11000,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 11
  }),
  [10] = ProtobufI("AchievementInfo", {
    id = 110,
    preId = 109,
    category = 1,
    priority = 1000,
    goalType = 1,
    maxProgress = 15000,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 2
  }),
  [11] = ProtobufI("AchievementInfo", {
    id = 201,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 8
  }),
  [12] = ProtobufI("AchievementInfo", {
    id = 202,
    preId = 201,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 3
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 8
  }),
  [13] = ProtobufI("AchievementInfo", {
    id = 203,
    preId = 202,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 8
  }),
  [14] = ProtobufI("AchievementInfo", {
    id = 204,
    preId = 203,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 5
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 1
  }),
  [15] = ProtobufI("AchievementInfo", {
    id = 205,
    preId = 204,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 6
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [16] = ProtobufI("AchievementInfo", {
    id = 206,
    preId = 205,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 6,
    param = {
      [1] = 0,
      [2] = 6
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [17] = ProtobufI("AchievementInfo", {
    id = 207,
    preId = 206,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 12,
    param = {
      [1] = 0,
      [2] = 6
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [18] = ProtobufI("AchievementInfo", {
    id = 208,
    preId = 207,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 20,
    param = {
      [1] = 0,
      [2] = 6
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [19] = ProtobufI("AchievementInfo", {
    id = 209,
    preId = 208,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 32,
    param = {
      [1] = 0,
      [2] = 6
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [20] = ProtobufI("AchievementInfo", {
    id = 210,
    preId = 209,
    category = 2,
    priority = 995,
    goalType = 4,
    maxProgress = 50,
    param = {
      [1] = 0,
      [2] = 6
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [21] = ProtobufI("AchievementInfo", {
    id = 301,
    category = 2,
    priority = 994,
    goalType = 6,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 15
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 10000}),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 16
  }),
  [22] = ProtobufI("AchievementInfo", {
    id = 302,
    preId = 301,
    category = 2,
    priority = 994,
    goalType = 6,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 40
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 20000}),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 16
  }),
  [23] = ProtobufI("AchievementInfo", {
    id = 303,
    preId = 302,
    category = 2,
    priority = 994,
    goalType = 6,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 75
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 30000}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 16
  }),
  [24] = ProtobufI("AchievementInfo", {
    id = 304,
    preId = 303,
    category = 2,
    priority = 994,
    goalType = 6,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 120
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 40000}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 16
  }),
  [25] = ProtobufI("AchievementInfo", {
    id = 305,
    preId = 304,
    category = 2,
    priority = 994,
    goalType = 6,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 175
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 50000}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 16
  }),
  [26] = ProtobufI("AchievementInfo", {
    id = 401,
    category = 2,
    priority = 993,
    goalType = 7,
    maxProgress = 10,
    param = {
      [1] = 0,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 3
  }),
  [27] = ProtobufI("AchievementInfo", {
    id = 402,
    category = 2,
    priority = 993,
    goalType = 7,
    maxProgress = 6,
    param = {
      [1] = 0,
      [2] = 3
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 3
  }),
  [28] = ProtobufI("AchievementInfo", {
    id = 403,
    preId = 402,
    category = 2,
    priority = 993,
    goalType = 7,
    maxProgress = 10,
    param = {
      [1] = 0,
      [2] = 3
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 3
  }),
  [29] = ProtobufI("AchievementInfo", {
    id = 404,
    preId = 403,
    category = 2,
    priority = 993,
    goalType = 7,
    maxProgress = 20,
    param = {
      [1] = 0,
      [2] = 3
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 3
  }),
  [30] = ProtobufI("AchievementInfo", {
    id = 405,
    category = 2,
    priority = 993,
    goalType = 7,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 3
  }),
  [31] = ProtobufI("AchievementInfo", {
    id = 406,
    preId = 405,
    category = 2,
    priority = 993,
    goalType = 7,
    maxProgress = 6,
    param = {
      [1] = 0,
      [2] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 3
  }),
  [32] = ProtobufI("AchievementInfo", {
    id = 407,
    preId = 406,
    category = 2,
    priority = 993,
    goalType = 7,
    maxProgress = 12,
    param = {
      [1] = 0,
      [2] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 3
  }),
  [33] = ProtobufI("AchievementInfo", {
    id = 408,
    preId = 407,
    category = 2,
    priority = 993,
    goalType = 7,
    maxProgress = 20,
    param = {
      [1] = 0,
      [2] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 3
  }),
  [34] = ProtobufI("AchievementInfo", {
    id = 501,
    category = 3,
    priority = 988,
    goalType = 10,
    maxProgress = 1,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40002,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 1
  }),
  [35] = ProtobufI("AchievementInfo", {
    id = 502,
    preId = 501,
    category = 3,
    priority = 988,
    goalType = 10,
    maxProgress = 3,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40003,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 1
  }),
  [36] = ProtobufI("AchievementInfo", {
    id = 503,
    preId = 502,
    category = 3,
    priority = 988,
    goalType = 10,
    maxProgress = 6,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40004,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 1
  }),
  [37] = ProtobufI("AchievementInfo", {
    id = 504,
    preId = 503,
    category = 3,
    priority = 988,
    goalType = 10,
    maxProgress = 12,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 1
  }),
  [38] = ProtobufI("AchievementInfo", {
    id = 505,
    preId = 504,
    category = 3,
    priority = 988,
    goalType = 10,
    maxProgress = 24,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 15
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 1
  }),
  [39] = ProtobufI("AchievementInfo", {
    id = 506,
    preId = 505,
    category = 3,
    priority = 988,
    goalType = 10,
    maxProgress = 48,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 20
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 1
  }),
  [40] = ProtobufI("AchievementInfo", {
    id = 601,
    category = 3,
    priority = 10000,
    goalType = 11,
    maxProgress = 1,
    param = {
      [1] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40002,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 118
  }),
  [41] = ProtobufI("AchievementInfo", {
    id = 602,
    preId = 601,
    category = 3,
    priority = 10000,
    goalType = 11,
    maxProgress = 3,
    param = {
      [1] = 3
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40003,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 118
  }),
  [42] = ProtobufI("AchievementInfo", {
    id = 603,
    preId = 602,
    category = 3,
    priority = 10000,
    goalType = 11,
    maxProgress = 12,
    param = {
      [1] = 3
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40004,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 118
  }),
  [43] = ProtobufI("AchievementInfo", {
    id = 604,
    preId = 603,
    category = 3,
    priority = 10000,
    goalType = 11,
    maxProgress = 1,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 118
  }),
  [44] = ProtobufI("AchievementInfo", {
    id = 605,
    preId = 604,
    category = 3,
    priority = 10000,
    goalType = 11,
    maxProgress = 12,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 15
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 118
  }),
  [45] = ProtobufI("AchievementInfo", {
    id = 606,
    preId = 605,
    category = 3,
    priority = 10000,
    goalType = 11,
    maxProgress = 35,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 20
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 118
  }),
  [46] = ProtobufI("AchievementInfo", {
    id = 607,
    preId = 606,
    category = 3,
    priority = 10000,
    goalType = 11,
    maxProgress = 90,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 25
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 118
  }),
  [47] = ProtobufI("AchievementInfo", {
    id = 608,
    preId = 607,
    category = 3,
    priority = 10000,
    goalType = 11,
    maxProgress = 150,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 30
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 118
  }),
  [48] = ProtobufI("AchievementInfo", {
    id = 609,
    preId = 608,
    category = 3,
    priority = 10000,
    goalType = 11,
    maxProgress = 240,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 40005,
        count = 35
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 118
  }),
  [49] = ProtobufI("AchievementInfo", {
    id = 701,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 20,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 107
  }),
  [50] = ProtobufI("AchievementInfo", {
    id = 702,
    preId = 701,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 50,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 107
  }),
  [51] = ProtobufI("AchievementInfo", {
    id = 703,
    preId = 702,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 80,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 107
  }),
  [52] = ProtobufI("AchievementInfo", {
    id = 704,
    preId = 703,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 120,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 2
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 107
  }),
  [53] = ProtobufI("AchievementInfo", {
    id = 705,
    preId = 704,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 160,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 2
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 107
  }),
  [54] = ProtobufI("AchievementInfo", {
    id = 706,
    preId = 705,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 200,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 2
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 107
  }),
  [55] = ProtobufI("AchievementInfo", {
    id = 707,
    preId = 706,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 260,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 3
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 107
  }),
  [56] = ProtobufI("AchievementInfo", {
    id = 708,
    preId = 707,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 360,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 107
  }),
  [57] = ProtobufI("AchievementInfo", {
    id = 709,
    preId = 708,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 500,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 6
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 107
  }),
  [58] = ProtobufI("AchievementInfo", {
    id = 710,
    preId = 709,
    category = 4,
    priority = 987,
    goalType = 12,
    maxProgress = 800,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 15
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 107
  }),
  [59] = ProtobufI("AchievementInfo", {
    id = 801,
    category = 5,
    priority = 982,
    goalType = 27,
    maxProgress = 500,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 25}),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 7
  }),
  [60] = ProtobufI("AchievementInfo", {
    id = 802,
    preId = 801,
    category = 5,
    priority = 982,
    goalType = 27,
    maxProgress = 1000,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 25}),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 7
  }),
  [61] = ProtobufI("AchievementInfo", {
    id = 803,
    preId = 802,
    category = 5,
    priority = 982,
    goalType = 27,
    maxProgress = 2500,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 75}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 7
  }),
  [62] = ProtobufI("AchievementInfo", {
    id = 804,
    preId = 803,
    category = 5,
    priority = 982,
    goalType = 27,
    maxProgress = 5000,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 7
  }),
  [63] = ProtobufI("AchievementInfo", {
    id = 805,
    preId = 804,
    category = 5,
    priority = 982,
    goalType = 27,
    maxProgress = 12000,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 7
  }),
  [64] = ProtobufI("AchievementInfo", {
    id = 806,
    preId = 805,
    category = 5,
    priority = 982,
    goalType = 27,
    maxProgress = 25000,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 7
  }),
  [65] = ProtobufI("AchievementInfo", {
    id = 807,
    preId = 806,
    category = 5,
    priority = 982,
    goalType = 27,
    maxProgress = 50000,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 7
  }),
  [66] = ProtobufI("AchievementInfo", {
    id = 808,
    preId = 807,
    category = 5,
    priority = 982,
    goalType = 27,
    maxProgress = 80000,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 7
  }),
  [67] = ProtobufI("AchievementInfo", {
    id = 809,
    preId = 808,
    category = 5,
    priority = 982,
    goalType = 27,
    maxProgress = 150000,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {type = 6, count = 200}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 7
  }),
  [68] = ProtobufI("AchievementInfo", {
    id = 901,
    category = 6,
    priority = 981,
    goalType = 15,
    maxProgress = 100,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 10
  }),
  [69] = ProtobufI("AchievementInfo", {
    id = 902,
    preId = 901,
    category = 6,
    priority = 981,
    goalType = 15,
    maxProgress = 500,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 10
  }),
  [70] = ProtobufI("AchievementInfo", {
    id = 903,
    preId = 902,
    category = 6,
    priority = 981,
    goalType = 15,
    maxProgress = 1200,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 10
  }),
  [71] = ProtobufI("AchievementInfo", {
    id = 904,
    preId = 903,
    category = 6,
    priority = 981,
    goalType = 15,
    maxProgress = 3000,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 10
  }),
  [72] = ProtobufI("AchievementInfo", {
    id = 905,
    preId = 904,
    category = 6,
    priority = 981,
    goalType = 15,
    maxProgress = 6800,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 10
  }),
  [73] = ProtobufI("AchievementInfo", {
    id = 906,
    preId = 905,
    category = 6,
    priority = 981,
    goalType = 15,
    maxProgress = 12800,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 10
  }),
  [74] = ProtobufI("AchievementInfo", {
    id = 907,
    preId = 906,
    category = 6,
    priority = 981,
    goalType = 15,
    maxProgress = 19800,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 10
  }),
  [75] = ProtobufI("AchievementInfo", {
    id = 908,
    preId = 907,
    category = 6,
    priority = 981,
    goalType = 15,
    maxProgress = 32800,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 10
  }),
  [76] = ProtobufI("AchievementInfo", {
    id = 909,
    preId = 908,
    category = 6,
    priority = 981,
    goalType = 15,
    maxProgress = 64800,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 10
  }),
  [77] = ProtobufI("AchievementInfo", {
    id = 1001,
    hide = 1,
    category = 5,
    priority = 978,
    goalType = 22,
    maxProgress = 10,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10001,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 14
  }),
  [78] = ProtobufI("AchievementInfo", {
    id = 1002,
    preId = 1001,
    hide = 1,
    category = 5,
    priority = 978,
    goalType = 22,
    maxProgress = 50,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10002,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 14
  }),
  [79] = ProtobufI("AchievementInfo", {
    id = 1003,
    preId = 1002,
    hide = 1,
    category = 5,
    priority = 978,
    goalType = 22,
    maxProgress = 130,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10002,
        count = 15
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 14
  }),
  [80] = ProtobufI("AchievementInfo", {
    id = 1004,
    preId = 1003,
    hide = 1,
    category = 5,
    priority = 978,
    goalType = 22,
    maxProgress = 300,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10003,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 14
  }),
  [81] = ProtobufI("AchievementInfo", {
    id = 1005,
    preId = 1004,
    hide = 1,
    category = 5,
    priority = 978,
    goalType = 22,
    maxProgress = 700,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10003,
        count = 15
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 14
  }),
  [82] = ProtobufI("AchievementInfo", {
    id = 1006,
    preId = 1005,
    hide = 1,
    category = 5,
    priority = 978,
    goalType = 22,
    maxProgress = 1500,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10004,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 14
  }),
  [83] = ProtobufI("AchievementInfo", {
    id = 1007,
    preId = 1006,
    hide = 1,
    category = 5,
    priority = 978,
    goalType = 22,
    maxProgress = 4500,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10004,
        count = 15
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 14
  }),
  [84] = ProtobufI("AchievementInfo", {
    id = 1008,
    preId = 1007,
    hide = 1,
    category = 5,
    priority = 978,
    goalType = 22,
    maxProgress = 9000,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10004,
        count = 20
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 14
  }),
  [85] = ProtobufI("AchievementInfo", {
    id = 1009,
    preId = 1008,
    hide = 1,
    category = 5,
    priority = 978,
    goalType = 22,
    maxProgress = 18000,
    param = {
      [1] = 0
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 10004,
        count = 25
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 14
  }),
  [86] = ProtobufI("AchievementInfo", {
    id = 1101,
    category = 5,
    priority = 976,
    goalType = 36,
    maxProgress = 15,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53001,
        count = 2
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 105
  }),
  [87] = ProtobufI("AchievementInfo", {
    id = 1102,
    preId = 1101,
    category = 5,
    priority = 976,
    goalType = 36,
    maxProgress = 40,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 105
  }),
  [88] = ProtobufI("AchievementInfo", {
    id = 1103,
    preId = 1102,
    category = 5,
    priority = 976,
    goalType = 36,
    maxProgress = 100,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53002,
        count = 2
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [89] = ProtobufI("AchievementInfo", {
    id = 1104,
    preId = 1103,
    category = 5,
    priority = 976,
    goalType = 36,
    maxProgress = 230,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53002,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [90] = ProtobufI("AchievementInfo", {
    id = 1105,
    preId = 1104,
    category = 5,
    priority = 976,
    goalType = 36,
    maxProgress = 500,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53003,
        count = 2
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [91] = ProtobufI("AchievementInfo", {
    id = 1106,
    preId = 1105,
    category = 5,
    priority = 976,
    goalType = 36,
    maxProgress = 1000,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53003,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [92] = ProtobufI("AchievementInfo", {
    id = 1107,
    preId = 1106,
    category = 5,
    priority = 976,
    goalType = 36,
    maxProgress = 1500,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53003,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [93] = ProtobufI("AchievementInfo", {
    id = 1108,
    preId = 1107,
    category = 5,
    priority = 976,
    goalType = 36,
    maxProgress = 3000,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 53003,
        count = 15
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [94] = ProtobufI("AchievementInfo", {
    id = 1201,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 1,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 10})
    },
    displayRoleId = 6
  }),
  [95] = ProtobufI("AchievementInfo", {
    id = 1202,
    preId = 1201,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 5,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 15})
    },
    displayRoleId = 6
  }),
  [96] = ProtobufI("AchievementInfo", {
    id = 1203,
    preId = 1202,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 10,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [97] = ProtobufI("AchievementInfo", {
    id = 1204,
    preId = 1203,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 15,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [98] = ProtobufI("AchievementInfo", {
    id = 1205,
    preId = 1204,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 20,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [99] = ProtobufI("AchievementInfo", {
    id = 1206,
    preId = 1205,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 30,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 20
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [100] = ProtobufI("AchievementInfo", {
    id = 1207,
    preId = 1206,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 40,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 20
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [101] = ProtobufI("AchievementInfo", {
    id = 1208,
    preId = 1207,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 50,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 20
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [102] = ProtobufI("AchievementInfo", {
    id = 1209,
    preId = 1208,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 60,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 20
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [103] = ProtobufI("AchievementInfo", {
    id = 1210,
    preId = 1209,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 80,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 50
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [104] = ProtobufI("AchievementInfo", {
    id = 1211,
    preId = 1210,
    category = 2,
    priority = 976,
    goalType = 64,
    maxProgress = 100,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 50
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [105] = ProtobufI("AchievementInfo", {
    id = 1,
    hide = 1,
    category = 4,
    priority = 1000,
    goalType = 60,
    maxProgress = 50,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 118
  }),
  [106] = ProtobufI("AchievementInfo", {
    id = 2,
    preId = 1,
    hide = 1,
    category = 4,
    priority = 1000,
    goalType = 60,
    maxProgress = 100,
    param = {
      [1] = 1,
      [2] = 2
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 5
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 6
  }),
  [107] = ProtobufI("AchievementInfo", {
    id = 3,
    hide = 1,
    category = 6,
    priority = 1000,
    goalType = 15,
    maxProgress = 50,
    param = {
      [1] = 10004
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 13
  }),
  [108] = ProtobufI("AchievementInfo", {
    id = 4,
    hide = 1,
    category = 6,
    priority = 1000,
    goalType = 15,
    maxProgress = 50,
    param = {
      [1] = 10002
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 5
  }),
  [109] = ProtobufI("AchievementInfo", {
    id = 5,
    hide = 1,
    category = 6,
    priority = 1000,
    goalType = 15,
    maxProgress = 50,
    param = {
      [1] = 10027
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 102
  }),
  [110] = ProtobufI("AchievementInfo", {
    id = 6,
    hide = 1,
    category = 6,
    priority = 1000,
    goalType = 15,
    maxProgress = 50,
    param = {
      [1] = 10013
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 101
  }),
  [111] = ProtobufI("AchievementInfo", {
    id = 7,
    hide = 1,
    category = 6,
    priority = 1000,
    goalType = 15,
    maxProgress = 50,
    param = {
      [1] = 10028
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 14
  }),
  [112] = ProtobufI("AchievementInfo", {
    id = 8,
    hide = 1,
    category = 6,
    priority = 1000,
    goalType = 67,
    maxProgress = 1,
    param = {
      [1] = 1,
      [2] = 100
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 10006,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [113] = ProtobufI("AchievementInfo", {
    id = 9,
    hide = 1,
    category = 4,
    priority = 1000,
    goalType = 68,
    maxProgress = 300,
    param = {
      [1] = 1,
      [2] = 2,
      [3] = 5
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 23, count = 3000}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 112
  }),
  [114] = ProtobufI("AchievementInfo", {
    id = 10,
    hide = 1,
    category = 2,
    priority = 1000,
    goalType = 69,
    maxProgress = 50,
    param = {},
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 90001,
        count = 10
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 117
  }),
  [115] = ProtobufI("AchievementInfo", {
    id = 11,
    hide = 1,
    category = 2,
    priority = 1000,
    goalType = 62,
    maxProgress = 1,
    param = {
      [1] = 0,
      [2] = 100
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [116] = ProtobufI("AchievementInfo", {
    id = 12,
    hide = 1,
    category = 2,
    priority = 1000,
    goalType = 63,
    maxProgress = 1,
    param = {
      [1] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 100}),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 110
  }),
  [117] = ProtobufI("AchievementInfo", {
    id = 13,
    hide = 1,
    category = 2,
    priority = 1000,
    goalType = 66,
    maxProgress = 1,
    param = {
      [1] = 4,
      [2] = 3001
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 10001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 201
  }),
  [118] = ProtobufI("AchievementInfo", {
    id = 14,
    hide = 1,
    category = 2,
    priority = 1000,
    goalType = 66,
    maxProgress = 1,
    param = {
      [1] = 4,
      [2] = 3002
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 10002,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 202
  }),
  [119] = ProtobufI("AchievementInfo", {
    id = 15,
    hide = 1,
    category = 2,
    priority = 1000,
    goalType = 66,
    maxProgress = 1,
    param = {
      [1] = 4,
      [2] = 3003
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 10003,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 203
  }),
  [120] = ProtobufI("AchievementInfo", {
    id = 16,
    hide = 1,
    category = 2,
    priority = 1000,
    goalType = 66,
    maxProgress = 1,
    param = {
      [1] = 4,
      [2] = 3004
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 10004,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 204
  }),
  [121] = ProtobufI("AchievementInfo", {
    id = 17,
    hide = 1,
    category = 2,
    priority = 1000,
    goalType = 66,
    maxProgress = 4,
    param = {
      [1] = 4,
      [2] = 3001,
      [3] = 3002,
      [4] = 3003,
      [5] = 3004
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 10005,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 105
  }),
  [122] = ProtobufI("AchievementInfo", {
    id = 18,
    hide = 1,
    category = 6,
    priority = 1000,
    goalType = 15,
    maxProgress = 50,
    param = {
      [1] = 10063
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 29,
        id = 101006,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 10
  }),
  [123] = ProtobufI("AchievementInfo", {
    id = 19,
    hide = 1,
    category = 2,
    priority = 1000,
    goalType = 71,
    maxProgress = 200,
    param = {
      [1] = 0,
      [2] = 2128
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 31015,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 128
  }),
  [124] = ProtobufI("AchievementInfo", {
    id = 20,
    hide = 1,
    category = 5,
    priority = 1000,
    goalType = 72,
    maxProgress = 88,
    param = {
      [1] = 2,
      [2] = 3,
      [3] = 4
    },
    reward = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 5019,
        count = 1
      }),
      [2] = ProtobufI("STResource", {type = 21, count = 20})
    },
    displayRoleId = 2
  })
}
local indexed = {
  [1] = 105,
  [2] = 106,
  [3] = 107,
  [4] = 108,
  [5] = 109,
  [6] = 110,
  [7] = 111,
  [8] = 112,
  [9] = 113,
  [10] = 114,
  [11] = 115,
  [12] = 116,
  [13] = 117,
  [14] = 118,
  [15] = 119,
  [16] = 120,
  [17] = 121,
  [18] = 122,
  [19] = 123,
  [20] = 124,
  [101] = 1,
  [102] = 2,
  [103] = 3,
  [104] = 4,
  [105] = 5,
  [106] = 6,
  [107] = 7,
  [108] = 8,
  [109] = 9,
  [110] = 10,
  [201] = 11,
  [202] = 12,
  [203] = 13,
  [204] = 14,
  [205] = 15,
  [206] = 16,
  [207] = 17,
  [208] = 18,
  [209] = 19,
  [210] = 20,
  [301] = 21,
  [302] = 22,
  [303] = 23,
  [304] = 24,
  [305] = 25,
  [401] = 26,
  [402] = 27,
  [403] = 28,
  [404] = 29,
  [405] = 30,
  [406] = 31,
  [407] = 32,
  [408] = 33,
  [501] = 34,
  [502] = 35,
  [503] = 36,
  [504] = 37,
  [505] = 38,
  [506] = 39,
  [601] = 40,
  [602] = 41,
  [603] = 42,
  [604] = 43,
  [605] = 44,
  [606] = 45,
  [607] = 46,
  [608] = 47,
  [609] = 48,
  [701] = 49,
  [702] = 50,
  [703] = 51,
  [704] = 52,
  [705] = 53,
  [706] = 54,
  [707] = 55,
  [708] = 56,
  [709] = 57,
  [710] = 58,
  [801] = 59,
  [802] = 60,
  [803] = 61,
  [804] = 62,
  [805] = 63,
  [806] = 64,
  [807] = 65,
  [808] = 66,
  [809] = 67,
  [901] = 68,
  [902] = 69,
  [903] = 70,
  [904] = 71,
  [905] = 72,
  [906] = 73,
  [907] = 74,
  [908] = 75,
  [909] = 76,
  [1001] = 77,
  [1002] = 78,
  [1003] = 79,
  [1004] = 80,
  [1005] = 81,
  [1006] = 82,
  [1007] = 83,
  [1008] = 84,
  [1009] = 85,
  [1101] = 86,
  [1102] = 87,
  [1103] = 88,
  [1104] = 89,
  [1105] = 90,
  [1106] = 91,
  [1107] = 92,
  [1108] = 93,
  [1201] = 94,
  [1202] = 95,
  [1203] = 96,
  [1204] = 97,
  [1205] = 98,
  [1206] = 99,
  [1207] = 100,
  [1208] = 101,
  [1209] = 102,
  [1210] = 103,
  [1211] = 104
}
return {raw, indexed}
