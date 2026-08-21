_class("AnimatorControllerComponent", Object)
AnimatorControllerComponent = AnimatorControllerComponent

function AnimatorControllerComponent:Constructor(triggerTable, boolTable, needDirToBoolTable, layerWeightTable)
  self.AniTriggerTable = triggerTable or {}
  self.AniBoolTable = boolTable or {}
  self.AniNeedDirToBoolTable = needDirToBoolTable or false
  self._LastHitAnimationTime = 0
  self.AnimatorLayerWeightTable = layerWeightTable or {}
  self.bKeepAnimatorLayerWeight = false
  self.specialAnimRoot = nil
  self.linkAnimatorEntityArray = {}
end

function AnimatorControllerComponent:IsNeedHitAnimation(currentTimeMs)
  local lastTime = self._LastHitAnimationTime
  if currentTimeMs - lastTime > BattleConst.HitAnimationIntervalMs then
    self._LastHitAnimationTime = currentTimeMs
    return true
  else
    return false
  end
end

function AnimatorControllerComponent:AddLinkAnimatorEntity(e)
  table.insert(self.linkAnimatorEntityArray, e)
end

function Entity:AnimatorController()
  return self:GetComponent(self.WEComponentsEnum.AnimatorController)
end

function Entity:HasAnimatorController()
  return self:HasComponent(self.WEComponentsEnum.AnimatorController)
end

function Entity:AddAnimatorController(triggerTable, boolTable)
  local index = self.WEComponentsEnum.AnimatorController
  local component = AnimatorControllerComponent:New(triggerTable, boolTable)
  self:AddComponent(index, component)
end

function Entity:SetAnimatorControllerTriggers(triggerTable)
  if table.count(triggerTable) <= 0 then
    return
  end
  local index = self.WEComponentsEnum.AnimatorController
  local component = self:AnimatorController()
  if component then
    component.AniTriggerTable = triggerTable
    for _, e in ipairs(component.linkAnimatorEntityArray) do
      e:SetAnimatorControllerTriggers(triggerTable)
    end
    self:ReplaceComponent(index, component)
  else
    local component = AnimatorControllerComponent:New(triggerTable)
    self:ReplaceComponent(index, component)
  end
end

function Entity:SetAnimatorControllerBools(boolTable)
  local index = self.WEComponentsEnum.AnimatorController
  local component = self:AnimatorController()
  if component then
    for param, value in pairs(boolTable) do
      component.AniBoolTable[param] = value
    end
    for _, e in ipairs(component.linkAnimatorEntityArray) do
      local c = e:AnimatorController()
      for param, value in pairs(boolTable) do
        c.AniBoolTable[param] = value
      end
    end
    self:ReplaceComponent(index, component)
  else
    local component = AnimatorControllerComponent:New({}, boolTable)
    self:ReplaceComponent(index, component)
  end
end

function Entity:GetAnimatorControllerBoolsData(stBoolParam)
  local component = self:AnimatorController()
  if component then
    for param, value in pairs(component.AniBoolTable) do
      if param == stBoolParam then
        return value
      end
    end
  end
  return nil
end

function Entity:RemoveAnimatorController()
  if self:HasAnimatorController() then
    self:RemoveComponent(self.WEComponentsEnum.AnimatorController)
  end
end

function Entity:IsNeedHitAnimation(currentTimeMs)
  if self:HasAnimatorController() then
    local component = self:AnimatorController()
    return component:IsNeedHitAnimation(currentTimeMs)
  end
  return true
end

function Entity:SetHitAnimatorControllerTriggers(triggerTable)
  local timeService = self:GetOwnerWorld():GetService("Time")
  local currentTimeMs = timeService:GetCurrentTimeMs()
  local index = self.WEComponentsEnum.AnimatorController
  local component = self:AnimatorController()
  if component then
    if self:IsNeedHitAnimation(currentTimeMs) then
      component.AniTriggerTable = triggerTable
      self:ReplaceComponent(index, component)
      for _, e in ipairs(component.linkAnimatorEntityArray) do
        e:SetHitAnimatorControllerTriggers(triggerTable)
      end
    end
  else
    local component = AnimatorControllerComponent:New(triggerTable)
    self:ReplaceComponent(index, component)
  end
end

function Entity:SetAnimatorLayerWeight(layerWeightTable)
  local index = self.WEComponentsEnum.AnimatorController
  local component = self:AnimatorController()
  if component then
    for param, value in pairs(layerWeightTable) do
      component.AnimatorLayerWeightTable[param] = value
    end
    self:ReplaceComponent(index, component)
    for _, e in ipairs(component.linkAnimatorEntityArray) do
      e:SetAnimatorLayerWeight(layerWeightTable)
    end
  else
    local component = AnimatorControllerComponent:New({}, {}, nil, layerWeightTable)
    self:ReplaceComponent(index, component)
  end
end

function Entity:SetKeepAnimatorLayerWeight(bKeep)
  local index = self.WEComponentsEnum.AnimatorController
  local component = self:AnimatorController()
  if component then
    component.bKeepAnimatorLayerWeight = bKeep
    self:ReplaceComponent(index, component)
    for _, e in ipairs(component.linkAnimatorEntityArray) do
      e:SetKeepAnimatorLayerWeight(bKeep)
    end
  else
    local component = AnimatorControllerComponent:New({}, {}, nil, nil)
    component.bKeepAnimatorLayerWeight = bKeep
    self:ReplaceComponent(index, component)
  end
end

function Entity:SetSpecialAnimRoot(specialRoot)
  local index = self.WEComponentsEnum.AnimatorController
  local component = self:AnimatorController()
  if component then
    component.specialAnimRoot = specialRoot
    self:ReplaceComponent(index, component)
  else
    local component = AnimatorControllerComponent:New({}, {}, nil, nil)
    component.specialAnimRoot = specialRoot
    self:ReplaceComponent(index, component)
  end
end
