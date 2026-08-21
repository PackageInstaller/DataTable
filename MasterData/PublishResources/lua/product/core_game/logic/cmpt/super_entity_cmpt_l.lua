_class("SuperEntityComponent", Object)
SuperEntityComponent = SuperEntityComponent

function SuperEntityComponent:Constructor(entity)
  self._superEntity = entity
  self._useSuperView = false
  self._useSuperPetAttackData = false
end

function SuperEntityComponent:GetSuperEntity()
  return self._superEntity
end

function SuperEntityComponent:IsUseSuperEntityView()
  return self._useSuperView
end

function SuperEntityComponent:SetUseSuperEntityViewState(state)
  self._useSuperView = state
end

function SuperEntityComponent:IsUseSuperPetAttackData()
  return self._useSuperPetAttackData
end

function SuperEntityComponent:SetUseSuperPetAttackData(state)
  self._useSuperPetAttackData = state
end

function SuperEntityComponent:GetBuffSkillHolderCasterEntityID()
  return self._buffCasterEntityID
end

function SuperEntityComponent:SetBuffSkillHolderCasterEntityID(buffCasterEntityID)
  self._buffCasterEntityID = buffCasterEntityID
end

function Entity:SuperEntityComponent()
  return self:GetComponent(self.WEComponentsEnum.SuperEntity)
end

function Entity:AddSuperEntity(entity)
  local index = self.WEComponentsEnum.SuperEntity
  local component = SuperEntityComponent:New(entity)
  self:AddComponent(index, component)
end

function Entity:GetSuperEntity()
  local index = self.WEComponentsEnum.SuperEntity
  local superEntityCmp = self:GetComponent(index)
  if not superEntityCmp then
    return
  end
  return superEntityCmp:GetSuperEntity()
end

function Entity:HasSuperEntity()
  local index = self.WEComponentsEnum.SuperEntity
  return self:HasComponent(index)
end
