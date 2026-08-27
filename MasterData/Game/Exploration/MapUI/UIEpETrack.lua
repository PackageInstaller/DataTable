local UIEpETrack = class("UIEpETrack", UIBaseNode)
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function UIEpETrack:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.ui.img_Vertical:SetActive(false)
  self.ui.img_Line:SetActive(false)
  self.lineSizeDeltaY = self.ui.img_Line.transform.sizeDelta.y
  self.lineDefaultColor = self.ui.img_Trunk.color
  self.lineDefaultHeight = self.ui.img_Trunk.transform.sizeDelta.y
  self.traceType = ExplorationEnum.eTrackLineType.NormalETrack
end

function UIEpETrack:InitRoomNormalETrack(roomData, mapCtrl, trackLength, verticalIntervalY)
  self.roomData = roomData
  self:__InitTrunkLine(trackLength)
  local nextRoom = roomData:GetNextRoom()
  self:__InitTrackDynLine(nextRoom, mapCtrl, verticalIntervalY)
end

function UIEpETrack:InitRoomReverseETrack(roomData, mapCtrl, trackLength, verticalIntervalY)
  self.roomData = roomData
  local originScale = self.ui.img_Trunk.transform.localScale
  self.ui.img_Trunk.transform.localScale = Vector3.New(-originScale.x, originScale.y, originScale.z)
  self:__InitTrunkLine(trackLength)
  local lastRoom = roomData:GetLastRoom()
  self:__InitTrackDynLine(lastRoom, mapCtrl, verticalIntervalY)
end

function UIEpETrack:__InitTrunkLine(trackLength)
  local lineSizeDelta = self.ui.img_Line.transform.sizeDelta
  local trunkSizeX = trackLength - lineSizeDelta.x
  local sizeDeltaY = self.ui.img_Trunk.transform.sizeDelta.y
  self.ui.img_Trunk.transform.sizeDelta = Vector2.New(trunkSizeX, sizeDeltaY)
  self.ui.img_Trunk.gameObject:SetActive(self.roomData:GetVisible())
end

function UIEpETrack:__InitTrackDynLine(nextRoomList, mapCtrl, verticalIntervalY)
  local forkRoomList = {}
  for _, v in pairs(nextRoomList) do
    table.insert(forkRoomList, v)
  end
  table.sort(forkRoomList, function(r1, r2)
    return r1.y < r2.y
  end)
  self.forkRoomList = forkRoomList
  if #self.forkRoomList == 0 then
    return
  end
  self.forkRoomVisible = {}
  for k, tmpRoomData in ipairs(self.forkRoomList) do
    self.forkRoomVisible[k] = tmpRoomData:GetVisible()
  end
  self.curForkLineRoomPos = nil
  self.forkLineDic = {}
  local oldLinePosition = self.ui.img_Line.transform.localPosition
  for k, roomData in pairs(self.forkRoomList) do
    local lineItemObj = self.ui.img_Line:Instantiate()
    lineItemObj:SetActive(roomData:GetVisible())
    local lineItem = lineItemObj:FindComponent(eUnityComponentID.Image)
    local uiRoom = mapCtrl:GetRoomUI(roomData.position)
    local localPos = lineItemObj.transform.parent:InverseTransformPoint(uiRoom.transform.position)
    oldLinePosition.y = localPos.y
    lineItem.transform.localPosition = oldLinePosition
    self.forkLineDic[roomData.position] = lineItem
  end
  local verticalLineItemObj = self.ui.img_Vertical:Instantiate()
  self.verticalLineDown = verticalLineItemObj:FindComponent(eUnityComponentID.Image)
  verticalLineItemObj = self.ui.img_Vertical:Instantiate()
  self.verticalLineUp = verticalLineItemObj:FindComponent(eUnityComponentID.Image)
  verticalLineItemObj = self.ui.img_Vertical:Instantiate()
  verticalLineItemObj:SetActive(true)
  self.verticalLineCenter = verticalLineItemObj:FindComponent(eUnityComponentID.Image)
  self:__ReCalcVerticalLen(mapCtrl)
  self:__ResetDynLine()
end

function UIEpETrack:__ReCalcVerticalLen(mapCtrl)
  local curPosY = self.verticalLineCenter.transform.parent:InverseTransformPoint(self.transform.position).y
  local minRoom
  for i = 1, #self.forkRoomList do
    if self.forkRoomVisible[i] then
      minRoom = self.forkRoomList[i]
      break
    end
  end
  local minPosY
  if minRoom ~= nil then
    local uiRoomDown = mapCtrl:GetRoomUI(minRoom.position)
    minPosY = self.verticalLineCenter.transform.parent:InverseTransformPoint(uiRoomDown.transform.position).y
  else
    minPosY = curPosY
  end
  local maxRoom
  for i = #self.forkRoomList, 1, -1 do
    if self.forkRoomVisible[i] then
      maxRoom = self.forkRoomList[i]
      break
    end
  end
  local maxPosY
  if maxRoom ~= nil then
    local uiRoomUp = mapCtrl:GetRoomUI(maxRoom.position)
    maxPosY = self.verticalLineCenter.transform.parent:InverseTransformPoint(uiRoomUp.transform.position).y
  else
    maxPosY = curPosY
  end
  self.verticalMinPosY = math.min(minPosY, curPosY)
  self.verticalMaxPosY = math.max(maxPosY, curPosY)
  self.verticalCurPosY = curPosY
end

function UIEpETrack:__ResetDynLine()
  self:SetVerticalLineSizePos(self.verticalLineCenter, self.verticalMinPosY, self.verticalMaxPosY)
  self.verticalLineCenter.color = self.lineDefaultColor
  local sizeDelta = self.verticalLineCenter.transform.sizeDelta
  sizeDelta.x = self.lineDefaultHeight
  self.verticalLineCenter.transform.sizeDelta = sizeDelta
  self.verticalLineDown.gameObject:SetActive(false)
  self.verticalLineUp.gameObject:SetActive(false)
end

function UIEpETrack:SetVerticalLineSizePos(lineItem, minPosY, maxPosY)
  local oldVerticalSizeDelta = lineItem.transform.sizeDelta
  oldVerticalSizeDelta.y = maxPosY - minPosY + self.lineSizeDeltaY
  lineItem.transform.sizeDelta = oldVerticalSizeDelta
  local oldVerticalPos = lineItem.transform.localPosition
  oldVerticalPos.y = (minPosY + maxPosY) / 2 - self.verticalCurPosY
  lineItem.transform.localPosition = oldVerticalPos
end

function UIEpETrack:SetTrunkLinePass(lineState, color, height)
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

function UIEpETrack:SetForkLinePass(forkRoom, mapCtrl, lineState, color, height)
  local lineItem = self.forkLineDic[forkRoom.position]
  if lineItem ~= nil then
    local sizeDelta = lineItem.transform.sizeDelta
    if lineState == ExplorationEnum.eTrackLineState.Pass then
      lineItem.color = color
      sizeDelta.y = height
    elseif lineState == ExplorationEnum.eTrackLineState.Auto then
      lineItem.color = ExplorationEnum.LineAutoModeColor
      sizeDelta.y = height
    else
      lineItem.color = self.lineDefaultColor
      sizeDelta.y = self.lineDefaultHeight
    end
    lineItem.transform.sizeDelta = sizeDelta
  end
  if lineState == ExplorationEnum.eTrackLineState.Normal then
    if forkRoom.position == self.curForkLineRoomPos then
      self:__ResetDynLine()
      self.curForkLineRoomPos = nil
    end
    return
  end
  self.curForkLineRoomPos = forkRoom.position
  if lineState == ExplorationEnum.eTrackLineState.Pass then
    self.verticalLineCenter.color = color
  else
    self.verticalLineCenter.color = ExplorationEnum.LineAutoModeColor
  end
  if #self.forkRoomList <= 1 then
    return
  end
  local roomIndex
  for k, roomData in ipairs(self.forkRoomList) do
    if roomData == forkRoom then
      roomIndex = k
      break
    end
  end
  if roomIndex == nil then
    return
  end
  local uiForkRoom = mapCtrl:GetRoomUI(forkRoom.position)
  if uiForkRoom == nil then
    return
  end
  local forRoomPosY = self.verticalLineCenter.transform.parent:InverseTransformPoint(uiForkRoom.transform.position).y
  local curVerticalMinPosY = math.min(self.verticalCurPosY, forRoomPosY)
  local curVerticalMaxPosY = math.max(self.verticalCurPosY, forRoomPosY)
  self:SetVerticalLineSizePos(self.verticalLineCenter, curVerticalMinPosY, curVerticalMaxPosY)
  local sizeDelta = self.verticalLineCenter.transform.sizeDelta
  sizeDelta.x = height
  self.verticalLineCenter.transform.sizeDelta = sizeDelta
  if 1 < roomIndex then
    self.verticalLineDown.gameObject:SetActive(true)
    local tmpVerticalMinPosY = self.verticalMinPosY
    local tmpVerticalMaxPosY = curVerticalMinPosY
    self:SetVerticalLineSizePos(self.verticalLineDown, tmpVerticalMinPosY, tmpVerticalMaxPosY)
  else
    self.verticalLineDown.gameObject:SetActive(false)
  end
  if roomIndex < #self.forkRoomList then
    self.verticalLineUp.gameObject:SetActive(true)
    local tmpVerticalMinPosY = curVerticalMaxPosY
    local tmpVerticalMaxPosY = self.verticalMaxPosY
    self:SetVerticalLineSizePos(self.verticalLineUp, tmpVerticalMinPosY, tmpVerticalMaxPosY)
  else
    self.verticalLineUp.gameObject:SetActive(false)
  end
end

function UIEpETrack:SetTrunkLineActive()
  self.ui.img_Trunk.gameObject:SetActive(self.roomData:GetVisible())
end

function UIEpETrack:SetForkLineActive(roomData, mapCtrl)
  local lineItem = self.forkLineDic[roomData.position]
  if not IsNull(lineItem) then
    lineItem.gameObject:SetActive(roomData:GetVisible())
  end
  for i = 1, #self.forkRoomList do
    if roomData == self.forkRoomList[i] and self.forkRoomVisible[i] == false then
      self.forkRoomVisible[i] = true
      self:__ReCalcVerticalLen(mapCtrl)
      self:__ResetDynLine()
      break
    end
  end
end

function UIEpETrack:GetTrackCrossingPos()
  return self.ui.lineList.transform.position
end

return UIEpETrack
