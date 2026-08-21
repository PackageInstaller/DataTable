local SeasonEventPointLoadState = {
  None = 0,
  Wait = 1,
  Loading = 2,
  Invalid = 3,
  Finish = 4,
  Closed = 5
}
_enum("SeasonEventPointLoadState", SeasonEventPointLoadState)
local SeasonEventPointLoadType = {Sync = 1, Async = 2}
_enum("SeasonEventPointLoadType", SeasonEventPointLoadType)
local SeasonZone = {
  One = 1,
  Two = 2,
  Three = 3,
  Four = 4
}
_enum("SeasonZone", SeasonZone)
local SeasonCameraMode = {Drag = 1, Follow = 2}
_enum("SeasonCameraMode", SeasonCameraMode)
local SeasonPlayerAnimation = {
  Move = "smove",
  Stand = "stand",
  BattleIdle = "battleidle"
}
_enum("SeasonPlayerAnimation", SeasonPlayerAnimation)
local SeasonLayerMask = {
  Default = 0,
  UI = 5,
  Stage = 13,
  Scene = 20
}
_enum("SeasonLayerMask", SeasonLayerMask)
local SeasonSceneLayer = {
  SoundMaterial = "Layer",
  ZoneFlag = "Layer0",
  Ground = "Layer1",
  Building = "Layer2",
  HighBuilding = "Layer3",
  FogMask = "Layer4",
  Ambient = "Layer5",
  AmbientMap = "Layer7"
}
_enum("SeasonSceneLayer", SeasonSceneLayer)
local SeasonExpressTriggerType = {
  Active = 1,
  Passive = 2,
  Trigger = 3
}
_enum("SeasonExpressTriggerType", SeasonExpressTriggerType)
local SeasonExpressType = {
  Level = 1,
  Animation = 2,
  Effect = 3,
  Story = 4,
  Bubble = 5,
  Reward = 6,
  Show = 7,
  Obstacle = 8,
  Focus = 9,
  LockInput = 10,
  Sign = 11,
  UI = 12,
  Transmit = 13,
  Transitions = 14,
  UnlockZone = 15,
  Born = 16,
  Delay = 17,
  Story3D = 18,
  Function = 19
}
_enum("SeasonExpressType", SeasonExpressType)
local SeasonExpressFocusObjType = {
  Player = 1,
  EventPoint = 2,
  Position = 3
}
_enum("SeasonExpressFocusObjType", SeasonExpressFocusObjType)
local SeasonExpressFocusType = {
  Left = 1,
  Center = 2,
  Right = 3
}
_enum("SeasonExpressFocusType", SeasonExpressFocusType)
local SeasonExpressState = {
  NotStart = 1,
  Playing = 2,
  Over = 3
}
_enum("SeasonExpressState", SeasonExpressState)
local SeasonInputMode = {Input = 1, LockInput = 2}
_enum("SeasonInputMode", SeasonInputMode)
local UISeasonLevelDiff = {Normal = 1, Hard = 2}
_enum("UISeasonLevelDiff", UISeasonLevelDiff)
local UISeasonOvalTipType = {
  Player = 1,
  Mission = 2,
  Box = 3,
  Daily = 4,
  Task = 5
}
_enum("UISeasonOvalTipType", UISeasonOvalTipType)
local ESeasonExtInfo = {SeasonFirstPlotReadState = 1}
_enum("ESeasonExtInfo", ESeasonExtInfo)
local SeasonClickEffectPhase = {
  None = 0,
  Click = 1,
  In = 2,
  Loop = 3
}
_enum("SeasonClickEffectPhase", SeasonClickEffectPhase)
local SeasonMapMaterial = {
  Default = 1,
  Metal = 2,
  Stone = 3,
  Water = 4
}
_enum("SeasonMapMaterial", SeasonMapMaterial)
local SeasonInputPhase = {
  None = 0,
  Down = 2,
  Up = 3
}
_enum("SeasonInputPhase", SeasonInputPhase)
local SeasonDailyState = {
  Lock = 0,
  Time = 1,
  Mission = 2,
  MaxReward = 3,
  Unlock = 4
}
_enum("SeasonDailyState", SeasonDailyState)
local SeasonResetPhase = {
  None = 0,
  Waiting = 1,
  Reseting = 2,
  Success = 3
}
_enum("SeasonResetPhase", SeasonResetPhase)
local SeasonExpressTiming = {Before = 1, Play = 2}
_enum("SeasonExpressTiming", SeasonExpressTiming)
local SeasonPlayerExpressType = {
  None = 0,
  Click = 1,
  Relax = 2,
  Moving = 3
}
_enum("SeasonPlayerExpressType", SeasonPlayerExpressType)
local SeasonBubbleObjectType = {Player = 1, EventPoint = 2}
_enum("SeasonBubbleObjectType", SeasonBubbleObjectType)
local SeasonTriggerShapeType = {Rect = 1, Circle = 2}
_enum("SeasonTriggerShapeType", SeasonTriggerShapeType)
local SeasonTriggerType = {
  Once = 1,
  Count = 2,
  Loop = 3
}
_enum("SeasonTriggerType", SeasonTriggerType)
local SeasonTriggerState = {Wait = 1, Finish = 2}
_enum("SeasonTriggerState", SeasonTriggerState)
local SeasonMapMode = {
  None = 0,
  Mode1 = 1,
  Mode2 = 2
}
_enum("SeasonMapMode", SeasonMapMode)
local SeasonBornType = {Before = 1, Play = 2}
_enum("SeasonBornType", SeasonBornType)
local UISeasonLevelStagePanelMode = {AwardsInfo = 1, BattleInfo = 2}
_enum("UISeasonLevelStagePanelMode", UISeasonLevelStagePanelMode)
local SeasonFunctionType = {None = 1, PlayExpress = 2}
_enum("SeasonFunctionType", SeasonFunctionType)
local SeasonEventPointModelType = {
  None = 1,
  UI = 2,
  Spine = 3
}
_enum("SeasonEventPointModelType", SeasonEventPointModelType)
local SeasonNavArea = {
  Walkable = 1,
  SeasonZone1 = 512,
  SeasonZone2 = 1024,
  SeasonZone3 = 2048,
  SeasonZone4 = 4096,
  SeasonZone5 = 8192,
  SeasonZone6 = 16384
}
_enum("SeasonNavArea", SeasonNavArea)
local SeaonPlayerEnterStyle = {Direct = 1, NavFromNearesTransPoint = 2}
_enum("SeaonPlayerEnterStyle", SeaonPlayerEnterStyle)
