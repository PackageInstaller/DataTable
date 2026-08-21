_class("LogicTrapWallComponent", Object)
LogicTrapWallComponent = LogicTrapWallComponent

function LogicTrapWallComponent:Constructor()
  self._wallDataList = {}
  self._trapWallPosListWithEntity = {}
  self._trapWallPosList = {}
end

function LogicTrapWallComponent:GetWallList()
  return self._wallDataList
end

function LogicTrapWallComponent:GetTrapWallPosList()
  return self._trapWallPosList
end

function LogicTrapWallComponent:AddTrapWall(casterEntityID, pos, dir)
  if not self._wallDataList[pos.x] then
    self._wallDataList[pos.x] = {}
  end
  self._wallDataList[pos.x][pos.y] = LogicTrapWallData:New(casterEntityID, pos, dir)
  if not self._trapWallPosListWithEntity[casterEntityID] then
    self._trapWallPosListWithEntity[casterEntityID] = {}
  end
  table.insert(self._trapWallPosListWithEntity[casterEntityID], pos)
  if not table.icontains(self._trapWallPosList, pos) then
    table.insert(self._trapWallPosList, pos)
  end
end

function LogicTrapWallComponent:RemoveTrapWall(pos)
  if not self._wallDataList[pos.x] then
    return
  end
  local wallData = self._wallDataList[pos.x][pos.y]
  local casterEntityID = wallData:GetCasterEntityID()
  self._wallDataList[pos.x][pos.y] = nil
  table.removev(self._trapWallPosList, pos)
  if self._trapWallPosListWithEntity[casterEntityID] then
    table.removev(self._trapWallPosListWithEntity[casterEntityID], pos)
  end
end

function LogicTrapWallComponent:GetTrapWall(pos)
  if not self._wallDataList[pos.x] then
    return nil
  end
  local wall = self._wallDataList[pos.x][pos.y]
  return wall
end

function LogicTrapWallComponent:GetTrapWallPosListByEntityID(casterEntityID)
  local wallPosList = self._trapWallPosListWithEntity[casterEntityID]
  return wallPosList
end

_class("LogicTrapWallData", Object)
LogicTrapWallData = LogicTrapWallData

function LogicTrapWallData:Constructor(casterEntityID, pos, dir)
  self._casterEntityID = casterEntityID
  self._pos = pos
  self._dir = dir or Vector2(0, 0)
end

function LogicTrapWallData:GetCasterEntityID()
  return self._casterEntityID
end

function LogicTrapWallData:GetPos()
  return self._pos
end

function LogicTrapWallData:GetDir()
  return self._dir
end

function Entity:LogicTrapWall()
  return self:GetComponent(self.WEComponentsEnum.LogicTrapWall)
end

function Entity:HasLogicTrapWall()
  return self:HasComponent(self.WEComponentsEnum.LogicTrapWall)
end

function Entity:AddLogicTrapWall()
  local index = self.WEComponentsEnum.LogicTrapWall
  local component = LogicTrapWallComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceLogicTrapWall()
  local index = self.WEComponentsEnum.LogicTrapWall
  local component = LogicTrapWallComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveLogicTrapWall()
  if self:HasLogicTrapWall() then
    self:RemoveComponent(self.WEComponentsEnum.LogicTrapWall)
  end
end
