require("play_skill_phase_base_r")
_class("PlaySkillGridArrayPhase", PlaySkillPhaseBase)
PlaySkillGridArrayPhase = PlaySkillGridArrayPhase

function PlaySkillGridArrayPhase:PlayFlight(TT, casterEntity, phaseParam)
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local gridEffectID = phaseParam:GetGridEffectID()
  local bestEffectTime = phaseParam:GetBestEffectTime()
  if gridEffectID then
    local result = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ConvertGridElement)
    local gridPosArray = result:GetTargetGridArray()
    local targetGridType = result:GetTargetElementType()
    for _, gridPos in ipairs(gridPosArray) do
      GameGlobal.TaskManager():CoreGameStartTask(self:SkillService()._SingleGridEffect, self:SkillService(), gridEffectID, gridPos, bestEffectTime, targetGridType)
    end
  end
  local scope = skillEffectResultContainer:GetScopeResult()
  local centerPos = scope:GetCenterPos()
  if #centerPos == 0 then
    centerPos = {centerPos}
  end
  for k, v in pairs(centerPos) do
    self._world:GetService("Effect"):CreateWorldPositionEffect(phaseParam:GetAtkEffectID(), v, true)
  end
  local hitDelay = phaseParam:GetHitDelayTime()
  YIELD(TT, hitDelay)
  local damageResult = skillEffectResultContainer:GetEffectResultsAsPosDic(SkillEffectType.Damage)
  if damageResult then
    for posIdx, res in pairs(damageResult) do
      local pos = Vector2.Index2Pos(posIdx)
      local targetEntityID = res:GetTargetID()
      local targetEntity = self._world:GetEntityByID(targetEntityID)
      if targetEntity ~= nil then
        local targetDamage = res:GetDamageInfo(1)
        local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(phaseParam:GetHitAnimation()):SetHandleBeHitParam_HitEffectID(-1):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(pos):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillEffectResultContainer:GetSkillID())
        GameGlobal.TaskManager():CoreGameStartTask(self:SkillService().HandleBeHit, self:SkillService(), beHitParam)
      end
    end
  end
  local finishDelayTime = phaseParam:GetFinishTime()
  YIELD(TT, finishDelayTime)
end
