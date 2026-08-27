local UIEpYTrack = class("UIEpYTrack", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UIEpYTrack:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.lineDefaultColor = self.ui.img_Trunk.color
  self.pointColor = self.ui.img_Point.color
  self.lineDefaultHeight = self.ui.img_Trunk.transform.sizeDelta.y
  self.traceType = ExplorationEnum.eTrackLineType.NormalYTrack
end

function UIEpYTrack:InitEpYTrack(roomData, trunkSizeX, forkLength)
  self.roomData = roomData
  local sizeDeltaY = self.ui.img_Trunk.transform.sizeDelta.y
  self.ui.img_Trunk.transform.sizeDelta = Vector2.New(trunkSizeX, sizeDeltaY)
  local forkSizeY = self.ui.img_LineUP.transform.sizeDelta.y
  local newSize = Vector2.New(forkLength, forkSizeY)
  self.ui.img_LineUP.transform.sizeDelta = newSize
  self.ui.img_LineDown.transform.sizeDelta = newSize
  self.ui.img_Trunk.gameObject:SetActive(roomData:GetVisible())
  self.forkLineDic = {}
  local downDirRoom = roomData:GetNextDownDirRoom()
  local downDirLineShow = downDirRoom ~= nil and downDirRoom:GetVisible()
  self.ui.img_LineDown.gameObject:SetActive(downDirLineShow)
  if downDirRoom ~= nil then
    self.forkLineDic[downDirRoom.position] = self.ui.img_LineDown
  end
  local upDirRoom = roomData:GetNextUpDirRoom()
  local upDirLineShow = upDirRoom ~= nil and upDirRoom:GetVisible()
  self.ui.img_LineUP.gameObject:SetActive(upDirLineShow)
  if upDirRoom ~= nil then
    self.forkLineDic[upDirRoom.position] = self.ui.img_LineUP
  end
end

function UIEpYTrack:SetTrunkLinePass(lineState, color, height)
  local sizeDelta = self.ui.img_Trunk.transform.sizeDelta
  if lineState == ExplorationEnum.eTrackLineState.Pass then
    self.ui.img_Trunk.color = color
    self.ui.img_Point.color = color
    sizeDelta.y = height
  elseif lineState == ExplorationEnum.eTrackLineState.Auto then
    self.ui.img_Trunk.color = ExplorationEnum.LineAutoModeColor
    self.ui.img_Point.color = ExplorationEnum.LineAutoModeColor
    sizeDelta.y = height
  else
    self.ui.img_Trunk.color = self.lineDefaultColor
    self.ui.img_Point.color = self.pointColor
    sizeDelta.y = self.lineDefaultHeight
  end
  self.ui.img_Trunk.transform.sizeDelta = sizeDelta
end

function UIEpYTrack:SetForkLinePass(forkRoom, mapCtrl, lineState, color, height)
  local forkLine = self.forkLineDic[forkRoom.position]
  if forkLine == nil then
    return
  end
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

function UIEpYTrack:SetTrunkLineActive()
  self.ui.img_Trunk.gameObject:SetActive(self.roomData:GetVisible())
end

function UIEpYTrack:SetForkLineActive(roomData, mapCtrl)
  local lineItem = self.forkLineDic[roomData.position]
  if not IsNull(lineItem) then
    lineItem.gameObject:SetActive(roomData:GetVisible())
  end
end

function UIEpYTrack:GetTrackCrossingPos()
  return self.ui.img_Point.transform.position
end

return UIEpYTrack
