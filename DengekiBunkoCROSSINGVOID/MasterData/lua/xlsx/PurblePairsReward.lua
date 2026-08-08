local raw = {
  [1] = ProtobufI("PurblePairsReward", {
    matchedPairs = 9,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 11500}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2009,
        count = 1
      })
    }
  }),
  [2] = ProtobufI("PurblePairsReward", {
    matchedPairs = 7,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 10000}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2009,
        count = 1
      })
    }
  }),
  [3] = ProtobufI("PurblePairsReward", {
    matchedPairs = 5,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 9000}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2009,
        count = 1
      })
    }
  }),
  [4] = ProtobufI("PurblePairsReward", {
    matchedPairs = 3,
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 7500}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2009,
        count = 1
      })
    }
  }),
  [5] = ProtobufI("PurblePairsReward", {
    reward = {
      [1] = ProtobufI("STResource", {type = 7, count = 6000}),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 2009,
        count = 1
      })
    }
  })
}
local indexed = {}
return {raw, indexed}
