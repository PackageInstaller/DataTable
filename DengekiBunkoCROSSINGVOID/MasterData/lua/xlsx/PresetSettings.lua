local raw = {
  [1] = ProtobufI("PresetSettings", {
    settings = ProtobufI("GameSettings", {})
  }),
  [2] = ProtobufI("PresetSettings", {
    level = 1,
    settings = ProtobufI("GameSettings", {roleQuality = 1, shadowQuality = 1})
  }),
  [3] = ProtobufI("PresetSettings", {
    level = 2,
    settings = ProtobufI("GameSettings", {
      targetFramerate = 1,
      resolution = 1,
      roleQuality = 1,
      shadowQuality = 1,
      sceneEffect = 1
    })
  }),
  [4] = ProtobufI("PresetSettings", {
    level = 3,
    settings = ProtobufI("GameSettings", {
      targetFramerate = 1,
      resolution = 1,
      roleQuality = 1,
      shadowQuality = 1,
      antiAlias = 1,
      postEffect = 1,
      sceneEffect = 1
    })
  }),
  [5] = ProtobufI("PresetSettings", {
    level = 4,
    settings = ProtobufI("GameSettings", {})
  })
}
local indexed = {
  [0] = 1,
  [1] = 2,
  [2] = 3,
  [3] = 4,
  [4] = 5
}
return {raw, indexed}
