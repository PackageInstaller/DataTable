local raw = {
  [1] = ProtobufI("ShareReward", {
    activityId = 24001,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
  }),
  [2] = ProtobufI("ShareReward", {
    activityId = 24002,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
  }),
  [3] = ProtobufI("ShareReward", {
    activityId = 24003,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      })
    }
  })
}
local indexed = {
  [24001] = 1,
  [24002] = 2,
  [24003] = 3
}
return {raw, indexed}
