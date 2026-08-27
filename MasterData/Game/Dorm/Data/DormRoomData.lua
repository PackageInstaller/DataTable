local DormRoomData = class("DormRoomData")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormFurnitureData = require("Game.Dorm.Data.DormFurnitureData")

function DormRoomData:ctor()
end

function DormRoomData.CreateNewRoom(spos, roomId)
  local roomdata = {id = roomId}
  local room = DormRoomData.New()
  room:InitRoomData(spos, roomdata)
  return room
end

function DormRoomData:InitRoomData(spos, roomdata, houseid, houseHexRange)
  local x, y = DormUtil.RoomCoordToXY(spos)
  self.belongtohouseid = houseid
  self._houseHexRange = houseHexRange
  self.x = x
  self.y = y
  self.spos = spos
  self:__InitDormRoomData(roomdata)
end

function DormRoomData:InitPrefabRoom(uid, roomdata)
  self.uid = uid
  self:__InitDormRoomData(roomdata)
end

function DormRoomData:__InitDormRoomData(roomdata)
  self.id = roomdata.id
  self.roomCfg = ConfigData.dorm_room[self.id]
  if self.roomCfg == nil then
    error("dorm room cfg is null,id:" .. tostring(self.id))
  end
  self.__roomName = roomdata.name
  self.isPrefab = self.uid ~= nil
  self:UpdateRoomFntData(roomdata.data, true)
  self:_InitDmRoomDoorData(roomdata.door)
  self:SetDmRoomFloor(roomdata.floorId)
  self:SetDmRoomWall(roomdata.wallId)
  self:RecordOrnginalDmRoomData(roomdata)
  self.__enableUnbind = roomdata.unbind
end

function DormRoomData:UpdateRoomFntData(data, createFntData)
  self.data = data
  if createFntData then
    self.canBindfntDataList = {}
    self._wallPaperData = {
      [1] = {},
      [2] = {},
      [3] = {},
      [4] = {}
    }
    self.fntDataList = {}
    self.fntDataDic = {}
    if self.data ~= nil then
      local wallPaperDataTemp = {}
      local wallPaperIdxDicTemp = {}
      for k, v in ipairs(self.data) do
        local fntData = DormFurnitureData.New()
        fntData:InitFntData(v.id, self, v)
        self.fntDataList[k] = fntData
        self.fntDataDic[fntData] = true
        if #self.canBindfntDataList <= self:GetDormRoomMaxHero() and fntData:CanBindRole() then
          table.insert(self.canBindfntDataList, fntData)
        end
        if fntData:GetFntType() == DormEnum.eDormFntType.Wallpaper then
          local wallId = fntData:GetFntParam()
          wallPaperDataTemp[wallId] = wallPaperDataTemp[wallId] or {}
          table.insert(wallPaperDataTemp[wallId], fntData)
          wallPaperIdxDicTemp[fntData] = k
        end
      end
      for wallId, papaerList in pairs(wallPaperDataTemp) do
        table.sort(papaerList, function(fntA, fntB)
          local layerIdxA = fntA:GetFntDataLayer()
          local layerIdxB = fntB:GetFntDataLayer()
          local idxA = wallPaperIdxDicTemp[fntA]
          local idxB = wallPaperIdxDicTemp[fntB]
          if layerIdxA ~= layerIdxB then
            return layerIdxA < layerIdxB
          end
          return idxA < idxB
        end)
        for layerIdx, fntData in ipairs(papaerList) do
          self._wallPaperData[wallId][layerIdx] = fntData
          fntData:SetFntDataLayer(layerIdx)
        end
      end
    end
  else
    for k, fntData in ipairs(self.fntDataList) do
      fntData:RecordOriginalFntData()
    end
  end
  self.interpoint = {}
  for k, v in ipairs(self.fntDataList) do
    for _, pointData in pairs(v.interpoint) do
      pointData:UnBindInterPoint()
      table.insert(self.interpoint, pointData)
    end
  end
end

function DormRoomData:GetDormRoomMaxHero()
  return self.roomCfg.max_hero
end

function DormRoomData:GetRoomGridHeightCount()
  return self.roomCfg.grid_height
end

function DormRoomData:GetRoomGridLengthCount()
  return self.roomCfg.grid_length
end

function DormRoomData:GetRoomModelSize()
  return self.roomCfg.model_size
end

function DormRoomData:GetDmRoomType()
  return self.roomCfg.room_type
end

function DormRoomData:IsBigRoomType()
  return self.roomCfg.room_type == 1
end

function DormRoomData:GetDmRoomEditCamDistace()
  return Vector2.New(self.roomCfg.edit_cam_distance[1], self.roomCfg.edit_cam_distance[2])
end

function DormRoomData:GetEnableUnbind()
  return self.__enableUnbind
end

function DormRoomData:SetEnableUnbind(unbind)
  self.__enableUnbind = unbind
end

function DormRoomData:_InitDmRoomDoorData(doorData)
  if doorData == nil then
    error("Door door data from server is nil, roomId = " .. tostring(self.id))
    return
  end
  local fntData = DormFurnitureData.New()
  fntData:InitFntData(doorData.id, self, doorData, true)
  self.dmRoomDoorData = fntData
end

function DormRoomData:RecordOrnginalDmRoomData(roomdata)
  self.oldRoomdata = roomdata
end

function DormRoomData:ClearDormRoom()
  for _, pointData in pairs(self.interpoint) do
    pointData:UnBindInterPoint()
  end
end

function DormRoomData:__UpdateRoomInterPoint()
end

function DormRoomData:ChangePos(spos)
  if self.isPrefab then
    self.isPrefab = false
    self.uid = nil
  end
  local x, y = DormUtil.RoomCoordToXY(spos)
  self.x = x
  self.y = y
  self.spos = spos
end

function DormRoomData:GetName()
  if not string.IsNullOrEmpty(self.__roomName) then
    return self.__roomName
  end
  return LanguageUtil.GetLocaleText(self.roomCfg.name)
end

function DormRoomData:SetRoomName(name)
  self.__roomName = name
end

function DormRoomData:GetComfort()
  local comfort = 0
  for k, v in pairs(self.fntDataList) do
    comfort = comfort + v:GetFntComfort()
  end
  comfort = comfort + self.dmRoomDoorData:GetFntComfort()
  if 0 < self.floorId then
    local fntCfg = ConfigData.dorm_furniture[self.floorId]
    if fntCfg == nil then
      error("Can't find dorm_furniture cfg, id = " .. tostring(self.floorId))
      return
    end
    comfort = comfort + fntCfg.comfort
  end
  if 0 < self.wallId then
    local fntCfg = ConfigData.dorm_furniture[self.wallId]
    if fntCfg == nil then
      error("Can't find dorm_furniture cfg, id = " .. tostring(self.wallId))
      return
    end
    comfort = comfort + fntCfg.comfort
  end
  return comfort
end

function DormRoomData:BackupDmRoomDntList()
  local backupFntList = {}
  for k, v in ipairs(self.fntDataList) do
    backupFntList[k] = v
  end
  self._backupFntList = backupFntList
  local backupCanBindFntList = {}
  for k, v in ipairs(self.canBindfntDataList) do
    backupCanBindFntList[k] = v
  end
  self._backupCanBindFntList = backupCanBindFntList
end

function DormRoomData:ClearDmRoomDntListBackup()
  self._backupFntList = nil
  self._backupCanBindFntList = nil
end

function DormRoomData:RestoreDmRoomDntList()
  if self._backupFntList ~= nil then
    for k, v in ipairs(self._backupFntList) do
      self.fntDataList[k] = v
    end
  end
  if self._backupCanBindFntList ~= nil then
    for k, v in ipairs(self._backupCanBindFntList) do
      self.canBindfntDataList[k] = v
    end
  end
end

function DormRoomData:AddFntData(fntData)
  if fntData == nil then
    return
  end
  local fntType = fntData:GetFntType()
  if fntData == DormEnum.eDormFntType.Door then
    return
  end
  if self.fntDataDic[fntData] ~= nil then
    return
  end
  table.insert(self.fntDataList, fntData)
  self.fntDataDic[fntData] = true
  if #self.canBindfntDataList <= self:GetDormRoomMaxHero() and fntData:CanBindRole() then
    table.insert(self.canBindfntDataList, fntData)
  end
end

function DormRoomData:RemoveFntData(fntData)
  local fntType = fntData:GetFntType()
  if fntData == DormEnum.eDormFntType.Door then
    return
  end
  table.removebyvalue(self.fntDataList, fntData)
  self.fntDataDic[fntData] = nil
  if fntData:CanBindRole() then
    table.removebyvalue(self.canBindfntDataList, fntData)
  end
end

function DormRoomData:GetFntDatas(withCheckPaper)
  local dataList = {}
  for k, fntData in ipairs(self.fntDataList) do
    local data = fntData:GetDmFntServerData()
    dataList[k] = data
  end
  if withCheckPaper then
    self:_CheckWallpaperData()
  end
  return dataList
end

function DormRoomData:_CheckWallpaperData()
  for wallId, paperList in pairs(self._wallPaperData) do
    for layerIdx, fntData in ipairs(paperList) do
      local fntLayer = fntData:GetFntDataLayer()
      local fntWallIdx = fntData:GetFntParam()
      if wallId ~= fntWallIdx or layerIdx ~= fntLayer then
        error(string.format("CheckWallpaperData error, fntId:%s, wallId:%s, fntWallIdx:%s, layerIdx:%s, fntLayer:%s", fntData.id, wallId, fntWallIdx, layerIdx, fntLayer))
      end
    end
  end
end

function DormRoomData:GetRoomBindCount()
  local count = 0
  for k, fntData in ipairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param ~= 0 then
      count = count + 1
    end
  end
  return count
end

function DormRoomData:GetRoomBindList()
  local list = {}
  for k, fntData in pairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param ~= 0 then
      table.insert(list, fntData)
    end
  end
  return list
end

function DormRoomData:GetRoomCanBindFntCount()
  return #self.canBindfntDataList
end

function DormRoomData:GetRoomCanBindList()
  return self.canBindfntDataList
end

function DormRoomData:GetFntDataByBindHeroId(HeroID)
  for k, fntData in ipairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param == HeroID then
      return fntData
    end
  end
  return nil
end

function DormRoomData:GetFntDataIndex(fntData)
  for index, v in ipairs(self.fntDataList) do
    if fntData == v then
      return index - 1
    end
  end
  error("Can't get FntData index")
end

function DormRoomData:UnbindAllRoomFntData()
  for k, fntData in ipairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if 0 < param then
      fntData:SetFntParam(0, true)
    end
  end
end

function DormRoomData:IsHeroBindOnRoom(HeroID)
  for k, fntData in pairs(self.canBindfntDataList) do
    local param = fntData:GetFntParam()
    if param == HeroID then
      return true
    end
  end
  return false
end

function DormRoomData:SetDmRoomWall(wallId)
  self.wallId = wallId
end

function DormRoomData:SetDmRoomFloor(floorId)
  self.floorId = floorId
end

function DormRoomData:SaveDmRoomData()
  self.oldRoomdata.data = self.data
  self.oldRoomdata.wallId = self.wallId
  self.oldRoomdata.floorId = self.floorId
  self.dmRoomDoorData:RecordOriginalFntData()
end

function DormRoomData:GetDmRoomOldFloor()
  return self.oldRoomdata.floorId
end

function DormRoomData:GetDmRoomOldWall()
  return self.oldRoomdata.wallId
end

function DormRoomData:GetDmRoomOldDoor()
  return self.dmRoomDoorData:GetFntOldId()
end

function DormRoomData:GetDmRoomFntCategoryNum(categoryId)
  local num = 0
  for k, fntData in ipairs(self.fntDataList) do
    if fntData:GetFntCategory() == categoryId then
      num = num + 1
    end
  end
  return num
end

function DormRoomData:GetDmRoomIndex()
  return DormUtil.GetRoomIndexByRoomposToxy(self.x, self.y, self._houseHexRange)
end

function DormRoomData:AddDmWallpaper(fntData, wallIdx)
  local wallIdx = wallIdx or fntData:GetFntParam()
  local wallList = self._wallPaperData[wallIdx]
  table.insert(wallList, fntData)
  fntData:SetFntDataLayer(#wallList)
end

function DormRoomData:InsertDmWallpaper(fntData)
  local layerIndex = fntData:GetFntDataLayer()
  local wallIdx = fntData:GetFntParam()
  local wallList = self._wallPaperData[wallIdx]
  layerIndex = math.min(#wallList + 1, layerIndex)
  fntData:SetFntDataLayer(layerIndex)
  table.insert(wallList, layerIndex, fntData)
  self:_ChangeOtherFntLayer(wallList, layerIndex + 1)
end

function DormRoomData:_ChangeOtherFntLayer(wallList, layerIndex)
  local changeLayerFntDic
  for i = layerIndex, #wallList do
    local fntDt = wallList[i]
    fntDt:SetFntDataLayer(i)
    changeLayerFntDic = changeLayerFntDic or {}
    changeLayerFntDic[fntDt] = true
  end
  if changeLayerFntDic ~= nil then
    MsgCenter:Broadcast(eMsgEventId.DmWallpaperLayerIdxChanged, changeLayerFntDic)
  end
end

function DormRoomData:RemoveDmWallpaper(fntData)
  local wallIdx = fntData:GetFntParam()
  local wallList = self._wallPaperData[wallIdx]
  local layerIndex = fntData:GetFntDataLayer()
  table.remove(wallList, layerIndex)
  self:_ChangeOtherFntLayer(wallList, layerIndex)
end

function DormRoomData:DmRoomResetWallpaper()
  self:DmRoomClearWallpaper()
  for k, fntData in ipairs(self.fntDataList) do
    if fntData:GetFntType() == DormEnum.eDormFntType.Wallpaper then
      local wallId = fntData:GetFntParam()
      local layerIdx = fntData:GetFntDataLayer()
      self._wallPaperData[wallId][layerIdx] = fntData
    end
  end
end

function DormRoomData:DmRoomClearWallpaper()
  for wallId, wallList in pairs(self._wallPaperData) do
    self._wallPaperData[wallId] = {}
  end
end

return DormRoomData
