local raw = {
  [1] = ProtobufI("ActorCultivationEmote", {
    actorId = 1502,
    scale = 0.9,
    Xoffset = 60,
    Yoffset = -65
  }),
  [2] = ProtobufI("ActorCultivationEmote", {
    actorId = 1514,
    scale = 0.9,
    Xoffset = 45,
    Yoffset = -135
  })
}
local indexed = {
  [1502] = 1,
  [1514] = 2
}
return {raw, indexed}
