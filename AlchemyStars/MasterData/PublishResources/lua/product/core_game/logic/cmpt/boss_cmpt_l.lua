_class("BossComponent", Object)
BossComponent = BossComponent

function BossComponent:Constructor()
  self._hasShow = false
end

function BossComponent:SetShowState(state)
  self._hasShow = state
end

function BossComponent:IsHasShow()
  return self._hasShow
end

function Entity:Boss()
  return self:GetComponent(self.WEComponentsEnum.Boss)
end

function Entity:HasBoss()
  return self:HasComponent(self.WEComponentsEnum.Boss)
end

function Entity:ReplaceBoss()
  local index = self.WEComponentsEnum.Boss
  local component = BossComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:AddBoss()
  local index = self.WEComponentsEnum.Boss
  local component = BossComponent:New()
  self:AddComponent(index, component)
end

function Entity:RemoveBoss()
  if self:HasBoss() then
    self:RemoveComponent(self.WEComponentsEnum.Boss)
  end
end
