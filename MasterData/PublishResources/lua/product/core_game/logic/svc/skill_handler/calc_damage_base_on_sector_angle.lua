require("calc_base")
_class("SkillEffectCalc_DamageBasedOnSectorAngle", SkillEffectCalc_Base)
SkillEffectCalc_DamageBasedOnSectorAngle = SkillEffectCalc_DamageBasedOnSectorAngle

function SkillEffectCalc_DamageBasedOnSectorAngle:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_DamageBasedOnSectorAngle:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.appendArray(results, result)
    end
  end
  return results
end

function SkillEffectCalc_DamageBasedOnSectorAngle:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local defender = self._world:GetEntityByID(defenderEntityID)
  if defender == nil then
    Log.notice("CalculationForeachTarget defender is null ", defenderEntityID)
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(nil, -1, 0, nil, nil)
    return {skillResult}
  end
  if skillEffectCalcParam.skillRange == nil then
    skillEffectCalcParam.skillRange = {
      skillEffectCalcParam.gridPos
    }
  end
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local attackPos = skillEffectCalcParam.attackPos
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local area = defender:BodyArea():GetArea()
  local locationPos = defender:GridLocation():GetGridPos()
  local effectCalcSvc = self._skillEffectService
  local skillResultList = {}
  for i, bodyArea in ipairs(area) do
    local workPos = locationPos + bodyArea
    local damageRate = self:_CalculateAngleDamageRate(attackPos, workPos, skillEffectCalcParam)
    skillDamageParam:SetAngleDamageRate(damageRate)
    if table.intable(skillEffectCalcParam.skillRange, workPos) then
      local gridPos = workPos
      local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(attacker, attackPos, defender, gridPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex)
      local skillResult = effectCalcSvc:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
      table.insert(skillResultList, skillResult)
    end
  end
  return skillResultList
end

function SkillEffectCalc_DamageBasedOnSectorAngle:_CalculateAngleDamageRate(casterPos, targetPos, skillEffectCalcParam)
  local centerPosVec = skillEffectCalcParam:GetCenterPos()
  if 1 < #centerPosVec then
    local selPos = centerPosVec[1]
    local mainDir = selPos - casterPos
    local targetDir = targetPos - casterPos
    local diffAngle = Vector2.Angle(mainDir, targetDir)
    diffAngle = math.floor(diffAngle + 0.5)
    local skillDamageParam = skillEffectCalcParam.skillEffectParam
    local maxAngle = skillDamageParam:GetMaxAngle()
    local minRate = skillDamageParam:GetMinDamageRate()
    if 0 < maxAngle then
      local decRateRange = 1 - minRate
      local resRate = 1 - diffAngle / maxAngle * decRateRange
      return resRate
    end
  end
  return 1
end
