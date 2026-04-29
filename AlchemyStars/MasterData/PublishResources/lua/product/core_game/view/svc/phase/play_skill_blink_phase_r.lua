require("play_skill_phase_base_r")
_class("PlaySkillBlinkPhase", PlaySkillPhaseBase)
PlaySkillBlinkPhase = PlaySkillBlinkPhase

function PlaySkillBlinkPhase:PlayFlight(TT, casterEntity, phaseParam, phaseIndex, phaseAdapter)
  local effectService = self._world:GetService("Effect")
  casterEntity:SetAnimatorControllerTriggers({
    phaseParam.castAnimation
  })
  if phaseParam.castEffectID and phaseParam.castEffectID ~= 0 then
    effectService:CreateEffect(phaseParam.castEffectID, casterEntity)
  end
  YIELD(TT, phaseParam.castDuration)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Teleport)
  local world = casterEntity:GetOwnerWorld()
  local playSkillInstructionService = world:GetService("PlaySkillInstruction")
  playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportHide, false, skillResult)
  playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportMove, false, skillResult)
  YIELD(TT, phaseParam.stealthDuration)
  playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.TeleportShow, false, skillResult)
  playSkillInstructionService:Teleport(TT, casterEntity, RoleShowType.BuffNotify, false, skillResult)
  casterEntity:SetAnimatorControllerTriggers({
    phaseParam.appearAnimation
  })
  if phaseParam.appearEffectID and phaseParam.appearEffectID ~= 0 then
    effectService:CreateEffect(phaseParam.appearEffectID, casterEntity)
  end
  YIELD(TT, phaseParam.appearDuration)
  local pieceService = self._world:GetService("Piece")
  pieceService:RemovePrismAt(skillResult:GetPosNew())
end
