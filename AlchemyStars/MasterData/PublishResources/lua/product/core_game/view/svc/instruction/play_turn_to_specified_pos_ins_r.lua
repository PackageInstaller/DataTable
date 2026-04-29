require("base_ins_r")
_class("PlayTurnToSpecifiedPosInstruction", BaseInstruction)
PlayTurnToSpecifiedPosInstruction = PlayTurnToSpecifiedPosInstruction

function PlayTurnToSpecifiedPosInstruction:Constructor(paramList)
  self._gridX = tonumber(paramList.gridX) or 0
  self._gridY = tonumber(paramList.gridY) or 0
end

function PlayTurnToSpecifiedPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local grid = Vector2(self._gridX, self._gridY)
  local world = casterEntity:GetOwnerWorld()
  local boardServiceRender = world:GetService("BoardRender")
  local casterPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  local dir = grid - casterPos
  casterEntity:SetDirection(dir)
end
