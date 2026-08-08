local raw = {
  [1] = ProtobufI("SpecialDevice", {
    hasBottomLine = {
      [1] = "iPhone10,3",
      [2] = "iPhone10,6",
      [3] = "iPhone11,8",
      [4] = "iPhone11,2",
      [5] = "iPhone11,4",
      [6] = "iPhone11,6"
    }
  })
}
local indexed = {}
return {raw, indexed}
