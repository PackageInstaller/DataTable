require("base_ins_r")
_class("PlayTurnToSpecifiedDirInstruction", BaseInstruction)
PlayTurnToSpecifiedDirInstruction = PlayTurnToSpecifiedDirInstruction

function PlayTurnToSpecifiedDirInstruction:Constructor(paramList)
  self._dirX = tonumber(paramList.dirX) or 0
  self._dirY = tonumber(paramList.dirY) or 0
end

function PlayTurnToSpecifiedDirInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local dir = Vector2(self._dirX, self._dirY)
  casterEntity:SetDirection(dir)
end
