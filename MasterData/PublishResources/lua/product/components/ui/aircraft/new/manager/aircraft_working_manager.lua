_class("AircraftWorkingManager", Object)
AircraftWorkingManager = AircraftWorkingManager

function AircraftWorkingManager:Constructor(aircraftMain)
  self._main = aircraftMain
  self._module = GameGlobal.GetModule(AircraftModule)
end

function AircraftWorkingManager:Init()
  local spaces = Cfg.cfg_aircraft_space({})
  for i = 1, #spaces do
    local roomData = self._module:GetRoom(i)
    if roomData then
      local pets = roomData:GetPets()
      if pets and 0 < #pets then
        for _, pet in ipairs(pets) do
          local tmpID = pet:GetTemplateID()
          if self._main:IsRandomStoryPet(tmpID) or self._main:IsGiftPet(tmpID) then
            local apet = self._main:GetPetByTmpID(tmpID)
            apet:SetAsWorkingPet()
            apet:SetSpace(i)
            AirLog("工作中星灵产生了剧情或送礼事件，不工作：", tmpID)
          else
            local apet, sp = self._main:AddPet(tmpID)
            if apet then
              apet:SetState(AirPetState.Working)
              apet:SetAsWorkingPet()
              apet:SetSpace(i)
              local room = self._main:GetRoomBySpaceID(i)
              local holder = room:GetPointHolder()
              local pos = self._main:GetInitPos(holder)
              apet:SetPosition(pos)
              apet:SetFloor(holder:Floor())
              local action = AirActionWandering:New(apet, holder, nil, "漫游-工作中", self._main)
              self._main:StartInitAction(apet, action, nil)
              AirLog("星灵开始工作：", tmpID)
            elseif sp then
              AirLog("已经有sp星灵存在，：", sp, ",tmpID:", tmpID)
            end
          end
        end
      end
    end
  end
  AirLog("AircraftWorkingManager Init Done")
end

function AircraftWorkingManager:StartWorking(pet)
  if not pet:IsWorkingPet() then
    Log.fatal("[AircraftWorking] 该星灵不是工作星灵：", pet:TemplateID())
    return
  end
  local spaceID = pet:GetSpace()
  local room = self._main:GetRoomBySpaceID(spaceID)
  local holder = room:GetPointHolder()
  local action = AirActionWandering:New(pet, holder, nil, "漫游-工作中", self._main)
  pet:SetState(AirPetState.Working)
  pet:StartMainAction(action)
end

function AircraftWorkingManager:PetEnterSpaceToWork(petID, spaceID)
  local pet = self._main:GetPetByTmpID(petID)
  local sp = false
  if pet == nil then
    pet, sp = self._main:AddPet(petID)
  end
  if not pet then
    if sp then
      Log.debug("###[AircraftWorkingManager] 已存在sp星灵，sp:", sp, ",petid:", petID)
    end
    return
  end
  pet:SetAsWorkingPet()
  pet:SetSpace(spaceID)
  if self._main:IsRandomStoryPet(petID) then
    return
  end
  pet:SetState(AirPetState.Working)
  local room = self._main:GetRoomBySpaceID(spaceID)
  local holder = room:GetPointHolder()
  local point = holder:PopPoint()
  local pos = point:Pos()
  holder:ReleasePoint(point)
  pet:SetFloor(holder:Floor())
  local action = AirActionWandering:New(pet, holder, nil, "漫游-工作中", self._main)
  pet:StartMainAction(action)
  pet:SetPosition(pos)
end

function AircraftWorkingManager:OnSpacePetChanged(spaceID)
  local pets = self._main:GetPets(function(p)
    local pet = p
    if pet:IsWorkingPet() and pet:GetSpace() == spaceID then
      return true
    end
    return false
  end)
  local roomData = self._module:GetRoom(spaceID)
  local roomPets
  if roomData then
    roomPets = roomData:GetPets()
  else
    AirLog("找不到房间，可能是房间被拆除了:", spaceID)
    roomPets = {}
  end
  local remove = {}
  local add = {}
  for _, roomPet in ipairs(roomPets) do
    local found = false
    for __, pet in ipairs(pets) do
      if pet:TemplateID() == roomPet:GetTemplateID() then
        found = true
        break
      end
    end
    if not found then
      local petID = roomPet:GetTemplateID()
      add[#add + 1] = petID
      local replacePetID = self:_CheckSpPet(roomPet)
      if replacePetID then
        local pModule = GameGlobal.GetModule(PetModule)
        local pet1Name = StringTable.Get(pModule:GetPetByTemplateId(petID):GetPetName())
        local pet2Name = StringTable.Get(pModule:GetPetByTemplateId(replacePetID):GetPetName())
        local tips = StringTable.Get("str_aircraft_sp_enter_tips", pet1Name, pet2Name)
        ToastManager.ShowToast(tips)
        remove[replacePetID] = true
      end
    end
  end
  for _, pet in ipairs(pets) do
    local found = false
    for __, roomPet in ipairs(roomPets) do
      if roomPet:GetTemplateID() == pet:TemplateID() then
        found = true
        break
      end
    end
    if not found then
      remove[pet:TemplateID()] = true
    end
  end
  for id, _ in pairs(remove) do
    self._main:PetStopWork(id)
  end
  for _, id in ipairs(add) do
    self._main:PetStartWork(id, spaceID)
  end
end

function AircraftWorkingManager:Update(deltaTimeMS)
end

function AircraftWorkingManager:Dispose()
end

function AircraftWorkingManager:_CheckSpPet(pet)
  local pModule = GameGlobal.GetModule(PetModule)
  local bindPet = pModule:GetBindPet(pet:GetTemplateID())
  if bindPet then
    local spID = bindPet:GetTemplateID()
    local spAirPet = self._main:GetPetByTmpID(spID)
    if spAirPet and (not (self._main:IsGiftPet(spID) or self._main:IsRandomStoryPet(spID)) and spAirPet:IsWorkingPet() or self._main:IsRestPet(spID)) then
      return spID
    end
  end
end
