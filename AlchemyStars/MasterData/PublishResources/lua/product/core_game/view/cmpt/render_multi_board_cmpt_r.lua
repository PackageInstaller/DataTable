_class("RenderMultiBoardComponent", Object)
RenderMultiBoardComponent = RenderMultiBoardComponent

function RenderMultiBoardComponent:Constructor()
  self._multiBoard = {}
end

function RenderMultiBoardComponent:Dispose()
end

function RenderMultiBoardComponent:GetCurBoard(boardIndex)
  if not self._multiBoard then
    self._multiBoard = {}
  end
  if not self._multiBoard[boardIndex] then
    self._multiBoard[boardIndex] = {}
  end
  local curBoard = self._multiBoard[boardIndex]
  return curBoard
end

function RenderMultiBoardComponent:GetGridRenderEntity(boardIndex, pos)
  local curBoard = self:GetCurBoard(boardIndex)
  if not (curBoard and pos and curBoard._gridEntityTable[pos.x]) or not curBoard._gridEntityTable[pos.x][pos.y] then
    return nil
  end
  return curBoard._gridEntityTable[pos.x][pos.y]
end

function RenderMultiBoardComponent:SetGridRenderEntityData(boardIndex, pos, gridEntity)
  local curBoard = self:GetCurBoard(boardIndex)
  if not curBoard._gridEntityTable then
    curBoard._gridEntityTable = {}
  end
  if not curBoard._gridEntityTable[pos.x] then
    curBoard._gridEntityTable[pos.x] = {}
  end
  if not curBoard._gridEntityTable[pos.x][pos.y] then
    curBoard._gridEntityTable[pos.x][pos.y] = {}
  end
  curBoard._gridEntityTable[pos.x][pos.y] = gridEntity
end

function RenderMultiBoardComponent:RemoveGridRenderEntityData(boardIndex, pos)
  local curBoard = self:GetCurBoard(boardIndex)
  if not curBoard._gridEntityTable[pos.x][pos.y] then
    curBoard._gridEntityTable[pos.x][pos.y] = {}
  end
  curBoard._gridEntityTable[pos.x][pos.y] = nil
end

function RenderMultiBoardComponent:SetMultiBoardRootGameObject(boardIndex, boardRootGameObject)
  local curBoard = self:GetCurBoard(boardIndex)
  curBoard.boardRoot = boardRootGameObject
end

function RenderMultiBoardComponent:GetMultiBoardRootGameObject(boardIndex)
  local curBoard = self:GetCurBoard(boardIndex)
  return curBoard.boardRoot
end

function Entity:RenderMultiBoard()
  return self:GetComponent(self.WEComponentsEnum.RenderMultiBoard)
end

function Entity:HasRenderMultiBoard()
  return self:HasComponent(self.WEComponentsEnum.RenderMultiBoard)
end

function Entity:AddRenderMultiBoard()
  local index = self.WEComponentsEnum.RenderMultiBoard
  local component = RenderMultiBoardComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplaceRenderMultiBoard()
  local index = self.WEComponentsEnum.RenderMultiBoard
  local component = RenderMultiBoardComponent:New()
  self:ReplaceComponent(index, component)
end

function Entity:RemoveRenderMultiBoard()
  if self:HasRenderMultiBoard() then
    self:RemoveComponent(self.WEComponentsEnum.RenderMultiBoard)
  end
end
