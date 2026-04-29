_class("LogicChainDamageComponent", Object)
LogicChainDamageComponent = LogicChainDamageComponent

function LogicChainDamageComponent:Constructor()
  self._chainDamageList = {}
  self._chainRecoverList = {}
  self._enable = true
end

function LogicChainDamageComponent:Clear()
  self._chainDamageList = {}
  self._chainRecoverList = {}
  self._enable = true
end

function LogicChainDamageComponent:GetChainDamageEnable()
  return self._enable
end

function LogicChainDamageComponent:SetChainDamageEnable(enable)
  self._enable = enable
end

function LogicChainDamageComponent:GetChainDamageList()
  return self._chainDamageList
end

function LogicChainDamageComponent:SetChainDamageList(entityID, value)
  self._chainDamageList[entityID] = value
end

function LogicChainDamageComponent:GetChainDamageEntityID(entityID)
  return self._chainDamageList[entityID]
end

function LogicChainDamageComponent:GetChainRecoverList()
  return self._chainRecoverList
end

function LogicChainDamageComponent:SetChainRecoverList(entityID, value)
  self._chainRecoverList[entityID] = value
end

function LogicChainDamageComponent:GetChainRecoverEntityID(entityID)
  return self._chainRecoverList[entityID]
end

function Entity:LogicChainDamage()
  return self:GetComponent(self.WEComponentsEnum.LogicChainDamage)
end

function Entity:HasLogicChainDamage()
  return self:HasComponent(self.WEComponentsEnum.LogicChainDamage)
end

function Entity:AddLogicChainDamage()
  local index = self.WEComponentsEnum.LogicChainDamage
  local component = LogicChainDamageComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceLogicChainDamage()
  local index = self.WEComponentsEnum.LogicChainDamage
  local component = LogicChainDamageComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLogicChainDamage()
  if self:HasLogicChainDamage() then
    self:RemoveComponent(self.WEComponentsEnum.LogicChainDamage)
  end
end
