require("calc_base")
_class("SkillEffectCalc_SplashDamage", SkillEffectCalc_Base)
SkillEffectCalc_SplashDamage = SkillEffectCalc_SplashDamage

function SkillEffectCalc_SplashDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_SplashDamage:DoSkillEffectCalculator(param)
  local attacker = self._world:GetEntityByID(param.casterEntityID)
  local cmptRoutine = attacker:SkillContext()
  local effectParam = param.skillEffectParam
  if param.targetEntityIDs and #param.targetEntityIDs == 1 and param.targetEntityIDs[1] == -1 then
    return {
      SkillEffectSplashDamageResult:New({}, SkillScopeResult:New(SkillScopeType.None, Vector2.zero, {}, {}), effectParam:GetSkillEffectDamageStageIndex())
    }
  end
  local lastHitpoint = param.gridPos
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local calcScope = utilScopeSvc:GetSkillScopeCalc()
  local scopeType = effectParam:GetSplashScopeType()
  local scopeParam = effectParam:GetSplashScopeParam()
  local parser = SkillScopeParamParser:New()
  scopeParam = parser:ParseScopeParam(scopeType, scopeParam)
  local casterBodyArea = attacker:BodyArea():GetArea()
  local casterDirection = attacker:GetGridDirection()
  local targetType = SkillTargetType.MonsterTrap
  local splashScopeResult = calcScope:ComputeScopeRange(scopeType, scopeParam, lastHitpoint, casterBodyArea, casterDirection, SkillTargetType.MonsterTrap, lastHitpoint)
  local skillEffectResultContainer = attacker:SkillContext():GetResultContainer()
  local damageResults = skillEffectResultContainer:GetEffectResultsAsArray(SkillEffectType.Damage, effectParam:GetBaseDamageStageIndex())
  if not damageResults then
    return {
      SkillEffectSplashDamageResult:New({}, SkillScopeResult:New(SkillScopeType.None, Vector2.zero, {}, {}), effectParam:GetSkillEffectDamageStageIndex())
    }
  end
  local baseDamage = 0
  for _, result in ipairs(damageResults) do
    if result:GetGridPos() == param.gridPos then
      baseDamage = result:GetTotalDamage()
    end
  end
  if baseDamage <= 0 then
    return {
      SkillEffectSplashDamageResult:New({}, SkillScopeResult:New(SkillScopeType.None, Vector2.zero, {}, {}), effectParam:GetSkillEffectDamageStageIndex())
    }
  end
  local cSkillContext = attacker:SkillContext()
  cSkillContext:SetSplashBaseDamage(baseDamage)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetArray = targetSelector:DoSelectSkillTarget(attacker, SkillTargetType.MonsterTrap, splashScopeResult)
  local targetGridAreaMap = {}
  for _, targetEntityID in ipairs(targetArray) do
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity then
      local targetCenterPos = targetEntity:GetGridPosition()
      local bodyAreaComponent = targetEntity:BodyArea()
      if bodyAreaComponent then
        local bodyAreaArray = bodyAreaComponent:GetArea()
        for _, areaPos in ipairs(bodyAreaArray) do
          local absAreaPos = areaPos + targetCenterPos
          if not targetGridAreaMap[absAreaPos.x] then
            targetGridAreaMap[absAreaPos.x] = {}
          end
          targetGridAreaMap[absAreaPos.x][absAreaPos.y] = targetEntityID
        end
      else
        if not targetGridAreaMap[targetCenterPos.x] then
          targetGridAreaMap[targetCenterPos.x] = {}
        end
        targetGridAreaMap[targetCenterPos.x][targetCenterPos.y] = targetEntityID
      end
    end
  end
  local resultArray = {}
  local attackRange = splashScopeResult:GetAttackRange()
  table.removev(attackRange, lastHitpoint)
  for _, attackPos in ipairs(attackRange) do
    if targetGridAreaMap[attackPos.x] and targetGridAreaMap[attackPos.x][attackPos.y] then
      local defenderEntityID = targetGridAreaMap[attackPos.x][attackPos.y]
      local defender = self._world:GetEntityByID(defenderEntityID)
      local attackerPos = param.attackPos
      local gridPos = attackPos
      local skillDamageParam = param.skillEffectParam
      local effectCalcSvc = self._skillEffectService
      local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
      local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(attacker, attackerPos, defender, gridPos, param.skillID, skillDamageParam, SkillEffectType.SplashDamage, damageStageIndex)
      local skillResult = effectCalcSvc:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
      table.insert(resultArray, skillResult)
    end
  end
  return {
    SkillEffectSplashDamageResult:New(resultArray, splashScopeResult, effectParam:GetSkillEffectDamageStageIndex())
  }
end
