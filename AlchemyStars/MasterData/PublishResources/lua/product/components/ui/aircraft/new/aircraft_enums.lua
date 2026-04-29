local AircraftConst = {DecorateAreaCount = 25}
_enum("AircraftConst", AircraftConst)
local AirPetState = {
  None = 0,
  Wandering = 1,
  OnFurniture = 2,
  Transiting = 3,
  WaitingElevator = 4,
  InElevator = 5,
  Social = 6,
  Leaving = 7,
  Working = 8,
  Selected = 9,
  RandomEvent = 10,
  WaitForEnter = 11,
  RandomEventWith = 12,
  Upstairs = 13,
  MoveToWork = 14,
  SendingGift = 15,
  Testing = 1000,
  END = 9999
}
_enum("AirPetState", AirPetState)
local AirRestAreaType = {
  RestRoom = 10001,
  CoffeeHouse = 10002,
  Bar = 10003,
  EntertainmentRoom = 10004,
  Board3 = 10005,
  Board4 = 10006,
  CenterRoom = 10007,
  None = 9999
}
_enum("AirRestAreaType", AirRestAreaType)
local AirUIState = {
  SpaceNotOpen = 0,
  SpaceUnclean = 1,
  SpaceUnbuild = 2,
  AisleNotOpen = 3,
  AisleUnclean = 4,
  AisleUnbuild = 5,
  Aisle = 6,
  RoomBuilding = 7,
  RoomIdle = 8,
  RoomUpgrading = 9,
  RoomStopWork = 10,
  EvilClearing = 11,
  EvilClearEnd = 12,
  SpaceCleaning = 13,
  RoomDegrading = 14,
  RoomTearing = 15,
  CollectAward = 16,
  RestAreaRoom = 17,
  RestAreaRoomLock = 18,
  CanCollectAward = 19,
  HaveNewTask = 20,
  SpaceClosed = 21
}
_enum("AirUIState", AirUIState)
local AirFurnitureType = {
  RestChair = 1001,
  RestEmpty = 1002,
  RestSofa = 1003,
  RestChess = 1004,
  RestRobot = 1005,
  CoffeeShelf = 2003,
  CoffeeDesk = 2004,
  CoffeeMachine = 2005,
  CoffeeSpecimen = 2006,
  GameDarts = 3003,
  GameSnooker = 3004,
  GameBoxingBall = 3005,
  GameMachine = 3006,
  BarWineTable = 4003,
  BarCounter = 4004,
  BarStage = 4005,
  BarMusicBox = 4006,
  None = 9999
}
_enum("AirFurnitureType", AirFurnitureType)
local AirRandomActionType = {Wandering = 1, Furniture = 2}
_enum("AirRandomActionType", AirRandomActionType)
local AircraftRoomTag = {
  RestRoom = 1,
  CoffeeHouse = 2,
  Bar = 3,
  Game = 4
}
_enum("AircraftRoomTag", AircraftRoomTag)
local AircraftSocialTag = {
  Hot = 1,
  Normal = 2,
  Lone = 3
}
_enum("AircraftSocialTag", AircraftSocialTag)
local AirSocialAreaType = {Work = 1, Happy = 2}
_enum("AirSocialAreaType", AirSocialAreaType)
local AirSocialActionType = {
  Gather = 1,
  WalkTalk = 2,
  Furniture = 3
}
_enum("AirSocialActionType", AirSocialActionType)
local AirGroupActionStateType = {
  None = 0,
  Move = 1,
  Follow = 2,
  LookAt = 3,
  Talk = 4,
  Furniture = 5,
  Stand = 6,
  Closer = 7,
  Located = 8,
  Correct = 9,
  MoveTalk = 10,
  FurnitureTalk = 11
}
_enum("AirGroupActionStateType", AirGroupActionStateType)
local AirSocialSubLibType = {
  [AirGroupActionStateType.MoveTalk] = {
    AirGroupActionStateType.Move,
    AirGroupActionStateType.LookAt,
    AirGroupActionStateType.Stand
  }
}
_enum("AirSocialSubLibType", AirSocialSubLibType)
local AirPetMoveState = {
  Moving = 1,
  Blocked = 2,
  Pausing = 3,
  Prepare = 4,
  Arrived = 5,
  Prepare1 = 6,
  NONE = 99
}
_enum("AirPetMoveState", AirPetMoveState)
local AirPetCalcNextActionState = {
  None = 0,
  Prepare = 1,
  Calculate = 2,
  Finish = 3,
  Wait = 4,
  Max = 99
}
_enum("AirPetCalcNextActionState", AirPetCalcNextActionState)
local AirFurnitureSeqType = {
  XiaQi = 10001,
  WuTai = 20001,
  TaiQiu = 30001,
  BiaoBen = 40001
}
_enum("AirFurnitureSeqType", AirFurnitureSeqType)
local AirRelationType = {
  Pets = 1,
  ShiLi = 2,
  All = 3
}
_enum("AirRelationType", AirRelationType)
local AirStairDoorState = {
  Idle = 1,
  Opening = 2,
  Stay = 3,
  Closing = 4
}
_enum("AirStairDoorState", AirStairDoorState)
local AirPetStairState = {
  Enter = 1,
  Hide = 2,
  Wait = 3,
  Exit = 4,
  Finish = 5
}
_enum("AirPetStairState", AirPetStairState)
local AirPetFurState = {
  FadeIn = 1,
  Idle = 2,
  FadeOut = 3,
  None = 4
}
_enum("AirPetFurState", AirPetFurState)
local AircraftLayer = {
  Default = 1,
  Ground = 13,
  Smelt = 14,
  Tactic = 15,
  Award = 18,
  Pet = 20,
  BookShelf = 21,
  DispatchTaskMap = 22,
  Furniture = 23,
  Surface = 24,
  DragLayer = 25
}
_enum("AircraftLayer", AircraftLayer)
local AirPetAnimName = {
  Stand = "stand",
  Walk = "walk",
  Click = "click01",
  Sit = "sit"
}
_enum("AirPetAnimName", AirPetAnimName)
local ElevatorState = {
  Idle = 1,
  Moving = 2,
  WaitEnter = 3,
  WaitExit = 4,
  Delivering = 5
}
_enum("ElevatorState", ElevatorState)
local AircraftSpeed = {Pet = 0.9, Elevator = 1.5}
_enum("AircraftSpeed", AircraftSpeed)
local AircraftDoorAnim = {
  BuildRoom = 1,
  TearDown = 2,
  LevelUp = 3,
  LevelDown = 4
}
_enum("AircraftDoorAnim", AircraftDoorAnim)
local AircraftNavAgent = {Normal = 0, Oversize = 1}
_enum("AircraftNavAgent", AircraftNavAgent)
local AircraftMode = {Normal = 0, Decorate = 1}
_enum("AircraftMode", AircraftMode)
local AircraftFurnitureLayer = {
  First = 1,
  Second = 2,
  Third = 3
}
_enum("FurnitureLayer", AircraftFurnitureLayer)
local AircraftDecorateMode = {FullView = 1, Edit = 2}
_enum("DecorateMode", AircraftDecorateMode)
local FurnitureOpration = {
  Steady = 1,
  Movable = 2,
  Free = 3
}
_enum("FurnitureOpration", FurnitureOpration)
local LocationType = {
  Floor = 0,
  Wall = 1,
  Ceiling = 2
}
_enum("LocationType", LocationType)
local AircraftSocialTalkType = {Normal = 1, RealTalk = 2}
_enum("AircraftSocialTalkType", AircraftSocialTalkType)
local AircraftSpecialActionType = {
  PresentBag = 1,
  Name = 2,
  Light = 3
}
_enum("AircraftSpecialActionType", AircraftSpecialActionType)
local AircraftPetFurSpacialActionType = {WithGivenPoint = 1, OccupyFurniture = 2}
_enum("AircraftPetFurSpacialActionType", AircraftPetFurSpacialActionType)
local AircraftPetMoveToDoState = {
  MoveToElevator = 1,
  MoveToStair = 2,
  Wait = 3,
  Blocked = 4,
  MoveToActionTarget = 5,
  Stop = 6
}
_enum("AircraftPetMoveToDoState", AircraftPetMoveToDoState)
local AircraftPetMoveType = {
  ToWandering = 1,
  ToFurniture = 2,
  ToWork = 3,
  ToLeave = 4
}
_enum("AircraftPetMoveType", AircraftPetMoveType)
local AircraftPetLoadState = {
  None = 0,
  Wait = 1,
  Loading = 2,
  Invalid = 3,
  Finish = 4,
  Closed = 5
}
_enum("AircraftPetLoadState", AircraftPetLoadState)
local AircraftPetGiftBubble = {
  Gift = "eff_meme_liwuhe.prefab",
  VisitName = "UIAircraftVisitPetName.prefab",
  Light = "eff_aircraft_guest.prefab"
}
_enum("AircraftPetGiftBubble", AircraftPetGiftBubble)
local AircraftPetGiftTag = {Gift = 1, Visit = 2}
_enum("AircraftPetGiftTag", AircraftPetGiftTag)
local AircraftPetSlotType = {
  None = 0,
  Root = 1,
  Head = 2,
  Custom = 3
}
_enum("AircraftPetSlotType", AircraftPetSlotType)
local AircraftWaitElevState = {
  MoveToLine = 1,
  WaitInLine = 2,
  MoveToNext = 3,
  Finished = 4
}
_enum("AircraftWaitElevState", AircraftWaitElevState)
local AircraftActionType = {None = 0, Face = 1}
_enum("AircraftActionType", AircraftActionType)
