require("base_ins_r")
_class("PlayTurnToTeleportOldPosInstruction", BaseInstruction)
PlayTurnToTeleportOldPosInstruction = PlayTurnToTeleportOldPosInstruction

function PlayTurnToTeleportOldPosInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
end

function PlayTurnToTeleportOldPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, self._stageIndex)
  if not teleportEffectResult then
    return
  end
  local oldPos = teleportEffectResult:GetPosOld()
  local world = casterEntity:GetOwnerWorld()
  local boardServiceRender = world:GetService("BoardRender")
  local casterPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  local dir = oldPos - casterPos
  casterEntity:SetDirection(dir)
end
