_class("LLTCBase", Object)
LLTCBase = LLTCBase

function LLTCBase:Constructor(param)
  self._param = param
end

function LLTCBase:CalculateTarget(buffOwner)
  return {}
end

_class("LLTCNone", LLTCBase)
LLTCNone = LLTCNone

function LLTCNone:CalculateTarget(buffOwner)
  return {}
end

_class("LLTCSelf", LLTCBase)
LLTCSelf = LLTCSelf

function LLTCSelf:CalculateTarget(buffOwner)
  local es = {}
  es[#es + 1] = buffOwner
  return es
end

_class("LLTCTagPet", LLTCBase)
LLTCTagPet = LLTCTagPet

function LLTCTagPet:CalculateTarget(buffOwner)
  local es = {}
  local tagList = self._param.tagList
  local isAnd = false
  if self._param.isAnd then
    isAnd = self._param.isAnd == 1
  end
  local isContainSelf = true
  if self._param.containSelf then
    isContainSelf = self._param.containSelf == 1
  end
  local dis = self._param.dis
  local gameModule = buffOwner:GetLuckLandModule()
  local entityMng = gameModule:GetEntityMng()
  local pets = entityMng:GetFightPets()
  for _, pet in ipairs(pets) do
    if not pet:HasDeleteFlag() and (buffOwner:ID() ~= pet:ID() or isContainSelf) then
      local isMatch = entityMng:CheckPetTagMatch(pet, tagList, isAnd)
      if isMatch then
        if dis then
          if dis >= LuckLandTriggerTool.Distance(pet, buffOwner) then
            es[#es + 1] = pet
          end
        else
          es[#es + 1] = pet
        end
      end
    end
  end
  return es
end

_class("LLTCTIDPet", LLTCBase)
LLTCTIDPet = LLTCTIDPet

function LLTCTIDPet:CalculateTarget(buffOwner)
  local es = {}
  local dis = self._param.dis
  local tIDList = self._param.IDList
  local isContainSelf = true
  if self._param.containSelf then
    isContainSelf = self._param.containSelf == 1
  end
  local gameModule = buffOwner:GetLuckLandModule()
  local entityMng = gameModule:GetEntityMng()
  local pets = entityMng:GetFightPets()
  for _, pet in ipairs(pets) do
    if not pet:HasDeleteFlag() and (buffOwner:ID() ~= pet:ID() or isContainSelf) and table.icontains(tIDList, pet:GetTemplateID()) then
      if dis then
        if dis >= LuckLandTriggerTool.Distance(pet, buffOwner) then
          es[#es + 1] = pet
        end
      else
        es[#es + 1] = pet
      end
    end
  end
  return es
end

_class("LLTCRandomPet", LLTCBase)
LLTCRandomPet = LLTCRandomPet

function LLTCRandomPet:CalculateTarget(buffOwner)
  local es = {}
  local gameModule = buffOwner:GetLuckLandModule()
  local entityMng = gameModule:GetEntityMng()
  local pets = entityMng:GetFightPets()
  local petIDList = {}
  for _, pet in ipairs(pets) do
    table.insert(petIDList, pet:ID())
  end
  for i = 1, self._param.count do
    if 0 < #petIDList then
      local randVal = math.random(1, #petIDList)
      local randID = petIDList[randVal]
      local pet = entityMng:GetPetByID(randID)
      es[#es + 1] = pet
      table.removev(petIDList, randID)
    end
  end
  return es
end

_class("LLTCNearestTagPet", LLTCBase)
LLTCNearestTagPet = LLTCNearestTagPet

function LLTCNearestTagPet:CalculateTarget(buffOwner)
  return {}
end

_class("LLTCAllPet", LLTCBase)
LLTCAllPet = LLTCAllPet

function LLTCAllPet:CalculateTarget(buffOwner)
  local es = {}
  local gameModule = buffOwner:GetLuckLandModule()
  local entityMng = gameModule:GetEntityMng()
  local pets = entityMng:GetFightPets()
  local isContainSelf = true
  if self._param and self._param.containSelf then
    isContainSelf = self._param.containSelf == 1
  end
  for _, pet in ipairs(pets) do
    if not pet:HasDeleteFlag() and (buffOwner:ID() ~= pet:ID() or isContainSelf) then
      es[#es + 1] = pet
    end
  end
  return es
end

_class("LLTCAllMonster", LLTCBase)
LLTCAllMonster = LLTCAllMonster

function LLTCAllMonster:CalculateTarget(buffOwner)
  local es = {}
  local gameModule = buffOwner:GetLuckLandModule()
  local entityMng = gameModule:GetEntityMng()
  local monsters = entityMng:GetFightMonsters()
  local isContainSelf = true
  if self._param.containSelf then
    isContainSelf = self._param.containSelf == 1
  end
  for _, monster in ipairs(monsters) do
    if not monster:IsDead() and (buffOwner:ID() ~= monster:ID() or isContainSelf) then
      es[#es + 1] = monster
    end
  end
  return es
end

_class("LLTCDistancePet", LLTCBase)
LLTCDistancePet = LLTCDistancePet

function LLTCDistancePet:CalculateTarget(buffOwner)
  local es = {}
  local dis = self._param.dis
  local isContainSelf = true
  if self._param.containSelf then
    isContainSelf = self._param.containSelf == 1
  end
  local gameModule = buffOwner:GetLuckLandModule()
  local entityMng = gameModule:GetEntityMng()
  local pets = entityMng:GetFightPets()
  for _, pet in ipairs(pets) do
    if not pet:HasDeleteFlag() and (buffOwner:ID() ~= pet:ID() or isContainSelf) and dis and dis >= LuckLandTriggerTool.Distance(pet, buffOwner) then
      es[#es + 1] = pet
    end
  end
  return es
end

_class("LLTCPosPets", LLTCBase)
LLTCPosPets = LLTCPosPets

function LLTCPosPets:CalculateTarget(buffOwner)
  local es = {}
  local posType = self._param.posType
  local isContainSelf = true
  if self._param.containSelf then
    isContainSelf = self._param.containSelf == 1
  end
  local gameModule = buffOwner:GetLuckLandModule()
  local entityMng = gameModule:GetEntityMng()
  local pets = entityMng:GetFightPets()
  for _, pet in ipairs(pets) do
    if not pet:HasDeleteFlag() and (buffOwner:ID() ~= pet:ID() or isContainSelf) and posType and LuckLandTriggerTool.CheckPetPos(posType, pet) then
      es[#es + 1] = pet
    end
  end
  return es
end
