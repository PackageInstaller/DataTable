_class("MonsterEscapeComponent", Object)
MonsterEscapeComponent = MonsterEscapeComponent

function MonsterEscapeComponent:Constructor(bEscapeSuccess)
  self.m_bEscapeSuccess = bEscapeSuccess
end

function MonsterEscapeComponent:IsEscapeSuccess()
  return self.m_bEscapeSuccess
end

function Entity:MonsterEscape()
  return self:GetComponent(self.WEComponentsEnum.MonsterEscape)
end

function Entity:HasMonsterEscape()
  return self:HasComponent(self.WEComponentsEnum.MonsterEscape)
end

function Entity:AddMonsterEscape(bEscape)
  local index = self.WEComponentsEnum.MonsterEscape
  local component = MonsterEscapeComponent:New(bEscape)
  self:AddComponent(index, component)
end

function Entity:ReplaceMonsterEscape(bEscape)
  local index = self.WEComponentsEnum.MonsterEscape
  local component = MonsterEscapeComponent:New(bEscape)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveMonsterEscape()
  if self:HasMonsterEscape() then
    self:RemoveComponent(self.WEComponentsEnum.MonsterEscape)
  end
end
