require("base_ins_r")
_class("PlayTurnToTeleportNewPosInstruction", BaseInstruction)
PlayTurnToTeleportNewPosInstruction = PlayTurnToTeleportNewPosInstruction

function PlayTurnToTeleportNewPosInstruction:Constructor(paramList)
  self._stageIndex = tonumber(paramList.stageIndex) or 1
  self._spFix = tonumber(paramList.spFix) or 0
end

function PlayTurnToTeleportNewPosInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local teleportEffectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport, self._stageIndex)
  if not teleportEffectResult then
    return
  end
  local newPos = teleportEffectResult:GetPosNew()
  local world = casterEntity:GetOwnerWorld()
  local boardServiceRender = world:GetService("BoardRender")
  local casterPos = boardServiceRender:GetRealEntityGridPos(casterEntity)
  local dir = newPos - casterPos
  if self._spFix then
    if dir == Vector2(-1, -1) then
      dir = Vector2(-1, 0)
    elseif dir == Vector2(-1, 1) then
      dir = Vector2(0, 1)
    elseif dir == Vector2(1, 1) then
      dir = Vector2(1, 0)
    elseif dir == Vector2(1, -1) then
      dir = Vector2(0, -1)
    end
  end
  casterEntity:SetDirection(dir)
end
