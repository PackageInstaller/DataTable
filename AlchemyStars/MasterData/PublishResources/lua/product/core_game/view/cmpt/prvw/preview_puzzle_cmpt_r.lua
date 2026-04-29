local PuzzleStateType = {
  None = 0,
  PreEnter = 1,
  Enter = 2,
  Moving = 3
}
_enum("PuzzleStateType", PuzzleStateType)
_class("PreviewPuzzleComponent", Object)
PreviewPuzzleComponent = PreviewPuzzleComponent

function PreviewPuzzleComponent:Constructor()
  self._puzzleState = PuzzleStateType.None
  self._centerPos = Vector2.zero
  self._casterEntityID = -1
  self._puzzleRange = {}
  self._puzzleGridPosList = {}
  self._puzzleGridEffID = nil
end

function PreviewPuzzleComponent:Dispose()
end

function PreviewPuzzleComponent:SetCenterPos(pos)
  self._centerPos = pos
end

function PreviewPuzzleComponent:GetCenterPos()
  return self._centerPos
end

function PreviewPuzzleComponent:SetPuzzleGridEffID(effID)
  self._puzzleGridEffID = effID
end

function PreviewPuzzleComponent:GetPuzzleGridEffID()
  return self._puzzleGridEffID
end

function PreviewPuzzleComponent:SetCasterEntityID(entityID)
  self._casterEntityID = entityID
end

function PreviewPuzzleComponent:GetCasterEntityID()
  return self._casterEntityID
end

function PreviewPuzzleComponent:SetGapTilePos(pos)
  self._gapTilePos = pos
end

function PreviewPuzzleComponent:GetGapTilePos()
  return self._gapTilePos
end

function PreviewPuzzleComponent:SetPuzzleRange(posList)
  self._puzzleRange = posList
end

function PreviewPuzzleComponent:GetPuzzleRange()
  return self._puzzleRange
end

function PreviewPuzzleComponent:AddPuzzleGridPos(pickUpGridPos)
  table.insert(self._puzzleGridPosList, pickUpGridPos)
end

function PreviewPuzzleComponent:GetPuzzleGridPosList()
  return self._puzzleGridPosList
end

function PreviewPuzzleComponent:SetPuzzleState(stateType)
  self._puzzleState = stateType
end

function PreviewPuzzleComponent:GetPuzzleState()
  return self._puzzleState
end

function Entity:PreviewPuzzle()
  return self:GetComponent(self.WEComponentsEnum.PreviewPuzzle)
end

function Entity:HasPreviewPuzzle()
  return self:HasComponent(self.WEComponentsEnum.PreviewPuzzle)
end

function Entity:AddPreviewPuzzle()
  local index = self.WEComponentsEnum.PreviewPuzzle
  local component = PreviewPuzzleComponent:New()
  self:AddComponent(index, component)
end

function Entity:ReplacePreviewPuzzle()
  local index = self.WEComponentsEnum.PreviewPuzzle
  local component = PreviewPuzzleComponent:New()
  self:ReplaceComponent(index, component)
end
