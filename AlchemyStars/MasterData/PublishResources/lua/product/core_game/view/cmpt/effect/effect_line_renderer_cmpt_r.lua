_class("EffectLineRendererComponent", Object)
EffectLineRendererComponent = EffectLineRendererComponent

function EffectLineRendererComponent:Constructor()
  self:_OnInit()
end

function EffectLineRendererComponent:_OnInit()
  self._current = {}
  self._target = {}
  self._root = {}
  self._effectObject = {}
  self._show = {}
  self._effectID = {}
  self._currentPos = {}
  self._targetPos = {}
  self._entityViewRootPos = {}
  self._ignoreEntityViewRootPos = false
  self._targetRootOff = nil
  self._currentRootOff = nil
end

function EffectLineRendererComponent:InitEffectLineRenderer(entityID, current, target, root, effectObject, effectID)
  if self._current == nil then
    self:_OnInit()
  end
  self._current[entityID] = current
  self._target[entityID] = target
  self._root[entityID] = root
  self._effectObject[entityID] = effectObject
  self._effectID[entityID] = effectID
  self._casterEntityID = entityID
end

function EffectLineRendererComponent:GetCasterEntityID()
  return self._casterEntityID
end

function EffectLineRendererComponent:SetTargetEntityID(targetEntityID)
  self._targetEntityID = targetEntityID
end

function EffectLineRendererComponent:GetTargetEntityID()
  return self._targetEntityID
end

function EffectLineRendererComponent:SetIgnoreEntityViewRootPos(bIgnore)
  self._ignoreEntityViewRootPos = bIgnore
end

function EffectLineRendererComponent:GetIgnoreEntityViewRootPos()
  return self._ignoreEntityViewRootPos
end

function EffectLineRendererComponent:GetEffectLineRendererEffectID(entityID)
  return self._effectID[entityID]
end

function EffectLineRendererComponent:GetEffectLineRendererCurrent()
  local effectShowList = {}
  for i, v in pairs(self._show) do
    if v == true then
      table.insert(effectShowList, self._current[i])
    end
  end
  return effectShowList
end

function EffectLineRendererComponent:GetEffectLineRendererTarget()
  local effectShowList = {}
  for i, v in pairs(self._show) do
    if v == true then
      table.insert(effectShowList, self._target[i])
    end
  end
  return effectShowList
end

function EffectLineRendererComponent:GetEffectLineRendererEntityViewRoot()
  local effectShowList = {}
  for i, v in pairs(self._show) do
    if v == true then
      table.insert(effectShowList, self._root[i])
    end
  end
  return effectShowList
end

function EffectLineRendererComponent:GetEffectLineRendererEffect()
  local effectShowList = {}
  for i, v in pairs(self._show) do
    if v == true then
      table.insert(effectShowList, self._effectObject[i])
    end
  end
  return effectShowList
end

function EffectLineRendererComponent:SetEffectLineActive(entityID, activeState)
  if self._effectObject[entityID] then
    for i = 0, self._effectObject[entityID].Length - 1 do
      local line = self._effectObject[entityID][i]
      if line then
        line.gameObject:SetActive(activeState)
      end
    end
  end
end

function EffectLineRendererComponent:OnCheckEffectPos(entityID, currentPos, targetPos, entityViewRootPos)
  local change = false
  if self._currentPos[entityID] ~= currentPos or self._targetPos[entityID] ~= targetPos or self._entityViewRootPos[entityID] ~= entityViewRootPos then
    self._currentPos[entityID] = currentPos
    self._targetPos[entityID] = targetPos
    self._entityViewRootPos[entityID] = entityViewRootPos
    change = true
  end
  return change
end

function EffectLineRendererComponent:GetEffectLineRendererIsShow()
  if self._show then
    for i, v in pairs(self._show) do
      if v == true then
        return true
      end
    end
  end
  return false
end

function EffectLineRendererComponent:SetEffectLineRendererShow(entityID, show)
  if not self._show[entityID] then
    self._show[entityID] = {}
  end
  self._show[entityID] = show
end

function EffectLineRendererComponent:SetTargetRootOff(off)
  self._targetRootOff = off
end

function EffectLineRendererComponent:GetTargetRootOff()
  return self._targetRootOff
end

function EffectLineRendererComponent:SetCurrentRootOff(off)
  self._currentRootOff = off
end

function EffectLineRendererComponent:GetCurrentRootOff()
  return self._currentRootOff
end

function Entity:EffectLineRenderer()
  return self:GetComponent(self.WEComponentsEnum.EffectLineRenderer)
end

function Entity:HasEffectLineRenderer()
  return self:HasComponent(self.WEComponentsEnum.EffectLineRenderer)
end

function Entity:AddEffectLineRenderer()
  local index = self.WEComponentsEnum.EffectLineRenderer
  local component = EffectLineRendererComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceEffectLineRenderer()
  local index = self.WEComponentsEnum.EffectLineRenderer
  local component = EffectLineRendererComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveEffectLineRenderer()
  if self:HasEffectLineRenderer() then
    self:RemoveComponent(self.WEComponentsEnum.EffectLineRenderer)
  end
end
