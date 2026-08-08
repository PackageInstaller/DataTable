local raw = {
  [1] = ProtobufI("RacePVPSeg", {
    id = 1,
    seg = 1,
    subSeg = 1,
    score = 200,
    protect = true,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 60})
    }
  }),
  [2] = ProtobufI("RacePVPSeg", {
    id = 2,
    seg = 1,
    subSeg = 2,
    score = 205,
    protect = true,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 65})
    }
  }),
  [3] = ProtobufI("RacePVPSeg", {
    id = 3,
    seg = 1,
    subSeg = 3,
    score = 215,
    protect = true,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 70})
    }
  }),
  [4] = ProtobufI("RacePVPSeg", {
    id = 4,
    seg = 2,
    subSeg = 1,
    score = 230,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 75})
    }
  }),
  [5] = ProtobufI("RacePVPSeg", {
    id = 5,
    seg = 2,
    subSeg = 2,
    score = 250,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 80})
    }
  }),
  [6] = ProtobufI("RacePVPSeg", {
    id = 6,
    seg = 2,
    subSeg = 3,
    score = 275,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 85})
    }
  }),
  [7] = ProtobufI("RacePVPSeg", {
    id = 7,
    seg = 3,
    subSeg = 1,
    score = 305,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 95})
    }
  }),
  [8] = ProtobufI("RacePVPSeg", {
    id = 8,
    seg = 3,
    subSeg = 2,
    score = 340,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 100})
    }
  }),
  [9] = ProtobufI("RacePVPSeg", {
    id = 9,
    seg = 3,
    subSeg = 3,
    score = 380,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 105})
    }
  }),
  [10] = ProtobufI("RacePVPSeg", {
    id = 10,
    seg = 4,
    subSeg = 1,
    score = 450,
    protect = true,
    rewards = {
      [1] = ProtobufI("STResource", {type = 5, count = 120})
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
  [8] = 8,
  [9] = 9,
  [10] = 10
}
return {raw, indexed}
