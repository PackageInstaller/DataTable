_class("ActiveSkillPickUpComponent", Object)
ActiveSkillPickUpComponent = ActiveSkillPickUpComponent

function ActiveSkillPickUpComponent:Constructor()
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

function ActiveSkillPickUpComponent:Clear()
  self._previewContextList = {}
  self._lastPickUpGridPos = nil
  self._skillEffectScopeResultList = {}
  self._pickUpDirection = {}
  self._pickUpEffectEntityIDs = {}
  self._directionPickupPos = {}
  self._reflectDir = nil
  self._pickUpExtraParamList = {}
  self._ignorePickCheck = false
  self._pickUpPetPstID = nil
end

function ActiveSkillPickUpComponent:SetPreviewContext(id, context)
  self._previewContextList[id] = context
end

function ActiveSkillPickUpComponent:GetPreviewContext(id)
  for _id, context in pairs(self._previewContextList) do
    if _id == id then
      return context
    end
  end
  return nil
end

function ActiveSkillPickUpComponent:SetSkillEffectScope(effectType, scopeResult)
  self._skillEffectScopeResultList[effectType] = scopeResult
end

function ActiveSkillPickUpComponent:GetSkillEffectScope(effectType)
  for _effectType, scopeResult in pairs(self._skillEffectScopeResultList) do
    if _effectType == effectType then
      return scopeResult
    end
  end
  return nil
end

function ActiveSkillPickUpComponent:AddGridPosList(gridList)
  for _, pos in ipairs(gridList) do
    self:AddGridPos(pos)
  end
end

function ActiveSkillPickUpComponent:AddGridPos(pickUpGridPos)
  table.insert(self._multiPickUpGridPosList, pickUpGridPos)
  self._lastPickUpGridPos = pickUpGridPos
end

function ActiveSkillPickUpComponent:RemoveGridPos(pickUpGridPos)
  table.removev(self._multiPickUpGridPosList, pickUpGridPos)
  if self._lastPickUpGridPos == pickUpGridPos then
    self._lastPickUpGridPos = self._multiPickUpGridPosList[#self._multiPickUpGridPosList]
  end
end

function ActiveSkillPickUpComponent:ClearGridPos()
  self._multiPickUpGridPosList = {}
  self._lastPickUpGridPos = nil
end

function ActiveSkillPickUpComponent:AddPickExtraParamList(extraParamList)
  if extraParamList then
    for _, param in ipairs(extraParamList) do
      self:AddPickExtraParam(param)
    end
  end
end

function ActiveSkillPickUpComponent:AddPickExtraParam(extraParam)
  table.insert(self._pickUpExtraParamList, extraParam)
end

function ActiveSkillPickUpComponent:RemovePickExtraParam(extraParam)
  table.removev(self._pickUpExtraParamList, extraParam)
end

function ActiveSkillPickUpComponent:ClearPickExtraParam()
  self._pickUpExtraParamList = {}
end

function ActiveSkillPickUpComponent:GetAllPickExtraParam()
  return self._pickUpExtraParamList
end

function ActiveSkillPickUpComponent:HasPickExtraParam(param)
  if table.icontains(self._pickUpExtraParamList, param) then
    return true
  end
  return false
end

function ActiveSkillPickUpComponent:AddDirectionList(directionPickupPos, pickUpDirection, lastPickUpDirection)
  self._directionPickupPos = directionPickupPos
  self._pickUpDirection = pickUpDirection
  self._lastPickUpDirection = lastPickUpDirection
end

function ActiveSkillPickUpComponent:AddDirection(direction, pickUpGridPos)
  table.insert(self._pickUpDirection, direction)
  self._lastPickUpDirection = direction
  self._directionPickupPos[direction] = pickUpGridPos
end

function ActiveSkillPickUpComponent:RemoveDirection(direction)
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

function ActiveSkillPickUpComponent:IsRepeatDirection(direction)
  if table.icontains(self._pickUpDirection, direction) then
    return true
  end
  return false
end

function ActiveSkillPickUpComponent:ClearDirection()
  self._pickUpDirection = {}
  self._lastPickUpDirection = nil
  self._directionPickupPos = {}
end

function ActiveSkillPickUpComponent:GetAllDirection()
  return self._pickUpDirection
end

function ActiveSkillPickUpComponent:GetLastPickDirectionAndPickPos()
  return self._lastPickUpDirection, self._directionPickupPos[self._lastPickUpDirection]
end

function ActiveSkillPickUpComponent:GetPickUpDirectionPos()
  return self._directionPickupPos
end

function ActiveSkillPickUpComponent:GetLastPickUpDirection()
  return self._lastPickUpDirection
end

function ActiveSkillPickUpComponent:IsRepeatPickUP(pickUpGridPos)
  return table.icontains(self._multiPickUpGridPosList, pickUpGridPos)
end

function ActiveSkillPickUpComponent:GetLastPickUpGridPos()
  return self._lastPickUpGridPos
end

function ActiveSkillPickUpComponent:GetAllValidPickUpGridPos()
  return self._multiPickUpGridPosList
end

function ActiveSkillPickUpComponent:GetAllValidPickUpGridPosCount()
  return #self._multiPickUpGridPosList
end

function ActiveSkillPickUpComponent:AddPickUpEffectEntityID(id, effectID)
  table.insert(self._pickUpEffectEntityIDs, id)
  if effectID then
    if not self._pickUpEffectEntityIDsByEffectID[effectID] then
      self._pickUpEffectEntityIDsByEffectID[effectID] = {}
    end
    table.insert(self._pickUpEffectEntityIDsByEffectID[effectID], id)
  end
end

function ActiveSkillPickUpComponent:GetPickUpEffectEntityIDArrayByEffectID(effectID)
  return self._pickUpEffectEntityIDsByEffectID[effectID] or {}
end

function ActiveSkillPickUpComponent:GetPickUpEffectEntityIDArray()
  return self._pickUpEffectEntityIDs
end

function ActiveSkillPickUpComponent:ClearPickUpEffectEntityIDArray()
  self._pickUpEffectEntityIDs = {}
  self._pickUpEffectEntityIDsByEffectID = {}
end

function ActiveSkillPickUpComponent:GetFirstValidPickUpGridPos()
  if #self._multiPickUpGridPosList >= 1 then
    return self._multiPickUpGridPosList[1]
  else
    Log.fatal("No PickUpGridPos Data")
    return nil
  end
end

function ActiveSkillPickUpComponent:SetReflectDir(dir)
  self._reflectDir = dir
end

function ActiveSkillPickUpComponent:GetReflectDir()
  return self._reflectDir or ReflectDirectionType.Heng
end

function ActiveSkillPickUpComponent:SetReflectPos(pos)
  self._reflectPos = pos
end

function ActiveSkillPickUpComponent:GetReflectPos()
  return self._reflectPos
end

function ActiveSkillPickUpComponent:GetRotateGhost()
  return self._rotateGhost
end

function ActiveSkillPickUpComponent:SetRotateGhost(ghost)
  self._rotateGhost = ghost
end

function ActiveSkillPickUpComponent:IsIgnorePickCheck()
  return self._ignorePickCheck
end

function ActiveSkillPickUpComponent:SetIgnorePickCheck(ignorePickCheck)
  self._ignorePickCheck = ignorePickCheck
end

function ActiveSkillPickUpComponent:ClearPickUpPetPstID()
  self._pickUpPetPstID = nil
end

function ActiveSkillPickUpComponent:SetPickUpPetPstID(petPstID)
  self._pickUpPetPstID = petPstID
end

function ActiveSkillPickUpComponent:GetPickUpPetPstID()
  return self._pickUpPetPstID
end

function ActiveSkillPickUpComponent:SetTetrisDirIndex(index)
  self._tetrisDirIndex = index
end

function ActiveSkillPickUpComponent:GetTetrisDirIndex()
  return self._tetrisDirIndex
end

function Entity:ActiveSkillPickUpComponent()
  return self:GetComponent(self.WEComponentsEnum.ActiveSkillPickUp)
end

function Entity:HasActiveSkillPickUpComponent()
  return self:HasComponent(self.WEComponentsEnum.ActiveSkillPickUp)
end

function Entity:AddActiveSkillPickUpComponent()
  local index = self.WEComponentsEnum.ActiveSkillPickUp
  local component = ActiveSkillPickUpComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceActiveSkillPickUpComponent()
  local index = self.WEComponentsEnum.ActiveSkillPickUp
  local component = ActiveSkillPickUpComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveActiveSkillPickUpComponent()
  if self:HasActiveSkillPickUpComponent() then
    self:RemoveComponent(self.WEComponentsEnum.ActiveSkillPickUp)
  end
end
