_class("FurnitureModifier", Object)
FurnitureModifier = FurnitureModifier

function FurnitureModifier:Constructor(area, sur, fur, newAdd)
  self._area = area
  self._surface = sur
  self._furniture = fur
  self._furID = self._furniture:InstanceID()
  self._isDirty = false
  self._firstPickup = true
  self._pickUp = false
  self._gridPos = self._furniture:GridPosition()
  self._rotY = self._furniture:GridRotY()
  self._deleted = false
  self._newAdd = newAdd
  if newAdd then
    self._isDirty = true
  end
  self._worldPosition = self._furniture:WorldPosition()
  self._worldRotation = self._furniture:WorldRotation()
  self._originGridPos = self._gridPos:Clone()
  self._originRotY = self._rotY
  self._originSurface = sur
  self._originWorldPos = self._worldPosition:Clone()
  self._originWorldRot = self._worldRotation:Clone()
end

function FurnitureModifier:Furniture()
  return self._furniture
end

function FurnitureModifier:Surface()
  return self._surface
end

function FurnitureModifier:Area()
  return self._area
end

function FurnitureModifier:ID()
  return self._furID
end

function FurnitureModifier:IsDirty()
  return self._isDirty
end

function FurnitureModifier:WorldPostion()
  return self._worldPosition
end

function FurnitureModifier:WorldRotation()
  return self._worldRotation
end

function FurnitureModifier:GridPosition()
  return self._gridPos
end

function FurnitureModifier:RotY()
  return self._rotY
end

function FurnitureModifier:GetSaveData()
  if self._isDirty then
    if self._deleted then
      return nil
    end
    local data = MobileFurnitureInfo:New()
    data.asset_id = self._furniture:CfgID()
    data.area_id = self._area
    data.surface = self._surface:ID()
    data.pos_x = GridHelper.ToInt(self._gridPos.x)
    data.pos_z = GridHelper.ToInt(self._gridPos.y)
    data.rot = math.floor(self._rotY)
    return data
  else
    return self._furniture:GetSvrData()
  end
end

function FurnitureModifier:GetGrids()
  return self._grids
end

function FurnitureModifier:ChangedAmbient()
  if self._newAdd then
    if self._deleted then
      return 0
    end
    return self._furniture:Ambient()
  end
  if self._deleted then
    return -self._furniture:Ambient()
  end
  return 0
end

function FurnitureModifier:PickUp()
  self._pickUp = true
  self._pickUpOffset = self._furniture._transform.up * GridHelper.PICKUPHEIGHT
  self._furniture:SetPosition(self._worldPosition + self._pickUpOffset)
  self._validPos = self._gridPos:Clone()
  self._validRotY = self._rotY
  self._validSurface = self._surface
  self._validWorldPos = self._worldPosition:Clone()
  self._validWorldRot = self._worldRotation:Clone()
  if self._firstPickup then
    self._firstPickup = false
    self._grids = GridHelper.FurnitureOccupyGrids(self._furniture, self._gridPos, self._rotY)
  end
  self._furniture:OccupyTiles(false)
  self._isValid = true
end

function FurnitureModifier:SetValidWhenPickup(valid)
  self._isValid = valid
end

function FurnitureModifier:DropDown(shake)
  self._pickUp = false
  if self._isValid then
    self._furniture:SetPosition(self._worldPosition)
  else
    self._gridPos = self._validPos
    self._rotY = self._validRotY
    self._surface = self._validSurface
    self._worldPosition = self._validWorldPos
    self._worldRotation = self._validWorldRot
    self._grids = GridHelper.FurnitureOccupyGrids(self._furniture, self._gridPos, self._rotY)
    if shake then
      self._furniture:DoShake(function()
        self._furniture:SetPosition(self._worldPosition)
        self._furniture:SetRotation(self._worldRotation)
      end)
    else
      self._furniture:SetPosition(self._worldPosition)
      self._furniture:SetRotation(self._worldRotation)
    end
  end
  local tiles = self._surface:Tiles()
  local layer = self._furniture:Layer()
  local otiles = {}
  for _, pos in ipairs(self._grids) do
    local tile
    if tiles[pos.x] then
      tile = tiles[pos.x][pos.y]
    end
    if tile then
      otiles[#otiles + 1] = tile
    else
      Log.exception("找不到格子：", pos.x, ",", pos.y)
    end
  end
  self._furniture:SetTiles(otiles)
  self._furniture:OccupyTiles(true)
end

function FurnitureModifier:ChangePos(gridPos, worldPos, grids, valid)
  self._isDirty = true
  if not self._pickUp then
    Log.exception("没有抬起，不能移动")
  end
  self._gridPos = gridPos
  self._worldPosition = worldPos
  self._grids = grids
  if self._isValid ~= valid then
  end
  self._isValid = valid
  self._furniture:SetPosition(worldPos + self._pickUpOffset)
end

function FurnitureModifier:ChangeRotY(y, worldRot, grids, valid)
  self._isDirty = true
  if not self._pickUp then
    Log.exception("没有抬起，不能移动")
  end
  self._rotY = y
  self._worldRotation = worldRot
  self._grids = grids
  if self._isValid ~= valid then
  end
  self._isValid = valid
  self._furniture:SetRotation(worldRot)
end

function FurnitureModifier:ChangeSurface(sur)
  self._isDirty = true
  if self._surface:ID() == sur:ID() then
    Log.exception("面id未改变")
  end
  self._surface = sur
end

function FurnitureModifier:IsDeleted()
  return self._deleted
end

function FurnitureModifier:Delete()
  if self._deleted then
    return
  end
  self._isDirty = true
  self._deleted = true
  self._furniture:SetActive(false)
  self._furniture:OccupyTiles(false)
end

function FurnitureModifier:Revert()
  if not self._isDirty then
    return
  end
  if self._pickUp then
    self:DropDown(false)
  elseif not self._originWorldPos:Equals(self._worldPosition) or not self._originWorldRot:Equals(self._worldRotation) then
    if not self._deleted then
      self._furniture:OccupyTiles(false)
    end
    local grids = GridHelper.FurnitureOccupyGrids(self._furniture, self._originGridPos, self._originRotY)
    local tiles = self._originSurface:Tiles()
    local otiles = {}
    for _, pos in ipairs(grids) do
      local tile
      if tiles[pos.x] then
        tile = tiles[pos.x][pos.y]
      end
      if tile then
        otiles[#otiles + 1] = tile
      else
        Log.exception("找不到格子：", pos.x, ",", pos.y)
      end
    end
    self._furniture:SetTiles(otiles)
    self._furniture:OccupyTiles(true)
  end
  if self._newAdd then
    self._furniture:Dispose()
    return
  end
  if self._deleted then
    self._furniture:SetActive(true)
    self._deleted = false
    self._furniture:OccupyTiles(true)
  end
  self._worldPosition = self._originWorldPos
  self._worldRotation = self._originWorldRot
  self._rotY = self._originRotY
  self._surface = self._originSurface
  self._gridPos = self._originGridPos
  self._furniture:SetPosition(self._worldPosition)
  self._furniture:SetRotation(self._worldRotation)
  self._isDirty = false
end

function FurnitureModifier:Dispose()
  if self._newAdd then
    self._furniture:Dispose()
  end
end

function FurnitureModifier:IsNewAdd()
  return self._newAdd
end
