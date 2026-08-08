local raw = {
  [1] = ProtobufI("DormFloorExtensionCost", {
    floor = 1,
    level = 2,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 100}),
      [2] = ProtobufI("STResource", {type = 5, count = 100})
    }
  }),
  [2] = ProtobufI("DormFloorExtensionCost", {
    floor = 1,
    level = 3,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 200}),
      [2] = ProtobufI("STResource", {type = 5, count = 200})
    }
  }),
  [3] = ProtobufI("DormFloorExtensionCost", {
    floor = 1,
    level = 4,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 300}),
      [2] = ProtobufI("STResource", {type = 5, count = 300})
    }
  }),
  [4] = ProtobufI("DormFloorExtensionCost", {
    floor = 2,
    level = 2,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 100}),
      [2] = ProtobufI("STResource", {type = 5, count = 100})
    }
  }),
  [5] = ProtobufI("DormFloorExtensionCost", {
    floor = 2,
    level = 3,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 200}),
      [2] = ProtobufI("STResource", {type = 5, count = 200})
    }
  }),
  [6] = ProtobufI("DormFloorExtensionCost", {
    floor = 2,
    level = 4,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 300}),
      [2] = ProtobufI("STResource", {type = 5, count = 300})
    }
  }),
  [7] = ProtobufI("DormFloorExtensionCost", {
    floor = 3,
    level = 1,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 100}),
      [2] = ProtobufI("STResource", {type = 5, count = 100})
    }
  }),
  [8] = ProtobufI("DormFloorExtensionCost", {
    floor = 3,
    level = 2,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 100}),
      [2] = ProtobufI("STResource", {type = 5, count = 100})
    }
  }),
  [9] = ProtobufI("DormFloorExtensionCost", {
    floor = 3,
    level = 3,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 200}),
      [2] = ProtobufI("STResource", {type = 5, count = 200})
    }
  }),
  [10] = ProtobufI("DormFloorExtensionCost", {
    floor = 3,
    level = 4,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 300}),
      [2] = ProtobufI("STResource", {type = 5, count = 300})
    }
  }),
  [11] = ProtobufI("DormFloorExtensionCost", {
    floor = 4,
    level = 1,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 100}),
      [2] = ProtobufI("STResource", {type = 5, count = 100})
    }
  }),
  [12] = ProtobufI("DormFloorExtensionCost", {
    floor = 4,
    level = 2,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 100}),
      [2] = ProtobufI("STResource", {type = 5, count = 100})
    }
  }),
  [13] = ProtobufI("DormFloorExtensionCost", {
    floor = 4,
    level = 3,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 200}),
      [2] = ProtobufI("STResource", {type = 5, count = 200})
    }
  }),
  [14] = ProtobufI("DormFloorExtensionCost", {
    floor = 4,
    level = 4,
    cost = {
      [1] = ProtobufI("STResource", {type = 7, count = 300}),
      [2] = ProtobufI("STResource", {type = 5, count = 300})
    }
  })
}
local indexed = {
  [1] = {
    [2] = 1,
    [3] = 2,
    [4] = 3
  },
  [2] = {
    [2] = 4,
    [3] = 5,
    [4] = 6
  },
  [3] = {
    [1] = 7,
    [2] = 8,
    [3] = 9,
    [4] = 10
  },
  [4] = {
    [1] = 11,
    [2] = 12,
    [3] = 13,
    [4] = 14
  }
}
return {raw, indexed}
