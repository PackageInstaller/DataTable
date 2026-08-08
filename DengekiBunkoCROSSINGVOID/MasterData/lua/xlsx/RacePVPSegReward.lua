local raw = {
  [1] = ProtobufI("RacePVPSegReward", {
    seg = 1,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 1001,
        count = 1
      })
    }
  }),
  [2] = ProtobufI("RacePVPSegReward", {
    seg = 2,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 1002,
        count = 1
      })
    }
  }),
  [3] = ProtobufI("RacePVPSegReward", {
    seg = 3,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 1003,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 14,
        id = 6,
        count = 1
      })
    }
  }),
  [4] = ProtobufI("RacePVPSegReward", {
    seg = 4,
    rewards = {
      [1] = ProtobufI("STResource", {
        type = 8,
        id = 1004,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 14,
        id = 7,
        count = 1
      })
    }
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4
}
return {raw, indexed}
