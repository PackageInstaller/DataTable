local DynEpMapData = class("DynMapData")
local DynEpMapColType = require("Game.Exploration.MapData.DynEpMapColType")
local DynEpRoomData = require("Game.Exploration.MapData.DynEpRoomData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function DynEpMapData:ctor(sectorId)
  self.sectorId = sectorId
end

function DynEpMapData:InitMapData(mapdata, nextMapBrief, opDetail)
  self.dungeonId = mapdata.dungeonId
  self.floorIdx = mapdata.floorIdx
  self.exploraionId = mapdata.floorId
  if self.exploraionId == nil then
    error("Can't get exploraionId,floorIdx:" .. tostring(self.floorIdx))
    return
  end
  self.epCfg = ConfigData.exploration[self.exploraionId]
  if self.epCfg == nil then
    error("exploraion cfg is null,id:" .. tostring(self.exploraionId))
    return
  end
  local sceneCfg = ConfigData.scene[self.epCfg.scene_id]
  if sceneCfg == nil then
    error("scene cfg is null,id:" .. tostring(self.epCfg.scene_id))
    return
  end
  self.sceneCfg = sceneCfg
  self.epMapLogic = mapdata.logic
  self.width = mapdata.width
  self.depth = mapdata.depth
  self.lineDepth = table.count(mapdata.lineData)
  self.floor = mapdata.floor
  self.nextMapBrief = nextMapBrief
  local oddColNum = self.width // 2 * 2
  local evenColNum = self.width * 2 - 1 - oddColNum
  self.maxWidthIsOdd = self.width == self.oddColNum
  self.centerPosY = (self.width + 1) / 2 - 1
  self.roomMap = {}
  self.mapColTypeList = {}
  self.maxMapColNumber = self.depth + self.lineDepth
  self.isChallengeMode = mapdata.challengeMode
  self._snapshot = mapdata.snapshot
  self._snapshotTimes = mapdata.snapshotTimes
  self._infiniteCoe = mapdata.infiniteCoe
  self._sViewRange = mapdata.viewRange
  self._reCardGradeUp = mapdata.reCardGradeUp
  self._reCardGradeDown = mapdata.reCardGradeDown
  self._reinforceChip = mapdata.reinforceChip
  for i = 0, self.maxMapColNumber do
    self.roomMap[i] = {}
  end
  self.mapColTypeList[0] = DynEpMapColType.New(self, 0, ExplorationEnum.eTrackLineType.NormalETrack, 1)
  for i = 1, self.depth do
    local maxColRoomCount = i % 2 == 0 and evenColNum or oddColNum
    local trackLineType = i == self.depth and ExplorationEnum.eTrackLineType.ReverseETrack or ExplorationEnum.eTrackLineType.NormalYTrack
    self.mapColTypeList[i] = DynEpMapColType.New(self, i, trackLineType, maxColRoomCount)
  end
  for i = self.depth + 1, self.maxMapColNumber - 1 do
    self.mapColTypeList[i] = DynEpMapColType.New(self, i, ExplorationEnum.eTrackLineType.SingleTrack, 1)
  end
  self.mapColTypeList[self.maxMapColNumber] = DynEpMapColType.New(self, self.maxMapColNumber, ExplorationEnum.eTrackLineType.EndTrack, 1)
  local deployRoom = DynEpRoomData.New(0, 0, ExplorationEnum.eRoomType.deploy)
  deployRoom:SetMapData(self)
  self.deployRoom = deployRoom
  local startRoom = DynEpRoomData.New(0, 0, ExplorationEnum.eRoomType.start)
  startRoom:SetMapData(self)
  self:SetMapOneRoom(startRoom.x, startRoom.y, startRoom)
  self.__startRoom = startRoom
  for coord, roomType in pairs(mapdata.data) do
    local isHidden = mapdata.hidden[coord] ~= nil
    local isCross = mapdata.crossroad[coord]
    local x, y = ExplorationManager.Coordination2Pos(coord)
    local room = DynEpRoomData.New(x, y, roomType, coord, isHidden, isCross)
    room:SetMapData(self, opDetail)
    room:SetVisible(not isHidden)
    local tagData = mapdata.dataTag[coord]
    if tagData ~= nil then
      room:SetEpRoomTagData(tagData)
    end
    self:SetMapOneRoom(x, y, room)
  end
  local lastIsHidden = false
  self.__hasOverBossRoom = false
  local sortPosList = {}
  for k, v in pairs(mapdata.lineData) do
    table.insert(sortPosList, k)
  end
  table.sort(sortPosList)
  for _, k in pairs(sortPosList) do
    local v = mapdata.lineData[k]
    lastIsHidden = lastIsHidden or v.mode == 2 or v.mode == 4
    local x, y = ExplorationManager.Coordination2Pos(k)
    local room = DynEpRoomData.New(x, y, v.cat, k, lastIsHidden, nil, v.mode)
    room:SetMapData(self, opDetail)
    room:SetVisible(not lastIsHidden)
    self:SetMapOneRoom(x, y, room)
    if v.mode == 3 or v.mode == 4 then
      self.__realBossRoom = room
      if x < self.maxMapColNumber then
        self.__hasOverBossRoom = true
      end
    end
  end
  if 0 < self:GetEpViewRange() then
    self.mapViewRange = {}
    local x = 0
    if 0 < #opDetail.path then
      local coord = opDetail.path[#opDetail.path]
      x = ExplorationManager.Coordination2Pos(coord)
    end
    for i = x, math.min(self.maxMapColNumber, x + self:GetEpViewRange()) do
      self.mapViewRange[i] = true
    end
    for i = x + self:GetEpViewRange() + 1, self.maxMapColNumber do
      local colRooms = self.roomMap[i]
      for y, roomData in pairs(colRooms) do
        roomData:SetVisible(false)
      end
    end
  end
  for pos, _ in pairs(opDetail.epFloorWalked) do
    local x, y = ExplorationManager.Coordination2Pos(pos)
    local roomData = self:GetRoomByXY(x, y)
    roomData:SetVisible(true)
    local nextRoomList = roomData:GetNextRoom()
    for _, nextRoom in ipairs(nextRoomList) do
      nextRoom:SetVisible(true)
    end
  end
  self.totalStep = mapdata.step + 1
end

function DynEpMapData:EpHasViewRange()
  return self.mapViewRange ~= nil
end

function DynEpMapData:GetEpViewRange()
  if self._sViewRange > 0 then
    return self._sViewRange
  end
  return self.epCfg.view_range
end

function DynEpMapData:GetTotalStep()
  return self.totalStep
end

function DynEpMapData:UpdateTotalStep(totalStep)
  self.totalStep = totalStep + 1
end

function DynEpMapData:RefreshViewRrange(x, refreshRoomAction)
  for i = x, math.min(self.maxMapColNumber, x + self:GetEpViewRange()) do
    if not self.mapViewRange[i] then
      self.mapViewRange[i] = true
      local colRooms = self.roomMap[i]
      if colRooms ~= nil then
        for y, roomData in pairs(colRooms) do
          if not roomData:IsHiddenRoom() and not roomData:GetVisible() then
            roomData:SetVisible(true)
            refreshRoomAction(roomData)
          end
        end
      end
    end
  end
end

function DynEpMapData:HasOverBossRoom()
  return self.__hasOverBossRoom
end

function DynEpMapData:HasWeeklyChallengeBigBossRoom()
  return ExplorationManager:GetIsInWeeklyChallenge() and self:HasOverBossRoom()
end

function DynEpMapData:GetMapColType(x)
  return self.mapColTypeList[x]
end

function DynEpMapData:GetMapColTrackType(x)
  return self.mapColTypeList[x].trackType
end

function DynEpMapData:GetStartRoom()
  return self.__startRoom
end

function DynEpMapData:GetRealBossRoom()
  return self.__realBossRoom
end

function DynEpMapData:GetDeployRoom()
  return self.deployRoom
end

function DynEpMapData:SetMapOneRoom(x, y, roomData)
  self.roomMap[x][y] = roomData
end

function DynEpMapData:GetRoomByCoord(coord)
  if coord == proto_object_EplSpecialPosition.EplSpecialPositionInit then
    return self:GetEpSpecialRoomData()
  end
  local x, y = ExplorationManager.Coordination2Pos(coord)
  if self.roomMap[x] == nil or self.roomMap[x][y] == nil then
    warn("Cant't find DynEpRoomData, pos = " .. tostring(x) .. "," .. tostring(y))
    return nil
  end
  return self.roomMap[x][y]
end

function DynEpMapData:GetEpSpecialRoomData()
  if self.epSpecialRoom == nil then
    local position = proto_object_EplSpecialPosition.EplSpecialPositionInit
    local x, y = ExplorationManager.Coordination2Pos(position)
    local room = DynEpRoomData.New(x, y, nil, position)
    room:SetMapData(self)
    local roomType = ExplorationManager.dynPlayer:GetOperatorDetail().specialCat
    room:SetEpRoomType(roomType)
    self.epSpecialRoom = room
  end
  return self.epSpecialRoom
end

function DynEpMapData:GetRoomByXY(x, y)
  return self.roomMap[x][y]
end

function DynEpMapData:GetOneRoomByX(x)
  for k, room in pairs(self.roomMap[x]) do
    if room ~= nil then
      return room
    end
  end
  return nil
end

function DynEpMapData:GetRoomsByX(x)
  return self.roomMap[x]
end

function DynEpMapData:GetIsRoomHavePreviousTalkDialog(curPostion)
  local x, y = ExplorationManager.Coordination2Pos(curPostion)
  if x >= self.maxMapColNumber then
    return false
  end
  local talkId = self.epCfg.play_tip[x + 1]
  if talkId == 0 or talkId == nil then
    return false
  end
  return true, talkId
end

function DynEpMapData:GetFirstAbleRoomData()
  if self.roomMap[1] == nil then
    return nil
  end
  for k, roomData in pairs(self.roomMap[1]) do
    if roomData ~= nil then
      return roomData
    end
  end
  return nil
end

function DynEpMapData:GetNextMapBrief()
  return self.nextMapBrief
end

function DynEpMapData:GetEpSceneCfg()
  return self.sceneCfg
end

function DynEpMapData:GetBattleFieldSize()
  local sceneCfg = self:GetEpSceneCfg()
  return sceneCfg.size_row, sceneCfg.size_col, sceneCfg.deploy_rows, sceneCfg.grid_scale_factor
end

function DynEpMapData:GetEpSceneSectorId()
  return self.sectorId
end

function DynEpMapData:ClearPassedRoomData(opDetail, curRoomData)
  if opDetail.state ~= proto_object_ExplorationCurGridState.ExplorationCurGridState_Secleted then
    return
  end
  local curRow = curRoomData.x - 1
  local lastRowRoomDic = self.roomMap[curRow]
  if lastRowRoomDic == nil then
    return
  end
  for k, roomData in pairs(lastRowRoomDic) do
    roomData:ClearEpRoomData()
  end
end

function DynEpMapData:IsEpDefault()
  return self.epMapLogic == ExplorationEnum.eMapLogic.Default
end

function DynEpMapData:IsEpTD()
  return self.epMapLogic == ExplorationEnum.eMapLogic.TowerDefence
end

function DynEpMapData:IsEpLight()
  return self.epMapLogic == ExplorationEnum.eMapLogic.Light
end

function DynEpMapData:IsEpChallengeMode()
  return self.isChallengeMode
end

function DynEpMapData:EnableEpFloorRestart()
  return self._snapshot
end

function DynEpMapData:GetEpFloorRestartTimes()
  return self._snapshotTimes
end

function DynEpMapData:GetEpInfiniteCoe()
  return self._infiniteCoe
end

function DynEpMapData:GetReCardGradeUp()
  return self._reCardGradeUp or 0
end

function DynEpMapData:UpdateReCardGradeUp(reCardGradeUp)
  self._reCardGradeUp = reCardGradeUp
end

function DynEpMapData:GetReCardGradeDown()
  return self._reCardGradeDown or 0
end

function DynEpMapData:UpdateReCardGradeDown(reCardGradeDown)
  self._reCardGradeDown = reCardGradeDown
end

function DynEpMapData:GetReinforceChip()
  return self._reinforceChip or 0
end

return DynEpMapData
