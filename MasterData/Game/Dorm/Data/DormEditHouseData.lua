local DormEditHouseData = class("DormEditHouseData")
local DormRoomData = require("Game.Dorm.Data.DormRoomData")
local EditHouseState = {
  Empty = 0,
  OldRoom = 1,
  NewRoom = 2,
  PrefabRoom = 3
}

function DormEditHouseData:ctor()
end

function DormEditHouseData:InitEditHouse(houseData)
  self.houseId = houseData.id
  self.houseData = houseData
  self.editState = {}
  setmetatable(self.editState, {
    __index = function(tab, key)
      return 0
    end
  })
  self.posResult = {}
  for spos, roomData in pairs(self.houseData.roomDic) do
    self.posResult[spos] = {store = false, param = spos}
    self.editState[spos] = EditHouseState.OldRoom
  end
  self.oldStoreRoom = {}
  self.newRoom = {}
  self.newRoomCount = {}
  self.installPrefab = {}
end

function DormEditHouseData:__RecycleOldRoom(spos)
  local posState = self.editState[spos]
  if posState == EditHouseState.OldRoom then
    for oldPos, v in pairs(self.posResult) do
      if v.param == spos then
        v.store = true
        self.oldStoreRoom[oldPos] = self.houseData.roomDic[oldPos]
        break
      end
    end
  elseif posState == EditHouseState.NewRoom then
    local oldRoomId = self.newRoom[spos]
    if oldRoomId ~= nil then
      self.newRoom[spos] = nil
      self.newRoomCount[oldRoomId] = self.newRoomCount[oldRoomId] and self.newRoomCount[oldRoomId] - 1 or 0
    end
  elseif posState == EditHouseState.PrefabRoom then
    for k, v in pairs(self.installPrefab) do
      if v == spos then
        self.installPrefab[k] = nil
        break
      end
    end
  end
  self.editState[spos] = EditHouseState.Empty
end

function DormEditHouseData:ReplaceHouseRoom(spos, roomId, roomData)
  self:__RecycleOldRoom(spos)
  if roomData ~= nil then
    if roomData.isPrefab then
      self.editState[spos] = EditHouseState.PrefabRoom
      self.installPrefab[roomData.uid] = spos
    else
      self.editState[spos] = EditHouseState.OldRoom
      self.posResult[roomData.spos].param = spos
      self.posResult[roomData.spos].store = false
      self.oldStoreRoom[roomData.spos] = nil
    end
  else
    self.editState[spos] = EditHouseState.NewRoom
    self.newRoom[spos] = roomId
    self.newRoomCount[roomId] = self.newRoomCount[roomId] and self.newRoomCount[roomId] + 1 or 1
  end
end

function DormEditHouseData:RecycleHouseRoom(spos)
  self:__RecycleOldRoom(spos)
end

function DormEditHouseData:ApplyModifyHouseData(prefabUpdate, allDormData, roomEntityDic)
  for spos, v in pairs(self.posResult) do
    if v.store then
      self.houseData:RemoveHouseRoom(spos)
    else
      self.houseData.roomDic[spos]:ChangePos(v.param)
    end
  end
  for spos, roomId in pairs(self.newRoom) do
    local roomEntity = roomEntityDic[spos]
    if roomEntity ~= nil and roomEntity.roomData ~= nil then
      self.houseData:AddHouseRoom(roomEntity.roomData)
    else
      local roomData = DormRoomData.CreateNewRoom(spos, roomId)
      self.houseData:AddHouseRoom(roomData)
    end
  end
  for uid, spos in pairs(self.installPrefab) do
    local roomData = allDormData.prefabDic[uid]
    roomData:ChangePos(spos)
    self.houseData:AddHouseRoom(roomData)
  end
  self.editState = nil
  self:__UpdatePrefab(prefabUpdate, allDormData)
end

function DormEditHouseData:ApplyDecomposeHouseRoom(formHouse, param, prefabUpdate, allDormData)
  if formHouse then
    local curPos = self.posResult[param].param
    self.editState[curPos] = nil
    self.posResult[param] = nil
  else
    local spos = self.installPrefab[param]
    if spos ~= nil then
      self.editState[spos] = nil
    end
    self.installPrefab[param] = nil
  end
  self:__UpdatePrefab(prefabUpdate, allDormData)
end

function DormEditHouseData:__UpdatePrefab(prefabUpdate, allDormData)
  if prefabUpdate == nil then
    return
  end
  for uid, _ in pairs(prefabUpdate.prefabDelete) do
    allDormData:RemovePrefabRoom(uid)
  end
  for uid, room in pairs(prefabUpdate.prefabUpdate) do
    allDormData:UpdatePrefabRoom(uid, room)
  end
end

function DormEditHouseData:ContainHouseRoom(spos)
  return self.editState[spos] ~= EditHouseState.Empty
end

function DormEditHouseData:IsEmptyOrBpRoom(spos)
  return self.editState[spos] == EditHouseState.Empty or self.editState[spos] == EditHouseState.NewRoom
end

function DormEditHouseData:GetDeployRoomCount()
  local count = 0
  for k, v in pairs(self.editState) do
    if v ~= EditHouseState.Empty then
      count = count + 1
    end
  end
  return count
end

function DormEditHouseData.CreateFormHouseData(houseData)
  local editHosueData = DormEditHouseData.New()
  editHosueData:InitEditHouse(houseData)
  return editHosueData
end

return DormEditHouseData
