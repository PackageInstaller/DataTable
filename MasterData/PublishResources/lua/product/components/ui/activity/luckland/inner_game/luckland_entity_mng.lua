_class("LLEntityMng", Object)
LLEntityMng = LLEntityMng

function LLEntityMng:Constructor()
  self._fightPetList = {}
  self._fightPetEnterList = {}
  self._fightMonsterList = {}
  self._buildingList = {}
  self._backpackPetList = {}
  self._monsterList = {}
  self._entityCreationIndex = 1
  self._entityCreationDic = {}
  self._entityCreationDic[LuckLandEntityType.Pet] = LLEntityPet
  self._entityCreationDic[LuckLandEntityType.Monster] = LLEntityMonster
  self._entityCreationDic[LuckLandEntityType.Building] = LLEntityBuilding
end

function LLEntityMng:Dispose()
  self._fightPetList = {}
  self._fightPetEnterList = {}
  self._fightMonsterList = {}
  self._buildingList = {}
  self._backpackPetList = {}
  self._monsterList = {}
  self._entityCreationIndex = 1
  self._entityCreationDic = {}
end

function LLEntityMng:Init(gameModule)
  self._gameModule = gameModule
  self._triggerMng = self._gameModule:GetTriggerMng()
  self:_InitBackpackPets()
  self:_InitBuildings()
  self:_InitMonsterPool()
  self._fightMonsterList = {
    self._monsterList[1]
  }
  table.remove(self._monsterList, 1)
  for _, monster in ipairs(self._fightMonsterList) do
    self._triggerMng:Notify(LLNTMonsterEnter:New(monster))
  end
end

function LLEntityMng:CreateEntity(entityType, templateID, roundCount)
  local classType = self._entityCreationDic[entityType]
  if classType == nil then
    Log.exception("[LuckLand] CreateEntity cant find entity type ", entityType)
  end
  local entity = classType:New(self._gameModule)
  local creationIndex = self._entityCreationIndex
  if roundCount then
    entity:SetEntryRound(roundCount)
  end
  entity:Initialize(creationIndex, templateID)
  self._entityCreationIndex = creationIndex + 1
  return entity
end

function LLEntityMng:_InitBackpackPets()
  local cfgMng = self._gameModule:GetConfigMng()
  local levelCfgData = cfgMng:GetLevelConfigData()
  local backpackPets = levelCfgData:GetBackpackPetList()
  for _, petTmpID in ipairs(backpackPets) do
    local entity = self:CreateEntity(LuckLandEntityType.Pet, petTmpID)
    self._backpackPetList[#self._backpackPetList + 1] = entity
  end
end

function LLEntityMng:_InitBuildings()
  local cfgMng = self._gameModule:GetConfigMng()
  local levelCfgData = cfgMng:GetLevelConfigData()
  local buildings = levelCfgData:GetBuildingList()
  for _, tmpID in ipairs(buildings) do
    local entity = self:CreateEntity(LuckLandEntityType.Building, tmpID)
    self._buildingList[#self._buildingList + 1] = entity
  end
end

function LLEntityMng:_InitMonsterPool()
  self._monsterList = {}
  local cfgMng = self._gameModule:GetConfigMng()
  local levelCfgData = cfgMng:GetLevelConfigData()
  local monsterDataList = levelCfgData:GetMonsterList()
  for _, monsterData in ipairs(monsterDataList) do
    local entity = self:CreateEntity(LuckLandEntityType.Monster, monsterData.id)
    entity:SetDemandRound(monsterData.round)
    entity:SetDemandMoney(monsterData.money)
    self._monsterList[#self._monsterList + 1] = entity
  end
end

function LLEntityMng:GetFightPetData()
end

function LLEntityMng:GetBackpackPets()
  return self._backpackPetList
end

function LLEntityMng:GetPetByID(ID)
  for _, pet in ipairs(self._backpackPetList) do
    if ID == pet:ID() then
      return pet
    end
  end
end

function LLEntityMng:GetPetsByTemplateID(templateID)
  local result
  for _, pet in ipairs(self._backpackPetList) do
    if templateID == pet:GetTemplateID() then
      result = result or {}
      table.insert(result, pet)
    end
  end
  return result
end

function LLEntityMng:GetFightPetsByTemplateID(templateID)
  local result
  if self._fightPetList then
    for _, pet in ipairs(self._fightPetList) do
      if templateID == pet:GetTemplateID() then
        result = result or {}
        table.insert(result, pet)
      end
    end
  end
  return result
end

function LLEntityMng:GetPetsByElement(elementType)
  local result
  for _, pet in ipairs(self._backpackPetList) do
    if elementType == pet:Element() then
      result = result or {}
      table.insert(result, pet)
    end
  end
  return result
end

function LLEntityMng:GetFightPetsByElement(elementType)
  local result
  if self._fightPetList then
    for _, pet in ipairs(self._fightPetList) do
      if elementType == pet:Element() then
        result = result or {}
        table.insert(result, pet)
      end
    end
  end
  return result
end

function LLEntityMng:GetFightPetsByCamp(campType)
  local result
  if self._fightPetList then
    for _, pet in ipairs(self._fightPetList) do
      if campType == pet:Camp() then
        result = result or {}
        table.insert(result, pet)
      end
    end
  end
  return result
end

function LLEntityMng:GetFightPetsByLevel(level)
  local result
  if self._fightPetList then
    for _, pet in ipairs(self._fightPetList) do
      if level == pet:Level() then
        result = result or {}
        table.insert(result, pet)
      end
    end
  end
  return result
end

function LLEntityMng:GetFightPetsByResType(resType)
  local result
  if self._fightPetList then
    for _, pet in ipairs(self._fightPetList) do
      if resType == pet:ResType() then
        result = result or {}
        table.insert(result, pet)
      end
    end
  end
  return result
end

function LLEntityMng:AddFightPet(fightPet)
  self._fightPetList[#self._fightPetList + 1] = fightPet
  self._fightPetEnterList[#self._fightPetEnterList + 1] = fightPet
  fightPet:SetFightState(true)
end

function LLEntityMng:GetFightPets()
  return self._fightPetList
end

function LLEntityMng:GetFightPetEnterList()
  return self._fightPetEnterList
end

function LLEntityMng:GetFightPetPos(pet)
  for index, value in ipairs(self._fightPetList) do
    if pet == value then
      return index
    end
  end
end

function LLEntityMng:ClearFightPets()
  self._fightPetList = {}
  self._fightPetEnterList = {}
  for _, pet in ipairs(self._backpackPetList) do
    pet:SetFightState(false)
  end
end

function LLEntityMng:MovePetToFirst(pet)
  local pos = table.ikey(self._fightPetList, pet)
  if pos then
    table.removev(self._fightPetList, pet)
    table.insert(self._fightPetList, 1, pet)
    pet:SetTempMove(LuckLandConst.BVK_MoveToFirst)
    return pos - 1
  else
    Log.error("[LuckLand] LLEntityMng MovePetToFirst pet not exist,", pet:GetTemplateID())
  end
end

function LLEntityMng:MovePetToLast(pet)
  local pos = table.ikey(self._fightPetList, pet)
  if pos then
    table.removev(self._fightPetList, pet)
    self._fightPetList[#self._fightPetList + 1] = pet
    pet:SetTempMove(LuckLandConst.BVK_MoveToLast)
    return #self._fightPetList - pos
  else
    Log.error("[LuckLand] LLEntityMng MovePetToLast pet not exist,", pet:GetTemplateID())
  end
end

function LLEntityMng:CheckPetTagMatch(pet, tagList, isAnd)
  local isMatch = false
  for _, tag in pairs(tagList) do
    local tagType = tag.type
    local tagParam = tag.param
    local tmpParam = pet:GetParamByTag(tagType)
    if tagParam == tmpParam then
      isMatch = true
      if not isAnd then
        return true
      end
    else
      isMatch = false
      if isAnd then
        return false
      end
    end
  end
  return isMatch
end

function LLEntityMng:SelectCard(petTemplateID, pos)
  local entity = self:CreateEntity(LuckLandEntityType.Pet, petTemplateID)
  self._triggerMng:Notify(LLNTSelectPet:New(entity))
  self:PetEnterBackpack(entity, pos)
end

function LLEntityMng:PetEnterBackpack(entity, pos)
  if pos then
    table.insert(self._backpackPetList, pos, entity)
  else
    self._backpackPetList[#self._backpackPetList + 1] = entity
  end
  self._triggerMng:Notify(LLNTGetPet:New(entity))
end

function LLEntityMng:DeleteCard(petID, sourceEntity)
  local entity = self:GetPetByID(petID)
  if sourceEntity then
    for _, pet in ipairs(self._fightPetList) do
      self._triggerMng:Notify(LLNTDeletePet:New(pet, entity, sourceEntity))
    end
  end
  table.removev(self._backpackPetList, entity)
end

function LLEntityMng:GetFightMonsters()
  return self._fightMonsterList
end

function LLEntityMng:SetFightMonsters(monsters, roundCount)
  self._fightMonsterList = monsters
  if #self._fightMonsterList > LuckLandConst.MaxMonsterCount then
    local pos = #self._fightMonsterList - LuckLandConst.MaxMonsterCount + 1
    table.sub(self._fightMonsterList, pos, #self._fightMonsterList)
  end
  if roundCount then
    table.remove(self._monsterList, 1)
  end
end

function LLEntityMng:IsFightMonstersFull()
  return #self._fightMonsterList >= LuckLandConst.MaxMonsterCount
end

function LLEntityMng:AppendMonster(monster)
  Log.exception("不支持buff增加怪物")
end

function LLEntityMng:GetNextMonsters()
  return self._monsterList[1]
end

function LLEntityMng:GetLeftMonstersCount()
  return #self._monsterList
end

function LLEntityMng:MoveMonsterToFirst(monster)
  local pos = table.ikey(self._fightMonsterList, monster)
  if pos then
    table.removev(self._fightMonsterList, monster)
    table.insert(self._fightMonsterList, 1, monster)
    return pos - 1
  else
    Log.error("[LuckLand] LLEntityMng MovePetToFirst monster not exist,", monster:GetTemplateID())
  end
end

function LLEntityMng:MoveMonsterToLast(monster)
  local pos = table.ikey(self._fightMonsterList, monster)
  if pos then
    table.removev(self._fightMonsterList, monster)
    self._fightMonsterList[#self._fightMonsterList + 1] = monster
    return #self._fightMonsterList - pos
  else
    Log.error("[LuckLand] LLEntityMng MovePetToLast monster not exist,", monster:GetTemplateID())
  end
end

function LLEntityMng:GetBuildings()
  return self._buildingList
end

function LLEntityMng:GetBuildingMaxHPIncrease()
  local maxHPIncr = 0
  for _, building in ipairs(self._buildingList) do
    local tmpInc = building:GetMaxHPIncreaseParam()
    if tmpInc then
      maxHPIncr = maxHPIncr + tmpInc
    end
  end
  return maxHPIncr
end

function LLEntityMng:GetPosCount()
  local posCount = 0
  for _, building in ipairs(self._buildingList) do
    local tmp = building:GetPosCount()
    if tmp then
      posCount = posCount + tmp
    end
  end
  return posCount
end

function LLEntityMng:GetPosList()
  local posList = {}
  for _, building in ipairs(self._buildingList) do
    if building:GetBuildingType() == LuckLandBuildingType.CampFire then
      return building:GetPosList()
    end
  end
  return posList
end

function LLEntityMng:GetCardPool()
  for _, building in ipairs(self._buildingList) do
    if building:GetBuildingType() == LuckLandBuildingType.Main then
      return building:GetCardPool()
    end
  end
end

function LLEntityMng:GetBuildingByID(buildingID)
  for _, building in ipairs(self._buildingList) do
    if buildingID == building:ID() then
      return building
    end
  end
end

function LLEntityMng:GetBuildingByTemplateID(templateID)
  for _, building in ipairs(self._buildingList) do
    if templateID == building:GetTemplateID() then
      return building
    end
  end
end

function LLEntityMng:BuildingUpgrade(building)
  building:Upgrade()
end

function LLEntityMng:DestroyEntity()
  local deleteEntityList = {}
  for _, pet in ipairs(self._backpackPetList) do
    if pet:HasDeleteFlag() then
      deleteEntityList[#deleteEntityList + 1] = pet
    end
  end
  for _, delPet in ipairs(deleteEntityList) do
    table.removev(self._backpackPetList, delPet)
  end
  deleteEntityList = {}
  for _, monster in ipairs(self._fightMonsterList) do
    if monster:IsDead() then
      deleteEntityList[#deleteEntityList + 1] = monster
    end
  end
  for _, delMonster in ipairs(deleteEntityList) do
    table.removev(self._fightMonsterList, delMonster)
  end
end

function LLEntityMng:ClearEntityTmpData()
  local entityList = {}
  table.appendArray(entityList, self._backpackPetList)
  table.appendArray(entityList, self._fightMonsterList)
  table.appendArray(entityList, self._buildingList)
  for _, pet in ipairs(entityList) do
    pet:ResetTempParam()
  end
end
