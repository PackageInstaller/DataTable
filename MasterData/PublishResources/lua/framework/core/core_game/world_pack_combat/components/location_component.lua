_class("LocationComponent", Object)
LocationComponent = LocationComponent

function LocationComponent:Constructor(pos, dir)
  self.Position = pos or Vector3(0, 0, 0)
  self.Direction = dir or Vector3(0, 0, 1)
  self.Scale = Vector3(1, 1, 1)
  self.height = 0
  self._modifyLocationCallback = nil
  self._syncToHPBar = true
end

function LocationComponent:SetPosition(pos)
  self.Position = pos
  self:CallBackModify()
end

function LocationComponent:SetDirection(dir)
  self.Direction = dir
  self:CallBackModify()
end

function LocationComponent:GetPosition()
  return self.Position:Clone()
end

function LocationComponent:GetDirection()
  return self.Direction:Clone()
end

function LocationComponent:GetScale()
  return self.Scale:Clone()
end

function LocationComponent:GetRenderGridDirection()
  local dir = self:GetDirection()
  return Vector2(math.floor(dir.x), math.floor(dir.z))
end

function LocationComponent:Height()
  return self.height
end

function LocationComponent:SetModifyLocationCallback(callback)
  self._modifyLocationCallback = callback
end

function LocationComponent:CallBackModify()
  if self._modifyLocationCallback then
    self._modifyLocationCallback(self:GetPosition(), self:GetDirection())
  end
end

function LocationComponent:CallBackModifyLocation(pos, dir, entity)
  self.Position.x = pos.x
  self.Position.z = pos.z
  self.Direction = dir
  self:SyncLocation(entity)
end

function LocationComponent:SyncLocation(entity)
  if self.tranRenderSvc == nil then
    local world = entity:GetOwnerWorld()
    self.tranRenderSvc = world:GetService("TransformRenderer")
  end
  self.tranRenderSvc:SimpleSyncLocation(entity)
end

function LocationComponent:SetSyncToHPBarState(state)
  self._syncToHPBar = state
end

function LocationComponent:IsSyncToHPBar()
  return self._syncToHPBar
end

function Entity:Location()
  return self:GetComponent(self.WEComponentsEnum.Location)
end

function Entity:HasLocation()
  return self:HasComponent(self.WEComponentsEnum.Location)
end

function Entity:RemoveLocation()
  if self:HasLocation() then
    self:RemoveComponent(self.WEComponentsEnum.Location)
  end
end

function Entity:GetPosition()
  if self:HasLocation() then
    local cmpt = self:Location()
    return cmpt:GetPosition()
  end
  return nil
end

function Entity:GetDirection()
  if self:HasLocation() then
    local cmpt = self:Location()
    return cmpt:GetDirection()
  end
  return nil
end

function Entity:GetRenderGridDirection()
  if self:HasLocation() then
    local cmpt = self:Location()
    return cmpt:GetRenderGridDirection()
  end
  return nil
end

function Entity:GetRenderGridPosition()
  if self:HasLocation() then
    local boardServiceRender = self:GetOwnerWorld():GetService("BoardRender")
    return boardServiceRender:GetEntityRealTimeGridPos(self)
  end
  return nil
end

function Entity:SetLocation(pos, dir, forceDirection)
  local logicPos = pos
  local logicDir = dir
  local boardServiceRender = self:GetOwnerWorld():GetService("BoardRender")
  pos = boardServiceRender:GridPosition2LocationPos(pos, self)
  if not forceDirection or dir._className ~= "Vector3" then
    dir = boardServiceRender:GridDir2LocationDir(dir)
  end
  local locationCmp
  local index = self.WEComponentsEnum.Location
  if self:HasLocation() then
    locationCmp = self:Location()
    locationCmp.Position = pos or locationCmp.Position
    locationCmp.Direction = dir or locationCmp.Direction
    locationCmp:CallBackModify()
  else
    locationCmp = LocationComponent:New(pos, dir)
    self:ReplaceComponent(index, locationCmp)
  end
  locationCmp:SyncLocation(self)
end

function Entity:SetPosition(pos)
  local boardServiceRender = self:GetOwnerWorld():GetService("BoardRender")
  pos = boardServiceRender:GridPosition2LocationPos(pos, self)
  if not pos then
    Log.fatal("SetPosition Invalid ", Log.traceback())
    return
  end
  local locationCmp
  local index = self.WEComponentsEnum.Location
  if self:HasLocation() then
    locationCmp = self:Location()
    locationCmp:SetPosition(pos)
  else
    locationCmp = LocationComponent:New(pos, nil)
    self:ReplaceComponent(index, locationCmp)
  end
  locationCmp:SyncLocation(self)
end

function Entity:SetDirection(dir, offset)
  local BoardServiceRender = self:GetOwnerWorld():GetService("BoardRender")
  dir = BoardServiceRender:GridDir2LocationDir(dir)
  if not dir then
    return
  end
  if offset then
    dir.y = dir.y + offset
  end
  local locationCmp
  local index = self.WEComponentsEnum.Location
  if self:HasLocation() then
    locationCmp = self:Location()
    locationCmp:SetDirection(dir)
    self:ReplaceComponent(index, locationCmp)
  else
    locationCmp = LocationComponent:New(nil, dir)
    self:ReplaceComponent(index, locationCmp)
  end
  locationCmp:SyncLocation(self)
end

function Entity:SetScale(scale)
  if scale and scale._className ~= "Vector3" then
    Log.fatal("Param Invalid ", Log.traceback())
    return
  end
  local locationCmp
  local index = self.WEComponentsEnum.Location
  if self:HasLocation() then
    locationCmp = self:Location()
    locationCmp.Scale = scale
    self:ReplaceComponent(index, locationCmp)
  else
    locationCmp = LocationComponent:New()
    locationCmp.Scale = scale
    self:ReplaceComponent(index, locationCmp)
  end
  locationCmp:SyncLocation(self)
end

function Entity:SetLocationHeight(height)
  local locationCmp
  local index = self.WEComponentsEnum.Location
  if self:HasLocation() then
    locationCmp = self:Location()
    locationCmp.height = height
    locationCmp.Position.y = height
    self:ReplaceComponent(index, locationCmp)
  else
    locationCmp = LocationComponent:New(nil, nil)
    locationCmp.height = height
    self:ReplaceComponent(index, locationCmp)
  end
  locationCmp:SyncLocation(self)
end

function Entity:GetDamageCenter()
  local posReturn
  if self:HasGridLocation() then
    local cmpt = self:GridLocation()
    local posOffSet = cmpt:GetDamageOffset()
    local entityGridPos = self:GetRenderGridPosition()
    if entityGridPos and posOffSet then
      posReturn = entityGridPos + posOffSet
    end
  end
  return posReturn
end
