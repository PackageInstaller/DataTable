local raw = {
  [1] = ProtobufI("RDPVPReward", {
    winCnt = 1,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50})
    }
  }),
  [2] = ProtobufI("RDPVPReward", {
    winCnt = 2,
    reward = {
      [1] = ProtobufI("STResource", {type = 5, count = 50})
    }
  })
}
local indexed = {
  [1] = 1,
  [2] = 2
}
return {raw, indexed}
