_class("PreviewChainSelectPetComponent", Object)

function PreviewChainSelectPetComponent:Constructor()
  self._petList = {}
  self._petScopeResultDic = {}
  self._petSkillDic = {}
end

function PreviewChainSelectPetComponent:AddPreviewChainSelectPet(petEntityID)
  if not table.icontains(self._petList, petEntityID) then
    self._petList[#self._petList + 1] = petEntityID
  end
end

function PreviewChainSelectPetComponent:AddPreviewChainSelectPetScopeResult(petEntityID, scopeResult)
  self._petScopeResultDic[petEntityID] = scopeResult
end

function PreviewChainSelectPetComponent:AddPreviewChainSelectPetSkillID(petEntityID, skillID)
  self._petSkillDic[petEntityID] = skillID
end

function PreviewChainSelectPetComponent:GetRenderPetList()
  return self._petList
end

function PreviewChainSelectPetComponent:GetPreviewChainSelectPetScopeResult(petEntityID)
  return self._petScopeResultDic[petEntityID]
end

function PreviewChainSelectPetComponent:GetPreviewChainSelectPetSkillID(petEntityID)
  return self._petSkillDic[petEntityID]
end

function PreviewChainSelectPetComponent:ClearPreviewChainSelectPet()
  self._petList = {}
  self._petScopeResultDic = {}
end

function PreviewChainSelectPetComponent:WEC_PostInitialize(owner)
end

function PreviewChainSelectPetComponent:WEC_PostRemoved()
end

function Entity:PreviewChainSelectPet()
  return self:GetComponent(self.WEComponentsEnum.PreviewChainSelectPet)
end

function Entity:HasPreviewChainSelectPet()
  return self:HasComponent(self.WEComponentsEnum.PreviewChainSelectPet)
end

function Entity:AddPreviewChainSelectPet()
  local index = self.WEComponentsEnum.PreviewChainSelectPet
  local component = PreviewChainSelectPetComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewChainSelectPet()
  local index = self.WEComponentsEnum.PreviewChainSelectPet
  local component = PreviewChainSelectPetComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemovePreviewChainSelectPet()
  if self:HasPreviewChainSelectPet() then
    self:RemoveComponent(self.WEComponentsEnum.PreviewChainSelectPet)
  end
end
