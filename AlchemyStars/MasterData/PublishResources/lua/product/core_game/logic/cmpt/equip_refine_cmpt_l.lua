_class("EquipRefineComponent", Object)
EquipRefineComponent = EquipRefineComponent

function EquipRefineComponent:Constructor()
  self._equipRefineBuffList = nil
  self._extraChainSkillList = nil
  self._extraActiveSkillList = nil
  self._equipRefineIntensifyParam = nil
  self._featureList = nil
  self._variantActiveSkillInfo = nil
end

function EquipRefineComponent:WEC_PostInitialize(owner)
end

function EquipRefineComponent:WEC_PostRemoved()
end

function EquipRefineComponent:SetEquipRefineBuffList(param)
  self._equipRefineBuffList = param
end

function EquipRefineComponent:GetEquipRefineBuffList()
  return self._equipRefineBuffList
end

function EquipRefineComponent:SetEquipRefineExtraChainSkillList(param)
  self._extraChainSkillList = param
end

function EquipRefineComponent:GetEquipRefineExtraChainSkillList()
  return self._extraChainSkillList
end

function EquipRefineComponent:SetEquipRefineIntensifyParam(param)
  self._equipRefineIntensifyParam = param
end

function EquipRefineComponent:GetEquipRefineIntensifyParam()
  return self._equipRefineIntensifyParam
end

function EquipRefineComponent:SetEquipRefineExtraActiveSkillList(param)
  self._extraActiveSkillList = param
end

function EquipRefineComponent:GetEquipRefineExtraActiveSkillList()
  return self._extraActiveSkillList
end

function EquipRefineComponent:SetEquipRefineFeatureList(param)
  self._featureList = param
end

function EquipRefineComponent:GetEquipRefineFeatureListFromCmpt()
  return self._featureList
end

function EquipRefineComponent:SetEquipRefineVariantActiveSkillInfo(param)
  self._variantActiveSkillInfo = param
end

function EquipRefineComponent:GetEquipRefineVariantActiveSkillInfo()
  return self._variantActiveSkillInfo
end

function Entity:EquipRefine()
  return self:GetComponent(self.WEComponentsEnum.EquipRefine)
end

function Entity:HasEquipRefine()
  return self:HasComponent(self.WEComponentsEnum.EquipRefine)
end

function Entity:AddEquipRefine()
  local index = self.WEComponentsEnum.EquipRefine
  local component = EquipRefineComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceEquipRefine()
  local index = self.WEComponentsEnum.EquipRefine
  local component = EquipRefineComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveEquipRefine()
  if self:HasEquipRefine() then
    self:RemoveComponent(self.WEComponentsEnum.EquipRefine)
  end
end
