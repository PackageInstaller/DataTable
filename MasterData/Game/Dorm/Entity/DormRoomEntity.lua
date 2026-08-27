local DormRoomEntity = class("DormRoomEntity")
local DormUtil = require("Game.Dorm.DormUtil")
local DormEnum = require("Game.Dorm.DormEnum")
local DormFurnitureEntity = require("Game.Dorm.Entity.DormFurnitureEntity")
local CS_EventTrigger = CS.EventTriggerListener
local CS_GameObject = CS.UnityEngine.GameObject
local CS_ResLoader = CS.ResLoader

function DormRoomEntity:ctor()
  self.__onRoomClicked = BindCallback(self, self.OnRoomClicked)
  self._AddFntEntityGoFunc = BindCallback(self, self.AddFntEntityGo)
end

function DormRoomEntity:InitHouseData(x, y, spos, roomData)
  self.x = x
  self.y = y
  self.spos = spos
  self.roomData = roomData
end

function DormRoomEntity:GetCharacterResLoader()
  return self.characterResLoader
end

function DormRoomEntity:SetDmRoomEntityData(roomData)
  self.roomData = roomData
end

function DormRoomEntity:IsEmptyRoom()
  return self.roomData == nil
end

function DormRoomEntity:IsBigRoomType()
  return self.roomData and self.roomData:IsBigRoomType()
end

function DormRoomEntity:ChangeDormRoomPos(spos)
  self.spos = spos
  local x, y = DormUtil.RoomCoordToXY(spos)
  self.x = x
  self.y = y
  self.roomData:ChangePos(spos)
  if not IsNull(self.gameObject) then
    self.transform.position = self:RoomHexToUnityCoord(self.x, self.y)
  end
  self:__RefreshDormDoorPos()
end

function DormRoomEntity:RoomHexToUnityCoord(x, y)
  local z = -x - y
  local gridHeight = self._roomCfg.grid_height
  local modelSize = self._roomCfg.model_size
  local houseHeight = gridHeight * ConfigData.game_config.HouseGridWidth + ConfigData.game_config.HouseFloorHeight
  return Vector3.New(y * modelSize, z * houseHeight, x * modelSize)
end

function DormRoomEntity:GetDormRoomCenterPos()
  local pos = self.transform.position
  local gridHeight = self._roomCfg.grid_height
  pos.y = pos.y + (gridHeight * ConfigData.game_config.HouseGridWidth - ConfigData.game_config.HouseFloorHeight) / 2
  local resultPos = UIManager:World2UIPosition(pos)
  return Vector3.New(resultPos.x, resultPos.y, 0)
end

function DormRoomEntity:LoadRoomEntity(dormHolder, comResDic, clickAction, showUnlockFx)
  self._comResDic = comResDic
  self._roomCfg = comResDic.defaultDmRoomCfg
  local prefab = self:IsEmptyRoom() and comResDic.lockRoomPrefab or comResDic.roomPrefab
  local go = prefab:Instantiate(dormHolder)
  go.name = string.format("%d_%d", self.x, self.y)
  self.gameObject = go
  self.transform = go.transform
  self.transform.position = self:RoomHexToUnityCoord(self.x, self.y)
  local eventTrigger = CS_EventTrigger.Get(self.gameObject)
  eventTrigger:onClick("+", self.__onRoomClicked)
  self.clickAction = clickAction
  if showUnlockFx and not IsNull(comResDic.roomUnlockFxPrefab) and not self:IsEmptyRoom() then
    local unlockFxGo = comResDic.roomUnlockFxPrefab:Instantiate(self.transform)
    unlockFxGo.transform.position = Vector3.zero
    unlockFxGo:SetActive(false)
    self._unlockFxGo = unlockFxGo
    local lockGo = comResDic.lockRoomPrefab:Instantiate(self.transform)
    lockGo.transform.position = Vector3.zero
    self._lockGo = lockGo
  end
  if self:IsBigRoomType() then
    local effect = self.transform:Find("Effect")
    if not IsNull(effect) then
      effect.gameObject:SetActive(false)
    end
  end
  if self:IsEmptyRoom() then
    return
  end
  self:InitRoomHolder()
  self:ChangeDmRoomFloor(self.roomData.floorId)
  self:ChangeDmRoomWall(self.roomData.wallId)
  if self.characterResLoader ~= nil then
    self.characterResLoader:Put2Pool()
  end
  self.characterResLoader = CS_ResLoader.Create()
  self:InitAllFntEntity()
  self:__RefreshDormDoorPos()
end

function DormRoomEntity:TryPlayDmRoomUnlockFx()
  if not IsNull(self._lockGo) then
    self._lockGo:SetActive(false)
  end
  if not IsNull(self._unlockFxGo) then
    self._unlockFxGo:SetActive(true)
  end
end

function DormRoomEntity:_InstantiateFloor(prefab)
  DestroyUnityObject(self.__floorObject)
  local go = prefab:Instantiate(self.floorObjHolder)
  go.name = prefab.name
  self.__floorObject = go
end

function DormRoomEntity:_InstantiateWall(prefab)
  self.__wallObjectList = self.__wallObjectList or {}
  local wallsGo = prefab:Instantiate()
  for k, holder in ipairs(self.wallHolder) do
    DestroyUnityObject(self.__wallObjectList[k])
    local wall = wallsGo.transform:Find(tostring(k))
    if IsNull(wall) then
      error(string.format("Cant find dorm wall, prefab name : %s, wall index : %s", prefab.name, k))
    else
      wall:SetParent(holder.parent, false)
      wall.localEulerAngles = Vector3.zero
      wall:SetAsFirstSibling()
      wall.gameObject.name = prefab.name
      self.__wallObjectList[k] = wall.gameObject
    end
  end
  DestroyUnityObject(wallsGo)
end

function DormRoomEntity:_InitWallFntEntityDic()
  self.wallFntEntityDic = {}
  for i = 1, 4 do
    self.wallFntEntityDic[i] = {}
  end
end

function DormRoomEntity:InitAllFntEntity()
  self.fntObjDic = {}
  self.fntEntityDic = {}
  self:_InitWallFntEntityDic()
  if self.roomData ~= nil then
    for k, fntData in ipairs(self.roomData.fntDataList) do
      self:CreateFntEntity(fntData, false)
    end
  end
  self:CreateFntEntity(self.roomData.dmRoomDoorData, false)
end

function DormRoomEntity:ResetDmRoomFntEntity(fntEntity, isResetOneFnt)
  local fntData = fntEntity.fntData
  local fntType = fntData:GetFntType()
  local wallpaperChangeWall
  if isResetOneFnt then
    self:UpdateFntMap(fntEntity, false)
    wallpaperChangeWall = fntType == DormEnum.eDormFntType.Wallpaper and fntData:IsFntDataParam2Change()
    if wallpaperChangeWall then
      self.roomData:RemoveDmWallpaper(fntData)
    end
  end
  fntData:ResetFntData()
  local holder = self:GetFntHolder(fntType, fntData:GetFntParam())
  fntEntity:ResetFntEntityByData(holder)
  if isResetOneFnt then
    self:UpdateFntMap(fntEntity, true)
    if wallpaperChangeWall then
      self.roomData:InsertDmWallpaper(fntData)
    end
  end
end

function DormRoomEntity:ReinitAllFntEntity()
  for fntData, fntEntity in pairs(self.originFntEntityDic) do
    if not fntData:IsDmFntDoor() then
      self:ResetDmRoomFntEntity(fntEntity)
      if self.fntEntityDic[fntData] == nil then
        fntEntity:OnRecoveryOriginFnt()
        self:AddFntEntityGo(fntEntity)
        self:AddFntEntityData(fntEntity)
      end
    end
  end
  self.roomData:RestoreDmRoomDntList()
end

function DormRoomEntity:InitRoomHolder()
  local offset = ConfigData.game_config.HouseGridWidth / 2
  local gridLength = self._roomCfg.grid_length
  local gridHeight = self._roomCfg.grid_height
  local groundX = gridLength * ConfigData.game_config.HouseGridWidth / 2 - offset
  local wallY = gridHeight * ConfigData.game_config.HouseGridWidth - offset
  local floorPos = Vector3.New(-groundX, 0, -groundX)
  local wallSizeX = self._roomCfg.model_size
  local wallSizeY = gridHeight * ConfigData.game_config.HouseGridWidth
  local wallThickness = ConfigData.game_config.HouseFloorHeight
  self.editCollider = self.transform:FindComponent(eUnityComponentID.Collider)
  self.characterHolder = self.transform:FindComponent("Character", eUnityComponentID.Transform)
  self.characterHolder.localPosition = floorPos
  self.fntHolder = self.transform:FindComponent("Furniture", eUnityComponentID.Transform)
  self.fntHolder.localPosition = floorPos
  self.floorHolder = self.transform:FindComponent("FloorHolder", eUnityComponentID.Transform)
  self.floorHolder.localPosition = floorPos
  local floorCollider = self.transform:FindComponent("Floor", eUnityComponentID.Collider)
  floorCollider.center = Vector3.New(0, -wallThickness / 2, 0)
  local floorWidth = wallSizeX
  if self:IsBigRoomType() then
    floorWidth = floorWidth + 10
  end
  floorCollider.size = Vector3.New(floorWidth, wallThickness, floorWidth)
  self.floorObjHolder = floorCollider.transform
  self.wallHolder = {}
  self.wallObjDic = {}
  self.wallColliderDic = {}
  local wallCenterV3 = Vector3.New(0, wallSizeY / 2, -(wallSizeX / 2 - wallThickness / 2))
  local wallSizeV3 = Vector3.New(wallSizeX, wallSizeY, wallThickness)
  for i = 1, 4 do
    local wall = self.transform:FindComponent("Wall/" .. tostring(i), eUnityComponentID.Transform)
    local wallLocalPos = Quaternion.Euler(0, (i - 1) * 90, 0):MulVec3(Vector3.New(groundX, wallY, -groundX - offset))
    local holder = CS_GameObject("WallHolder" .. tostring(i)).transform
    self.wallHolder[i] = holder
    holder:SetParent(wall, false)
    holder.position = self.transform.position + wallLocalPos
    self.wallObjDic[i] = wall.gameObject
    local collider = wall:FindComponent(eUnityComponentID.Collider)
    if IsNull(collider) then
      error("wall collider is nil, wallId" .. tostring(i))
    else
      self.wallColliderDic[i] = collider
      collider.center = wallCenterV3
      collider.size = wallSizeV3
    end
  end
end

function DormRoomEntity:SetEditColliderEnable(enable)
  if self:IsEmptyRoom() then
    return
  end
  self.editCollider.enabled = enable
end

function DormRoomEntity:InitFntMapData()
  local groundX = self._roomCfg.grid_length
  local wallY = self._roomCfg.grid_height
  self.mapData = {}
  local wallMapList = {}
  local wallpaperMapList = {}
  for i = 1, 4 do
    wallMapList[i] = {}
    wallpaperMapList[i] = {}
  end
  self.mapData.wallMapList = wallMapList
  self.mapData.wallpaperMapList = wallpaperMapList
  local fntMap = {}
  self.mapData.fntMap = fntMap
  local groundMap = {}
  self.mapData.groundMap = groundMap
  for k, fntEntity in pairs(self.fntObjDic) do
    self:UpdateFntMap(fntEntity, true)
  end
end

function DormRoomEntity:ClearFntMapData()
  self.mapData = nil
end

function DormRoomEntity:__GetFntMap(fntType, param)
  local map
  if fntType == DormEnum.eDormFntType.FloorDecoration then
    map = self.mapData.groundMap
  elseif fntType == DormEnum.eDormFntType.WallDecoration or fntType == DormEnum.eDormFntType.Door then
    map = self.mapData.wallMapList[param]
  elseif fntType == DormEnum.eDormFntType.Wallpaper then
    map = self.mapData.wallpaperMapList[param]
  elseif fntType == DormEnum.eDormFntType.Furniture then
    map = self.mapData.fntMap
  end
  if map == nil then
    error("fnt map is nil, fntType = " .. tostring(fntType) .. ", param = " .. tostring(param))
    return
  end
  return map
end

function DormRoomEntity:UpdateFntMap(fntEntity, isAdd, areaList, wallIndex, doorFloorAreaList)
  local fntType = fntEntity.fntData:GetFntType()
  local param = wallIndex or fntEntity.fntData:GetFntParam()
  if areaList == nil then
    areaList = fntEntity:GetFntAreaList()
  end
  local overlapEntityDic = {}
  if fntType ~= DormEnum.eDormFntType.Wallpaper then
    local map = self:__GetFntMap(fntType, param)
    self:_UpdMapAreaList(areaList, isAdd, map, fntType, fntEntity, overlapEntityDic)
  end
  if fntEntity.fntData:IsInFntWallpaperMap() then
    local map = self:__GetFntMap(DormEnum.eDormFntType.Wallpaper, param)
    self:_UpdMapAreaList(areaList, isAdd, map, fntType, fntEntity, overlapEntityDic, true)
  end
  if fntType == DormEnum.eDormFntType.Door then
    if doorFloorAreaList == nil then
      doorFloorAreaList = fntEntity:GetFntDoorAreaList()
    end
    local floorMap = self:__GetFntMap(DormEnum.eDormFntType.Furniture)
    self:_UpdMapAreaList(doorFloorAreaList, isAdd, floorMap, DormEnum.eDormFntType.Furniture, fntEntity, overlapEntityDic)
  end
  for entity, notOnlyOne in pairs(overlapEntityDic) do
    if entity == fntEntity then
      entity:SetFntOverlap(notOnlyOne)
    else
      local overlap = self:_CheckFntOverlap(entity)
      entity:SetFntOverlap(overlap)
    end
  end
  local wallFntEntityDic = self.wallFntEntityDic[param]
  if wallFntEntityDic ~= nil then
    if isAdd then
      wallFntEntityDic[fntEntity.fntData] = fntEntity
    else
      wallFntEntityDic[fntEntity.fntData] = nil
    end
  end
end

function DormRoomEntity:_UpdMapAreaList(areaList, isAdd, map, fntType, fntEntity, overlapEntityDic, isWallpaperMap)
  for k, pos in pairs(areaList) do
    if isAdd and self:FntPosOutMap(pos.x, pos.y, fntType) then
      overlapEntityDic[fntEntity] = true
    else
      if map[pos.x] == nil then
        map[pos.x] = {}
      end
      if map[pos.x][pos.y] == nil then
        map[pos.x][pos.y] = {}
      end
      local grid = map[pos.x][pos.y]
      if isAdd then
        grid[fntEntity] = true
      else
        grid[fntEntity] = nil
      end
      local overlap = self:_CheckAreaGridOverlap(grid, isWallpaperMap)
      for entity, _ in pairs(grid) do
        overlapEntityDic[entity] = overlapEntityDic[entity] or overlap
      end
    end
  end
end

function DormRoomEntity:FntPosOutMap(x, y, fntType)
  local sizeX = self._roomCfg.grid_length
  local sizeY = self._roomCfg.grid_height
  if DormEnum.IsFntWallType(fntType) then
    return x < 0 or x >= sizeX or y < 0 or y >= sizeY
  else
    return x < 0 or x >= sizeX or y < 0 or y >= sizeX
  end
end

function DormRoomEntity:_CheckFntOverlap(fntEntity)
  local fntType = fntEntity.fntData:GetFntType()
  local areaList = fntEntity:GetFntAreaList()
  local param = fntEntity.fntData:GetFntParam()
  local map = self:__GetFntMap(fntType, param)
  if fntType ~= DormEnum.eDormFntType.Wallpaper and self:_CheckAreaListOverlap(areaList, fntType, map) then
    return true
  end
  if fntEntity.fntData:IsInFntWallpaperMap() then
    local mapPaper = self:__GetFntMap(DormEnum.eDormFntType.Wallpaper, param)
    if self:_CheckAreaListOverlap(areaList, fntType, mapPaper, true) then
      return true
    end
  end
  if fntType == DormEnum.eDormFntType.Door then
    local doorFloorAreaList = fntEntity:GetFntDoorAreaList()
    local floorMap = self:__GetFntMap(DormEnum.eDormFntType.Furniture)
    if self:_CheckAreaListOverlap(doorFloorAreaList, DormEnum.eDormFntType.Furniture, floorMap) then
      return true
    end
  end
  return false
end

function DormRoomEntity:_CheckAreaListOverlap(areaList, fntType, map, isWallpaperMap)
  for k, pos in pairs(areaList) do
    if self:FntPosOutMap(pos.x, pos.y, fntType) then
      return true
    end
    if map[pos.x] ~= nil and map[pos.x][pos.y] ~= nil then
      local grid = map[pos.x][pos.y]
      if self:_CheckAreaGridOverlap(grid, isWallpaperMap) then
        return true
      end
    end
  end
  return false
end

function DormRoomEntity:_CheckAreaGridOverlap(gridDic, isWallpaperMap)
  local overlap = false
  local num = 0
  local hasWallpaperOverlap = false
  for entity, _ in pairs(gridDic) do
    if isWallpaperMap and not hasWallpaperOverlap and entity.fntData:IsFntWallpaperOverlap() then
      hasWallpaperOverlap = true
    end
    num = num + 1
    if 1 < num then
      if isWallpaperMap then
        if hasWallpaperOverlap then
          overlap = true
          break
        end
      else
        overlap = true
        break
      end
    end
  end
  return overlap
end

function DormRoomEntity:FntMapOverlap()
  for k, v in pairs(self.fntObjDic) do
    if v:IsOverlap() then
      return true
    end
  end
  return false
end

function DormRoomEntity:OnRoomClicked(go, eventData)
  if self.clickAction ~= nil then
    self.clickAction(self)
  end
end

function DormRoomEntity:GetFntHolder(fntType, wallId)
  if DormEnum.IsFntWallType(fntType) then
    return self.wallHolder[wallId]
  elseif fntType == DormEnum.eDormFntType.Furniture then
    return self.fntHolder
  elseif fntType == DormEnum.eDormFntType.FloorDecoration then
    return self.floorHolder
  else
    error("Furniture type error, id = " .. tostring(fntType))
  end
end

function DormRoomEntity:CreateFntEntity(fntData, isNew)
  local path = fntData:GetFntPrefab()
  local fntType = fntData:GetFntType()
  local entity = DormFurnitureEntity.New()
  local parent = self:GetFntHolder(fntType, fntData.param)
  entity:InitFntEntity(fntData, parent)
  self:AddFntEntityData(entity)
  if isNew then
    self.roomData:AddFntData(fntData)
    self:UpdateFntMap(entity, true)
  end
  entity:LoadFntEntityGo(path, self._AddFntEntityGoFunc)
  return entity
end

function DormRoomEntity:ChangeDmRoomDoorGo()
  local fntData = self.roomData.dmRoomDoorData
  local entity = self:GetFntByData(fntData)
  entity:InitFntEntityRoot()
  if not entity:IsDmFntEntityInLoading() then
    self.fntObjDic[entity.gameObject] = nil
    entity:DestroyDmFntEntityGo()
  end
  entity:ResetFntBottom()
  local path = fntData:GetFntPrefab()
  entity:LoadFntEntityGo(path, self._AddFntEntityGoFunc)
end

function DormRoomEntity:AddFntEntityGo(fntEntity)
  self.fntObjDic[fntEntity.gameObject] = fntEntity
end

function DormRoomEntity:AddFntEntityData(fntEntity)
  self.fntEntityDic[fntEntity.fntData] = fntEntity
  local wallFntEntityDic = self.wallFntEntityDic[fntEntity.fntData:GetFntParam()]
  if wallFntEntityDic ~= nil then
    wallFntEntityDic[fntEntity.fntData] = fntEntity
  end
end

function DormRoomEntity:RemoveFntEntity(fntEntity, isRemoveAll)
  local fntData = fntEntity.fntData
  local fntType = fntData:GetFntType()
  self:UpdateFntMap(fntEntity, false)
  self.fntObjDic[fntEntity.gameObject] = nil
  self.fntEntityDic[fntEntity.fntData] = nil
  local wallFntEntityDic = self.wallFntEntityDic[fntEntity.fntData:GetFntParam()]
  if wallFntEntityDic ~= nil then
    wallFntEntityDic[fntEntity.fntData] = nil
  end
  self.roomData:RemoveFntData(fntEntity.fntData)
  if fntType == DormEnum.eDormFntType.Wallpaper and not isRemoveAll then
    self.roomData:RemoveDmWallpaper(fntData)
  end
end

function DormRoomEntity:GetFntByGo(go)
  local entity = self.fntObjDic[go]
  if entity == nil then
    error("Can't get fnt entity by go, go = " .. tostring(go))
  end
  return entity
end

function DormRoomEntity:GetFntByData(fntData)
  return self.fntEntityDic[fntData]
end

function DormRoomEntity:GetFntObjDic()
  return self.fntObjDic
end

function DormRoomEntity:GetFntCount()
  return #self.roomData.fntDataList
end

function DormRoomEntity:IsOriginDmRoomFnt(fntData)
  return self.originFntEntityDic[fntData] ~= nil
end

function DormRoomEntity:EnterRoomEditMode(floorGo, wallGoDic, roomCtrl)
  self.roomData:BackupDmRoomDntList()
  floorGo.transform:SetParent(self.transform, false)
  floorGo:SetActive(false)
  for k, go in pairs(wallGoDic) do
    go.transform:SetParent(self.wallHolder[k].parent, false)
    go:SetActive(false)
  end
  self:InitFntMapData()
  local originFntEntityDic = {}
  for k, fntEntity in pairs(self.fntObjDic) do
    local fntBottomItem = roomCtrl:GetFntBottomItem()
    fntEntity:AddFntBottom(fntBottomItem)
    if fntEntity.fntData:IsDmFntDoor() then
      local bottomItem = roomCtrl:GetFntBottomItem()
      fntEntity:AddFntDoorBottom(bottomItem)
    end
    originFntEntityDic[fntEntity.fntData] = fntEntity
  end
  self.originFntEntityDic = originFntEntityDic
  for k, fntEntity in pairs(self.fntEntityDic) do
    fntEntity:ResetFntAnimatorState()
  end
  self._dmRoomCtrl = roomCtrl
end

function DormRoomEntity:ExitRoomEditMode(roomCtrl, editSuccess)
  self:ClearFntMapData()
  self.roomData:ClearDmRoomDntListBackup()
  for k, fntEntity in pairs(self.fntEntityDic) do
    local fntBottomItem = fntEntity:RemoveFntBottom()
    if fntBottomItem ~= nil then
      roomCtrl:RecycleFntBottomItem(fntBottomItem)
    end
    local bottomItem = fntEntity:RemoveFntDoorBottom()
    if bottomItem ~= nil then
      roomCtrl:RecycleFntBottomItem(bottomItem)
    end
  end
  if editSuccess then
    self:__RefreshDormDoorPos()
  end
  self.originFntEntityDic = nil
  self._dmRoomCtrl = nil
end

function DormRoomEntity:ResetAllFntAniState()
  if self.fntEntityDic == nil then
    return
  end
  for k, fntEntity in pairs(self.fntEntityDic) do
    fntEntity:ResetFntAnimatorState()
  end
end

function DormRoomEntity:StartHideRoom()
  self.gameObject:SetActive(false)
end

function DormRoomEntity:StartShowRoom()
  self.gameObject:SetActive(true)
end

function DormRoomEntity:ResetDormRoomWall()
  self:Show2Hide2DormRoom(1, 2, 3, 4)
end

function DormRoomEntity:Show3Hide1DormRoom(hideIndex)
  for i = 1, 4 do
    self:SetDormRoomWallActive(i, hideIndex ~= i)
  end
end

function DormRoomEntity:Show2Hide2DormRoom(index1, index2, index3, index4)
  self:SetDormRoomWallActive(index1, true)
  self:SetDormRoomWallActive(index2, true)
  self:SetDormRoomWallActive(index3, false)
  self:SetDormRoomWallActive(index4, false)
end

function DormRoomEntity:SetDormRoomWallActive(index, active)
  if self.wallColliderDic == nil then
    return
  end
  local wallCollider = self.wallColliderDic[index]
  if wallCollider ~= nil then
    wallCollider.enabled = active
  end
  local wallFntEntityDic = self.wallFntEntityDic[index]
  for fntData, fntEntity in pairs(wallFntEntityDic) do
    fntEntity:EnableDmFntCollider(active)
    fntEntity:EnableDmFntVisibleHolder(active)
  end
  if self._dmRoomCtrl ~= nil then
    self._dmRoomCtrl:OnDmRoomWallShow(index, active)
  end
end

function DormRoomEntity:ChangeDmRoomFloor(id)
  if id == 0 then
    self:_InstantiateFloor(self._comResDic.defaultFloorPrefab)
    return
  end
  local fntCfg = ConfigData.dorm_furniture[id]
  if fntCfg == nil then
    error("Can't find dorm_furniture cfg, id = " .. tostring(id))
    return
  end
  local roomType = self.roomData:GetDmRoomType()
  local path = DormUtil.GetDmFntPrefabPath(roomType, fntCfg)
  self:_ClearFloorResLoader()
  local resLoader = CS_ResLoader.Create()
  resLoader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) then
      return
    end
    self:_InstantiateFloor(prefab)
  end)
  self._floorResLoader = resLoader
end

function DormRoomEntity:_ClearFloorResLoader()
  if self._floorResLoader ~= nil then
    self._floorResLoader:Put2Pool()
    self._floorResLoader = nil
  end
end

function DormRoomEntity:ChangeDmRoomWall(id)
  if id == 0 then
    self:_InstantiateWall(self._comResDic.defaultWallPrefab)
    return
  end
  local fntCfg = ConfigData.dorm_furniture[id]
  if fntCfg == nil then
    error("Can't find dorm_furniture cfg, id = " .. tostring(id))
    return
  end
  local roomType = self.roomData:GetDmRoomType()
  local path = DormUtil.GetDmFntPrefabPath(roomType, fntCfg)
  self:_ClearWallResLoader()
  local resLoader = CS_ResLoader.Create()
  resLoader:LoadABAssetAsync(path, function(prefab)
    if IsNull(prefab) then
      return
    end
    self:_InstantiateWall(prefab)
  end)
  self._wallResLoader = resLoader
end

function DormRoomEntity:_ClearWallResLoader()
  if self._wallResLoader ~= nil then
    self._wallResLoader:Put2Pool()
    self._wallResLoader = nil
  end
end

function DormRoomEntity:_ClearCharacterResLoader()
  if self.characterResLoader ~= nil then
    self.characterResLoader:Put2Pool()
    self.characterResLoader = nil
  end
end

function DormRoomEntity:IsDmRoomWall(gameObject)
  for wallIndex, go in pairs(self.wallObjDic) do
    if go == gameObject then
      return true, wallIndex, self.wallHolder[wallIndex]
    end
  end
  return false
end

function DormRoomEntity:__RefreshDormDoorPos()
  local doorData = self.roomData.dmRoomDoorData
  local offsetX = (doorData:GetFntSize() - 1) * ConfigData.game_config.HouseGridWidth / 2
  local wallpos = DormUtil.FntCoord2Unity(doorData.x, doorData.y, doorData:GetFntType())
  local wallId = doorData:GetFntParam()
  local holder = self.wallHolder[wallId]
  if holder == nil then
    error("dorm holder ")
    return Vector3.zero
  end
  wallpos.x = wallpos.x - offsetX
  wallpos.z = -0.2
  local worldPos = holder:TransformPoint(wallpos)
  local y = self.transform.position.y
  worldPos.y = y
  wallpos.z = 0.2
  local doorFrontPos = holder:TransformPoint(wallpos)
  doorFrontPos.y = y
  self.__doorWorldPos = worldPos
  self.__doorFrontPos = doorFrontPos
end

function DormRoomEntity:GetRoomDoorPos()
  local wallId = self.roomData.dmRoomDoorData:GetFntParam()
  return wallId, self.__doorWorldPos, self.__doorFrontPos
end

function DormRoomEntity:IsAnyDmFntEntityInLoading()
  for k, fntEntity in pairs(self.fntEntityDic) do
    if fntEntity:IsDmFntEntityInLoading() then
      return true
    end
  end
  return false
end

function DormRoomEntity:GetDmRoomDoorWallId()
  if self.roomData == nil then
    return 0
  end
  return self.roomData.dmRoomDoorData:GetFntParam()
end

function DormRoomEntity:OnDelete()
  self:_ClearFloorResLoader()
  self:_ClearWallResLoader()
  self:_ClearCharacterResLoader()
  self.wallObjDic = nil
  self.wallColliderDic = nil
  if self.fntEntityDic ~= nil then
    for fntData, fntEntity in pairs(self.fntEntityDic) do
      fntEntity:OnDelete()
    end
    self.fntEntityDic = nil
  end
end

return DormRoomEntity
