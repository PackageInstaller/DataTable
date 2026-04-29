_class("SkillHolderComponent", Object)
SkillHolderComponent = SkillHolderComponent

function SkillHolderComponent:Constructor()
  self._SkillHolder = {}
end

function SkillHolderComponent:Dispose()
  for name, holderId in pairs(self._SkillHolder) do
    local holder = self._entity._world:GetEntityByID(holderId)
    if holder then
      self._entity._world:DestroyEntity(holder)
    end
  end
end

function SkillHolderComponent:AddSkillHolder(name, entityID)
  self._SkillHolder[name] = entityID
end

function SkillHolderComponent:GetSkillHolder(name)
  return self._SkillHolder[name]
end

function SkillHolderComponent:RemoveSkillHolder(name)
  self._SkillHolder[name] = nil
end

function Entity:SkillHolder()
  return self:GetComponent(self.WEComponentsEnum.SkillHolder)
end

function Entity:HasSkillHolder()
  local index = self.WEComponentsEnum.SkillHolder
  return self:HasComponent(index)
end

function Entity:AddSkillHolder(name, entityID)
  local index = self.WEComponentsEnum.SkillHolder
  local component = self:SkillHolder()
  if not component then
    component = SkillHolderComponent:New()
    self:AddComponent(index, component)
  end
  component:AddSkillHolder(name, entityID)
end

function Entity:GetSkillHolder(name)
  local com = self:SkillHolder()
  if com then
    return com:GetSkillHolder(name)
  end
end

function Entity:RemoveSkillHolder(name)
  local com = self:SkillHolder()
  if com then
    com:RemoveSkillHolder(name)
  end
end
