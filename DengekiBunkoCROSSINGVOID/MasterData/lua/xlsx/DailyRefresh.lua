local raw = {
  [1] = ProtobufI("DailyRefresh", {
    id = 1,
    type = 1,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80002,
      count = 2
    }),
    refreshLimit = 4
  }),
  [2] = ProtobufI("DailyRefresh", {
    id = 2,
    type = 1,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80001,
      count = 1
    }),
    refreshLimit = 3
  }),
  [3] = ProtobufI("DailyRefresh", {
    id = 3,
    type = 2,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80005,
      count = 3
    }),
    refreshLimit = 6
  }),
  [4] = ProtobufI("DailyRefresh", {
    id = 4,
    type = 2,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80003,
      count = 2
    }),
    refreshLimit = 10
  }),
  [5] = ProtobufI("DailyRefresh", {
    id = 5,
    type = 1,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80006,
      count = 5
    }),
    refreshLimit = 5
  }),
  [6] = ProtobufI("DailyRefresh", {
    id = 6,
    type = 2,
    refreshRes = ProtobufI("STResource", {type = 11, id = 80009}),
    refreshLimit = 10
  }),
  [7] = ProtobufI("DailyRefresh", {
    id = 7,
    type = 2,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80011,
      count = 6
    }),
    refreshLimit = 6
  }),
  [8] = ProtobufI("DailyRefresh", {
    id = 8,
    type = 2,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80013,
      count = 3
    }),
    refreshLimit = 3
  }),
  [9] = ProtobufI("DailyRefresh", {
    id = 9,
    type = 1,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80012,
      count = 1
    }),
    refreshLimit = 1
  }),
  [10] = ProtobufI("DailyRefresh", {
    id = 10,
    type = 1,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80001,
      count = 3
    }),
    refreshLimit = 3
  }),
  [11] = ProtobufI("DailyRefresh", {
    id = 11,
    type = 1,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80016,
      count = 10
    }),
    refreshLimit = 10
  })
}
local indexed = {
  [1] = {
    [1] = 1
  },
  [2] = {
    [1] = 2
  },
  [3] = {
    [2] = 3
  },
  [4] = {
    [2] = 4
  },
  [5] = {
    [1] = 5
  },
  [6] = {
    [2] = 6
  },
  [7] = {
    [2] = 7
  },
  [8] = {
    [2] = 8
  },
  [9] = {
    [1] = 9
  },
  [10] = {
    [1] = 10
  },
  [11] = {
    [1] = 11
  }
}
return {raw, indexed}
