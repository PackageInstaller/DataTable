_class("UnscaledCountDownRenderComponent", Object)
UnscaledCountDownRenderComponent = UnscaledCountDownRenderComponent

function UnscaledCountDownRenderComponent:Constructor()
  self:Reset()
end

function UnscaledCountDownRenderComponent:Reset()
  self._flagID = 0
  self._curRestTimeMs = 0
  self._isActive = false
  self._isWaitTrigger = false
  self._isRunning = false
  self._countDownValue = 0
  self._waitPlayNotify = false
end

function UnscaledCountDownRenderComponent:GetFlagID()
  return self._flagID
end

function UnscaledCountDownRenderComponent:GetIsActive()
  return self._isActive
end

function UnscaledCountDownRenderComponent:GetIsRunning()
  return self._isRunning
end

function UnscaledCountDownRenderComponent:SetIsRunning(isRunning)
  self._isRunning = isRunning
end

function UnscaledCountDownRenderComponent:GetIsWaitTrigger()
  return self._isWaitTrigger
end

function UnscaledCountDownRenderComponent:SetIsWaitTrigger(isWaitTrigger)
  self._isWaitTrigger = isWaitTrigger
end

function UnscaledCountDownRenderComponent:GetCurRestTimeMs()
  return self._curRestTimeMs
end

function UnscaledCountDownRenderComponent:SetCurRestTimeMs(restTimeMs)
  self._curRestTimeMs = restTimeMs
end

function UnscaledCountDownRenderComponent:StartCoundDown(flagID, countDownValueMs)
  self._flagID = flagID
  self._countDownValue = countDownValueMs
  self._curRestTimeMs = self._countDownValue
  self._isActive = true
  self._isRunning = true
  self._isWaitTrigger = false
  self._waitPlayNotify = false
end

function UnscaledCountDownRenderComponent:GetWaitPlayNotify()
  return self._waitPlayNotify
end

function UnscaledCountDownRenderComponent:SetWaitPlayNotify(bWaitPlay)
  self._waitPlayNotify = bWaitPlay
end

function Entity:UnscaledCountDownRender()
  return self:GetComponent(self.WEComponentsEnum.UnscaledCountDownRender)
end

function Entity:HasUnscaledCountDownRender()
  return self:HasComponent(self.WEComponentsEnum.UnscaledCountDownRender)
end

function Entity:AddUnscaledCountDownRender()
  local index = self.WEComponentsEnum.UnscaledCountDownRender
  local component = UnscaledCountDownRenderComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceUnscaledCountDownRender()
  local index = self.WEComponentsEnum.UnscaledCountDownRender
  local component = UnscaledCountDownRenderComponent:New()
  self:ReplaceComponent(index, component)
end
