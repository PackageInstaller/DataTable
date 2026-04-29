_class("AircraftRoom", Object)
AircraftRoom = AircraftRoom

function AircraftRoom:Constructor(roomGameObject, roomLogicData, floor)
  self._roomGO = roomGameObject
  self._roomLogicData = roomLogicData
  self._floor = floor
  self.collider = self._roomGO:GetComponent(typeof(UnityEngine.BoxCollider))
  self._boxCenter = self._roomGO.transform.position + self.collider.center
  self._visible = true
  self:_initArea()
  self:_Init()
  self:_initClickObject()
end

function AircraftRoom:_initArea()
  local type = self:LogicRoomType()
  self._area = nil
  if type == AirRoomType.CentralRoom then
    self._area = AirRestAreaType.CenterRoom
  elseif type == AirRoomType.RestRoom then
    self._area = AirRestAreaType.RestRoom
  elseif type == AirRoomType.CoffeeRoom then
    self._area = AirRestAreaType.CoffeeHouse
  elseif type == AirRoomType.WaterBarRoom then
    self._area = AirRestAreaType.Bar
  elseif type == AirRoomType.GameRoom then
    self._area = AirRestAreaType.EntertainmentRoom
  end
end

function AircraftRoom:_Init()
  local cfg = self._roomLogicData:GetConfig()
  local modleParam
  if cfg then
    modleParam = cfg.Prefab
  end
  if modleParam == nil then
    Log.fatal("### aircraft -- modle param is nil !")
    return
  end
  local modleNameArr = string.split(modleParam, "|")
  if #modleNameArr <= 0 then
    Log.fatal("### aircraft -- modle param is error !")
    return
  end
  local modleName
  for i = 1, #modleNameArr do
    local PerfabAndSpace = string.split(modleNameArr[i], ",")
    modleName = PerfabAndSpace[1]
    if PerfabAndSpace[2] ~= nil and tonumber(PerfabAndSpace[2]) == self:SpaceID() then
      break
    end
  end
  if modleName == nil then
    Log.fatal("### aircraft -- modle name is nil !")
    return
  end
  Log.notice("加载房间模型--", modleName)
  self._roomModleRequest = ResourceManager:GetInstance():SyncLoadAsset(modleName .. ".prefab", LoadType.GameObject)
  local module = self._roomModleRequest.Obj
  module:SetActive(true)
  module.transform:SetParent(self._roomGO.transform, true)
  module.transform.localPosition = Vector3(0, 0, 0)
  module.transform.localScale = Vector3(1, 1, 1)
  self._roomPrefab = module
  local rootTrans = self._roomGO.transform
  self._naviRoot = rootTrans:GetChild(0):Find("naviRoot")
  if self._naviRoot == nil then
    Log.exception("找不到房间内naviRoot，房间模型名称：", self._roomGO.name)
    return
  end
  local nodeName = "Points"
  self._pointHolder = AircraftPointHolder:New(self._naviRoot:Find(nodeName), self._floor, "空间" .. self:SpaceID() .. "漫游点")
  nodeName = "GatherPoints"
  self._gatherPointHolder = AircraftPointHolder:New(self._naviRoot:Find(nodeName), self._floor, "空间" .. self:SpaceID() .. "社交聚集点")
  local randomPointRoot = self._naviRoot:Find("RandomStoryPoints")
  if randomPointRoot then
    self._randomStoryPointHolder = AircraftStoryPointHolder:New(randomPointRoot, self._floor)
  end
  if self._roomLogicData:GetRoomType() < AirRoomType.EmptySpace then
    self:InitNavi(module)
    if self._roomLogicData:GetRoomType() == AirRoomType.CentralRoom then
      self:InitRestRoom()
    end
  else
    self:InitRestRoom()
  end
end

function AircraftRoom:InitNavi(module)
  if self._roomLogicData:GetRoomType() == AirRoomType.AisleRoom then
    self:SetColliderEnable(self._roomLogicData:GetSpaceStatus() ~= SpaceState.SpaceStateFull)
  else
    local model = module.transform:Find("model"):GetChild(0)
    local navmeshObj = model:Find("NavMeshRoot").gameObject
    if navmeshObj then
      navmeshObj:SetActive(false)
    end
  end
end

function AircraftRoom:InitRestRoom()
  local roomType = self._roomLogicData:GetRoomType()
  self._wanderingPetList = {}
  self._belongPetList = {}
  if roomType == AirRoomType.RestRoom then
    self._walkCeiling = Cfg.cfg_aircraft_rest_room[1001].WalkCeiling
    self._petCeiling = Cfg.cfg_aircraft_rest_room[1001].PetCeiling
    self._roomTag = AircraftRoomTag.RestRoom
  elseif roomType == AirRoomType.CoffeeRoom then
    self._walkCeiling = Cfg.cfg_aircraft_rest_room[2001].WalkCeiling
    self._petCeiling = Cfg.cfg_aircraft_rest_room[2001].PetCeiling
    self._roomTag = AircraftRoomTag.CoffeeHouse
  elseif roomType == AirRoomType.WaterBarRoom then
    self._walkCeiling = Cfg.cfg_aircraft_rest_room[3001].WalkCeiling
    self._petCeiling = Cfg.cfg_aircraft_rest_room[3001].PetCeiling
    self._roomTag = AircraftRoomTag.Bar
  elseif roomType == AirRoomType.GameRoom then
    self._walkCeiling = Cfg.cfg_aircraft_rest_room[4001].WalkCeiling
    self._petCeiling = Cfg.cfg_aircraft_rest_room[4001].PetCeiling
    self._roomTag = AircraftRoomTag.Game
  elseif roomType == AirRoomType.CentralRoom then
    self._walkCeiling = Cfg.cfg_aircraft_rest_room[9999].WalkCeiling
    self._petCeiling = Cfg.cfg_aircraft_rest_room[9999].PetCeiling
  else
    Log.fatal("[AircaftPet] 休息区房间类型错误：", roomType, "，空间ID：", self:SpaceID())
  end
  self:InitDefaultFurniture()
end

function AircraftRoom:InitDefaultFurniture()
  local furnitureRoot = self._roomPrefab.transform:Find("furnitureRoot")
  if furnitureRoot == nil or furnitureRoot.childCount == 0 then
    return
  end
  self._defaultFurnitures = {}
  for i = 0, furnitureRoot.childCount - 1 do
    local fGo = furnitureRoot:GetChild(i).gameObject
    local furniture = AircraftFurniture:New(nil, fGo, self._floor, self._area)
    self._defaultFurnitures[i + 1] = furniture
  end
end

function AircraftRoom:GetDefaultFurniture()
  return self._defaultFurnitures
end

function AircraftRoom:_initClickObject()
  self._clickObject = nil
  local roomType = self._roomLogicData:GetRoomType()
  if roomType == AirRoomType.CoffeeRoom then
    local bookShelf = self._roomPrefab.transform:Find("UIAircraftBookTip")
    if bookShelf then
      self._clickObject = bookShelf.gameObject
    end
  elseif roomType == AirRoomType.SmeltRoom then
    local smeltTip = self._roomPrefab.transform:Find("UIAircraftSmeltTip")
    if smeltTip then
      self._clickObject = smeltTip.gameObject
    end
  elseif roomType == AirRoomType.DispatchRoom then
    local dispatchTip = self._roomPrefab.transform:Find("UIAircraftDispatchTip")
    if dispatchTip then
      self._clickObject = dispatchTip.gameObject
    end
  elseif roomType == AirRoomType.PrismRoom then
    local award = self._roomPrefab.transform:Find("award")
    if award then
      self._clickObject = award.gameObject
    end
  elseif roomType == AirRoomType.MazeRoom then
    local award = self._roomPrefab.transform:Find("award")
    if award then
      self._clickObject = award.gameObject
    end
  elseif roomType == AirRoomType.TowerRoom then
    local award = self._roomPrefab.transform:Find("award")
    if award then
      self._clickObject = award.gameObject
    end
  elseif roomType == AirRoomType.TacticRoom then
    local tip = self._roomPrefab.transform:Find("UIAircrafTacticTip")
    if tip then
      self._clickObject = tip.gameObject
    end
  end
end

function AircraftRoom:Dispose()
  if self._awardTimer then
    GameGlobal.Timer():CancelEvent(self._awardTimer)
  end
  self._roomModleRequest:Dispose()
end

function AircraftRoom:CheckGround(trans)
  return self._naviRoot == trans
end

function AircraftRoom:GetRoomGameObject()
  return self._roomGO
end

function AircraftRoom:GetRoomLogicData()
  return self._roomLogicData
end

function AircraftRoom:LogicRoomType()
  return self._roomLogicData:GetRoomType()
end

function AircraftRoom:Status()
  return self._roomLogicData:Status()
end

function AircraftRoom:GetPointHolder()
  return self._pointHolder
end

function AircraftRoom:GetGatherPointHolder()
  return self._gatherPointHolder
end

function AircraftRoom:GetRandomStoryPointHolder()
  return self._randomStoryPointHolder
end

function AircraftRoom:SpaceID()
  return self._roomLogicData:SpaceId()
end

function AircraftRoom:Level()
  return self._roomLogicData:Level()
end

function AircraftRoom:GetRoomTag()
  return self._roomTag
end

function AircraftRoom:Area()
  return self._area
end

function AircraftRoom:Floor()
  return self._floor
end

function AircraftRoom:CenterPosition()
  return self._boxCenter
end

function AircraftRoom:PetEnterWandering(id)
  if self:IsWanderingPetFull() then
    Log.fatal("[AircaftPet] 当前房间已满，不能进入！")
    return
  end
  table.insert(self._wanderingPetList, id)
end

function AircraftRoom:PetLeaveWandering(id)
  if #self._wanderingPetList <= 0 then
    Log.fatal("[AircaftPet] 当前房间星灵为空")
    return
  end
  table.removev(self._wanderingPetList, id)
end

function AircraftRoom:IsWanderingPetFull()
  return #self._wanderingPetList >= self._walkCeiling
end

function AircraftRoom:PetIn(id)
  if self:IsBelongPetFull() then
    Log.fatal("[AircaftPet] 房间已满")
  end
  table.insert(self._belongPetList, id)
end

function AircraftRoom:PetOut(id)
  if #self._belongPetList <= 0 then
    Log.fatal("[AircaftPet] 房间人数为0")
  end
  table.removev(self._belongPetList, id)
end

function AircraftRoom:IsBelongPetFull()
  return #self._belongPetList >= self._petCeiling
end

function AircraftRoom:ClearPets()
  self._belongPetList = {}
end

function AircraftRoom:SetColliderEnable(enable)
  if self.collider then
    self.collider.enabled = enable
  end
end

function AircraftRoom:OnFocus()
  self._visible = true
  self:SetColliderEnable(false)
end

function AircraftRoom:OnExit()
  self._visible = false
  self:SetColliderEnable(true)
end

function AircraftRoom:GetFurniture(type)
  Log.exception("AircraftRoom的获取家具接口已删除。", debug.traceback())
end

function AircraftRoom:GetFurnitureByID(id)
  Log.exception("AircraftRoom的通过id获取家具接口已删除。", debug.traceback())
end

function AircraftRoom:_GetFurniture(type)
  local t = {}
  if self._furnitureTab then
    local furs = self._furnitureTab[type]
    if furs and 0 < #furs then
      for _, fur in ipairs(furs) do
        if 0 < fur:AvailableCount() then
          t[#t + 1] = fur
        end
      end
    end
  end
  return t
end

function AircraftRoom:GetFurnitures()
  Log.exception("AircraftRoom的GetFurnitures接口已删除。", debug.traceback())
end

function AircraftRoom:GetAllFurniture()
  Log.exception("AircraftRoom的GetAllFurniture接口已删除。", debug.traceback())
end

function AircraftRoom:RoomName()
  return StringTable.Get(self._roomLogicData:GetRoomName())
end

function AircraftRoom:GetFirflys(test)
  local firRoot
  if test then
    firRoot = self._lastReq.Obj.transform:Find("Firefly")
  else
    firRoot = self._roomPrefab.transform:Find("Firefly")
  end
  if firRoot then
    local fireflys = {}
    for i = 1, firRoot.childCount do
      local trans = firRoot:GetChild(i - 1)
      fireflys[i] = trans
    end
    return fireflys
  else
    Log.error("找不到Firefly节点")
  end
end

function AircraftRoom:GetWindow(test)
  if test then
    return self._lastReq.Obj.transform:Find("Window")
  else
    return self._roomPrefab.transform:Find("Window")
  end
end

function AircraftRoom:LoadLastGameObject()
  local lastID = self._roomLogicData:GetConfig().PrevLevelID
  local name = Cfg.cfg_aircraft_room[lastID].Prefab
  self._lastReq = ResourceManager:GetInstance():SyncLoadAsset(name .. ".prefab", LoadType.GameObject)
  local go = self._lastReq.Obj
  go.transform:SetParent(self._roomGO.transform)
  go.transform.localPosition = Vector3.zero
  go.transform.localRotation = Quaternion.identity
  go.transform.localScale = Vector3.one
  go:SetActive(true)
  self._lastGo = go
  self._roomModleRequest.Obj:SetActive(false)
end

function AircraftRoom:SwitchToNow()
  self._lastGo:SetActive(false)
  self._roomModleRequest.Obj:SetActive(true)
end

function AircraftRoom:ReleaseAllPoints()
  self._pointHolder:ReleaseAll()
  self._gatherPointHolder:ReleaseAll()
end

function AircraftRoom:OnStartDecorate()
  if self._clickObject then
    self._clickObject:SetActive(false)
  end
end

function AircraftRoom:OnStopDecorate()
  if self._clickObject then
    self._clickObject:SetActive(true)
  end
end
