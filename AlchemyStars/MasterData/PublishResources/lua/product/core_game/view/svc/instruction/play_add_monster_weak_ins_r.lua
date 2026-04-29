require("base_ins_r")
_class("PlayAddMonsterWeakInstruction", BaseInstruction)
PlayAddMonsterWeakInstruction = PlayAddMonsterWeakInstruction

function PlayAddMonsterWeakInstruction:Constructor(paramList)
  self._weakEffectID = tonumber(paramList.weakEffectID)
  self._convertDelayTime = tonumber(paramList.convertDelayTime)
  self._hitEffectID = tonumber(paramList.hitEffectID)
end

function PlayAddMonsterWeakInstruction:GetCacheResource()
  local t = {}
  if self._hitEffectID and self._hitEffectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayAddMonsterWeakInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.AddMonsterWeak)
  if resultArray == nil or table.count(resultArray) == 0 then
    Log.fatal("PlayAddMonsterWeakInstruction, result is nil.")
    return
  end
  local playSkillService = world:GetService("PlaySkill")
  local monsterRSvc = world:GetService("MonsterShowRender")
  for i, v in ipairs(resultArray) do
    local res = v
    local entityID = res:GetEntityID()
    local weakResults = res:GetWeakResult()
    local damageResults = res:GetDamageResult()
    local targetEntity = world:GetEntityByID(entityID)
    local targetRenderPos = targetEntity:GetDamageCenter()
    monsterRSvc:ShowMonsterWeak(targetEntity, weakResults)
    if damageResults and table.count(damageResults) > 0 then
      for _, damageResult in ipairs(damageResults) do
        local targetEntityID = damageResult:GetTargetID()
        local targetEntity = world:GetEntityByID(targetEntityID)
        local damageInfo = damageResult:GetDamageInfo(1)
        local damageGridPos = damageResult:GetGridPos()
        local beHitParam = HandleBeHitParam:New():SetHandleBeHitParam_CasterEntity(casterEntity):SetHandleBeHitParam_TargetEntity(targetEntity):SetHandleBeHitParam_HitAnimName("Hit"):SetHandleBeHitParam_HitEffectID(self._hitEffectID):SetHandleBeHitParam_DamageInfo(damageInfo):SetHandleBeHitParam_DamagePos(damageGridPos):SetHandleBeHitParam_HitTurnTarget(TurnToTargetType.None):SetHandleBeHitParam_DeathClear(false):SetHandleBeHitParam_IsFinalHit(false):SetHandleBeHitParam_SkillID(skillID)
        playSkillService:HandleBeHit(TT, beHitParam)
      end
    end
  end
end
