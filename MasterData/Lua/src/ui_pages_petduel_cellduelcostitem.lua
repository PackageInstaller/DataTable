local this = class("cellDuelCostItem", G_UIModuleBase)
local maxRatio = 0.96

function this:applyFilledFromBind()
  if not (self.isBind and self.bindComponents) or not self.bindComponents.cellAnimator then
    return
  end
  if self.bind == nil or self.bind.index == nil or self.bind.currentCost == nil then
    return
  end
  local bindIndex = self.bind.index
  local bindCurrentCost = self.bind.currentCost
  local isFilled = bindIndex <= bindCurrentCost
  self.bindComponents.cellAnimator:SetBool("Filled", isFilled)
  self.cellAnimFilled = isFilled
  local highLightFillAmont = isFilled and maxRatio or 0
  self.bind.highLightFillAmont = highLightFillAmont
  self.highLightFillAmont = highLightFillAmont
end

function this.bind()
  return {
    highLightFillAmont = 0,
    normalActive = true,
    feverActive = false
  }
end

function this:open()
  if not self.isBind then
    return
  end
  if not self.bindComponents.cellAnimator then
    return
  end
  self.onStartRapidStateHandler = self.onStartRapidStateHandler or handler(self, self.onStartRapidState)
  C_KiboDuelSystemMgr:RegisterEvent(C_EKiboDuelEvent.StartRapidState, self.onStartRapidStateHandler, self)
  self.bind.highLightFillAmont = 0
  self.bindComponents.cellAnimator:SetBool("Show", false)
  self.bindComponents.cellAnimator:SetBool("Selected", false)
  self:applyFilledFromBind()
end

function this:onStartRapidState(e, varList)
  local isRapid = varList:GetBool(0)
  self:setPointStatus(isRapid)
end

function this:setPointStatus(isRapid)
  if not self.isBind then
    return
  end
  if self.normalActive == nil or self.normalActive ~= not isRapid then
    self.bind.normalActive = not isRapid
    self.normalActive = not isRapid
  end
  if self.feverActive == nil or self.feverActive ~= isRapid then
    self.bind.feverActive = isRapid
    self.feverActive = isRapid
  end
end

function this:recoverTimerCallback()
  if self.bind.index == self.bind.currentCost + 1 then
    local percent, status = C_KiboDuelSystemMgr:GetCostData()
    if status == L_Const.kiBoDuelCostStatus.RecoverCost then
      local highLightFillAmont = percent * maxRatio
      self.bind.highLightFillAmont = highLightFillAmont
      self.highLightFillAmont = highLightFillAmont
    else
      self.bind.highLightFillAmont = 0
      self.highLightFillAmont = 0
    end
  end
end

function this:updatePercent()
  if self.recoverTimer ~= nil then
    return
  end
  self:recoverTimerCallback()
  self.recoverTimer = Timer.repeated(0.1, function()
    self:recoverTimerCallback()
  end, self)
end

function this:refresh()
  if self.bind.isEmpty then
    return
  end
  self:updatePercent()
  if not self.isBind then
    return
  end
  self:setPointStatus(C_KiboDuelSystemMgr:GetRapidState())
  local bindIndex = self.bind.index
  local bindCurrentCost = self.bind.currentCost
  local isFilled = bindIndex <= bindCurrentCost
  if self.cellAnimFilled == nil or self.cellAnimFilled ~= isFilled then
    self.bindComponents.cellAnimator:SetBool("Filled", isFilled)
    self.cellAnimFilled = isFilled
  end
  local highLightFillAmont = bindIndex <= bindCurrentCost and maxRatio or 0
  if self.highLightFillAmont == nil or self.highLightFillAmont ~= highLightFillAmont then
    self.bind.highLightFillAmont = highLightFillAmont
    self.highLightFillAmont = highLightFillAmont
  end
  local isShow = bindIndex % 2 == 0
  self:refreshUrD(isShow)
end

function this:refreshUrD(isShow)
  if not self.isBind then
    return
  end
  if self.cellAnimUorD == nil or self.cellAnimUorD ~= isShow then
    self.bindComponents.cellAnimator:SetBool("UorD", isShow)
    self.cellAnimUorD = isShow
  end
end

function this:close()
  self:disposeRecoverTimer()
  C_KiboDuelSystemMgr:UnregisterEvent(C_EKiboDuelEvent.StartRapidState, self.onStartRapidStateHandler, self)
end

function this:disposeRecoverTimer()
  if self.recoverTimer ~= nil then
    Timer.remove(self.recoverTimer)
  end
  self.recoverTimer = nil
end

function this:playInitAnimation(isShow)
  if not self.isBind then
    return
  end
  Timer.once((self.bind.index - 1) * self.bind.index * 0.0085, function()
    self:setShowAnimator(isShow)
  end, self)
end

function this:setShowAnimator(isShow)
  if not self.isBind or not self.bindComponents.cellAnimator then
    return
  end
  self.bindComponents.cellAnimator:SetBool("Show", isShow)
  if isShow then
    self:applyFilledFromBind()
  end
end

function this:playSelectedAnimator(isSelected, lastCost)
  if self.isSelected == isSelected then
    return
  end
  self.isSelected = isSelected
  self:disposeSelectedTimer()
  local delayTime = (self.bind.index - lastCost - 1) * 0.02
  if delayTime < 0 then
    delayTime = 0
  end
  self.selectTimer = Timer.once(delayTime, function()
    self:setSetelected(isSelected)
  end, self)
end

function this:setSetelected(isSelected)
  if not self.bindComponents.cellAnimator then
    return
  end
  self.isSelected = isSelected
  self.bindComponents.cellAnimator:SetBool("Selected", isSelected)
end

function this:disposeSelectedTimer()
  if self.selectTimer ~= nil then
    Timer.remove(self.selectTimer)
    self.selectTimer = nil
  end
end

function this:triggerCast()
  if not self.isBind then
    return
  end
  Timer.once((self.bind.index - 1) * 0.02, function()
    if not self.bindComponents.cellAnimator then
      return
    end
    self.bindComponents.cellAnimator:Play("anim_petduel_energy_select_cast", 0)
  end, self)
end

function this:playForceInit()
  if not self.bindComponents.cellAnimator then
    return
  end
  self.bindComponents.cellAnimator:SetTrigger("ForceInit")
end

function this:getIndex()
  return self.bind.index
end

return this
