local raw = {
  [1] = ProtobufI("GuildDungeonAssistScoreReward", {
    score = 100000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 30001,
        count = 5
      })
    }
  }),
  [2] = ProtobufI("GuildDungeonAssistScoreReward", {
    score = 130000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 30006,
        count = 10
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 30007,
        count = 10
      })
    }
  }),
  [3] = ProtobufI("GuildDungeonAssistScoreReward", {
    score = 180000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 30011,
        count = 10
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 30012,
        count = 10
      }),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 30013,
        count = 10
      })
    }
  }),
  [4] = ProtobufI("GuildDungeonAssistScoreReward", {
    score = 250000,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 30016,
        count = 15
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 30017,
        count = 15
      }),
      [3] = ProtobufI("STResource", {
        type = 11,
        id = 30018,
        count = 15
      })
    }
  })
}
local indexed = {
  [100000] = 1,
  [130000] = 2,
  [180000] = 3,
  [250000] = 4
}
return {raw, indexed}
