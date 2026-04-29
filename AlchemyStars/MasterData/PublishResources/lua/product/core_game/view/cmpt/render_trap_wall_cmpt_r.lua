_class("RenderTrapWallComponent", Object)
RenderTrapWallComponent = RenderTrapWallComponent

function RenderTrapWallComponent:Constructor()
  self._wallDataList = {}
  self._trapWallPosList = {}
  self._blockEffectEntityIDList = {}
end

function RenderTrapWallComponent:GetWallList()
  return self._wallDataList
end

function RenderTrapWallComponent:AddEffectEntity(effEntityID, pos, dir)
  if not self._wallDataList[pos.x] then
    self._wallDataList[pos.x] = {}
  end
  self._wallDataList[pos.x][pos.y] = RenderTrapWallData:New(effEntityID, pos, dir)
  table.insert(self._trapWallPosList, pos)
end

function RenderTrapWallComponent:RemoveTrapWall(pos)
  if not self._wallDataList[pos.x] then
    return
  end
  self._wallDataList[pos.x][pos.y] = nil
end

function RenderTrapWallComponent:GetTrapWall(pos)
  if not self._wallDataList[pos.x] then
    return nil
  end
  local wall = self._wallDataList[pos.x][pos.y]
  return wall
end

function RenderTrapWallComponent:GetTrapWallPosList()
  return self._trapWallPosList
end

function RenderTrapWallComponent:AddBlockEffectEntityID(effEntityID)
  table.insert(self._blockEffectEntityIDList, effEntityID)
end

function RenderTrapWallComponent:GetBlockEffectEntityIDList()
  return self._blockEffectEntityIDList
end

function RenderTrapWallComponent:ClearBlockEffectEntityIDList()
  self._blockEffectEntityIDList = {}
end

_class("RenderTrapWallData", Object)
RenderTrapWallData = RenderTrapWallData

function RenderTrapWallData:Constructor(effectEntityID, pos, dir)
  self._effectEntityID = effectEntityID
  self._pos = pos
  self._dir = dir or Vector2(0, 0)
end

function RenderTrapWallData:GetEffectEntityID()
  return self._effectEntityID
end

function RenderTrapWallData:GetPos()
  return self._pos
end

function RenderTrapWallData:GetDir()
  return self._dir
end

function Entity:RenderTrapWall()
  return self:GetComponent(self.WEComponentsEnum.RenderTrapWall)
end

function Entity:HasRenderTrapWall()
  return self:HasComponent(self.WEComponentsEnum.RenderTrapWall)
end

function Entity:AddRenderTrapWall()
  local index = self.WEComponentsEnum.RenderTrapWall
  local component = RenderTrapWallComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderTrapWall(roundTeam)
  local index = self.WEComponentsEnum.RenderTrapWall
  local component = RenderTrapWallComponent:New(roundTeam)
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderTrapWall()
  if self:HasRenderTrapWall() then
    self:RemoveComponent(self.WEComponentsEnum.RenderTrapWall)
  end
end
