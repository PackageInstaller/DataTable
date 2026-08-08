local raw = {
  [1] = ProtobufI("TaskActivityPointReward", {
    activityId = 81001,
    activePoint = 3,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 61001,
        count = 1
      })
    }
  }),
  [2] = ProtobufI("TaskActivityPointReward", {
    activityId = 81001,
    activePoint = 5,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 124002,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 61001,
        count = 1
      })
    }
  }),
  [3] = ProtobufI("TaskActivityPointReward", {
    activityId = 81001,
    activePoint = 7,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 1
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 61001,
        count = 1
      })
    }
  }),
  [4] = ProtobufI("TaskActivityPointReward", {
    activityId = 81002,
    activePoint = 3,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 9
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 61001,
        count = 9
      })
    }
  }),
  [5] = ProtobufI("TaskActivityPointReward", {
    activityId = 81002,
    activePoint = 5,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 124002,
        count = 9
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 61001,
        count = 9
      })
    }
  }),
  [6] = ProtobufI("TaskActivityPointReward", {
    activityId = 81002,
    activePoint = 7,
    reward = {
      [1] = ProtobufI("STResource", {
        type = 11,
        id = 60001,
        count = 9
      }),
      [2] = ProtobufI("STResource", {
        type = 11,
        id = 61001,
        count = 9
      })
    }
  })
}
local indexed = {
  [81001] = {
    [3] = 1,
    [5] = 2,
    [7] = 3
  },
  [81002] = {
    [3] = 4,
    [5] = 5,
    [7] = 6
  }
}
return {raw, indexed}
