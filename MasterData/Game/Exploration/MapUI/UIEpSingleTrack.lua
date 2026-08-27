local UIEpSingleTrack = class("UIEpSingleTrack", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UIEpSingleTrack:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.lineDefaultColor = self.ui.img_Trunk.color
  self.lineDefaultHeight = self.ui.img_Trunk.transform.sizeDelta.y
  self.traceType = ExplorationEnum.eTrackLineType.SingleTrack
end

function UIEpSingleTrack:InitEpSingleTrack(roomData, trunkSizeX)
  self.roomData = roomData
  local sizeDeltaY = self.ui.img_Trunk.transform.sizeDelta.y
  self.ui.img_Trunk.transform.sizeDelta = Vector2.New(trunkSizeX, sizeDeltaY)
  local sizeDeltaY = self.ui.img_Trunk.transform.sizeDelta.y
  self.ui.img_Line.transform.sizeDelta = Vector2.New(trunkSizeX, sizeDeltaY)
  local nextRoom = roomData:GetNextParallelRoom()
  local nextLineShow = nextRoom ~= nil and nextRoom:GetVisible()
  self.__nextRoomPos = nextRoom ~= nil and nextRoom.position
  self.ui.img_Trunk.gameObject:SetActive(self.roomData:GetVisible() and nextLineShow)
end

function UIEpSingleTrack:SetTrunkLinePass(lineState, color, height)
  local sizeDelta = self.ui.img_Trunk.transform.sizeDelta
  if lineState == ExplorationEnum.eTrackLineState.Pass then
    self.ui.img_Trunk.color = color
    sizeDelta.y = height
  elseif lineState == ExplorationEnum.eTrackLineState.Auto then
    self.ui.img_Trunk.color = ExplorationEnum.LineAutoModeColor
    sizeDelta.y = height
  else
    self.ui.img_Trunk.color = self.lineDefaultColor
    sizeDelta.y = self.lineDefaultHeight
  end
  self.ui.img_Trunk.transform.sizeDelta = sizeDelta
end

function UIEpSingleTrack:SetForkLinePass(forkRoom, mapCtrl, lineState, color, height)
  if self.__nextRoomPos ~= forkRoom.position then
    return
  end
  local forkLine = self.ui.img_Line
  local sizeDelta = forkLine.transform.sizeDelta
  if lineState == ExplorationEnum.eTrackLineState.Pass then
    forkLine.color = color
    sizeDelta.y = height
  elseif lineState == ExplorationEnum.eTrackLineState.Auto then
    forkLine.color = ExplorationEnum.LineAutoModeColor
    sizeDelta.y = height
  else
    forkLine.color = self.lineDefaultColor
    sizeDelta.y = self.lineDefaultHeight
  end
  forkLine.transform.sizeDelta = sizeDelta
end

function UIEpSingleTrack:SetTrunkLineActive(forkRoom)
  if self.__nextRoomPos == forkRoom.position then
    self.ui.img_Trunk.gameObject:SetActive(self.roomData:GetVisible() and forkRoom:GetVisible())
  end
end

function UIEpSingleTrack:SetForkLineActive(roomData, mapCtrl)
end

function UIEpSingleTrack:GetTrackCrossingPos()
  return self.ui.lineList.transform.position
end

return UIEpSingleTrack
