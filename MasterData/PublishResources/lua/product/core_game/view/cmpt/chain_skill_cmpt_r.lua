_class("ChainSkillComponent", Object)
ChainSkillComponent = ChainSkillComponent

function ChainSkillComponent:Constructor(chainNum)
  self._chainNum = chainNum
end

function ChainSkillComponent:GetChainNum()
  return self._chainNum
end

function Entity:ChainSkill()
  return self:GetComponent(self.WEComponentsEnum.ChainSkill)
end

function Entity:HasChainSkill()
  return self:HasComponent(self.WEComponentsEnum.ChainSkill)
end

function Entity:AddChainSkill(chainNum)
  local index = self.WEComponentsEnum.ChainSkill
  local component = ChainSkillComponent:New(chainNum)
  self:AddComponent(index, component)
end

function Entity:ReplaceChainSkill(chainNum)
  local index = self.WEComponentsEnum.ChainSkill
  local component = ChainSkillComponent:New(chainNum)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveChainSkill()
  if self:HasChainSkill() then
    self:RemoveComponent(self.WEComponentsEnum.ChainSkill)
  end
end
