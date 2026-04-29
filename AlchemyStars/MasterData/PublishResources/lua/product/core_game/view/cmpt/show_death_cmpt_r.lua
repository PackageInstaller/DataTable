_class("ShowDeathComponent", Object)
ShowDeathComponent = ShowDeathComponent

function ShowDeathComponent:Constructor()
  self._isShowDeathEnd = false
end

function ShowDeathComponent:SetShowDeathEnd(isEnd)
  self._isShowDeathEnd = isEnd
end

function ShowDeathComponent:IsShowDeathEnd()
  return self._isShowDeathEnd
end

function ShowDeathComponent:WEC_PostInitialize(owner)
end

function ShowDeathComponent:WEC_PostRemoved()
end

function Entity:ShowDeath()
  return self:GetComponent(self.WEComponentsEnum.ShowDeath)
end

function Entity:HasShowDeath()
  return self:HasComponent(self.WEComponentsEnum.ShowDeath)
end

function Entity:AddShowDeath()
  local index = self.WEComponentsEnum.ShowDeath
  local component = ShowDeathComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceShowDeath()
  local index = self.WEComponentsEnum.ShowDeath
  local component = ShowDeathComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveShowDeath()
  if self:HasShowDeath() then
    self:RemoveComponent(self.WEComponentsEnum.ShowDeath)
  end
end
