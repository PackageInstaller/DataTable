require("play_skill_phase_base_r")
_class("PlaySkillDrillerExplosionSimplePhase", PlaySkillPhaseBase)
PlaySkillDrillerExplosionSimplePhase = PlaySkillDrillerExplosionSimplePhase

function PlaySkillDrillerExplosionSimplePhase:PlayFlight(TT, casterEntity, phaseParam, phaseIndex, phaseAdapter)
  local effectService = self._world:GetService("Effect")
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local destroyResultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.DestroyMonster)
  if not destroyResultArray then
    return
  end
  local index = 1
  local destroyResult = destroyResultArray[index]
  if not destroyResult then
    return
  end
  local singleBossEntity
  local singleBossClassID = phaseParam:GetMonsterClassID()
  if singleBossClassID and 0 < singleBossClassID then
    local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
    for _, e in ipairs(monsterGroup:GetEntities()) do
      if e:HasView() and not e:HasShowDeath() and singleBossClassID == e:MonsterID():GetMonsterClassID() then
        singleBossEntity = e
        break
      end
    end
  end
  if not singleBossEntity then
    return
  end
  local singleBossPos = singleBossEntity:GetRenderGridPosition()
  local boomEffDir = self:_GetGridDirection(singleBossEntity)
  local eID = destroyResult:GetEntityID()
  local eMonster = self._world:GetEntityByID(eID)
  if not eMonster then
    return
  end
  self:SetHPVisible(casterEntity, false)
  self:SetHPVisible(singleBossEntity, false)
  YIELD(TT)
  local startAction = phaseParam:GetStartAction()
  casterEntity:SetAnimatorControllerTriggers({startAction})
  local startEffectID = phaseParam:GetStartEffectID()
  if startEffectID and startEffectID ~= 0 then
    effectService:CreateEffect(startEffectID, casterEntity)
  end
  local mainEffectID = phaseParam:GetMainEffectID()
  if mainEffectID and mainEffectID ~= 0 then
    local boomGridPos = singleBossPos + boomEffDir * 1
    effectService:CreateWorldPositionDirectionEffect(mainEffectID, boomGridPos, boomEffDir)
  end
  local startMatAnim = phaseParam:GetStartMatAnim()
  casterEntity:PlayMaterialAnim(startMatAnim)
  local bossShowDelayMs = phaseParam:GetBossShowDelayMs()
  YIELD(TT, bossShowDelayMs)
  eMonster:SetViewVisible(false)
  local svc = self._world:GetService("MonsterShowRender")
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    svc:_DoOneMonsterDead(TT, eMonster)
  end)
  singleBossEntity:SetViewVisible(true)
  self:SetHPVisible(singleBossEntity, false)
  singleBossEntity:RemoveRenderPerformanceByAgent()
  local bossShowAction = phaseParam:GetBossShowAction()
  singleBossEntity:SetAnimatorControllerTriggers({bossShowAction})
  local bossShowEffectID = phaseParam:GetBossShowEffectID()
  if bossShowEffectID and bossShowEffectID ~= 0 then
    effectService:CreateEffect(bossShowEffectID, singleBossEntity)
  end
  local finalDelayMs = phaseParam:GetFinalDelayMs()
  YIELD(TT, finalDelayMs)
  self:SetHPVisible(singleBossEntity, true)
end

function PlaySkillDrillerExplosionSimplePhase:_ShowTrapFromSummonEverything(TT, summonRes, phaseParam)
  local summonMonsterData = summonRes:GetTrapData()
  local posSummon = summonRes:GetSummonPos()
  local trapEntity = self._world:GetEntityByID(summonMonsterData.m_entityWorkID)
  GameGlobal.TaskManager():CoreGameStartTask(self._ShowTrap, self, trapEntity, posSummon, phaseParam)
end

function PlaySkillDrillerExplosionSimplePhase:_ShowTrap(TT, trapEntity, posSummon, phaseParam)
  trapEntity:SetPosition(posSummon)
  local trapServiceRender = self._world:GetService("TrapRender")
  trapServiceRender:CreateSingleTrapRender(TT, trapEntity, true)
end

function PlaySkillDrillerExplosionSimplePhase:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimName, hitEffectID, casterEntity, gridPos, hitTurnToTarget, skillID)
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if targetEntity ~= nil then
    local skillService = self:SkillService()
    local targetDamage = damageResult:GetDamageInfo(1)
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(gridPos):SetHandleBeHitParam_HitTurnTarget(hitTurnToTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
    GameGlobal.TaskManager():CoreGameStartTask(skillService.HandleBeHit, skillService, beHitParam)
  end
end

function PlaySkillDrillerExplosionSimplePhase:SetHPVisible(entity, bVisible)
  local hpCmpt = entity:HP()
  if hpCmpt then
    local sliderEntityID = entity:HP():GetHPSliderEntityID()
    local sliderEntity = self._world:GetEntityByID(sliderEntityID)
    if sliderEntity then
      hpCmpt:SetHPBarTempHide(not bVisible)
      hpCmpt:SetHPPosDirty(true)
    end
  end
end

function PlaySkillDrillerExplosionSimplePhase:_GetGridDirection(entity)
  local dir = entity:GetGridDirection():Clone()
  if dir.x > 1 then
    dir.x = 1
  elseif dir.x < -1 then
    dir.x = -1
  end
  if 1 < dir.y then
    dir.y = 1
  elseif -1 > dir.y then
    dir.y = -1
  end
  return dir
end
