_class("RenderPickUpComponent", Object)
RenderPickUpComponent = RenderPickUpComponent

function RenderPickUpComponent:Constructor()
  self._previewContextList = {}
  self._multiPickUpGridPosList = {}
  self._lastPickUpGridPos = nil
  self._skillEffectScopeResultList = {}
  self._pickUpDirection = {}
  self._lastPickUpDirection = nil
  self._pickUpEffectEntityIDs = {}
  self._directionPickupPos = {}
  self._reflectDir = nil
  self._pickUpExtraParamList = {}
  self._ignorePickCheck = false
end

function RenderPickUpComponent:Clear()
  self._previewContextList = {}
  self._lastPickUpGridPos = nil
  self._skillEffectScopeResultList = {}
  self._pickUpDirection = {}
  self._pickUpEffectEntityIDs = {}
  self._directionPickupPos = {}
  self._reflectDir = nil
  self._pickUpExtraParamList = {}
  self._ignorePickCheck = false
end

function RenderPickUpComponent:SetPreviewContext(id, context)
  self._previewContextList[id] = context
end

function RenderPickUpComponent:GetPreviewContext(id)
  for _id, context in pairs(self._previewContextList) do
    if _id == id then
      return context
    end
  end
  return nil
end

function RenderPickUpComponent:SetSkillEffectScope(effectType, scopeResult)
  self._skillEffectScopeResultList[effectType] = scopeResult
end

function RenderPickUpComponent:GetSkillEffectScope(effectType)
  for _effectType, scopeResult in pairs(self._skillEffectScopeResultList) do
    if _effectType == effectType then
      return scopeResult
    end
  end
  return nil
end

function RenderPickUpComponent:AddGridPosList(gridList)
  for _, pos in ipairs(gridList) do
    self:AddGridPos(pos)
  end
end

function RenderPickUpComponent:AddGridPos(pickUpGridPos)
  table.insert(self._multiPickUpGridPosList, pickUpGridPos)
  self._lastPickUpGridPos = pickUpGridPos
end

function RenderPickUpComponent:RemoveGridPos(pickUpGridPos)
  table.removev(self._multiPickUpGridPosList, pickUpGridPos)
  if self._lastPickUpGridPos == pickUpGridPos then
    self._lastPickUpGridPos = self._multiPickUpGridPosList[#self._multiPickUpGridPosList]
  end
end

function RenderPickUpComponent:ClearGridPos()
  self._multiPickUpGridPosList = {}
  self._lastPickUpGridPos = nil
end

function RenderPickUpComponent:AddPickExtraParamList(extraParamList)
  if extraParamList then
    for _, param in ipairs(extraParamList) do
      self:AddPickExtraParam(param)
    end
  end
end

function RenderPickUpComponent:AddPickExtraParam(extraParam)
  table.insert(self._pickUpExtraParamList, extraParam)
end

function RenderPickUpComponent:RemovePickExtraParam(extraParam)
  table.removev(self._pickUpExtraParamList, extraParam)
end

function RenderPickUpComponent:ClearPickExtraParam()
  self._pickUpExtraParamList = {}
end

function RenderPickUpComponent:GetAllPickExtraParam()
  return self._pickUpExtraParamList
end

function RenderPickUpComponent:HasPickExtraParam(param)
  if table.icontains(self._pickUpExtraParamList, param) then
    return true
  end
  return false
end

function RenderPickUpComponent:AddDirectionList(directionPickupPos, pickUpDirection, lastPickUpDirection)
  self._directionPickupPos = directionPickupPos
  self._pickUpDirection = pickUpDirection
  self._lastPickUpDirection = lastPickUpDirection
end

function RenderPickUpComponent:AddDirection(direction, pickUpGridPos)
  table.insert(self._pickUpDirection, direction)
  self._lastPickUpDirection = direction
  self._directionPickupPos[direction] = pickUpGridPos
end

function RenderPickUpComponent:RemoveDirection(direction)
  table.removev(self._pickUpDirection, direction)
  if self._lastPickUpDirection == direction then
    self._lastPickUpDirection = self._pickUpDirection[#self._pickUpDirection]
  end
  local pos = self._directionPickupPos[direction]
  if pos then
    self:RemoveGridPos(pos)
    self._directionPickupPos[direction] = nil
  end
end

function RenderPickUpComponent:IsRepeatDirection(direction)
  if table.icontains(self._pickUpDirection, direction) then
    return true
  end
  return false
end

function RenderPickUpComponent:ClearDirection()
  self._pickUpDirection = {}
  self._lastPickUpDirection = nil
  self._directionPickupPos = {}
end

function RenderPickUpComponent:GetAllDirection()
  return self._pickUpDirection
end

function RenderPickUpComponent:GetLastPickDirectionAndPickPos()
  return self._lastPickUpDirection, self._directionPickupPos[self._lastPickUpDirection]
end

function RenderPickUpComponent:GetPickUpDirectionPos()
  return self._directionPickupPos
end

function RenderPickUpComponent:GetLastPickUpDirection()
  return self._lastPickUpDirection
end

function RenderPickUpComponent:IsRepeatPickUP(pickUpGridPos)
  return table.icontains(self._multiPickUpGridPosList, pickUpGridPos)
end

function RenderPickUpComponent:GetLastPickUpGridPos()
  return self._lastPickUpGridPos
end

function RenderPickUpComponent:GetAllValidPickUpGridPos()
  return self._multiPickUpGridPosList
end

function RenderPickUpComponent:GetAllValidPickUpGridPosCount()
  return #self._multiPickUpGridPosList
end

function RenderPickUpComponent:AddPickUpEffectEntityID(id)
  table.insert(self._pickUpEffectEntityIDs, id)
end

function RenderPickUpComponent:GetPickUpEffectEntityIDArray()
  return self._pickUpEffectEntityIDs
end

function RenderPickUpComponent:GetFirstValidPickUpGridPos()
  if #self._multiPickUpGridPosList >= 1 then
    return self._multiPickUpGridPosList[1]
  else
    Log.fatal("No PickUpGridPos Data")
    return nil
  end
end

function RenderPickUpComponent:SetReflectDir(dir)
  self._reflectDir = dir
end

function RenderPickUpComponent:GetReflectDir()
  return self._reflectDir or ReflectDirectionType.Heng
end

function RenderPickUpComponent:SetReflectPos(pos)
  self._reflectPos = pos
end

function RenderPickUpComponent:GetReflectPos()
  return self._reflectPos
end

function RenderPickUpComponent:GetRotateGhost()
  return self._rotateGhost
end

function RenderPickUpComponent:SetRotateGhost(ghost)
  self._rotateGhost = ghost
end

function RenderPickUpComponent:IsIgnorePickCheck()
  return self._ignorePickCheck
end

function RenderPickUpComponent:SetIgnorePickCheck(ignorePickCheck)
  self._ignorePickCheck = ignorePickCheck
end

function Entity:RenderPickUpComponent()
  return self:ActiveSkillPickUpComponent()
end

function Entity:HasRenderPickUpComponent()
  return self:HasActiveSkillPickUpComponent()
end

function Entity:AddRenderPickUpComponent()
  self:AddActiveSkillPickUpComponent()
end

function Entity:ReplaceRenderPickUpComponent()
  self:ReplaceActiveSkillPickUpComponent()
end

function Entity:RemoveRenderPickUpComponent()
end
