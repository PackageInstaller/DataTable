_class("ChainSkillFlagComponent", Object)
ChainSkillFlagComponent = ChainSkillFlagComponent

function ChainSkillFlagComponent:Constructor()
end

function Entity:ChainSkillFlag()
  return self:GetComponent(self.WEComponentsEnum.ChainSkillFlag)
end

function Entity:HasChainSkillFlag()
  return self:HasComponent(self.WEComponentsEnum.ChainSkillFlag)
end

function Entity:AddChainSkillFlag()
  local index = self.WEComponentsEnum.ChainSkillFlag
  local component = ChainSkillFlagComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceChainSkillFlag()
  local index = self.WEComponentsEnum.ChainSkillFlag
  local component = ChainSkillFlagComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveChainSkillFlag()
  if self:HasChainSkillFlag() then
    self:RemoveComponent(self.WEComponentsEnum.ChainSkillFlag)
  end
end
