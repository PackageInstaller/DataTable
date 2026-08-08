local raw = {
  [1] = ProtobufI("GuildMisc", {
    maxMemberCount = 30,
    maxNameLen = 7,
    maxBillboardLen = 64,
    createMinLevel = 23,
    createCost = ProtobufI("STResource", {type = 7, count = 100000}),
    viceCount = 3,
    randomBatchCount = 10,
    loveScoreMu = 30,
    loveScoreSigma = 8,
    badgeCount = 6,
    renameCost = 1000,
    editIconCost = 1000,
    donateMaxCount = 10,
    donateMaxCountByOnePlayer = 100,
    maxGuildDeployDoneCount = 2,
    loveSegment = {
      [1] = ProtobufI("GuildMisc.LoveScoreSegment", {
        scoreLow = 60,
        randomLow = 12000,
        randomHigh = 16000
      }),
      [2] = ProtobufI("GuildMisc.LoveScoreSegment", {
        scoreLow = 80,
        randomLow = 16000,
        randomHigh = 18000
      }),
      [3] = ProtobufI("GuildMisc.LoveScoreSegment", {
        scoreLow = 100,
        randomLow = 18000,
        randomHigh = 20000
      })
    },
    maxRecord = 50,
    voteStartPresidentLeave = 604800,
    voteLastTime = 259200,
    voteCoolDown = 604800,
    donateRefund = ProtobufI("STResource", {type = 17, count = 10}),
    maxLoveScore = 100,
    donateRefreshIsoWeekday = 7,
    maxGuildPendingList = 50,
    guildFunctionLimitWhenQuit = 86400,
    punishQuitCount = 1,
    maxGuildLevel = 15
  })
}
local indexed = {}
return {raw, indexed}
