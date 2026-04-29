_class("AircraftPetManager", Object)
AircraftPetManager = AircraftPetManager

function AircraftPetManager:Constructor(main)
  self._main = main
  self._pets = {}
  self._petCount = 0
  self._visitPets = {}
  self.petScale = Cfg.cfg_aircraft_camera.petScale.Value
  self._petModule = GameGlobal.GetModule(PetModule)
  self._petLoader = AircraftPetLoader:New()
  local lodlevel = LODManager.Instance:GetLODLevel()
  if lodlevel == 0 then
    self._petCeiling = Cfg.cfg_aircraft_const.aircraft_pet_ceiling_0.IntValue
  elseif lodlevel == 1 then
    self._petCeiling = Cfg.cfg_aircraft_const.aircraft_pet_ceiling_1.IntValue
  else
    self._petCeiling = Cfg.cfg_aircraft_const.aircraft_pet_ceiling_2.IntValue
  end
  self._shownPets = {}
  self._shownPetCount = 0
  self._cacheArray = SortedArray:New(Algorithm.COMPARE_CUSTOM, function(p1, p2)
    local pet1 = p1
    local pet2 = p2
    local pos1 = pet1:WorldPosition():Clone()
    local pos2 = pet2:WorldPosition():Clone()
    pos1.z = 0
    pos2.z = 0
    local target = self._main:CameraFocusPoint()
    local d1 = (pos1 - target):SqrMagnitude()
    local d2 = (pos2 - target):SqrMagnitude()
    if d1 < d2 then
      return 1
    elseif d1 > d2 then
      return -1
    else
      return 0
    end
  end)
  self._cacheArray:AllowDuplicate()
  if false then
    self._testReq = ResourceManager:GetInstance():SyncLoadAsset("AircraftTestPanel.prefab", LoadType.GameObject)
    local view = self._testReq.Obj:GetComponent(typeof(UIView))
    self._totalT = view:GetUIComponent("UILocalizationText", "value1")
    self._ceilingT = view:GetUIComponent("UILocalizationText", "value2")
    self._ceilingT:SetText(self._petCeiling)
    self._shownT = view:GetUIComponent("UILocalizationText", "value3")
    self._loadingT = view:GetUIComponent("UILocalizationText", "value4")
    self._testReq.Obj:SetActive(true)
    self._test = true
  end
  self._timer = 1000
  self._showPetDistance = Cfg.cfg_aircraft_const.aircraft_show_pet_distance.FloatValue
end

function AircraftPetManager:forceShow(pet)
  return pet:GetState() == AirPetState.RandomEvent or pet:GetState() == AirPetState.RandomEventWith or pet:IsVisitPet() or pet:IsGiftPet()
end

function AircraftPetManager:Init()
  self.camera = self._main:GetMainCamera()
  self._cameraT = self.camera.transform
  self._petLoader:Init(function(count)
    self:onLoadingCountChanged(count)
  end)
end

function AircraftPetManager:ForceShowPetAfterInit()
  for id, pet in pairs(self._pets) do
    if self:forceShow(pet) then
      self._petLoader:SyncLoadePet(pet)
      self._shownPets[pet:PstID()] = pet
      self._shownPetCount = self._shownPetCount + 1
    end
  end
  for id, pet in pairs(self._visitPets) do
    if self:forceShow(pet) then
      self._petLoader:SyncLoadePet(pet)
      self._shownPets[pet:PstID()] = pet
      self._shownPetCount = self._shownPetCount + 1
    end
  end
end

function AircraftPetManager:Update(deltaTimeMS)
  for id, pet in pairs(self._pets) do
    pet:Update(deltaTimeMS)
    if pet:IsAlive() and pet:IsMainActionOver() then
      self._main:RandomActionForPet(pet)
    end
  end
  for id, pet in pairs(self._visitPets) do
    pet:Update(deltaTimeMS)
    if pet:IsMainActionOver() then
      self._main:RandomActionForPet(pet)
    end
  end
  self._petLoader:Update()
  self._timer = self._timer - deltaTimeMS
  if self._timer < 0 then
    self:CalShowPet()
    self._timer = 1000
  end
end

function AircraftPetManager:AddPet(tmpID)
  if self._pets[tmpID] then
    Log.fatal("[AircraftPet] 星灵已经出现在风船中，ID：", tmpID)
    return
  end
  if table.count(self._pets) > 0 then
    local pets = {}
    for key, value in pairs(self._pets) do
      table.insert(pets, key)
    end
    local inner, sp = HelperProxy:GetInstance():CheckBinderID(pets, tmpID)
    if inner then
      return nil, sp
    end
  end
  local data = self._petModule:GetPetByTemplateId(tmpID)
  if data == nil then
    Log.exception("[AircraftPet] 严重错误，星灵不在背包中，不能进入娱乐区：", tmpID)
  end
  local pstID = data:GetPstID()
  local level = data:GetPetLevel()
  local awake = data:GetPetGrade()
  local skinId = data:GetSkinId()
  local pdata = AircraftPetData:New(tmpID, pstID, level, awake, nil, skinId)
  local pet = self:_createPet(pdata)
  if pet == nil then
    return
  end
  self._pets[tmpID] = pet
  self._petCount = self._petCount + 1
  self:onPetCountChanged()
  return pet
end

function AircraftPetManager:RemovePet(tmpID)
  local pet = self._pets[tmpID]
  if not pet then
    Log.fatal("[AircraftPet] 星灵不在风船内，ID：", tmpID)
    return false
  end
  local pstID = pet:PstID()
  if self._shownPets[pstID] then
    self._shownPetCount = self._shownPetCount - 1
    self:onShownPetCountChanged()
    self._shownPets[pstID] = nil
  end
  pet:Dispose()
  self._pets[tmpID] = nil
  Log.fatal("[AircraftPet] 星灵销毁：", tmpID)
  self._petCount = self._petCount - 1
  self:onPetCountChanged()
  return true
end

function AircraftPetManager:CalShowPet()
  if self._petCount <= self._shownPetCount then
    return
  end
  local pets = self:getShowPets()
  self._cacheArray:Clear()
  self._shownPetCount = 0
  for _, pet in pairs(self._shownPets) do
    local id = pet:PstID()
    if pets[id] then
      self._shownPetCount = self._shownPetCount + 1
      pets[id] = nil
    else
      pet:Hide()
      self._petLoader:TryDelPet(pet)
      self._shownPets[id] = nil
    end
  end
  for _, pet in pairs(pets) do
    self._petLoader:AsyncLoadPet(pet)
    self._shownPets[pet:PstID()] = pet
    self._shownPetCount = self._shownPetCount + 1
  end
end

function AircraftPetManager:getShowPets()
  local pets = {}
  local count = 0
  for _, pet in pairs(self._pets) do
    if self:forceShow(pet) then
      pets[pet:PstID()] = pet
      count = count + 1
      if count >= self._petCeiling then
        return pets
      end
    end
  end
  for _, pet in pairs(self._visitPets) do
    pets[pet:PstID()] = pet
    count = count + 1
    if count >= self._petCeiling then
      return pets
    end
  end
  if self._cameraT.position.z > self._showPetDistance then
    self._cacheArray:Clear()
    for _, pet in pairs(self._pets) do
      self._cacheArray:Insert(pet)
    end
    for _, pet in pairs(self._visitPets) do
      self._cacheArray:Insert(pet)
    end
    for i = 1, self._cacheArray:Size() do
      local pet = self._cacheArray:GetAt(i)
      if pets[pet:PstID()] == nil then
        pets[pet:PstID()] = pet
        count = count + 1
        if count >= self._petCeiling then
          return pets
        end
      end
    end
    return pets
  else
    local workingPets = {}
    local restPets = {}
    local workingPetCount = 0
    local restPetCount = 0
    for _, pet in pairs(self._pets) do
      if pet:IsWorkingPet() then
        if pets[pet:PstID()] == nil then
          local spaceID = pet:GetSpace()
          if workingPets[spaceID] == nil then
            workingPets[spaceID] = {}
          end
          table.insert(workingPets[spaceID], pet)
          workingPetCount = workingPetCount + 1
        end
      elseif pets[pet:PstID()] == nil then
        table.insert(restPets, pet)
        restPetCount = restPetCount + 1
      end
    end
    if workingPetCount + restPetCount == 0 then
      return pets
    end
    local needCount = self._petCeiling - count
    local total = restPetCount + workingPetCount
    if needCount > total then
      total = needCount
    end
    local restCount = math.ceil(needCount * restPetCount / total)
    local workCount = needCount - restCount
    for i = 1, restCount do
      local pet = restPets[i]
      pets[pet:PstID()] = pet
      count = count + 1
    end
    while 0 < workingPetCount do
      for space, workingPets in pairs(workingPets) do
        if 0 < #workingPets then
          local pet = workingPets[1]
          table.remove(workingPets, 1)
          workingPetCount = workingPetCount - 1
          pets[pet:PstID()] = pet
          count = count + 1
          if count >= self._petCeiling then
            return pets
          elseif workingPetCount <= 0 then
            break
          end
        end
      end
    end
    return pets
  end
end

function AircraftPetManager:GetPetByCollider(collider)
  for key, pet in pairs(self._pets) do
    if pet:CheckCollider(collider) then
      return pet
    end
  end
  for key, pet in pairs(self._visitPets) do
    if pet:CheckCollider(collider) then
      return pet
    end
  end
  return nil
end

function AircraftPetManager:Dispose()
  for id, pet in pairs(self._pets) do
    pet:Dispose()
  end
  self._pets = {}
  for id, pet in pairs(self._visitPets) do
    pet:Dispose()
  end
  self._visitPets = {}
  self._petCount = 0
  self._petLoader:Dispose()
  if self._testReq then
    self._testReq:Dispose()
  end
end

function AircraftPetManager:GetPet(tmpID)
  return self._pets[tmpID]
end

function AircraftPetManager:HasPet(id)
  return self._pets[id] ~= nil
end

function AircraftPetManager:GetPets(filter, includeVisitPet)
  if filter == nil then
    Log.fatal("[AircraftPet] filter is nil")
    return nil
  end
  local pets = {}
  for _, pet in pairs(self._pets) do
    if filter(pet) then
      pets[#pets + 1] = pet
    end
  end
  if includeVisitPet then
    for _, pet in pairs(self._visitPets) do
      if filter(pet) then
        pets[#pets + 1] = pet
      end
    end
  end
  return pets
end

function AircraftPetManager:GetVisitPet(tmpID)
  return self._visitPets[tmpID]
end

function AircraftPetManager:_createPet(_data)
  local pet = AircraftPet:New(_data, self._main)
  return pet
end

function AircraftPetManager:AddVisitPet(pet)
  local tmpid = pet.pet_info.pet_template_id
  if self._visitPets[tmpid] then
    Log.exception("[AircraftPet] 拜访星灵已经出现在风船中:", tmpid)
    return
  end
  local pstid = pet.pet_info.pet_pst_id
  local level = pet.pet_info.level
  local awake = pet.pet_info.grade
  local skin = pet.pet_info.skin_id
  local data = AircraftPetData:New(tmpid, pstid, level, awake, nil, skin)
  local airPet = self:_createPet(data)
  if airPet == nil then
    return
  end
  self._visitPets[tmpid] = airPet
  airPet:SetAsVisitPet()
  self._petCount = self._petCount + 1
  self:onPetCountChanged()
  return airPet
end

function AircraftPetManager:RemoveVisitPet(tmpID)
  local pet = self._visitPets[tmpID]
  if not pet then
    Log.fatal("[AircraftPet] 拜访星灵不在风船内，ID：", tmpID)
    return false
  end
  local pstID = pet:PstID()
  if self._shownPets[pstID] then
    self._shownPetCount = self._shownPetCount - 1
    self:onShownPetCountChanged()
    self._shownPets[pstID] = nil
  end
  pet:Dispose()
  self._visitPets[tmpID] = nil
  AirLog("拜访星灵销毁：", tmpID)
  self._petCount = self._petCount - 1
  self:onPetCountChanged()
  return true
end

function AircraftPetManager:onPetCountChanged()
  if self._test then
    self._totalT:SetText(self._petCount)
  end
end

function AircraftPetManager:onLoadingCountChanged(count)
  if self._test then
    self._loadingT:SetText(count)
    self._shownT:SetText(self._shownPetCount - count)
  end
end

function AircraftPetManager:onShownPetCountChanged()
  self:onLoadingCountChanged(self._petLoader:LoadingCount())
end

function AircraftPetManager:IsVisitPet()
end

_class("AircraftPetData", Object)
AircraftPetData = AircraftPetData

function AircraftPetData:Constructor(tmpID, pstID, level, awake, breakL, skin)
  self._tmpID = tmpID
  self._pstID = pstID
  self._awake = awake
  self._level = level
  self._break = breakL
  self._skin = skin
  self._prefab = HelperProxy:GetInstance():GetPetPrefab(tmpID, awake, skin, PetSkinEffectPath.MODEL_AIRCRAFT)
end

function AircraftPetData:TmpID()
  return self._tmpID
end

function AircraftPetData:PstID()
  return self._pstID
end

function AircraftPetData:Awake()
  return self._awake
end

function AircraftPetData:SkinID()
  return self._skin
end

function AircraftPetData:Prefab()
  return self._prefab
end
