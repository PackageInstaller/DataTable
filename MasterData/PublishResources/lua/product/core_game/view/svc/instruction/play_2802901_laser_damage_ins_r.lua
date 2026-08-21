require("base_ins_r")
_class("Play2802901LaserDamageInstruction", BaseInstruction)
Play2802901LaserDamageInstruction = Play2802901LaserDamageInstruction

function Play2802901LaserDamageInstruction:Constructor(paramList)
  self._effectID = tonumber(paramList.effectID)
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._startWaitTime = tonumber(paramList.startWaitTime) or 1000
  self._oneGridTime = tonumber(paramList.oneGridTime) or 100
  self._endtWaitTime = tonumber(paramList.endtWaitTime) or 1000
end

function Play2802901LaserDamageInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local damageResults1 = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, 1)
  local damageResults2 = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, 2)
  local scopeResult = skillEffectResultContainer:GetScopeResult()
  local attackRange = scopeResult:GetAttackRange()
  YIELD(TT, self._startWaitTime)
  local gridPosStart1 = Vector2(1, 9)
  local gridPosStart2 = Vector2(1, 1)
  local gridPosList1 = {}
  local gridPosList2 = {}
  for _, pos in pairs(attackRange) do
    if pos.y == gridPosStart1.y then
      table.insert(gridPosList1, pos)
    end
    if pos.x == gridPosStart2.x then
      table.insert(gridPosList2, pos)
    end
  end
  if damageResults1 and table.count(damageResults1) > 0 then
    for _, result in pairs(damageResults1) do
      local targetEntityID = result:GetTargetID()
      local targetEntity = world:GetEntityByID(targetEntityID)
      local pos = result:GetGridPos()
      if targetEntity and table.icontains(gridPosList1, pos) then
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          local hitTime = Vector2.Distance(pos, gridPosStart1) * self._oneGridTime
          YIELD(TT, hitTime)
          local targetDamage = result:GetDamageInfo(1)
          self:_PlayAttackOnPos(TT, casterEntity, pos, targetEntity, targetDamage)
        end)
      end
    end
  end
  if damageResults2 and table.count(damageResults2) > 0 then
    for _, result in pairs(damageResults2) do
      local targetEntityID = result:GetTargetID()
      local targetEntity = world:GetEntityByID(targetEntityID)
      local pos = result:GetGridPos()
      if targetEntity and table.icontains(gridPosList2, pos) then
        GameGlobal.TaskManager():CoreGameStartTask(function(TT)
          local hitTime = Vector2.Distance(pos, gridPosStart2) * self._oneGridTime
          YIELD(TT, hitTime)
          local targetDamage = result:GetDamageInfo(1)
          self:_PlayAttackOnPos(TT, casterEntity, pos, targetEntity, targetDamage)
        end)
      end
    end
  end
  YIELD(TT, self._endtWaitTime)
end

function Play2802901LaserDamageInstruction:_PlayAttackOnPos(TT, casterEntity, pos, targetEntity, targetDamage)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local isFinalAttack = false
  local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName("Hit"):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(targetDamage):SetHandleBeHitParam_DamagePos(pos):SetHandleBeHitParam_HitTurnTarget(TurnToTargetType.Caster):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(isFinalAttack):SetHandleBeHitParam_SkillID(skillID)
  local playSkillService = world:GetService("PlaySkill")
  playSkillService:HandleBeHit(TT, beHitParam)
end

function Play2802901LaserDamageInstruction:GetCacheResource()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      7
    })
  end
  return t
end
