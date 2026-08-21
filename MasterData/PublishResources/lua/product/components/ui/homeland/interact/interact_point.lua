local InteractPointType = {
  None = 0,
  Info = 1,
  Build = 2,
  PetCommunication = 3,
  CutTree = 4,
  Treasure = 5,
  TreasureBoard = 6,
  PetBuilding = 7,
  Wishing = 8,
  Raise = 9,
  Shop = 10,
  Breed = 11,
  EnterDomitory = 12,
  FindTreasure = 13,
  Mining = 14,
  Photo = 15,
  Storehouse = 16,
  FixBuilding = 17,
  TreeDye = 18,
  RoleInteract = 19,
  Album = 20,
  Aquarium = 21,
  Clean = 22,
  HomelandShop = 23,
  FlushingRoom = 24,
  RoleSwimmingArea = 25,
  Invite = 26,
  EditMedalWall = 27,
  ShowMedalWall = 28,
  Movie = 29,
  Visit_Build = 2001,
  Visit_Water = 2002,
  Visit_GetGift = 2003,
  TaskNpc = 34,
  TracePoint = 35
}
_enum("InteractPointType", InteractPointType)
_class("InteractPoint", Object)
InteractPoint = InteractPoint

function InteractPoint:Constructor(build, index, interactPointCfgId)
  local cfg = Cfg.cfg_building_interact_point[interactPointCfgId]
  if not cfg then
    return
  end
  self._build = build
  self._index = index
  self._pointType = cfg.FunctionType
  self._pointName = StringTable.Get(cfg.Name)
  self._icon = cfg.Icon
  self.interactDistance = cfg.Distance
  self._interactObject = nil
  self._useBoxArea = cfg.UseBoxArea
  self._cfg = cfg
end

function InteractPoint:Dispose()
end

function InteractPoint:GetBuild()
  return self._build
end

function InteractPoint:GetIndex()
  return self._index
end

function InteractPoint:GetPointType()
  return self._pointType
end

function InteractPoint:GetPointName()
  return self._pointName
end

function InteractPoint:GetPointIcon()
  return self._icon
end

function InteractPoint:GetCfg()
  return self._cfg
end

function InteractPoint:GetRedPointStatus()
  return self._build:GetInteractRedStatus(self._pointType, self._index)
end

function InteractPoint:Interact(interactBtn)
  if not self._build then
    return
  end
  self._build:Interact(self._pointType, self._index, self, interactBtn)
end

function InteractPoint:IsTrigger(pos)
  if not pos then
    return false
  end
  if self._useBoxArea then
    local boxCollider = self:_GetInteractBoxCollider()
    if not boxCollider then
      Log.fatal("矩形交互未设置BoxCollider！！！")
      return false
    end
    local closestPoint = boxCollider:ClosestPoint(pos)
    local distance = Vector3.Distance(closestPoint, pos)
    return distance <= self.interactDistance
  else
    local interactPos = self:_GetInteractPosition()
    if not interactPos then
      return false
    end
    local distance = Vector3.Distance(interactPos, pos)
    return distance <= self.interactDistance
  end
end

function InteractPoint:Equal(build, index)
  return build == self._build and index == self._index
end

function InteractPoint:_GetInteractPosition()
  if not self._build then
    return nil
  end
  return self._build:GetInteractPosition(self._index)
end

function InteractPoint:_GetInteractBoxCollider()
  if not self._build then
    return nil
  end
  return self._build:GetInteractBoxCollider(self._index)
end

function InteractPoint:GetInteractObject()
  return self._interactObject
end

function InteractPoint:SetInteractObject(interactObject)
  self._interactObject = interactObject
end

function InteractPoint:GetDistance(pos)
  local interactPos = self:_GetInteractPosition()
  if not interactPos then
    return -1
  end
  if not pos then
    return -1
  end
  return Vector3.Distance(interactPos, pos)
end

function InteractPoint:Interactable()
  if self:GetPointType() == InteractPointType.PetBuilding or self:GetPointType() == InteractPointType.RoleInteract or self:GetPointType() == InteractPointType.Invite or self:GetPointType() == InteractPointType.RoleSwimmingArea then
    return self:GetBuild():Interactable()
  elseif self:GetPointType() == InteractPointType.FlushingRoom then
    local building = self:GetBuild()
    return building:Interactable()
  end
  return true
end
