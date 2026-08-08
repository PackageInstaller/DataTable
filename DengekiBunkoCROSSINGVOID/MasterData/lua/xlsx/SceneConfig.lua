local raw = {
  [1] = ProtobufI("SceneConfig", {
    sceneName = "ScenePatch",
    keepDeviceAwake = true,
    fadeWhenEnter = true
  }),
  [2] = ProtobufI("SceneConfig", {sceneName = "SceneLogin", fadeWhenEnter = true}),
  [3] = ProtobufI("SceneConfig", {
    sceneName = "SceneCity",
    fadeWhenExit = true,
    fadeWhenEnter = true
  }),
  [4] = ProtobufI("SceneConfig", {
    sceneName = "SceneCartoon",
    keepDeviceAwake = true,
    fadeWhenExit = true,
    fadeWhenEnter = true
  }),
  [5] = ProtobufI("SceneConfig", {
    sceneName = "SceneFight",
    detailLoading = true,
    keepDeviceAwake = true,
    fadeWhenExit = true,
    fadeWhenEnter = true
  }),
  [6] = ProtobufI("SceneConfig", {
    sceneName = "SceneBalance",
    fadeWhenExit = true,
    fadeWhenEnter = true
  })
}
local indexed = {
  SceneBalance = 6,
  SceneCartoon = 4,
  SceneCity = 3,
  SceneFight = 5,
  SceneLogin = 2,
  ScenePatch = 1
}
return {raw, indexed}
