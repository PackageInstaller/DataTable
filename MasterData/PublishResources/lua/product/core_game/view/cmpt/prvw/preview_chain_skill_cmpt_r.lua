_class("PreviewChainSkillComponent", Object)
PreviewChainSkillComponent = PreviewChainSkillComponent

function PreviewChainSkillComponent:Constructor(petIds, skillIds, posPickUpSafe, enablePickUp)
  self._petIds = petIds
  self._skillIds = skillIds
  self._posPickUpSafe = posPickUpSafe
  self._enablePickUp = enablePickUp
end

function PreviewChainSkillComponent:SetPickUpTargetEnalbe(enable)
  self._enablePickUp = enable
end

function PreviewChainSkillComponent:GetPickUpTargetEnalbe()
  return self._enablePickUp
end

function PreviewChainSkillComponent:GetPetIds()
  return self._petIds
end

function PreviewChainSkillComponent:GetSkillIds()
  return self._skillIds
end

function PreviewChainSkillComponent:GetPosPickUpSafe()
  return self._posPickUpSafe
end

function Entity:PreviewChainSkill()
  return self:GetComponent(self.WEComponentsEnum.PreviewChainSkill)
end

function Entity:HasPreviewChainSkill()
  return self:HasComponent(self.WEComponentsEnum.PreviewChainSkill)
end

function Entity:AddPreviewChainSkill(petIds, skillIds, posPickUpSafe)
  local index = self.WEComponentsEnum.PreviewChainSkill
  local component = PreviewChainSkillComponent:New(petIds, skillIds, posPickUpSafe)
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewChainSkill(petIds, skillIds, posPickUpSafe, enablePickUp)
  local index = self.WEComponentsEnum.PreviewChainSkill
  local component = PreviewChainSkillComponent:New(petIds, skillIds, posPickUpSafe, enablePickUp)
  self:ReplaceComponent(index, component)
end

function Entity:RemovePreviewChainSkill()
  if self:HasPreviewChainSkill() then
    self:RemoveComponent(self.WEComponentsEnum.PreviewChainSkill)
  end
end
