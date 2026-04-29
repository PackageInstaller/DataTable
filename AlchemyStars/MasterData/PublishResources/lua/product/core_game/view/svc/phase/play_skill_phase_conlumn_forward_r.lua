require("play_skill_phase_base_r")
_class("PlaySkillPhaseColumnForward", PlaySkillPhaseBase)
PlaySkillPhaseColumnForward = PlaySkillPhaseColumnForward

function PlaySkillPhaseColumnForward:PlayFlight(TT, casterEntity, phaseParam)
  local effectID = phaseParam:GetGridEffectID()
  local hitAnimationName = phaseParam:GetHitAnimationName()
  local hitEffectID = phaseParam:GetHitEffectID()
  local intervalTime = phaseParam:GetEffectIntervalTime()
  local hasDamage = phaseParam:HasDamage()
  local gridDelayTime = phaseParam:GetGridDelayTime()
  local hitPointDelay = phaseParam:GetHitPointDelay()
  local finishDelayTime = phaseParam:GetFinishDelayTime()
  local castPos = casterEntity:GridLocation().Position
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local gridDataArray = scopeResult:GetAttackRange()
  local sameConlumnList = {}
  local effectList = {}
  local waveCount = 10
  for i = 1, waveCount do
    local waveItem = {}
    waveItem.index = i
    waveItem.gridList = {}
    table.insert(effectList, waveItem)
  end
  for k, v in pairs(gridDataArray) do
    local grid = v
    local effectItem = {}
    if grid.y == castPos.y and grid ~= castPos then
      table.insert(sameConlumnList, grid)
    elseif grid.y < castPos.y then
      effectItem.grid = grid
      effectItem.index = castPos.y - grid.y
      effectItem.direction = Vector2(0, -1)
    elseif grid.y > castPos.y then
      effectItem.grid = grid
      effectItem.index = grid.y - castPos.y
      effectItem.direction = Vector2(0, 1)
    end
    if effectItem.index then
      table.insert(effectList[effectItem.index].gridList, effectItem)
    end
  end
  for k, grid in pairs(sameConlumnList) do
    local damageResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.Damage, grid)
    if damageResult then
      self:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimationName, hitEffectID, casterEntity, grid, 0, skillID)
    end
  end
  YIELD(TT, gridDelayTime)
  for wave, waveItem in pairs(effectList) do
    for k, effectItem in pairs(waveItem.gridList) do
      local entityEffect = world:GetService("Effect"):CreateWorldPositionEffect(effectID, effectItem.grid)
      entityEffect:SetDirection(effectItem.direction)
    end
    YIELD(TT, hitPointDelay)
    if hasDamage then
      for k, effectItem in pairs(waveItem.gridList) do
        local damageResult = skillEffectResultContainer:GetEffectResultByPos(SkillEffectType.Damage, effectItem.grid)
        if damageResult then
          self:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimationName, hitEffectID, casterEntity, effectItem.grid, 0, skillID)
        end
      end
    end
    YIELD(TT, intervalTime - hitPointDelay)
  end
  YIELD(TT, finishDelayTime)
end

function PlaySkillPhaseColumnForward:_ShowDamage(damageResult, skillEffectResultContainer, hitAnimName, hitEffectID, casterEntity, gridPos, hitTurnToTarget, skillID)
  local targetEntityID = damageResult:GetTargetID()
  local targetEntity = self._world:GetEntityByID(targetEntityID)
  if targetEntity ~= nil then
    local targetDamage = damageResult:GetDamageInfo(1)
    local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName(hitAnimName):SetHandleBeHitParam_HitEffectID(hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(gridPos):SetHandleBeHitParam_HitTurnTarget(hitTurnToTarget):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(skillEffectResultContainer:IsFinalAttack()):SetHandleBeHitParam_SkillID(skillID)
    GameGlobal.TaskManager():CoreGameStartTask(self:SkillService().HandleBeHit, self:SkillService(), beHitParam)
  end
end
