local HomelandMode = {
  Normal = 1,
  Build = 2,
  Story = 3
}
_enum("HomelandMode", HomelandMode)
_enum("HomelandCharMoveType", HomelandCharMoveType)
HomelandCharMoveType = {
  Idle = 0,
  Walk = 1,
  Run = 2,
  Rush = 3
}
local HomelandMapIconType = {
  Player = 1,
  Pet = 2,
  FishingPoint = 3,
  CommonBuild = 4,
  WhiteTower = 5,
  BreedLand = 6,
  Shop = 7,
  Treasure = 8,
  StorageBox = 9,
  Domitory = 10,
  FindTreasureNPC = 11,
  TracePoint = 12,
  WishCoinPoint = 13,
  RareFishingPoint = 14,
  PetFishingPoint = 15
}
_enum("HomelandMapIconType", HomelandMapIconType)
local HomelandFishingPointType = {
  Normal = 1,
  River = 2,
  Gold = 3,
  Box = 4,
  GoldPetFish = 5
}
_enum("HomelandFishingPointType", HomelandFishingPointType)
local HomelandFilterType = {
  All = 1,
  Edit = 2,
  Forge = 3
}
_enum("HomelandFilterType", HomelandFilterType)
