require("base_ins_r")
_class("PlayDetonateMonsterWeakInstruction", BaseInstruction)
PlayDetonateMonsterWeakInstruction = PlayDetonateMonsterWeakInstruction

function PlayDetonateMonsterWeakInstruction:Constructor(paramList)
  self._hitEffectID = tonumber(paramList.hitEffectID)
  self._effectID = tonumber(paramList.effectID)
end

function PlayDetonateMonsterWeakInstruction:GetCacheResource()
  local t = {}
  if self._effectID and self._effectID > 0 then
    table.insert(t, {
      Cfg.cfg_effect[self._effectID].ResPath,
      1
    })
  end
  if self._hitEffectID and 0 < self._hitEffectID then
    table.insert(t, {
      Cfg.cfg_effect[self._hitEffectID].ResPath,
      1
    })
  end
  return t
end

function PlayDetonateMonsterWeakInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local world = casterEntity:GetOwnerWorld()
  local skillEffectResultContainer = casterEntity:SkillRoutine():GetResultContainer()
  local skillID = skillEffectResultContainer:GetSkillID()
  local resultArray = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.DetonateMonsterWeak)
  if resultArray == nil or table.count(resultArray) == 0 then
    Log.fatal("PlayDetonateMonsterWeakInstruction, result is nil.")
    return
  end
  local effectService = world:GetService("Effect")
  local playSkillService = world:GetService("PlaySkill")
  for i, v in ipairs(resultArray) do
    local res = v
    local entityID = res:GetEntityID()
    local weakResults = res:GetWeakResult()
    local damageResults = res:GetDamageResult()
    local damageCenters = res:GetDamageCenters()
    local targetEntity = world:GetEntityByID(entityID)
    local targetRenderPos = targetEntity:GetDamageCenter()
    local renderMonsterWeakComponent = targetEntity:RenderMonsterWeak()
    if not renderMonsterWeakComponent then
      targetEntity:AddRenderMonsterWeak()
      renderMonsterWeakComponent = targetEntity:RenderMonsterWeak()
    end
    local effectHolderCmpt = targetEntity:EffectHolder()
    if weakResults and table.count(weakResults) > 0 then
      for _, weak in ipairs(weakResults) do
        local monsterWeakData = weak
        local key = monsterWeakData:GetKey()
        local effectList = renderMonsterWeakComponent:GetEffectEntity(key)
        if effectList and table.count(effectList) > 0 then
          for effectID, edgePos in pairs(effectList) do
            local effectEntity = world:GetEntityByID(effectID)
            if effectEntity then
              GameGlobal.TaskManager():CoreGameStartTask(function()
                local cView = effectEntity:View()
                local gameObject = cView:GetGameObject()
                local anim = gameObject:GetComponentInChildren(typeof(UnityEngine.Animation))
                if anim then
                  anim:Play(BattleConst.MonsterWeakEffectDeath)
                end
                YIELD(TT, 533)
                world:DestroyEntity(effectEntity)
              end)
            end
          end
        end
        renderMonsterWeakComponent:RemoveEffectEntity(key)
      end
    end
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
    if damageCenters and table.count(damageCenters) > 0 then
      for _, pos in ipairs(damageCenters) do
        local effEntity = effectService:CreateWorldPositionEffect(self._effectID, pos)
      end
    end
  end
end
