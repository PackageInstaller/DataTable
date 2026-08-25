local NewbieGuideStep = System.NewComponent("NewbieGuideStep")

function NewbieGuideStep:ctor(tid, config)
  self.tid = tid
  self.config = config
  self.childIndex = 1
  self.childGuideList = self.config.data_list
  self.maxPlayedIndex = 0
  self.playingIndex = 0
  self.passedChildIndexMap = {}
end

function NewbieGuideStep:OnBind(binder)
  self.binder = binder
  binder:BindEvent(EventMgr.Instance.NewbieGuidePass, System.fn(self, self.OnNewbieGuidePass))
end

function NewbieGuideStep:OnNewbieGuidePass(guideTid, guideIndex)
  if guideTid == self.tid then
    self:MarkGuideIndexPassed(guideIndex)
  end
end

function NewbieGuideStep:CheckUnlockCondition()
  if self.maxPlayedIndex > 1 then
    return true
  end
  local config = self.childGuideList[1]
  if self:CheckEndConditionSatisfy() then
    Logger.Warn("指引满足结束条件，不显示", self.tid, table.tostring(config.End, ",", ","))
    self:Complete()
    return false
  end
  if not config.Unlock then
    return true
  end
  if self:CheckCondition(config.Unlock) then
    return true
  end
  return false
end

function NewbieGuideStep:CheckEndConditionSatisfy()
  local targetConfig = self.childGuideList and self.childGuideList[1]
  if not targetConfig then
    return false
  end
  return targetConfig.End and self:CheckCondition(targetConfig.End, false)
end

function NewbieGuideStep:CheckCondition(condition, islogicAnd)
  if not condition then
    return false
  end
  local finalResult
  if islogicAnd then
    finalResult = true
  else
    finalResult = false
  end
  for conditionType, conditionParam in table.iteraDouble(condition) do
    local result = false
    if 1 == conditionType then
      result = MainCopyDataUtils.IsStageDataFirstFinish(conditionParam)
    end
    if 2 == conditionType then
      result = conditionParam <= PlayerDataUtils.GetLevel()
    end
    if 3 == conditionType then
      if GuideConditionUtils[conditionParam] then
        result = GuideConditionUtils[conditionParam]()
      else
        result = false
      end
    end
    if 4 == conditionType then
      result = PlayerDataUtils.IsFeatureTidUnlock(conditionParam)
    end
    if islogicAnd then
      if finalResult then
        finalResult = result
      end
    else
      finalResult = finalResult or result
    end
  end
  return finalResult
end

function NewbieGuideStep:IsPreStepPassed(childIndex)
  local preChildIndex = childIndex - 1
  local preChildCfg = self.childGuideList[preChildIndex]
  if not preChildCfg or preChildCfg.IsForcible ~= cd.NumberTrue then
    return true
  end
  return self.passedChildIndexMap[preChildIndex]
end

function NewbieGuideStep:CheckToShow(childIndex)
  local curChildCfg = self.childGuideList[childIndex]
  if not curChildCfg then
    return false
  end
  if not self:IsPreStepPassed(childIndex) then
    return false
  end
  local viewName = curChildCfg.ViewName
  if not (not viewName or GuidePanelUtils.IsViewAtTop(viewName)) or UIManager.Instance:GetWindow(Urls.FeatureUnlockPanel) then
    return false
  end
  local nodeName = curChildCfg.NodeName
  if nodeName and not GuidePanelUtils.IsNodeShow(nodeName) then
    return false
  end
  return true
end

function NewbieGuideStep:GetPriority()
  if self.config.TriggerPriority then
    return self.config.TriggerPriority
  end
  if self.childGuideList[1] then
    return self.childGuideList[1].TriggerPriority
  end
  return math.huge
end

function NewbieGuideStep:IsSafeGuard()
  for _, childCfg in ipairs(self.childGuideList) do
    if childCfg.MinRequirementSkip == cd.NumberTrue then
      return true
    end
  end
end

function NewbieGuideStep:CheckSafeGuard(index)
  if not self:IsSafeGuard() then
    return
  end
  local key = string.format("%s_%s", self.tid, index)
  local count = ClientDataUtils.GetData(cd.ClientDataMainKey.NewbieGuideCount, key, 0)
  ClientDataUtils.SetData(cd.ClientDataMainKey.NewbieGuideCount, key, count + 1)
  return count >= 2
end

function NewbieGuideStep:CheckToGuide()
  if self:CheckUnlockCondition() then
    return true
  end
end

function NewbieGuideStep:Continue()
  if self._completed then
    return
  end
  if not self:CheckUnlockCondition() then
    self:Complete()
    return
  end
  if self.maxPlayedIndex >= #self.childGuideList then
    local lastCfg = self.childGuideList[self.maxPlayedIndex]
    if lastCfg and -1 == lastCfg.IsForcible then
      self:Complete()
    elseif not self:CheckToShow(self.maxPlayedIndex) then
      self:Complete()
    end
    return
  end
  for i = self.maxPlayedIndex + 1, self.playingIndex, -1 do
    if self:CheckToShow(i) then
      self:ShowGuide(i)
      return
    end
  end
  for i = self.playingIndex - 1, 1, -1 do
    if not self._markedCompleted and self:CheckToShow(i) then
      self:ShowGuide(i)
      return
    end
  end
  self:HideGuide()
end

function NewbieGuideStep:MarkGuideIndexPassed(index)
  self.passedChildIndexMap[index] = true
end

function NewbieGuideStep:ShowGuide(checkIndex)
  if self.playingIndex == checkIndex and UIManager.Instance:GetWindow(Urls.NewbieGuideView) then
    return
  end
  if self:CheckSafeGuard(checkIndex) then
    self:Complete()
    return
  end
  self:MarkGuideIndexPassed(checkIndex - 1)
  self.playingIndex = checkIndex
  self.maxPlayedIndex = math.max(self.maxPlayedIndex, checkIndex)
  UIManager.Instance:Reopen(Urls.NewbieGuideView, self.tid, checkIndex, self.childGuideList[checkIndex], function()
    if checkIndex >= #self.childGuideList then
      self:Complete()
    end
  end)
  for index, childCfg in ipairs(self.childGuideList) do
    if childCfg.KeyNode and self._markedCompleted and checkIndex < index then
      self:Complete()
      return
    end
    if childCfg.KeyNode and checkIndex >= index then
      self:MarkGuideFinish()
      return
    end
  end
end

function NewbieGuideStep:HideGuide()
  if 0 ~= self.playingIndex then
    UIManager.Instance:CloseByUrl(Urls.NewbieGuideView)
    self.playingIndex = 0
  end
end

function NewbieGuideStep:MarkGuideFinish()
  self._markedCompleted = true
  NewbieGuideManager.Instance:MarkGuideFinish(self.tid)
end

function NewbieGuideStep:Complete()
  self._completed = true
  NewbieGuideManager.Instance:SetGuideStepFinish(self.tid, self)
  self:HideGuide()
  EventMgr.Instance.CloseClickMask:Dispatch("NewbieGuidePanel")
end

function NewbieGuideStep:IsCompleted()
  return self._completed
end

function NewbieGuideStep:OnGuideClick()
  if self.config.IsForcible then
    local targetNode = NewbieGuideStep:FindTargetNode(self.config.NodeName)
    if targetNode and targetNode:isClicked() then
      GuideManager.GetInstance():CompleteCurrentStep()
    end
  else
    GuideManager.GetInstance():CompleteCurrentStep()
  end
end

return NewbieGuideStep
