require("calc_base")
_class("SkillEffectCalcDeathBomb", SkillEffectCalc_Base)
SkillEffectCalcDeathBomb = SkillEffectCalcDeathBomb

function SkillEffectCalcDeathBomb:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalcDeathBomb:DoSkillEffectCalculator(param)
  if #param.targetEntityIDs == 0 or param.targetEntityIDs[1] == -1 then
    return {
      SkillEffectDeathBombResult:New()
    }
  end
  local attacker = self._world:GetEntityByID(param.casterEntityID)
  local effectParam = param.skillEffectParam
  local lastHitpoint = param.gridPos
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local calcScope = utilScopeSvc:GetSkillScopeCalc()
  local scopeType = effectParam:GetDeathBombScopeType()
  local scopeParam = effectParam:GetDeathBombScopeParam()
  local parser = SkillScopeParamParser:New()
  local rangeScopeParam = parser:ParseScopeParam(scopeType, scopeParam)
  local casterBodyArea = attacker:BodyArea():GetArea()
  local casterDirection = attacker:GetGridDirection()
  local deathTargetID = param.targetEntityIDs[1]
  local deathTargetEntity = self._world:GetEntityByID(deathTargetID)
  local buffLogicService = self._world:GetService("BuffLogic")
  local buffID = effectParam:GetDeathBombBuffID()
  local deathTargetBuffLayer = buffLogicService:GetBuffLayer(deathTargetEntity, buffID)
  local ScopeResult = calcScope:ComputeScopeRange(scopeType, rangeScopeParam, lastHitpoint, casterBodyArea, casterDirection, SkillTargetType.MonsterTrap, lastHitpoint)
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetArray = targetSelector:DoSelectSkillTarget(attacker, SkillTargetType.MonsterTrap, ScopeResult)
  local targetGridAreaMap = {}
  for _, targetEntityID in ipairs(targetArray) do
    local targetEntity = self._world:GetEntityByID(targetEntityID)
    if targetEntity then
      targetGridAreaMap[targetEntityID] = {}
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
  local attackRange = ScopeResult:GetAttackRange()
  table.removev(attackRange, lastHitpoint)
  local skillDamageParam = param.skillEffectParam
  skillDamageParam.buffLayer = deathTargetBuffLayer
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  for _, attackPos in ipairs(attackRange) do
    if targetGridAreaMap[attackPos.x] and targetGridAreaMap[attackPos.x][attackPos.y] then
      local defenderEntityID = targetGridAreaMap[attackPos.x][attackPos.y]
      local defender = self._world:GetEntityByID(defenderEntityID)
      local attackerPos = param.attackPos
      local gridPos = attackPos
      local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(attacker, attackerPos, defender, gridPos, param.skillID, skillDamageParam, SkillEffectType.DeathBomb, damageStageIndex)
      local skillResult = self._skillEffectService:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
      table.insert(resultArray, skillResult)
    end
  end
  return resultArray
end
