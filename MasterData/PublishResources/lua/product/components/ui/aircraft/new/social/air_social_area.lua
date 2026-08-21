_class("AirSocialArea", Object)
AirSocialArea = AirSocialArea
local SOCIAL_TIME = 300000
local GATHER_ROUND = 20
local WALKTALK_ROUND = 20
local PER_TIME = 5000

function AirSocialArea:Constructor(aircraftMain)
  self.m_AirMain = aircraftMain
  self.m_Pets = {}
  self.m_LibTypes = {}
  self.m_LibMaker = nil
  self.m_Furniture = nil
  self.m_SocialRound = 0
  self.m_RemainTime = 0
  self.log = ""
end

function AirSocialArea:Dispose(needRandom, isLeave)
  self:RandomAllPet(needRandom)
  self.m_LibTypes = {}
  if self.m_LibMaker then
    self.m_LibMaker:Dispose()
  end
  self.m_LibMaker = nil
  if not isLeave then
    for key, pet in pairs(self.m_Pets) do
      pet:ResetSocialParam()
    end
  end
  table.clear(self.m_Pets)
end

function AirSocialArea:RandomAllPet(needRandom)
  if self.m_Pets then
    for key, _pet in pairs(self.m_Pets) do
      local pet = _pet
      if needRandom and pet:IsAlive() then
        self.m_AirMain:RandomActionForPet(pet)
      else
      end
    end
  end
end

function AirSocialArea:StartAllPetAction()
  if self.m_Pets then
    for key, _pet in pairs(self.m_Pets) do
      local pet = _pet
      pet:StartIdleAction()
    end
  end
end

function AirSocialArea:SetAllPetSocialState()
  if self.m_Pets then
    for key, _pet in pairs(self.m_Pets) do
      local pet = _pet
      AirLog("星灵开始社交:", pet:TemplateID())
      pet:SetState(AirPetState.Social)
    end
  end
end

function AirSocialArea:GetAreaType()
end

function AirSocialArea:GetPets()
  return self.m_Pets
end

function AirSocialArea:AddPet(petId, pet)
  self.m_Pets[petId] = pet
end

function AirSocialArea:RemovePet(petId)
  self.m_Pets[petId] = nil
end

function AirSocialArea:AddLib(libType)
  self.m_LibTypes[libType] = true
end

function AirSocialArea:GetLibs()
  return self.m_LibTypes
end

function AirSocialArea:RemoveLib(libType)
  self.m_LibTypes[libType] = nil
end

function AirSocialArea:GetRoom()
  Log.error("AirSocialArea:GetRoom() need override")
  return nil
end

function AirSocialArea:SetFurniture(f, pets)
  self.m_Furniture = f
  if not pets then
  else
    table.clear(self.m_Pets)
    self.m_Pets = {}
    local allCount = self.m_Furniture:AvailableCount()
    local index = 0
    for _, pet in pairs(pets) do
      index = index + 1
      if allCount >= index then
        self:AddPet(pet:TemplateID(), pet)
      end
    end
    for key, pet in pairs(self.m_Pets) do
      pet:SetSocialFurnitureKey(self.m_Furniture:GetPstKey())
    end
  end
end

function AirSocialArea:GetFurniture()
  return self.m_Furniture
end

function AirSocialArea:IsFurnitureInteract()
  return self.m_Furniture ~= nil
end

function AirSocialArea:GetMainLibType()
  if not self.m_FinalLibType then
    self.m_FinalLibType = table.keys(self.m_LibTypes)[1]
  end
  return self.m_FinalLibType
end

function AirSocialArea:InitLibMaker(isSerialize)
  if isSerialize then
    local curCount = table.count(self.m_Pets)
    local expectCount = self.m_SocialPetCount
    if expectCount ~= curCount then
      return true
    end
  end
  self.m_LibMaker = AirLibMaker:New(self, self.m_AirMain)
  self:CalRemainTimeByRound()
  for key, pet in pairs(self.m_Pets) do
    pet:SetSocialActionType(self:GetMainLibType())
  end
  self:SetSocialPetCount(table.count(self.m_Pets), true)
  self:InitMaxRound()
  local type = self:GetAreaType()
  if type == AirSocialAreaType.Happy then
    local type = self:GetRestAreaType()
    for key, pet in pairs(self.m_Pets) do
      pet:SetSocialAreaType(type)
    end
  end
  math.randomseed(os.clock() * 1000000)
  local teamId = math.random(1, 99999)
  for key, value in pairs(self.m_Pets) do
    value.a = self:GetMainLibType() .. "  " .. teamId
  end
end

function AirSocialArea:InitMaxRound()
  self.m_MaxRound = 0
  for key, pet in pairs(self.m_Pets) do
    local id = pet:TemplateID()
    local cfg = Cfg.cfg_aircraft_pet[id]
    if cfg and cfg.SocialTag then
      local tag = cfg.SocialTag
      local key
      if tag == AircraftSocialTag.Hot then
        key = "aircraft_social_reqing_time"
      elseif tag == AircraftSocialTag.Normal then
        key = "aircraft_social_zhengchang_time"
      elseif tag == AircraftSocialTag.Lone then
        key = "aircraft_social_lengmo_time"
      end
      local value = Cfg.cfg_aircraft_const[key].IntValue
      self.m_MaxRound = self.m_MaxRound + value
    end
  end
  if self.m_MaxRound == 0 then
    self.m_MaxRound = 20
  end
end

function AirSocialArea:GetLibMaker()
  return self.m_LibMaker
end

function AirSocialArea:GetStateTypes()
  local index = 1
  local mainType = self:GetMainLibType()
  if mainType == AirSocialActionType.Gather then
    if self.m_SocialRound > 0 then
      return {
        AirGroupActionStateType.Located,
        AirGroupActionStateType.LookAt,
        AirGroupActionStateType.Talk
      }
    else
      return {
        AirGroupActionStateType.Move,
        AirGroupActionStateType.LookAt,
        AirGroupActionStateType.Talk
      }
    end
  elseif mainType == AirSocialActionType.WalkTalk then
    if self.m_SocialRound > 0 then
      return {
        AirGroupActionStateType.Located,
        AirGroupActionStateType.MoveTalk
      }
    else
      return {
        AirGroupActionStateType.Move,
        AirGroupActionStateType.MoveTalk
      }
    end
  elseif mainType == AirSocialActionType.Furniture then
    if self.m_SocialRound > 0 then
      return {
        AirGroupActionStateType.Located,
        AirGroupActionStateType.FurnitureTalk
      }
    else
      return {
        AirGroupActionStateType.Move,
        AirGroupActionStateType.FurnitureTalk
      }
    end
  end
end

function AirSocialArea:SetSocialRound(round, syn)
  self.m_SocialRound = round
  if syn then
    for key, pet in pairs(self.m_Pets) do
      pet:SetSocialRound(self.m_SocialRound)
    end
    self:CalRemainTimeByRound()
  end
end

function AirSocialArea:GetSocialRound()
  return self.m_SocialRound
end

function AirSocialArea:_SetRemainTime(time)
  self.m_RemainTime = time
  for key, pet in pairs(self.m_Pets) do
    pet:SetSocialRemainTime(self.m_RemainTime)
  end
end

function AirSocialArea:GetMaxRound()
  local finalType = self:GetMainLibType()
  if finalType == AirSocialActionType.Gather then
    return self.m_MaxRound
  elseif finalType == AirSocialActionType.WalkTalk then
    return self.m_MaxRound
  end
  return 0
end

function AirSocialArea:CalRemainTimeByRound()
  local remainTime = 0
  local finalType = self:GetMainLibType()
  if finalType == AirSocialActionType.Gather then
    if 0 < self.m_SocialRound then
      remainTime = (GATHER_ROUND - self.m_SocialRound) * PER_TIME
    else
      remainTime = SOCIAL_TIME
    end
  elseif finalType == AirSocialActionType.WalkTalk then
    if 0 < self.m_SocialRound then
      remainTime = (WALKTALK_ROUND - self.m_SocialRound) * PER_TIME
    else
      remainTime = SOCIAL_TIME
    end
  elseif finalType == AirSocialActionType.Furniture then
    if AirHelper.IsActionSeqFurniture(self.m_Furniture) then
      remainTime = self.m_LibMaker:GetSeqMaker():GetRemainTime(self.m_SocialRound, 1)
    else
      remainTime = SOCIAL_TIME
    end
  end
  self:_SetRemainTime(remainTime)
end

function AirSocialArea:GetRemainTime()
  return self.m_RemainTime
end

function AirSocialArea:SetSocialPointHolderIndex(pointHolderIndex, syn)
  self.m_SocialPointHolderIndex = pointHolderIndex
  if syn then
    for key, pet in pairs(self.m_Pets) do
      pet:SetSocialPointHolderIndex(self.m_SocialPointHolderIndex)
    end
  end
end

function AirSocialArea:GetSocialPointHolderIndex()
  return self.m_SocialPointHolderIndex
end

function AirSocialArea:SetSocialPetCount(count, syn)
  self.m_SocialPetCount = count
  if syn then
    for key, pet in pairs(self.m_Pets) do
      pet:SetSocialPetCount(self.m_SocialPetCount)
    end
  end
end

function AirSocialArea:GetSocialPetCount()
  return self.m_SocialPetCount
end

_class("AirSocialWorkArea", AirSocialArea)
AirSocialWorkArea = AirSocialWorkArea

function AirSocialWorkArea:GetAreaType()
  return AirSocialAreaType.Work
end

function AirSocialWorkArea:SetSpaceId(spaceId)
  self.m_SpaceId = spaceId
end

function AirSocialWorkArea:GetSpaceId()
  return self.m_SpaceId
end

function AirSocialWorkArea:GetRoom()
  return self.m_AirMain:GetRoomBySpaceID(self.m_SpaceId)
end

_class("AirSocialHappyArea", AirSocialArea)
AirSocialHappyArea = AirSocialHappyArea

function AirSocialHappyArea:GetAreaType()
  return AirSocialAreaType.Happy
end

function AirSocialHappyArea:SetRestAreaType(type)
  self.m_RestAreaType = type
end

function AirSocialHappyArea:GetRestAreaType()
  return self.m_RestAreaType
end

function AirSocialHappyArea:GetRoom()
  return self.m_AirMain:GetRoomByArea(self.m_RestAreaType)
end
