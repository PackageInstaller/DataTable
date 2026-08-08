local raw = {
  [1] = ProtobufI("ClawCrane", {
    id = 1,
    res = ProtobufI("STResource", {
      type = 11,
      id = 75001,
      count = 1
    }),
    stock = 10,
    probability = 90,
    isCountLimit = true,
    isUnique = true,
    getAnim = true
  }),
  [2] = ProtobufI("ClawCrane", {
    id = 2,
    res = ProtobufI("STResource", {
      type = 11,
      id = 75002,
      count = 1
    }),
    stock = 200,
    probability = 1800,
    isCountLimit = true,
    getAnim = true
  }),
  [3] = ProtobufI("ClawCrane", {
    id = 3,
    res = ProtobufI("STResource", {
      type = 11,
      id = 75003,
      count = 1
    }),
    stock = 350,
    probability = 3000,
    isCountLimit = true,
    getAnim = true
  }),
  [4] = ProtobufI("ClawCrane", {
    id = 4,
    res = ProtobufI("STResource", {
      type = 11,
      id = 71002,
      count = 1
    }),
    probability = 200000,
    getAnim = true
  }),
  [5] = ProtobufI("ClawCrane", {
    id = 5,
    res = ProtobufI("STResource", {
      type = 11,
      id = 71012,
      count = 1
    }),
    probability = 200000,
    getAnim = true
  }),
  [6] = ProtobufI("ClawCrane", {
    id = 6,
    res = ProtobufI("STResource", {
      type = 11,
      id = 71022,
      count = 1
    }),
    probability = 200000,
    getAnim = true
  }),
  [7] = ProtobufI("ClawCrane", {
    id = 7,
    res = ProtobufI("STResource", {
      type = 11,
      id = 71032,
      count = 1
    }),
    probability = 200000,
    getAnim = true
  }),
  [8] = ProtobufI("ClawCrane", {
    id = 8,
    res = ProtobufI("STResource", {
      type = 11,
      id = 60001,
      count = 1
    }),
    probability = 1500000,
    getAnim = true
  }),
  [9] = ProtobufI("ClawCrane", {
    id = 9,
    res = ProtobufI("STResource", {
      type = 11,
      id = 75004,
      count = 1
    }),
    probability = 3200000
  }),
  [10] = ProtobufI("ClawCrane", {
    id = 10,
    res = ProtobufI("STResource", {
      type = 11,
      id = 75005,
      count = 1
    }),
    probability = 4495110
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9,
  [10] = 10
}
return {raw, indexed}
