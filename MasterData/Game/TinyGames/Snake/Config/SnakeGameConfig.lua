local SnakeGameConfig = {
  SnakeHeadPrefab = "model_xsr",
  SnakeHeadBoyPrefab = "model_xsr_boy",
  SnakeBodyPrefab = "model_bsr",
  PlayerInitPosX = 7,
  PlayerInitPosZ = 4,
  PlayerInitDir = 4,
  PlayerInitLength = 3,
  GWorldSizeX = 16,
  GWorldSizeZ = 9,
  GWorldPointCount = 144,
  SnakeInitTime = 0.3,
  SnakeMinTime = 0.1,
  SnakeIncreaseNumber = 100,
  RotateAniRatio = 0.2,
  QuickDirRatio = 0.68,
  QuickDirTimeScale = 1.25,
  EndWaitTime = 1,
  JoyStickDeadZone = 8,
  JoyStickPowerZone = 0.16
}
SnakeGameConfig.DirVectorMap = {
  [1] = {x = 0, y = -1},
  [2] = {x = 0, y = 1},
  [3] = {x = -1, y = 0},
  [4] = {x = 1, y = 0}
}
SnakeGameConfig.DirResverMap = {
  [1] = 2,
  [2] = 1,
  [3] = 4,
  [4] = 3
}
SnakeGameConfig.DirRorate = {
  [1] = Vector3.New(0, 180, 0),
  [2] = Vector3.New(0, 0, 0),
  [3] = Vector3.New(0, 90, 0),
  [4] = Vector3.New(0, 270, 0)
}
return SnakeGameConfig
