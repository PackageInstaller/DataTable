local AILogicPeriodType = {
  Main = 1,
  Prev = 2,
  Anti = 3,
  BeforeMain = 5,
  AfterMain = 6,
  RoundResult = 7,
  RoundEnterBeforePlayer = 8
}
_enum("AILogicPeriodType", AILogicPeriodType)
local AILogicOrderType = {BaseOrder = 1000}
_enum("AILogicOrderType", AILogicOrderType)
AINewNodeStatus = {
  Ready = 0,
  Running = 1,
  Success = 2,
  Failure = 3,
  Other = 10
}
_enum("AINewNodeStatus", AINewNodeStatus)
AITargetType = {Normal = 0, Team = 1}
_enum("AITargetType", AITargetType)
AIEndReasonType = {
  NoMobility = 1,
  SelfDead = 2,
  TargetDead = 3,
  SkipTurn = 4,
  RoundEnd = 5
}
_enum("AIEndReasonType", AIEndReasonType)
AIRideStateType = {
  NoRide = 1,
  RideOnTrap = 2,
  RideOnMonster = 3,
  BeRide = 4,
  NoRideInRange = 5
}
_enum("AIRideStateType", AIRideStateType)
AIEntityInTargetRangeType = {
  NoRideInRange = 1,
  RideOnTrapInRange = 2,
  RideOnMonsterInRange = 3,
  NotInRange = 4
}
_enum("AIEntityInTargetRangeType", AIEntityInTargetRangeType)
AIAlphaRoundCount = {
  First = 1,
  Second = 2,
  Third = 3
}
_enum("AIAlphaRoundCount", AIAlphaRoundCount)
