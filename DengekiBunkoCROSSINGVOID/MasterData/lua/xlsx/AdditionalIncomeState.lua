local raw = {
  [1] = ProtobufI("AdditionalIncomeState", {
    id = 1,
    resType = 6,
    addtionalChance = 1000
  }),
  [2] = ProtobufI("AdditionalIncomeState", {
    id = 2,
    resType = 7,
    addtionalChance = 1000
  })
}
local indexed = {
  [1] = 1,
  [2] = 2
}
return {raw, indexed}
