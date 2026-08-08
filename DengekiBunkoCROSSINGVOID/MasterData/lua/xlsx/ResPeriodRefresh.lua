local raw = {
  [1] = ProtobufI("ResPeriodRefresh", {
    id = 1,
    day = 2,
    refreshRes = ProtobufI("STResource", {
      type = 11,
      id = 80007,
      count = 1
    }),
    refreshLimit = 2
  })
}
local indexed = {
  [1] = 1
}
return {raw, indexed}
