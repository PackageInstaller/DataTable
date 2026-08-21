_class("BattleWorldEnterDataComponent", Object)
BattleWorldEnterDataComponent = BattleWorldEnterDataComponent

function BattleWorldEnterDataComponent:Constructor(world)
  self._worldInfo = world.BW_WorldInfo
  self._world = world
  self.localMatchPets = {}
  self.localMatchPetDict = {}
  self.remoteTeamInfo = nil
  self.remotePlayerPos = Vector2(5, 5)
  self.remoteMatchPets = {}
  self.remoteMatchPetDict = {}
  self:Init()
  self:InitRemoterTeamInfo()
  self:InitializePetsData()
end

function BattleWorldEnterDataComponent:Init()
  self.bonusCondition = self._worldInfo.bonusCondition
  if #self.bonusCondition > 1 then
    self.hasBonusCondition = true
  end
end

function BattleWorldEnterDataComponent:IsHaveBonusCondition()
  return self.hasBonusCondition
end

function BattleWorldEnterDataComponent:GetClientCreateInfo()
  return self._worldInfo.clientCreateInfo
end

function BattleWorldEnterDataComponent:GetLocalPlayerInfo()
  return self._worldInfo.localPlayerInfo
end

function BattleWorldEnterDataComponent:GetMatchType(enterType)
  return self._world:MatchType(enterType)
end

function BattleWorldEnterDataComponent:InitRemoterTeamInfo()
  self.remoteTeamInfo = self._worldInfo.remoteTeamInfo
end

function BattleWorldEnterDataComponent:InitializePetsData()
  local petList = self:GetLocalPlayerInfo().pet_list
  for k, v in ipairs(petList) do
    local petData
    if self:GetMatchType() == MatchType.MT_PopStar then
      petData = PopStarMatchPet:New(v)
    else
      petData = MatchPet:New(v)
    end
    self.localMatchPets[#self.localMatchPets + 1] = petData
    self.localMatchPetDict[v.pet_pstid] = petData
  end
  if self.remoteTeamInfo then
    petList = self.remoteTeamInfo
    for k, v in ipairs(petList) do
      local petInfo = v
      petInfo.pet_pstid = k
      local petData = MatchPet:New(petInfo)
      self.remoteMatchPets[#self.remoteMatchPets + 1] = petData
      self.remoteMatchPetDict[petInfo.pet_pstid] = petData
    end
  end
  self.TeamLeaderPetPstID = -1
  return self.localMatchPetDict, self.remoteMatchPetDict
end

function BattleWorldEnterDataComponent:GetLocalMatchPets()
  return self.localMatchPetDict, self:GetLocalPlayerInfo().pet_list
end

function BattleWorldEnterDataComponent:GetRemoteTeamInfo()
  return self.remoteTeamInfo
end

function BattleWorldEnterDataComponent:GetRemoteMatchPets()
  return self.remoteMatchPetDict, self:GetRemoteTeamInfo()
end

function BattleWorldEnterDataComponent:GetBonusCondition()
  return self.bonusCondition
end

function BattleWorldEnterDataComponent:GetLocalMatchPetList()
  return self.localMatchPets
end

function BattleWorldEnterDataComponent:GetRemoteMatchPetList()
  return self.remoteMatchPets
end

function BattleWorldEnterDataComponent:GetRemotePlayerPosition()
  return self.remotePlayerPos
end

function BattleWorldEnterDataComponent:GetPetData(pstid)
  return self.localMatchPetDict[pstid] or self.remoteMatchPetDict[pstid]
end

function MainWorld:BattleWorldEnterData()
  return self:GetUniqueComponent(self.BW_UniqueComponentsEnum.BattleEnterData)
end

function MainWorld:AddBattleWorldEnterData()
  local index = self.BW_UniqueComponentsEnum.BattleEnterData
  local com = BattleWorldEnterDataComponent:New(self)
  self:SetUniqueComponent(index, com)
end

function MainWorld:HasBattleWorldEnterData(flag)
  local com = self:BattleWorldEnterData()
  if not com then
    return false
  end
  return com:HasFlag(flag)
end

function MainWorld:GetLocalMatchPetList()
  local com = self:BattleWorldEnterData()
  return com:GetLocalMatchPetList()
end

function MainWorld:GetLocalMatchPets()
  local com = self:BattleWorldEnterData()
  return com:GetLocalMatchPets()
end

function MainWorld:GetRemoteMatchPetList()
  local com = self:BattleWorldEnterData()
  return com:GetRemoteMatchPetList()
end

function MainWorld:GetRemotePlayerPosition()
  local com = self:BattleWorldEnterData()
  return com:GetRemotePlayerPosition()
end

function MainWorld:GetPetData(pstid)
  local com = self:BattleWorldEnterData()
  return com:GetPetData(pstid)
end
