_class("AppearTriggerTrapComponent", Object)
AppearTriggerTrapComponent = AppearTriggerTrapComponent

function AppearTriggerTrapComponent:Constructor(tEntities, tResults)
  self._triggeredTrapEntity = tEntities or {}
  self._triggeredSkillResult = tResults or {}
end

function AppearTriggerTrapComponent:GetData()
  return self._triggeredTrapEntity, self._triggeredSkillResult
end

function AppearTriggerTrapComponent:Clear()
  self._triggeredTrapEntity = {}
  self._triggeredSkillResult = {}
end

function Entity:HasAppearTriggerTrap()
  return self:HasComponent(self.WEComponentsEnum.AppearTriggerTrap)
end

function Entity:AddAppearTriggerTrap(tEntities, tResults)
  local component = AppearTriggerTrapComponent:New(tEntities, tResults)
  self:AddComponent(self.WEComponentsEnum.AppearTriggerTrap, component)
end

function Entity:AppearTriggerTrap()
  return self:GetComponent(self.WEComponentsEnum.AppearTriggerTrap)
end

function Entity:ReplaceAppearTriggerTrap(tEntities, tResults)
  local component = AppearTriggerTrapComponent:New(tEntities, tResults)
  self:ReplaceComponent(self.WEComponentsEnum.AppearTriggerTrap, component)
end

function Entity:RemoveAppearTriggerTrap()
  if not self:HasAppearTriggerTrap() then
    return
  end
  self:RemoveComponent(self.WEComponentsEnum.AppearTriggerTrap)
end
