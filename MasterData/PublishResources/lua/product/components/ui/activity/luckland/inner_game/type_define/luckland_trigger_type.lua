LuckLandTriggerType = {
  None = 0,
  Always = 1,
  Prob = 2,
  PetIDCount = 3,
  PetTagCount = 4,
  DisNPetTagCount = 5,
  MonsterCount = 6,
  PetPos = 7,
  IsLeader = 8,
  IsTail = 9,
  IsSameElementLT = 10,
  IsElementTriplet = 11,
  IsDeletingSelf = 12,
  ElementCount = 13,
  PosHasPet = 14
}
_enum("LuckLandTriggerType", LuckLandTriggerType)
local LuckLandTriggerCompareType = {
  Less = 1,
  LessEqual = 2,
  Equal = 3,
  MoreThan = 4,
  MoreThanEqual = 5
}
_enum("LuckLandTriggerCompareType", LuckLandTriggerCompareType)
local LuckLandTriggerPosType = {
  Morning = 1,
  Midday = 2,
  Night = 3,
  Bag = 4
}
_enum("LuckLandTriggerPosType", LuckLandTriggerPosType)
local LuckLandTriggerOperateType = {Or = 1, And = 2}
_enum("LuckLandTriggerOperateType", LuckLandTriggerOperateType)
local LuckLandTriggerIsSelf = {True = 1, False = 2}
_enum("LuckLandTriggerIsSelf", LuckLandTriggerIsSelf)
