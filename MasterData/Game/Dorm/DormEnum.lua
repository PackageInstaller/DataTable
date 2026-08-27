local DormEnum = {}
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")
DormEnum.eDormState = {
  None = 0,
  House = 1,
  HouseEdit = 2,
  Room = 3,
  RoomEdit = 4,
  Room2House = 5,
  House2Room = 6
}
DormEnum.eDormFntType = {
  FloorDecoration = 1,
  WallDecoration = 2,
  Furniture = 3,
  Wall = 4,
  Floor = 5,
  Door = 6,
  Wallpaper = 7
}
DormEnum.eDmHouseUnlockLogic = {BuildingLevel = 1, CostItem = 2}

function DormEnum.IsFntWallType(fntType)
  return fntType == DormEnum.eDormFntType.WallDecoration or fntType == DormEnum.eDormFntType.Door or fntType == DormEnum.eDormFntType.Wallpaper
end

DormEnum.eDormFntCategory = {Wall = 1, Floor = 4}
DormEnum.CharInteractState = {
  None = 0,
  Fnt = 1,
  WaitExit = 2,
  Talk = 3,
  LeaveDoor = 4,
  Greet = 5
}
DormEnum.CharacterAIEventId = {
  None = 0,
  ExitState = 1,
  StartFntInteract = 101,
  ExitFntInteract = 102
}
DormEnum.DormRoomState = {
  Normal = 1,
  Editor = 2,
  Visitee = 3
}
DormEnum.VisitPageType = {
  Visitors = 1,
  VisitByMe = 2,
  Friend = 3
}
DormEnum.DormInvisiblePos = Vector3.New(10000, 10000, 10000)
DormEnum.DormAnimatorNormalName = "StandWalk"
DormEnum.DormShadowDistance = 16
DormEnum.DormLodBias = 0.2
DormEnum.FntInterReadyState = "normal"
DormEnum.ThemeCatId = 12

function DormEnum.ShowMainInfoFunc()
  GuidePicture.OpenGuidePicture(PicTipsConsts.DormMain, nil)
end

function DormEnum.ShowRoomInfoFunc()
  GuidePicture.OpenGuidePicture(PicTipsConsts.DormRoom, nil)
end

return DormEnum
