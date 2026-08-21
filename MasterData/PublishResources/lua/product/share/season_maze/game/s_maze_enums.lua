local UISeasonMazeID = {SM1 = 9001}
_enum("UISeasonMazeID", UISeasonMazeID)
local SMazeStateID = {
  Born = "Born",
  ChooseRelic = "ChooseRelic",
  RoundBegin = "RoundBegin",
  PlayCard = "PlayCard",
  CardSettle = "CardSettle",
  PlayerMove = "PlayerMove",
  ArriveRoom = "ArriveRoom",
  RoomSettle = "RoomSettle",
  RoundEnd = "RoundEnd",
  BossAttack = "BossAttack",
  MazeComplete = "MazeComplete",
  Levelup = "Levelup",
  ChooseFullPet = "ChooseFullPet",
  WorldBoss = "WorldBoss"
}
_enum("SMazeStateID", SMazeStateID)
local SMazeCardQualityType = {
  Blue = 1,
  Purple = 2,
  Orange = 3
}
_enum("SMazeCardQualityType", SMazeCardQualityType)
local SMazeSceneLayer = {Arrow = 13, Room = 14}
_enum("SMazeSceneLayer", SMazeSceneLayer)
local SeasonMazePlayerAnimation = {
  Move = "smove",
  Stand = "stand",
  BattleIdle = "battleidle",
  Interact = "interact",
  Click = "click"
}
_enum("SeasonMazePlayerAnimation", SeasonMazePlayerAnimation)
local SMazeNodeState = {
  None = 0,
  UnReachable = 1,
  Reachable = 2,
  StayTemp = 3
}
_enum("SMazeNodeState", SMazeNodeState)
local SMazeRelicReason = {
  ChooseRelic = 1,
  ChooseRelicLastTime = 2,
  BuyRelic = 3,
  Box = 4
}
_enum("SMazeRelicReason", SMazeRelicReason)
local SMazeBattleExitState = {
  None = 0,
  RoomBattleFailed = 1,
  RoomBattleSuccess = 2,
  BossBattleFailed = 3,
  BossBattleSuccess = 4
}
_enum("SMazeBattleExitState", SMazeBattleExitState)
