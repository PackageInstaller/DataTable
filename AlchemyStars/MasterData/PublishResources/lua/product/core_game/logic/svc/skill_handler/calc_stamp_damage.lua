_class("SkillEffectCalc_StampDamage", Object)
SkillEffectCalc_StampDamage = SkillEffectCalc_StampDamage

function SkillEffectCalc_StampDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_StampDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.appendArray(results, result)
    end
  end
  return results
end

function SkillEffectCalc_StampDamage:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local percents = skillDamageParam:GetDamagePercent()
  local damageFormulaID = skillDamageParam:GetDamageFormulaID()
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local defender = self._world:GetEntityByID(defenderEntityID)
  if defender == nil then
    Log.notice("CalculationForeachTarget defender is null ", defenderEntityID)
    local skillResult = SkillDamageEffectResult:New(nil, -1, 0, 0, nil)
    return skillResult
  end
  local defenderPos = defender:GridLocation().Position
  local defenderAreaList = {}
  local defenderAreaCmpt = defender:BodyArea()
  local defenderArea = defenderAreaCmpt:GetArea()
  for _, areaOffset in ipairs(defenderArea) do
    local areaPos = Vector2(defenderPos.x + areaOffset.x, defenderPos.y + areaOffset.y)
    defenderAreaList[#defenderAreaList + 1] = areaPos
  end
  if skillEffectCalcParam.skillRange == nil then
    skillEffectCalcParam.skillRange = {}
    skillEffectCalcParam.skillRange[#skillEffectCalcParam.skillRange + 1] = skillEffectCalcParam.gridPos
  end
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillEffectCalcParam.skillID)
  local skillType = skillConfigData:GetSkillType()
  local attrModifyType = ModifySkillParamType.ChainSkill
  if skillType == SkillType.Active then
    attrModifyType = ModifySkillParamType.ActiveSkill
  end
  local attackRangeList = {}
  for _, skillRangePos in ipairs(skillEffectCalcParam.skillRange) do
    if skillRangePos._className == nil then
      for _, curPos in ipairs(skillRangePos) do
        for _, areaPos in ipairs(defenderAreaList) do
          if curPos == areaPos then
            attackRangeList[#attackRangeList + 1] = curPos
          end
        end
      end
    else
      for _, areaPos in ipairs(defenderAreaList) do
        if skillRangePos == areaPos then
          attackRangeList[#attackRangeList + 1] = skillRangePos
        end
      end
    end
  end
  local addDamageRate = skillEffectCalcParam.skillEffectParam:GetAddDamageByStamp()
  local addDamageBuffId = skillEffectCalcParam.skillEffectParam:GetBuffID()
  local buffService = self._world:GetService("BuffLogic")
  local formulaService = self._world:GetService("Formula")
  local svcCalcDamage = self._world:GetService("CalcDamage")
  local battleStatCmpt = self._world:BattleStat()
  local skillResultList = {}
  for _, damagePos in ipairs(attackRangeList) do
    local DamageCoefficient = 0
    local defenderBuffComp = defender:BuffComponent()
    local buffInstance = defenderBuffComp:GetBuffById(addDamageBuffId)
    if buffInstance then
      local count = buffInstance:GetLayerCount()
      DamageCoefficient = count * addDamageRate
    end
    if 0 < DamageCoefficient then
      Log.debug("Buff have stamp , and DamageCoefficient = ", DamageCoefficient)
    end
    buffService:ChangeSkillFinalParam(attacker, 1, attrModifyType, DamageCoefficient)
    local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
    local totalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(attacker, skillEffectCalcParam.attackPos, defender, damagePos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex, nil, nil, damagePos)
    buffService:RemoveSkillFinalParam(attacker, 1, attrModifyType)
    local skillResult = SkillDamageEffectResult:New(damagePos, defenderEntityID, totalDamage, listDamageInfo)
    skillResultList[#skillResultList + 1] = skillResult
  end
  return skillResultList
end
