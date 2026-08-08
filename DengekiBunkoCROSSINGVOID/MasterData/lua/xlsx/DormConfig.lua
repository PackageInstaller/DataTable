local raw = {
  [1] = ProtobufI("DormConfig", {
    level = 1,
    floorLevel = {
      [1] = 1,
      [2] = 0
    }
  }),
  [2] = ProtobufI("DormConfig", {
    level = 2,
    floorLevel = {
      [1] = 2,
      [2] = 0
    }
  }),
  [3] = ProtobufI("DormConfig", {
    level = 3,
    floorLevel = {
      [1] = 3,
      [2] = 0
    }
  }),
  [4] = ProtobufI("DormConfig", {
    level = 4,
    floorLevel = {
      [1] = 4,
      [2] = 0
    }
  }),
  [5] = ProtobufI("DormConfig", {
    level = 5,
    floorLevel = {
      [1] = 4,
      [2] = 1
    }
  }),
  [6] = ProtobufI("DormConfig", {
    level = 6,
    floorLevel = {
      [1] = 4,
      [2] = 2
    }
  }),
  [7] = ProtobufI("DormConfig", {
    level = 7,
    floorLevel = {
      [1] = 4,
      [2] = 3
    }
  }),
  [8] = ProtobufI("DormConfig", {
    level = 8,
    floorLevel = {
      [1] = 4,
      [2] = 4
    }
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
  [8] = 8
}
return {raw, indexed}
