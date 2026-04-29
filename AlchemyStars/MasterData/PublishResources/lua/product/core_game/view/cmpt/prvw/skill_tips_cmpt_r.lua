_class("SkillTipsComponent", Object)
SkillTipsComponent = SkillTipsComponent

function SkillTipsComponent:Constructor(skillName, skillDesc)
  self._skillName = skillName
  self._skillDesc = skillDesc
  self._isTrapDesc = false
  self._triggeredByChessPet = false
end

function SkillTipsComponent:GetSkillName()
  return self._skillName
end

function SkillTipsComponent:GetSkillDesc()
  return self._skillDesc
end

function SkillTipsComponent:SetTrapDesc(state)
  self._isTrapDesc = state
end

function SkillTipsComponent:GetTrapDesc()
  return self._isTrapDesc
end

function SkillTipsComponent:SetTriggeredByChessPet(v)
  self._triggeredByChessPet = v
end

function SkillTipsComponent:IsTriggeredByChessPet()
  return self._triggeredByChessPet
end

function Entity:SkillTips()
  return self:GetComponent(self.WEComponentsEnum.SkillTips)
end

function Entity:HasSkillTips()
  return self:HasComponent(self.WEComponentsEnum.SkillTips)
end

function Entity:AddSkillTips(skillName, skillDesc)
  local index = self.WEComponentsEnum.SkillTips
  local component = SkillTipsComponent:New(skillName, skillDesc)
  self:AddComponent(index, component)
end

function Entity:ReplaceSkillTips(skillName, skillDesc)
  local index = self.WEComponentsEnum.SkillTips
  local component = SkillTipsComponent:New(skillName, skillDesc)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveSkillTips()
  if self:HasSkillTips() then
    self:RemoveComponent(self.WEComponentsEnum.SkillTips)
  end
end
