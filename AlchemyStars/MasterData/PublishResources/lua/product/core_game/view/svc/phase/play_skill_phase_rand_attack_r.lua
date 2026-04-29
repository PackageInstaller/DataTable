require("play_skill_phase_base_r")
_class("PlaySkillPhase_RandAttack", PlaySkillPhaseBase)
PlaySkillPhase_RandAttack = PlaySkillPhase_RandAttack

function PlaySkillPhase_RandAttack:PlayFlight(TT, casterEntity, phaseParam)
  local param = phaseParam
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local results = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.RandAttack)
  local buffView = casterEntity:BuffView()
  local soulCount = buffView:GetBuffValue("SoulCount") or 0
  if 0 < soulCount and 0 < results:GetListAliveCount() then
    self:_DelayTime(TT, param:GetTargetWaitTime())
    local isFinalHit = skillEffectResultContainer:IsFinalAttack()
    local attackIntervalTime = param:GetAttackIntervalTime()
    local nDefenterCount = results:GetListDefenderCount()
    local nSkillID = skillEffectResultContainer:GetSkillID()
    for i = 1, nDefenterCount do
      local randAttackData = results:GetDefenderData(i)
      local targetEntity = self._world:GetEntityByID(randAttackData.m_entityDefenter)
      if targetEntity then
        if isFinalHit and i == nDefenterCount then
          skillEffectResultContainer:SetFinalAttackEntityID(targetEntity:GetID())
        end
        self:_PlayHitEffect(TT, casterEntity, targetEntity, phaseParam, randAttackData.m_damageData, isFinalHit, nSkillID)
        self:_DelayTime(TT, attackIntervalTime)
      end
    end
    self:_DelayTime(TT, param:GetFinishDelayTime())
  end
end

function PlaySkillPhase_RandAttack:_PlayHitEffect(TT, entityCast, entityTarget, phaseParam, damageData, isFinalHit, nSkillID)
  local posCast = self:_GetEntityBasePos(entityCast)
  local posTarget = self:_GetEntityBasePos(entityTarget)
  local hitAnimationName = phaseParam:GetHitAnimation()
  local hitEffectID = phaseParam:GetHitEffectID()
  local attackPos = entityCast:GridLocation():GetGridPos()
  local beAttackPos = entityTarget:GridLocation():GetGridPos()
  local playBuffSvc = self._world:GetService("PlayBuff")
  playBuffSvc:PlayBuffView(TT, NTRandAttackEnd:New(entityCast, entityTarget, attackPos, beAttackPos))
  GameGlobal.TaskManager():CoreGameStartTask(self._skillService.PlayCastAudio, self._skillService, phaseParam:GetAudioID(), phaseParam:GetAudioWaitTime())
  local skillService = self:SkillService()
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(entityCast):SetHandleBeHitParam_TargetEntity(entityTarget):SetHandleBeHitParam_HitAnimName(hitAnimationName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(damageData):SetHandleBeHitParam_DamagePos(posTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalHit):SetHandleBeHitParam_SkillID(nSkillID)
  skillService:HandleBeHit(TT, beHitParam)
end
