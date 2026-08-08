local raw = {
  [1] = ProtobufI("DungeonOpenTime", {
    id = 1,
    openTime = "2019-5-19 00:00:00",
    zone = 1
  }),
  [2] = ProtobufI("DungeonOpenTime", {
    id = 2,
    openTime = "2019-6-07 06:00:00",
    zone = 2
  }),
  [3] = ProtobufI("DungeonOpenTime", {
    id = 3,
    openTime = "2019-6-14 06:00:00",
    zone = 3
  })
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}
return {raw, indexed}
