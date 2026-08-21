_class("RenderBoardSpliceComponent", Object)
RenderBoardSpliceComponent = RenderBoardSpliceComponent

function RenderBoardSpliceComponent:Constructor()
  self._gridEntityTable = {}
end

function RenderBoardSpliceComponent:Dispose()
end

function RenderBoardSpliceComponent:GetGridRenderEntity(pos)
  if not (pos and self._gridEntityTable[pos.x]) or not self._gridEntityTable[pos.x][pos.y] then
    return nil
  end
  return self._gridEntityTable[pos.x][pos.y]
end

function RenderBoardSpliceComponent:SetGridRenderEntityData(pos, gridEntity)
  if not self._gridEntityTable[pos.x] then
    self._gridEntityTable[pos.x] = {}
  end
  if not self._gridEntityTable[pos.x][pos.y] then
    self._gridEntityTable[pos.x][pos.y] = {}
  end
  self._gridEntityTable[pos.x][pos.y] = gridEntity
end

function RenderBoardSpliceComponent:RemoveGridRenderEntityData(pos)
  if not self._gridEntityTable[pos.x][pos.y] then
    self._gridEntityTable[pos.x][pos.y] = {}
  end
  self._gridEntityTable[pos.x][pos.y] = nil
end

function Entity:RenderBoardSplice()
  return self:GetComponent(self.WEComponentsEnum.RenderBoardSplice)
end

function Entity:HasRenderBoardSplice()
  return self:HasComponent(self.WEComponentsEnum.RenderBoardSplice)
end

function Entity:AddRenderBoardSplice()
  local index = self.WEComponentsEnum.RenderBoardSplice
  local component = RenderBoardSpliceComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderBoardSplice()
  local index = self.WEComponentsEnum.RenderBoardSplice
  local component = RenderBoardSpliceComponent:New()
  self:ReplaceComponent(index, component)
end
