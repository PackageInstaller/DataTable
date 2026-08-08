local raw = {
  [1] = ProtobufI("DormComfortConfig", {subCategory = 1, comfortCount = 2}),
  [2] = ProtobufI("DormComfortConfig", {subCategory = 2, comfortCount = 3}),
  [3] = ProtobufI("DormComfortConfig", {subCategory = 3, comfortCount = 4})
}
local indexed = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}
return {raw, indexed}
