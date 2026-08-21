_class("PreviewPickUpComponent", Object)
PreviewPickUpComponent = PreviewPickUpComponent

function PreviewPickUpComponent:Constructor()
  self._previewContextList = {}
  self._multiPickUpGridPosList = {}
  self._lastPickUpGridPos = nil
  self._skillEffectScopeResultList = {}
  self._pickUpDirection = {}
  self._lastPickUpDirection = nil
  self._pickUpEffectEntityIDs = {}
  self._pickUpEffectEntityIDsByEffectID = {}
  self._directionPickupPos = {}
  self._reflectDir = nil
  self._pickUpExtraParamList = {}
  self._ignorePickCheck = false
  self._pickUpPetPstID = nil
end

function PreviewPickUpComponent:Clear()
  self._previewContextList = {}
  self._lastPickUpGridPos = nil
  self._skillEffectScopeResultList = {}
  self._pickUpDirection = {}
  self._pickUpEffectEntityIDs = {}
  self._pickUpEffectEntityIDsByEffectID = {}
  self._directionPickupPos = {}
  self._reflectDir = nil
  self._pickUpExtraParamList = {}
  self._ignorePickCheck = false
  self._pickUpPetPstID = nil
end

function PreviewPickUpComponent:SetPreviewContext(id, context)
  self._previewContextList[id] = context
end

function PreviewPickUpComponent:GetPreviewContext(id)
  for _id, context in pairs(self._previewContextList) do
    if _id == id then
      return context
    end
  end
  return nil
end

function PreviewPickUpComponent:SetSkillEffectScope(effectType, scopeResult)
  self._skillEffectScopeResultList[effectType] = scopeResult
end

function PreviewPickUpComponent:GetSkillEffectScope(effectType)
  for _effectType, scopeResult in pairs(self._skillEffectScopeResultList) do
    if _effectType == effectType then
      return scopeResult
    end
  end
  return nil
end

function PreviewPickUpComponent:AddGridPosList(gridList)
  for _, pos in ipairs(gridList) do
    self:AddGridPos(pos)
  end
end

function PreviewPickUpComponent:AddGridPos(pickUpGridPos)
  table.insert(self._multiPickUpGridPosList, pickUpGridPos)
  self._lastPickUpGridPos = pickUpGridPos
end

function PreviewPickUpComponent:RemoveGridPos(pickUpGridPos)
  table.removev(self._multiPickUpGridPosList, pickUpGridPos)
  if self._lastPickUpGridPos == pickUpGridPos then
    self._lastPickUpGridPos = self._multiPickUpGridPosList[#self._multiPickUpGridPosList]
  end
end

function PreviewPickUpComponent:ClearGridPos()
  self._multiPickUpGridPosList = {}
  self._lastPickUpGridPos = nil
end

function PreviewPickUpComponent:AddPickExtraParamList(extraParamList)
  if extraParamList then
    for _, param in ipairs(extraParamList) do
      self:AddPickExtraParam(param)
    end
  end
end

function PreviewPickUpComponent:AddPickExtraParam(extraParam)
  table.insert(self._pickUpExtraParamList, extraParam)
end

function PreviewPickUpComponent:RemovePickExtraParam(extraParam)
  table.removev(self._pickUpExtraParamList, extraParam)
end

function PreviewPickUpComponent:ClearPickExtraParam()
  self._pickUpExtraParamList = {}
end

function PreviewPickUpComponent:GetAllPickExtraParam()
  return self._pickUpExtraParamList
end

function PreviewPickUpComponent:HasPickExtraParam(param)
  if table.icontains(self._pickUpExtraParamList, param) then
    return true
  end
  return false
end

function PreviewPickUpComponent:AddDirectionList(directionPickupPos, pickUpDirection, lastPickUpDirection)
  self._directionPickupPos = directionPickupPos
  self._pickUpDirection = pickUpDirection
  self._lastPickUpDirection = lastPickUpDirection
end

function PreviewPickUpComponent:AddDirection(direction, pickUpGridPos)
  table.insert(self._pickUpDirection, direction)
  self._lastPickUpDirection = direction
  self._directionPickupPos[direction] = pickUpGridPos
end

function PreviewPickUpComponent:RemoveDirection(direction)
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

function PreviewPickUpComponent:IsRepeatDirection(direction)
  if table.icontains(self._pickUpDirection, direction) then
    return true
  end
  return false
end

function PreviewPickUpComponent:ClearDirection()
  self._pickUpDirection = {}
  self._lastPickUpDirection = nil
  self._directionPickupPos = {}
end

function PreviewPickUpComponent:GetAllDirection()
  return self._pickUpDirection
end

function PreviewPickUpComponent:GetLastPickDirectionAndPickPos()
  return self._lastPickUpDirection, self._directionPickupPos[self._lastPickUpDirection]
end

function PreviewPickUpComponent:GetPickUpDirectionPos()
  return self._directionPickupPos
end

function PreviewPickUpComponent:GetLastPickUpDirection()
  return self._lastPickUpDirection
end

function PreviewPickUpComponent:IsRepeatPickUP(pickUpGridPos)
  return table.icontains(self._multiPickUpGridPosList, pickUpGridPos)
end

function PreviewPickUpComponent:GetLastPickUpGridPos()
  return self._lastPickUpGridPos
end

function PreviewPickUpComponent:GetAllValidPickUpGridPos()
  return self._multiPickUpGridPosList
end

function PreviewPickUpComponent:GetAllValidPickUpGridPosCount()
  return #self._multiPickUpGridPosList
end

function PreviewPickUpComponent:AddPickUpEffectEntityID(id, effectID)
  table.insert(self._pickUpEffectEntityIDs, id)
  if not self._pickUpEffectEntityIDsByEffectID[effectID] then
    self._pickUpEffectEntityIDsByEffectID[effectID] = {}
  end
  table.insert(self._pickUpEffectEntityIDsByEffectID[effectID], id)
end

function PreviewPickUpComponent:GetPickUpEffectEntityIDArrayByEffectID(effectID)
  return self._pickUpEffectEntityIDsByEffectID[effectID] or {}
end

function PreviewPickUpComponent:GetPickUpEffectEntityIDArray()
  return self._pickUpEffectEntityIDs
end

function PreviewPickUpComponent:GetFirstValidPickUpGridPos()
  if #self._multiPickUpGridPosList >= 1 then
    return self._multiPickUpGridPosList[1]
  else
    Log.fatal("No PickUpGridPos Data")
    return nil
  end
end

function PreviewPickUpComponent:SetReflectDir(dir)
  self._reflectDir = dir
end

function PreviewPickUpComponent:GetReflectDir()
  return self._reflectDir or ReflectDirectionType.Heng
end

function PreviewPickUpComponent:SetReflectPos(pos)
  self._reflectPos = pos
end

function PreviewPickUpComponent:GetReflectPos()
  return self._reflectPos
end

function PreviewPickUpComponent:GetRotateGhost()
  return self._rotateGhost
end

function PreviewPickUpComponent:SetRotateGhost(ghost)
  self._rotateGhost = ghost
end

function PreviewPickUpComponent:IsIgnorePickCheck()
  return self._ignorePickCheck
end

function PreviewPickUpComponent:SetIgnorePickCheck(ignorePickCheck)
  self._ignorePickCheck = ignorePickCheck
end

function PreviewPickUpComponent:SetPickUpPetPstID(petPstID)
  self._pickUpPetPstID = petPstID
end

function PreviewPickUpComponent:GetPickUpPetPstID()
  return self._pickUpPetPstID
end

function PreviewPickUpComponent:SetTetrisDirIndex(index)
  self._tetrisDirIndex = index
end

function PreviewPickUpComponent:GetTetrisDirIndex()
  return self._tetrisDirIndex
end

function Entity:PreviewPickUpComponent()
  return self:ActiveSkillPickUpComponent()
end

function Entity:HasPreviewPickUpComponent()
  return self:HasActiveSkillPickUpComponent()
end

function Entity:AddPreviewPickUpComponent()
  self:AddActiveSkillPickUpComponent()
end

function Entity:ReplacePreviewPickUpComponent()
  self:ReplaceActiveSkillPickUpComponent()
end

function Entity:RemovePreviewPickUpComponent()
  self:RemoveActiveSkillPickUpComponent()
end
