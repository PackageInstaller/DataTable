_class("RenderBoardPushComponent", Object)
RenderBoardPushComponent = RenderBoardPushComponent

function RenderBoardPushComponent:Constructor()
  self._gridEntityTable = {}
end

function RenderBoardPushComponent:Dispose()
end

function RenderBoardPushComponent:GetGridRenderEntity(pos)
  if not (pos and self._gridEntityTable[pos.x]) or not self._gridEntityTable[pos.x][pos.y] then
    return nil
  end
  return self._gridEntityTable[pos.x][pos.y]
end

function RenderBoardPushComponent:SetGridRenderEntityData(pos, gridEntity)
  if not self._gridEntityTable[pos.x] then
    self._gridEntityTable[pos.x] = {}
  end
  if not self._gridEntityTable[pos.x][pos.y] then
    self._gridEntityTable[pos.x][pos.y] = {}
  end
  self._gridEntityTable[pos.x][pos.y] = gridEntity
end

function RenderBoardPushComponent:RemoveGridRenderEntityData(pos)
  if not self._gridEntityTable[pos.x][pos.y] then
    self._gridEntityTable[pos.x][pos.y] = {}
  end
  self._gridEntityTable[pos.x][pos.y] = nil
end

function Entity:RenderBoardPush()
  return self:GetComponent(self.WEComponentsEnum.RenderBoardPush)
end

function Entity:HasRenderBoardPush()
  return self:HasComponent(self.WEComponentsEnum.RenderBoardPush)
end

function Entity:AddRenderBoardPush()
  local index = self.WEComponentsEnum.RenderBoardPush
  local component = RenderBoardPushComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderBoardPush()
  local index = self.WEComponentsEnum.RenderBoardPush
  local component = RenderBoardPushComponent:New()
  self:ReplaceComponent(index, component)
end
