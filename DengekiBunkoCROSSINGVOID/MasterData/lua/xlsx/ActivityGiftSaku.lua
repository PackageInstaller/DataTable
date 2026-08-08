local raw = {
  [1] = ProtobufI("ActivityGiftSaku", {
    mallId = 496,
    activityId = 74001,
    voice = "voice",
    text = "text"
  }),
  [2] = ProtobufI("ActivityGiftSaku", {
    mallId = 497,
    activityId = 74001,
    voice = "voice"
  })
}
local indexed = {
  [496] = 1,
  [497] = 2
}
return {raw, indexed}
