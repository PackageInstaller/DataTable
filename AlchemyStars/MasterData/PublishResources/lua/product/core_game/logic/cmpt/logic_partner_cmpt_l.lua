_class("LogicPartnerComponent", Object)
LogicPartnerComponent = LogicPartnerComponent

function LogicPartnerComponent:Constructor()
end

function LogicPartnerComponent:WEC_PostInitialize(owner)
end

function LogicPartnerComponent:WEC_PostRemoved()
end

function Entity:LogicPartner()
  return self:GetComponent(self.WEComponentsEnum.LogicPartner)
end

function Entity:HasLogicPartner()
  return self:HasComponent(self.WEComponentsEnum.LogicPartner)
end

function Entity:AddLogicPartner()
  local index = self.WEComponentsEnum.LogicPartner
  local component = LogicPartnerComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceLogicPartner()
  local index = self.WEComponentsEnum.LogicPartner
  local component = LogicPartnerComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLogicPartner()
  if self:HasLogicPartner() then
    self:RemoveComponent(self.WEComponentsEnum.LogicPartner)
  end
end
