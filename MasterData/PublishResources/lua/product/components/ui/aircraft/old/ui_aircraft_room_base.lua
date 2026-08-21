_class("UIAircraftRoomBase", Object)
UIAircraftRoomBase = UIAircraftRoomBase

function UIAircraftRoomBase:Constructor(roomGameObject, roomLogicData)
  self._roomGO = roomGameObject
  self._roomLogicData = roomLogicData
  self._groundTrans = nil
  self._petList = {}
  self.collider = self._roomGO:GetComponent(typeof(UnityEngine.BoxCollider))
  self.petScale = Cfg.cfg_aircraft_camera.petScale.Value
  self._interactiveAreaList = {}
  self._restPointList = {}
  self._restPointOccupiedDic = {}
  self._areaAndRestPointCount = 0
  self._visible = true
  self._spaceID2NavLayer = {
    [1] = 6,
    [2] = 7,
    [3] = 7,
    [4] = 7,
    [5] = 7,
    [6] = 8,
    [7] = 8,
    [8] = 8,
    [9] = 8,
    [10] = 8,
    [11] = 6,
    [12] = 6,
    [13] = 6,
    [14] = 6,
    [15] = 5,
    [16] = 5,
    [17] = 5,
    [18] = 5,
    [19] = 5,
    [20] = 4,
    [21] = 4,
    [22] = 4,
    [23] = 4,
    [24] = 4,
    [25] = 4,
    [26] = 3,
    [27] = 3,
    [28] = 3
  }
  self:_Init()
end

function UIAircraftRoomBase:GetNavLayerBySpaceID(spaceID)
  return self._spaceID2NavLayer[spaceID]
end

function UIAircraftRoomBase:_Init()
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
  module.transform:SetParent(self._roomGO.transform, false)
  module.transform.localPosition = Vector3(0, 0, 0)
  self:_InitPositions()
  local navmeshObj = module.transform:Find("NavMeshRoot").gameObject
  local moduleNavMesh = navmeshObj:GetComponent("NavMeshSurface")
  if moduleNavMesh == nil then
    Log.exception("找不到导航组件，房间prefab名称：", module.name)
    return
  end
  moduleNavMesh.defaultArea = self:GetNavLayerBySpaceID(self._roomLogicData:SpaceId())
  for i = 0, navmeshObj.transform.childCount - 1 do
    navmeshObj.transform:GetChild(i).gameObject:SetActive(true)
  end
  moduleNavMesh:BuildNavMesh()
  for i = 0, navmeshObj.transform.childCount - 1 do
    navmeshObj.transform:GetChild(i).gameObject:SetActive(false)
  end
  if self._roomLogicData:GetRoomType() == AirRoomType.AisleRoom then
    self:SetColliderEnable(self._roomLogicData:GetSpaceStatus() ~= SpaceState.SpaceStateFull)
    return
  end
  self:RefreshPets()
end

function UIAircraftRoomBase:_InitPositions()
  local rootTrans = self._roomGO.transform
  self._groundTrans = rootTrans:GetChild(0):Find("posRoot/Ground")
  if self._groundTrans == nil then
    Log.exception("找不到房间内Ground，房间模型名称：", self._roomGO.name)
    return
  end
  local fadeObjectsParent = rootTrans:Find("fadeObjects")
  self.fadeObjects = {}
  if fadeObjectsParent then
    for i = 1, fadeObjectsParent.childCount do
      self.fadeObjects[i] = fadeObjectsParent:GetChild(i - 1).gameObject
    end
  end
  self:_InitAreaAndPoints(self._groundTrans)
end

function UIAircraftRoomBase:_InitAreaAndPoints(groundTrans)
  if not groundTrans then
    return
  end
  local interactiveAreaRoot = groundTrans:Find("InteractiveArea")
  if interactiveAreaRoot then
    local areaCount = interactiveAreaRoot.childCount
    for i = 0, areaCount - 1 do
      local areaTrans = interactiveAreaRoot:GetChild(i)
      local interactiveArea = UIAircraftInteractiveArea:New(areaTrans.gameObject)
      self._interactiveAreaList[#self._interactiveAreaList + 1] = interactiveArea
    end
    self._areaAndRestPointCount = self._areaAndRestPointCount + areaCount
  end
  local restPointRoot = groundTrans:Find("RestPoints")
  if restPointRoot then
    local pointCount = restPointRoot.childCount
    for i = 0, pointCount - 1 do
      local point = restPointRoot:GetChild(i)
      local pointPos = point.position
      local faceIDStrList = string.split(point.gameObject.name, "|")
      local faceIDList = {}
      for i = 1, #faceIDStrList do
        faceIDList[i] = tonumber(faceIDStrList[i])
      end
      local point = UIAircraftInteractivePoint:New(pointPos, nil, faceIDList)
      local index = #self._restPointList + 1
      point:SetIndex(index)
      self._restPointList[index] = point
    end
    self._areaAndRestPointCount = self._areaAndRestPointCount + pointCount
  end
end

function UIAircraftRoomBase:GetAvailableAreaAndPoints()
  local areaList = {}
  local pointList = {}
  for i = 1, #self._interactiveAreaList do
    local area = self._interactiveAreaList[i]
    if not area:IsFull() then
      areaList[#areaList + 1] = area
    end
  end
  for i = 1, #self._restPointList do
    local point = self._restPointList[i]
    if not self._restPointOccupiedDic[i] then
      pointList[#pointList + 1] = point
    end
  end
  return areaList, pointList
end

function UIAircraftRoomBase:OccupyRestPoint(pointIndex)
  self._restPointOccupiedDic[pointIndex] = true
end

function UIAircraftRoomBase:ReleaseRestPoint(pointIndex)
  self._restPointOccupiedDic[pointIndex] = false
end

function UIAircraftRoomBase:GetAreaAndRestPointCount()
  return self._areaAndRestPointCount
end

function UIAircraftRoomBase:GetAreaIndex(area)
  return table.ikey(self._interactiveAreaList, area)
end

function UIAircraftRoomBase:RefreshPets()
  local petData = self._roomLogicData:GetPets()
  local addList = {}
  for i = 1, #petData do
    local id = petData[i]:GetTemplateID()
    if self._petList[id] == nil then
      addList[id] = petData[i]
    end
  end
  local removeList = {}
  for id, pet in pairs(self._petList) do
    local contain = false
    for i = 1, #petData do
      if id == petData[i]:GetTemplateID() then
        contain = true
        break
      end
    end
    if not contain then
      table.insert(removeList, id)
    end
  end
  for id, data in pairs(addList) do
    local _pet = self:CreatePet(data)
    self._petList[id] = _pet
    if self._visible then
      _pet:StartNavi()
      _pet:ForceInitAnimator()
    end
  end
  for i = 1, #removeList do
    local key = removeList[i]
    self._petList[key]:Dispose()
    self._petList[key] = nil
  end
end

function UIAircraftRoomBase:Dispose()
  for _, pet in pairs(self._petList) do
    pet:Dispose()
  end
  if self._awardTimer then
    GameGlobal.Timer():CancelEvent(self._awardTimer)
  end
end

function UIAircraftRoomBase:CreatePet(_data)
  local petPrefabResName = _data:GetPetPrefab(PetSkinEffectPath.MODEL_AIRCRAFT)
  local go, reqs = HelperProxy:GetInstance():LoadPet(petPrefabResName, false)
  go.transform:SetParent(self._groundTrans, false)
  go:SetActive(true)
  go.transform.localScale = Vector3(1, 1, 1) * self.petScale
  local root = go.transform:Find("Root")
  for i = 0, root.childCount - 1 do
    local child = root:GetChild(i)
    local contains = string.find(child.name, "weapon")
    if contains then
      child.gameObject:SetActive(false)
    end
  end
  return UIAircraft3DPet:New(reqs, go, _data, self)
end

function UIAircraftRoomBase:Update(deltaTimeMS)
  if not self._visible then
    return
  end
  for k, v in pairs(self._petList) do
    v:Update(deltaTimeMS)
  end
end

function UIAircraftRoomBase:GetGroundPos()
  return self._groundTrans.position
end

function UIAircraftRoomBase:CheckGround(trans)
  return self._groundTrans == trans
end

function UIAircraftRoomBase:GetFadeObjects()
  return self.fadeObjects
end

function UIAircraftRoomBase:GetRoomGameObject()
  return self._roomGO
end

function UIAircraftRoomBase:GetRoomLogicData()
  return self._roomLogicData
end

function UIAircraftRoomBase:LogicRoomType()
  return self._roomLogicData:GetRoomType()
end

function UIAircraftRoomBase:Status()
  return self._roomLogicData:Status()
end

function UIAircraftRoomBase:SpaceID()
  return self._roomLogicData:SpaceId()
end

function UIAircraftRoomBase:TryClickPet(_go)
  for k, v in pairs(self._petList) do
    if v:PetGameObject() == _go then
      v:OnClick()
      return true
    end
  end
  return false
end

function UIAircraftRoomBase:TryGetPet(_go)
  for k, v in pairs(self._petList) do
    if v:PetGameObject() == _go then
      return v
    end
  end
  return nil
end

function UIAircraftRoomBase:SetColliderEnable(enable)
  if self.collider then
    self.collider.enabled = enable
  end
end

function UIAircraftRoomBase:SetVisible(visible)
  self._visible = visible
end

function UIAircraftRoomBase:OnEnter()
  self._visible = true
  self:SetColliderEnable(false)
  if self.ceiling then
    self.ceiling.gameObject:SetActive(false)
  end
end

function UIAircraftRoomBase:OnFocus()
end

function UIAircraftRoomBase:OnExit()
  self:SetColliderEnable(true)
end

function UIAircraftRoomBase.CreateRoom(roomGameObject, roomLogicData, doorGO)
  return UIAircraftRoomBase:New(roomGameObject, roomLogicData, doorGO)
end
