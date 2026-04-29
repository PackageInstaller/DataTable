_class("RenderFeatureComponent", Object)
RenderFeatureComponent = RenderFeatureComponent

function RenderFeatureComponent:Constructor()
end

function RenderFeatureComponent:SetCurRoundDecreaseSanValue(round, modifyValue, curVal, oldVal, debtVal, modifyTimes)
  if not self._decreaseSan then
    self._decreaseSan = {}
  end
  self._decreaseSan[round] = {
    modify = modifyValue,
    cur = curVal,
    old = oldVal,
    debt = debtVal,
    _modifyTimes = modifyTimes
  }
end

function RenderFeatureComponent:GetCurRoundDecreaseSanValue(round)
  if self._decreaseSan then
    return self._decreaseSan[round]
  end
end

function RenderFeatureComponent:SetCurRoundDayNightRouncChangeValue(round, curState, oldState, restRound)
  if not self._roundChangeDayNight then
    self._roundChangeDayNight = {}
  end
  self._roundChangeDayNight[round] = {
    _curState = curState,
    _oldState = oldState,
    _restRound = restRound
  }
end

function RenderFeatureComponent:GetCurRoundDayNightRouncChangeValue(round)
  if self._roundChangeDayNight then
    return self._roundChangeDayNight[round]
  end
end

function RenderFeatureComponent:SetCurRoundChangeStepPoint(round, curVal, oldVal)
  if not self._changeStepPoint then
    self._changeStepPoint = {}
  end
  self._changeStepPoint[round] = {cur = curVal, old = oldVal}
end

function RenderFeatureComponent:GetCurRoundChangeStepPoint(round)
  if self._changeStepPoint then
    return self._changeStepPoint[round]
  end
end

function RenderFeatureComponent:SetMoveCostStepPoint(round, curVal, oldVal)
  if not self._moveCostStepPoint then
    self._moveCostStepPoint = {}
  end
  self._moveCostStepPoint[round] = {cur = curVal, old = oldVal}
end

function RenderFeatureComponent:ClearMoveCostStepPoint()
  self._moveCostStepPoint = {}
end

function RenderFeatureComponent:GetMoveCostStepPoint(round)
  if self._moveCostStepPoint then
    return self._moveCostStepPoint[round]
  end
end

function RenderFeatureComponent:AddExtraRecoverStepPointForLinkUI(flagID, stepMin, stepMax, modifyValue)
  if not self._extraRecoverStepPointInfo then
    self._extraRecoverStepPointInfo = {}
  end
  table.insert(self._extraRecoverStepPointInfo, {
    flagID = flagID,
    stepMin = stepMin,
    stepMax = stepMax,
    modifyValue = modifyValue
  })
end

function RenderFeatureComponent:RemoveExtraRecoverStepPointForLinkUI(flagID)
  if self._extraRecoverStepPointInfo then
    local waitRemoveIndex = -1
    for index, info in ipairs(self._extraRecoverStepPointInfo) do
      if flagID == info.flagID then
        waitRemoveIndex = index
        break
      end
    end
    if 0 <= waitRemoveIndex then
      table.remove(self._extraRecoverStepPointInfo, waitRemoveIndex)
    end
  end
end

function RenderFeatureComponent:ClearExtraRecoverStepPointForLinkUI()
  self._extraRecoverStepPointInfo = {}
end

function RenderFeatureComponent:CalcExtraRecoverStepPointForLinkUI(chainPath)
  local curStep = -1
  if chainPath then
    curStep = #chainPath - 1
  end
  if curStep < 0 then
    return 0
  end
  if self._extraRecoverStepPointInfo then
    local extraVal = 0
    for index, info in ipairs(self._extraRecoverStepPointInfo) do
      if curStep >= info.stepMin and curStep <= info.stepMax then
        extraVal = extraVal + info.modifyValue
      end
    end
    return extraVal
  end
  return 0
end

function RenderFeatureComponent:WEC_PostInitialize(owner)
end

function RenderFeatureComponent:WEC_PostRemoved()
end

function Entity:RenderFeature()
  return self:GetComponent(self.WEComponentsEnum.RenderFeature)
end

function Entity:HasRenderFeature()
  return self:HasComponent(self.WEComponentsEnum.RenderFeature)
end

function Entity:AddRenderFeature()
  local index = self.WEComponentsEnum.RenderFeature
  local component = RenderFeatureComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderFeature()
  local index = self.WEComponentsEnum.RenderFeature
  local component = RenderFeatureComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderFeature()
  if self:HasRenderFeature() then
    self:RemoveComponent(self.WEComponentsEnum.RenderFeature)
  end
end
