require("play_skill_phase_base_r")
_class("PlaySkillLRAttackAnimationPhase", PlaySkillPhaseBase)
PlaySkillLRAttackAnimationPhase = PlaySkillLRAttackAnimationPhase

function PlaySkillLRAttackAnimationPhase:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local res = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.Damage)
  local beAttackEntityID = res:GetTargetID()
  local targetEntity = self._world:GetEntityByID(beAttackEntityID)
  if not targetEntity then
    return
  end
  local resvc = self._world:GetService("RenderEntity")
  resvc:TurnToTarget(casterEntity, targetEntity)
  local effectService = self._world:GetService("Effect")
  local playDamageSvc = self._world:GetService("PlayDamage")
  local attackAnimName
  local boardServiceRender = self._world:GetService("BoardRender")
  local casterGridLocation, targetGridLocation = casterEntity:GridLocation(), targetEntity:GridLocation()
  local attEffPos
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local frontPos = utilCalcSvc:GetFrontPieces(casterEntity)
  local armBlurEffId = 0
  if 0 > boardServiceRender:IsLeftOrRight(casterEntity, targetEntity) then
    attackAnimName = phaseParam:GetLAnimationName()
    attEffPos = frontPos[1]
    armBlurEffId = phaseParam:GetLBlurEffectID()
  else
    attackAnimName = phaseParam:GetRAnimationName()
    attEffPos = frontPos[2]
    armBlurEffId = phaseParam:GetRBlurEffectID()
  end
  casterEntity:SetAnimatorControllerTriggers({attackAnimName})
  local blurDelay = phaseParam:GetBlurDelay()
  if blurDelay then
    YIELD(TT, blurDelay)
  end
  if armBlurEffId then
    effectService:CreateEffect(armBlurEffId, casterEntity)
  end
  local deltaTimeMS = self._timeService:GetCurrentTimeMs()
  local hitPointDelay = phaseParam:GetHitPointDelay()
  if 0 < hitPointDelay then
    YIELD(TT, hitPointDelay)
  end
  local attackEffectID = phaseParam:GetCastEffectID()
  local renderDir = casterEntity:GetDirection()
  effectService:CreateWorldPositionDirectionEffect(attackEffectID, attEffPos, Vector2(renderDir.x, renderDir.z))
  local resvc = self._world:GetService("RenderEntity")
  resvc:TurnToTarget(targetEntity, casterEntity)
  local hitAnimName = phaseParam:GetHitAnimation()
  targetEntity:SetAnimatorControllerTriggers({hitAnimName})
  local hitEffectID = phaseParam:GetHitEffectID()
  effectService:CreateEffect(hitEffectID, targetEntity)
  local hitBackData = skillEffectResultContainer:GetEffectResultByTargetID(SkillEffectType.HitBack, beAttackEntityID)
  local processHitTaskID = self:SkillService():ProcessHit(casterEntity, targetEntity, hitBackData)
  local castDamage = res:GetDamageInfo(1)
  playDamageSvc:AsyncUpdateHPAndDisplayDamage(targetEntity, castDamage)
  local overDelay = phaseParam:GetOverDelay()
  if 0 < overDelay then
    YIELD(TT, overDelay)
  end
  if processHitTaskID then
    while not TaskHelper:GetInstance():IsTaskFinished(processHitTaskID) do
      YIELD(TT)
    end
  end
end
