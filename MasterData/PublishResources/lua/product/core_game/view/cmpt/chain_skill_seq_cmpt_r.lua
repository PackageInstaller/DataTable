_class("ChainSkillSequenceComponent", Object)
ChainSkillSequenceComponent = ChainSkillSequenceComponent

function ChainSkillSequenceComponent:Constructor()
  self.ChainSkillSeqTable = {}
end

function Entity:ChainSkillSequence()
  return self:GetComponent(self.WEComponentsEnum.ChainSkillSequence)
end

function Entity:HasChainSkillSequence()
  return self:HasComponent(self.WEComponentsEnum.ChainSkillSequence)
end

function Entity:AddChainSkillSequence()
  local index = self.WEComponentsEnum.ChainSkillSequence
  local component = ChainSkillSequenceComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceChainSkillSequence()
  local index = self.WEComponentsEnum.ChainSkillSequence
  local component = ChainSkillSequenceComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveChainSkillSequence()
  if self:HasChainSkillSequence() then
    self:RemoveComponent(self.WEComponentsEnum.ChainSkillSequence)
  end
end
