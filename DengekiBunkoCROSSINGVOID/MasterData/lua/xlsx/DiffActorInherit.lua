local raw = {
  [1] = ProtobufI("DiffActorInherit", {
    actorId = 1008,
    activityId = 33001,
    targetId = {
      [1] = 1007,
      [2] = 1018
    }
  })
}
local indexed = {
  [33001] = 1
}
return {raw, indexed}
