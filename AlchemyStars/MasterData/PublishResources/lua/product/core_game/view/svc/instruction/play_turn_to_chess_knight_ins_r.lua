require("base_ins_r")
_class("PlayTurnToChessKnightInstruction", BaseInstruction)
PlayTurnToChessKnightInstruction = PlayTurnToChessKnightInstruction

function PlayTurnToChessKnightInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
end

function PlayTurnToChessKnightInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, self._stageIndex)
  if not teleportEffectResult then
    return
  end
  local newPos = teleportEffectResult:GetPosNew()
  local oldPos = teleportEffectResult:GetPosOld()
  if newPos == oldPos then
    return
  end
  local dir = newPos - oldPos
  if math.abs(dir.x) == 1 then
    dir.x = 0
  end
  if math.abs(dir.y) == 1 then
    dir.y = 0
  end
  casterEntity:SetDirection(dir)
end
