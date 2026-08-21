_class("BuffLogicSetBoardPieceMapWithTrap", BuffLogicBase)
BuffLogicSetBoardPieceMapWithTrap = BuffLogicSetBoardPieceMapWithTrap

function BuffLogicSetBoardPieceMapWithTrap:Constructor(buffInstance, logicParam)
  self._trapID = logicParam.trapID
  self._piece = logicParam.piece
end

function BuffLogicSetBoardPieceMapWithTrap:DoLogic()
  local e = self._buffInstance:Entity()
  local board = self._world:GetBoardEntity():Board()
  local mapByPosition = {}
  local trapGroup = self._world:GetGroup(self._world.BW_WEMatchers.Trap)
  local trapEntities = trapGroup:GetEntities()
  for _, entity in ipairs(trapEntities) do
    local trapComponent = entity:Trap()
    if trapComponent and not entity:HasDeadMark() and trapComponent:GetTrapID() == self._trapID then
      local pos = entity:GetGridPosition()
      local posIndex = Vector2.Pos2Index(pos)
      mapByPosition[posIndex] = self._piece
    end
  end
  board:SetMapByPosition(mapByPosition)
  local buffResult = BuffResultSetBoardPieceMapWithTrap:New(mapByPosition)
  return buffResult
end
