_class("PetPstIDComponent", Object)
PetPstIDComponent = PetPstIDComponent

function PetPstIDComponent:Constructor()
  self._pstID = 0
  self._petTemplateID = 0
  self._petCampID = 0
  self._resID = 0
  self._isLegendPet = false
  self._isHelpPet = false
  self._teamOrderBeforeDead = 0
  self._roundNormalAttackDirTable = {}
  self._weikeChainSkillNotifyCountTable = {}
end

function PetPstIDComponent:GetPstID()
  return self._pstID
end

function PetPstIDComponent:GetTemplateID()
  return self._petTemplateID
end

function PetPstIDComponent:GetPetCampID()
  return self._petCampID
end

function PetPstIDComponent:GetRoundNormalAttackDirTable(round)
  return self._roundNormalAttackDirTable[round] or {}
end

function PetPstIDComponent:SetRoundNormalAttackDir(round, dir)
  if not self._roundNormalAttackDirTable[round] then
    self._roundNormalAttackDirTable[round] = {}
  end
  table.insert(self._roundNormalAttackDirTable[round], dir)
end

function PetPstIDComponent:ClearRoundNormalAttackDir(round)
  self._roundNormalAttackDirTable[round] = {}
end

function PetPstIDComponent:InitPstID(petPstID, petTemplateID, petCampID, isLegendPet)
  self._pstID = petPstID
  self._petTemplateID = petTemplateID
  self._petCampID = petCampID
  self._isLegendPet = isLegendPet
end

function PetPstIDComponent:SetResID(resID)
  self._resID = resID
end

function PetPstIDComponent:GetResID()
  return self._resID
end

function PetPstIDComponent:IsLegendPet()
  return self._isLegendPet
end

function PetPstIDComponent:SetHelpPet(val)
  self._isHelpPet = val
end

function PetPstIDComponent:IsHelpPet()
  return self._isHelpPet
end

function PetPstIDComponent:SetTeamOrderBeforeDead(val)
  self._teamOrderBeforeDead = val
end

function PetPstIDComponent:GetTeamOrderBeforeDead()
  return self._teamOrderBeforeDead
end

function PetPstIDComponent:TickWeikeChainSkillNotifyCount(notifyType)
  if not self._weikeChainSkillNotifyCountTable[notifyType] then
    self._weikeChainSkillNotifyCountTable[notifyType] = 0
  end
  self._weikeChainSkillNotifyCountTable[notifyType] = self._weikeChainSkillNotifyCountTable[notifyType] + 1
  return self._weikeChainSkillNotifyCountTable[notifyType]
end

function PetPstIDComponent:GetWeikeChainSkillNotifyCount(notifyType)
  return self._weikeChainSkillNotifyCountTable[notifyType] or 0
end

function Entity:PetPstID()
  return self:GetComponent(self.WEComponentsEnum.PetPstID)
end

function Entity:HasPetPstID()
  return self:HasComponent(self.WEComponentsEnum.PetPstID)
end

function Entity:AddPetPstID()
  local index = self.WEComponentsEnum.PetPstID
  local component = PetPstIDComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePetPstID(petPstID, petTemplateID, petCampID, IsLegendPet)
  local index = self.WEComponentsEnum.PetPstID
  local component = PetPstIDComponent:New()
  component:InitPstID(petPstID, petTemplateID, petCampID, IsLegendPet)
  self:ReplaceComponent(index, component)
end

function Entity:RemovePetPstID()
  if self:HasPetPstID() then
    self:RemoveComponent(self.WEComponentsEnum.PetPstID)
  end
end
