require("ai_node_new")
_class("ActionCheckN15ChessMonsterCanMove", AINewNode)
ActionCheckN15ChessMonsterCanMove = ActionCheckN15ChessMonsterCanMove

function ActionCheckN15ChessMonsterCanMove:Constructor()
end

function ActionCheckN15ChessMonsterCanMove:OnUpdate()
  local ownEntity = self.m_entityOwn
  local bodyArea = ownEntity:BodyArea()
  if bodyArea:GetAreaCount() > 1 then
    return AINewNodeStatus.Failure
  end
  local element = ownEntity:Element():GetPrimaryType()
  local myPos = ownEntity:GetGridPosition()
  local board = self._world:GetBoardEntity():Board()
  if board:GetPieceType(myPos) ~= element and board:GetPieceType(myPos) ~= PieceType.Any then
    return AINewNodeStatus.Failure
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local aroundPosList = utilScopeSvc:GetPosAroundSameTypePosList(myPos, element)
  if #aroundPosList == 0 then
    return AINewNodeStatus.Failure
  end
  return AINewNodeStatus.Success
end
