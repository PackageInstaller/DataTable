require("play_skill_phase_base_r")
_class("PlaySkillHitBackPhase", PlaySkillPhaseBase)
PlaySkillHitBackPhase = PlaySkillHitBackPhase

function PlaySkillHitBackPhase:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.HitBack)
  if not result then
    return
  end
  local beHitbackEntityID = result:GetTargetID()
  local targetEntity = self._world:GetEntityByID(beHitbackEntityID)
  local hitEffectID = phaseParam:GetHitEffectID()
  if 0 < hitEffectID then
    self._world:GetService("Effect"):CreateBeHitEffect(hitEffectID, targetEntity)
  end
  local hitTurnTarget = phaseParam:GetTurnToTarget()
  if hitTurnTarget == TurnToTargetType.Caster then
    local resvc = self._world:GetService("RenderEntity")
    resvc:TurnToTarget(targetEntity, casterEntity, nil, nil, hitTurnTarget)
  end
  local processHitTaskID
  if result and not targetEntity:HasHitback() and not result:GetHadPlay() then
    result:SetHadPlay(true)
    processHitTaskID = self:SkillService():ProcessHit(casterEntity, targetEntity, result)
  end
  if processHitTaskID then
    while not TaskHelper:GetInstance():IsTaskFinished(processHitTaskID) do
      YIELD(TT)
    end
  end
end
