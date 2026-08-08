local raw = {
  [1] = ProtobufI("GuildDungeon", {
    dungeonId = 6101,
    activityId = 49001,
    assistBuffId = 996104,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 1
  }),
  [2] = ProtobufI("GuildDungeon", {
    dungeonId = 6102,
    activityId = 49002,
    assistBuffId = 996105,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 2
  }),
  [3] = ProtobufI("GuildDungeon", {
    dungeonId = 6103,
    activityId = 49003,
    assistBuffId = 996106,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 3
  }),
  [4] = ProtobufI("GuildDungeon", {
    dungeonId = 6104,
    activityId = 49004,
    assistBuffId = 996107,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 4
  }),
  [5] = ProtobufI("GuildDungeon", {
    dungeonId = 6105,
    activityId = 49005,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 5
  }),
  [6] = ProtobufI("GuildDungeon", {
    dungeonId = 6001,
    activityId = 50001,
    otherAssistBuffId = 996101,
    challengeBuffs = {
      [1] = ProtobufI("GuildDungeon.challengeBuff", {id = 501, targetScore = 60000}),
      [2] = ProtobufI("GuildDungeon.challengeBuff", {id = 502, targetScore = 120000}),
      [3] = ProtobufI("GuildDungeon.challengeBuff", {id = 503, targetScore = 170000})
    },
    scoreUpLimit = 500,
    exchangeScaleForGuild = 1800,
    exchangeScaleForPerson = 40,
    dungeonType = 16,
    scoreDelta = 170000,
    openDay = 6,
    scoreUpLimitForGuild = 25000
  }),
  [7] = ProtobufI("GuildDungeon", {
    dungeonId = 6002,
    activityId = 50001,
    otherAssistBuffId = 996102,
    challengeBuffs = {
      [1] = ProtobufI("GuildDungeon.challengeBuff", {id = 501, targetScore = 100000}),
      [2] = ProtobufI("GuildDungeon.challengeBuff", {id = 502, targetScore = 180000}),
      [3] = ProtobufI("GuildDungeon.challengeBuff", {id = 503, targetScore = 300000})
    },
    scoreUpLimit = 500,
    exchangeScaleForGuild = 900,
    exchangeScaleForPerson = 20,
    dungeonType = 16,
    scoreDelta = 300000,
    openDay = 6,
    scoreUpLimitForGuild = 25000
  }),
  [8] = ProtobufI("GuildDungeon", {
    dungeonId = 6003,
    activityId = 50001,
    otherAssistBuffId = 996103,
    challengeBuffs = {
      [1] = ProtobufI("GuildDungeon.challengeBuff", {id = 501, targetScore = 20000}),
      [2] = ProtobufI("GuildDungeon.challengeBuff", {id = 502, targetScore = 60000}),
      [3] = ProtobufI("GuildDungeon.challengeBuff", {id = 503, targetScore = 90000})
    },
    scoreUpLimit = 500,
    exchangeScaleForGuild = 2700,
    exchangeScaleForPerson = 60,
    dungeonType = 16,
    scoreDelta = 90000,
    openDay = 6,
    scoreUpLimitForGuild = 25000
  }),
  [9] = ProtobufI("GuildDungeon", {
    dungeonId = 6101,
    activityId = 90001,
    assistBuffId = 996104,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 1
  }),
  [10] = ProtobufI("GuildDungeon", {
    dungeonId = 6102,
    activityId = 90001,
    assistBuffId = 996105,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 2
  }),
  [11] = ProtobufI("GuildDungeon", {
    dungeonId = 6103,
    activityId = 90001,
    assistBuffId = 996106,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 3
  }),
  [12] = ProtobufI("GuildDungeon", {
    dungeonId = 6104,
    activityId = 90001,
    assistBuffId = 996107,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 4
  }),
  [13] = ProtobufI("GuildDungeon", {
    dungeonId = 6105,
    activityId = 90001,
    challengeBuffs = {},
    dungeonType = 15,
    openDay = 5
  }),
  [14] = ProtobufI("GuildDungeon", {
    dungeonId = 6001,
    activityId = 90001,
    otherAssistBuffId = 996101,
    challengeBuffs = {},
    dungeonType = 16,
    openDay = 6,
    challengeDungeonRewardBuff = 503
  }),
  [15] = ProtobufI("GuildDungeon", {
    dungeonId = 6002,
    activityId = 90001,
    otherAssistBuffId = 996102,
    challengeBuffs = {},
    dungeonType = 16,
    openDay = 6,
    challengeDungeonRewardBuff = 503
  }),
  [16] = ProtobufI("GuildDungeon", {
    dungeonId = 6003,
    activityId = 90001,
    otherAssistBuffId = 996103,
    challengeBuffs = {},
    dungeonType = 16,
    openDay = 6,
    challengeDungeonRewardBuff = 503
  })
}
local indexed = {
  [6001] = {
    [50001] = 6,
    [90001] = 14
  },
  [6002] = {
    [50001] = 7,
    [90001] = 15
  },
  [6003] = {
    [50001] = 8,
    [90001] = 16
  },
  [6101] = {
    [49001] = 1,
    [90001] = 9
  },
  [6102] = {
    [49002] = 2,
    [90001] = 10
  },
  [6103] = {
    [49003] = 3,
    [90001] = 11
  },
  [6104] = {
    [49004] = 4,
    [90001] = 12
  },
  [6105] = {
    [49005] = 5,
    [90001] = 13
  }
}
return {raw, indexed}
