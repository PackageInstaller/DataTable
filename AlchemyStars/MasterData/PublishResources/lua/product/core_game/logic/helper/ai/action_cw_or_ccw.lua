require("ai_node_new")
_class("ActionCWOrCCW", AINewNode)
ActionCWOrCCW = ActionCWOrCCW

function ActionCWOrCCW:OnUpdate()
  local boardService = self._world:GetService("BoardLogic")
  local cGridLocation = self.m_entityOwn:GridLocation()
  local dir = cGridLocation:GetGridDir()
  local clockwiseDir = Vector2(dir.y, -dir.x)
  local clockwiseDirPos = cGridLocation.Position + clockwiseDir
  local aiNewNodeStatus = AINewNodeStatus.Failure
  local utilData = self._world:GetService("UtilData")
  if utilData:IsValidPiecePos(clockwiseDirPos) then
    aiNewNodeStatus = AINewNodeStatus.Success
  end
  return aiNewNodeStatus
end
