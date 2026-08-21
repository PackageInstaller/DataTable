require("calc_base")
_class("SkillEffectCalc_DamageBasedOnPickUpRect", SkillEffectCalc_Base)
SkillEffectCalc_DamageBasedOnPickUpRect = SkillEffectCalc_DamageBasedOnPickUpRect

function SkillEffectCalc_DamageBasedOnPickUpRect:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_DamageBasedOnPickUpRect:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local rectX = {}
  local rectY = {}
  for k, pos in ipairs(skillEffectCalcParam.skillRange) do
    if not table.intable(rectX, pos.x) then
      table.insert(rectX, pos.x)
    end
    if not table.intable(rectY, pos.y) then
      table.insert(rectY, pos.y)
    end
  end
  skillEffectParam:SetSkillRangeRectParam(table.count(rectX), table.count(rectY))
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.appendArray(results, result)
    end
  end
  return results
end

function SkillEffectCalc_DamageBasedOnPickUpRect:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
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
  local effectCalcSvc = self._skillEffectService
  local skillResultList = {}
  local area = defender:BodyArea():GetArea()
  local locationPos = defender:GridLocation():GetGridPos()
  for i, bodyArea in ipairs(area) do
    local workPos = locationPos + bodyArea
    if table.intable(skillEffectCalcParam.skillRange, workPos) then
      local gridPos = workPos
      local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(attacker, attackPos, defender, gridPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex)
      local skillResult = effectCalcSvc:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
      table.insert(skillResultList, skillResult)
    end
  end
  return skillResultList
end
