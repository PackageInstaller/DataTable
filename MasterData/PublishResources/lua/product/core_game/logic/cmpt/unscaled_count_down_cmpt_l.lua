_class("UnscaledCountDownLogicComponent", Object)
UnscaledCountDownLogicComponent = UnscaledCountDownLogicComponent

function UnscaledCountDownLogicComponent:Constructor()
  self:Reset()
end

function UnscaledCountDownLogicComponent:Reset()
  self._flagID = 0
  self._isActive = false
  self._isWaitTrigger = false
  self._countDownValue = 0
end

function UnscaledCountDownLogicComponent:StartCoundDown(flagID, countDownValueMs)
  self._flagID = flagID
  self._countDownValue = countDownValueMs
  self._isActive = true
  self._isWaitTrigger = false
end

function UnscaledCountDownLogicComponent:GetFlagID()
  return self._flagID
end

function UnscaledCountDownLogicComponent:GetIsActive()
  return self._isActive
end

function UnscaledCountDownLogicComponent:GetIsWaitTrigger()
  return self._isWaitTrigger
end

function UnscaledCountDownLogicComponent:SetIsWaitTrigger()
  self._isWaitTrigger = true
end

function Entity:UnscaledCountDownLogic()
  return self:GetComponent(self.WEComponentsEnum.UnscaledCountDownLogic)
end

function Entity:HasUnscaledCountDownLogic()
  return self:HasComponent(self.WEComponentsEnum.UnscaledCountDownLogic)
end

function Entity:AddUnscaledCountDownLogic()
  local index = self.WEComponentsEnum.UnscaledCountDownLogic
  local component = UnscaledCountDownLogicComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceUnscaledCountDownLogic()
  local index = self.WEComponentsEnum.UnscaledCountDownLogic
  local component = UnscaledCountDownLogicComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveUnscaledCountDownLogic()
  if self:HasUnscaledCountDownLogic() then
    self:RemoveComponent(self.WEComponentsEnum.UnscaledCountDownLogic)
  end
end
