_class("ShareSkillResultComponent", Object)
ShareSkillResultComponent = ShareSkillResultComponent

function ShareSkillResultComponent:Constructor()
  self._entityContainer = {}
end

function ShareSkillResultComponent:AddEntityResult(entityID, skillResult)
  if not self._entityContainer[entityID] then
    self._entityContainer[entityID] = SkillEffectResultContainer:New()
  end
  local resultContainer = self._entityContainer[entityID]
  local result = skillResult:Clone()
  resultContainer:AddEffectResult(result)
end

function ShareSkillResultComponent:GetResultContainerByEntityID(entityID)
  return self._entityContainer[entityID]
end

function ShareSkillResultComponent:Clear()
  self._entityContainer = {}
end

function Entity:ShareSkillResult()
  return self:GetComponent(self.WEComponentsEnum.ShareSkillResult)
end

function Entity:HasShareSkillResult()
  return self:HasComponent(self.WEComponentsEnum.ShareSkillResult)
end

function Entity:AddShareSkillResult()
  local index = self.WEComponentsEnum.ShareSkillResult
  local component = ShareSkillResultComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceShareSkillResult()
  local index = self.WEComponentsEnum.ShareSkillResult
  local component = ShareSkillResultComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveShareSkillResult()
  if self:HasShareSkillResult() then
    self:RemoveComponent(self.WEComponentsEnum.ShareSkillResult)
  end
end
