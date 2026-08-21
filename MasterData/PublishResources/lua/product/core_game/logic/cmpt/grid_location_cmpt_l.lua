_class("GridLocationComponent", Object)
GridLocationComponent = GridLocationComponent

function GridLocationComponent:Constructor(pos, dir, offset, height, damageOffset)
  self.Position = self:_InitVectorData(pos) or Vector2(1, 1)
  self.Direction = self:_InitVectorData(dir) or Vector2(0, 0)
  self.Offset = self:_InitVectorData(offset) or Vector2(0, 0)
  self.Height = height or 0
  self.DamageOffset = damageOffset or offset
  self._moveLastPosition = Vector2(0, 0)
  self._modifyLocationCallback = nil
end

function GridLocationComponent:InitByGridLocResult(gridLocRes)
  self.Position = gridLocRes:GetGridLocResultBornPos()
  self.Direction = gridLocRes:GetGridLocResultBornDir()
  self.Offset = gridLocRes:GetGridLocResultBornOffset()
  self.Height = gridLocRes:GetGridLocResultBornHeight()
  self.DamageOffset = gridLocRes:GetGridLocResultDamageOffset()
end

function GridLocationComponent:_InitVectorData(data)
  if data then
    return Vector2.New(data.x, data.y)
  end
end

function GridLocationComponent:Destructor()
  self.Position = nil
  self.Direction = nil
  self.Offset = nil
  self.Height = 0
  self.DamageOffset = nil
  self._modifyLocationCallback = nil
end

function GridLocationComponent:GetGridPos()
  return self.Position
end

function GridLocationComponent:GetGridDir()
  return Vector2.New(math.floor(self.Direction.x), math.floor(self.Direction.y))
end

function GridLocationComponent:GetRawGridDir()
  return self.Direction:Clone()
end

function GridLocationComponent:GetGridOffset()
  return self.Offset or Vector2.zero
end

function GridLocationComponent:SetMoveLastPosition(pos)
  self._moveLastPosition = pos
end

function GridLocationComponent:GetMoveLastPosition()
  return self._moveLastPosition
end

function GridLocationComponent:Center()
  local entityPos = self.Position
  local entityOffset = self.Offset or Vector2.zero
  return entityPos + entityOffset
end

function GridLocationComponent:CenterNoOffset()
  local entityPos = self.Position
  local entityOffset = self.Offset or Vector2.zero
  return entityPos
end

function GridLocationComponent:DamageCenter()
  local entityPos = self:_InitVectorData(self.Position)
  local entityOffset = self:_InitVectorData(self.DamageOffset) or Vector2.zero
  return entityPos + entityOffset
end

function GridLocationComponent:GetDamageOffset()
  local entityOffset = self:_InitVectorData(self.DamageOffset) or Vector2.zero
  return entityOffset
end

function GridLocationComponent:SetGridPosCmpt(pos)
  if pos.x == 0 and pos.y == 0 and self._entity:HasTeam() then
    Log.fatal("SetGridPos :", tostring(pos), " entity=", self._entity:GetID(), " ", Log.traceback())
  end
  self.Position = self:_InitVectorData(pos)
  self:CallBackModify()
end

function GridLocationComponent:GetGridLocHeight()
  return self.Height
end

function GridLocationComponent:SetModifyLocationCallback(callback)
  self._modifyLocationCallback = callback
end

function GridLocationComponent:CallBackModify()
  if self._modifyLocationCallback then
    self._modifyLocationCallback(self:GetGridPos(), self:GetGridDir())
  end
end

function GridLocationComponent:CallBackModifyLocation(pos, dir)
  self.Position.x = pos.x
  self.Position.y = pos.y
  self.Direction = dir
end

function Entity:GridLocation()
  return self:GetComponent(self.WEComponentsEnum.GridLocation)
end

function Entity:HasGridLocation()
  return self:HasComponent(self.WEComponentsEnum.GridLocation)
end

function Entity:SetGridLocation(pos, dir)
  if pos ~= nil and (pos.x == nil or pos.y == nil) then
    Log.error("SetGridLocation error pos param")
    Log.error(pos.x, pos.y)
  else
  end
  if dir ~= nil and (dir.x == nil or dir.y == nil) then
    Log.error("SetGridLocation error dir param")
    Log.error(dir.x, dir.y)
  else
  end
  local index = self.WEComponentsEnum.GridLocation
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    self:GetOwnerWorld():GetService("Battle"):RemoveMonsterAuraRange(self)
    if pos then
      cmpt:SetGridPosCmpt(pos)
    end
    if dir then
      cmpt.Direction = dir
    end
    cmpt:CallBackModify()
    self:GetOwnerWorld():GetService("Battle"):AddMonsterAuraRange(self)
    self:ReplaceComponent(index, cmpt)
  else
    local component = GridLocationComponent:New(pos, dir)
    self:ReplaceComponent(index, component)
  end
end

function Entity:CloneOffsetAndDamageOffset(cloneTargetEntity)
  local cCloneGridLocation = cloneTargetEntity:GridLocation()
  if not cCloneGridLocation then
    return
  end
  local offset = cCloneGridLocation.Offset
  local damageOffset = cCloneGridLocation.DamageOffset
  offset = offset and offset:Clone()
  damageOffset = damageOffset and damageOffset:Clone()
  local cSelfGridLocation = self:GridLocation()
  cSelfGridLocation.Offset = offset
  cSelfGridLocation.DamageOffset = damageOffset
end

function Entity:SetGridLocationAndOffset(pos, dir, offset, damageOffset, notRefreshAura)
  local index = self.WEComponentsEnum.GridLocation
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    if not notRefreshAura then
      self:GetOwnerWorld():GetService("Battle"):RemoveMonsterAuraRange(self)
    end
    cmpt:SetGridPosCmpt(pos)
    cmpt.Direction = dir
    cmpt.Offset = offset
    cmpt.DamageOffset = damageOffset
    cmpt:CallBackModify()
    if not notRefreshAura then
      self:GetOwnerWorld():GetService("Battle"):AddMonsterAuraRange(self)
    end
    self:ReplaceComponent(index, cmpt)
  else
    local component = GridLocationComponent:New(pos, dir, offset, damageOffset)
    self:ReplaceComponent(index, component)
  end
end

function Entity:SetGridPosition(pos)
  local index = self.WEComponentsEnum.GridLocation
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    self:GetOwnerWorld():GetService("Battle"):RemoveMonsterAuraRange(self)
    cmpt:SetGridPosCmpt(pos)
    self:GetOwnerWorld():GetService("Battle"):AddMonsterAuraRange(self)
    self:ReplaceComponent(index, cmpt)
  else
    self:SetGridLocation(pos, nil)
  end
end

function Entity:GetGridPosition()
  local posReturn
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    posReturn = cmpt:GetGridPos()
  end
  return posReturn
end

function Entity:GetGridOffset()
  local offSet
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    offSet = cmpt:GetGridOffset()
  end
  return offSet
end

function Entity:GetGridHeight()
  local height
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    height = cmpt.Height
  end
  return height
end

function Entity:GetGridDirection()
  local dirReturn
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    dirReturn = cmpt:GetGridDir()
  end
  return dirReturn
end

function Entity:SetGridDirection(dir)
  local index = self.WEComponentsEnum.GridLocation
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    cmpt.Direction = dir
    cmpt:CallBackModify()
    self:ReplaceComponent(index, cmpt)
  else
    self:SetGridLocation(nil, dir)
  end
end

function Entity:SetGridOffset(offset)
  local index = self.WEComponentsEnum.GridLocation
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    cmpt.Offset = offset
    self:ReplaceComponent(index, cmpt)
  else
    local component = GridLocationComponent:New(nil, nil, offset)
    self:ReplaceComponent(index, component)
  end
end

function Entity:SetGridOffsetAndDamageOffset(gridOffset, damageOffset)
  local index = self.WEComponentsEnum.GridLocation
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    cmpt.Offset = gridOffset
    cmpt.DamageOffset = damageOffset
    self:ReplaceComponent(index, cmpt)
  else
    local component = GridLocationComponent:New(nil, nil, gridOffset, nil, damageOffset)
    self:ReplaceComponent(index, component)
  end
end

function Entity:SetGridHeight(height)
  local index = self.WEComponentsEnum.GridLocation
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    cmpt.Height = height
    self:ReplaceComponent(index, cmpt)
  else
    local component = GridLocationComponent:New(nil, nil, nil, height)
    self:ReplaceComponent(index, component)
  end
end

function Entity:IsOnGridPosition(pos)
  if not self:HasGridLocation() then
    return false
  end
  if self:HasOutsideRegion() then
    return false
  end
  if self:HasOffBoardMonster() then
    return false
  end
  local entityPos = self:GridLocation().Position
  if self:HasBodyArea() then
    local bodyArea = self:BodyArea()._area
    for i = 1, #bodyArea do
      local bodyPos = entityPos + bodyArea[i]
      if bodyPos == pos then
        return true
      end
    end
    local previewArea = self:BodyArea():GetPreviewArea()
    if previewArea and table.count(previewArea) > 0 then
      for i = 1, #previewArea do
        local bodyPos = entityPos + previewArea[i]
        if bodyPos == pos then
          return true
        end
      end
    end
    return false
  else
    return pos == entityPos
  end
end
