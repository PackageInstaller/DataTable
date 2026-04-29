require("calc_base")
_class("SkillEffectCalc_Damage", SkillEffectCalc_Base)
SkillEffectCalc_Damage = SkillEffectCalc_Damage

function SkillEffectCalc_Damage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_Damage:DoSkillEffectCalculator(skillEffectCalcParam)
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

function SkillEffectCalc_Damage:_CalculateSingleTarget(skillEffectCalcParam, defenderEntityID)
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local defender = self._world:GetEntityByID(defenderEntityID)
  if defender == nil then
    Log.notice("CalculationForeachTarget defender is null ", defenderEntityID)
    local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(nil, -1, 0, nil, damageStageIndex)
    return {skillResult}
  end
  local nTargetType = skillDamageParam:GetTargetType()
  if not PieceBlockData.IsEnumMatch(defender, nTargetType, nil) then
    return
  end
  if skillEffectCalcParam.skillRange == nil then
    skillEffectCalcParam.skillRange = {
      skillEffectCalcParam.gridPos
    }
  end
  local formulaService = self._world:GetService("Formula")
  local attackPos = skillEffectCalcParam.attackPos
  local gridPos = skillEffectCalcParam.gridPos
  local skillResultList = {}
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local defender = self._world:GetEntityByID(defenderEntityID)
  local effectCalcSvc = self._skillEffectService
  local damageIncreaseBuffEffectType = skillDamageParam:GetDamageIncreaseBuffEffectType()
  local damageIncreaseMul = skillDamageParam:GetDamageIncreaseMul()
  if damageIncreaseBuffEffectType and damageIncreaseMul then
    local cSkillContext = attacker:SkillContext()
    cSkillContext:SetDamagePctIncreaseBuffEffectType(damageIncreaseBuffEffectType)
    cSkillContext:SetDamagePctIncreaseMul(damageIncreaseMul)
  end
  if 0 < skillDamageParam:GetNearPoint() then
    local listBodyPos = defender:GetCoverAreaList()
    local sortPosList = SortedArray:New(Algorithm.COMPARE_CUSTOM, AiSortByDistance._ComparerByNear)
    sortPosList:AllowDuplicate()
    for keyIndex, areaPos in ipairs(listBodyPos) do
      local bIsInRange = false
      if skillEffectCalcParam.skillRange[1]._className == nil then
        for _, skillRangePos in ipairs(skillEffectCalcParam.skillRange) do
          bIsInRange = true
          break
        end
      elseif table.icontains(skillEffectCalcParam.skillRange, areaPos) then
        bIsInRange = true
      end
      if bIsInRange then
        AINewNode.InsertSortedArray(sortPosList, attackPos, areaPos, keyIndex)
      end
    end
    local nearPointGrid = sortPosList:GetAt(1):GetPosData()
    if gridPos.x ~= nearPointGrid.x or gridPos.y ~= nearPointGrid.y then
      return
    end
  end
  local configServer = self._world:GetService("Config")
  local config = configServer:GetSkillConfigData(skillEffectCalcParam.skillID)
  local curSkillDamageIndex
  if config:GetSkillType() == SkillType.Normal then
    curSkillDamageIndex = skillEffectCalcParam:GetNormalAttackIndex()
  end
  local damageTimes = skillDamageParam:GetDamageTimes()
  for i = 1, damageTimes do
    local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
    local ignoreShield = skillDamageParam:IsIgnoreShield()
    local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(attacker, attackPos, defender, gridPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex, ignoreShield, curSkillDamageIndex, skillEffectCalcParam:GetDamageGridPos())
    local skillResult = effectCalcSvc:NewSkillDamageEffectResult(gridPos, defenderEntityID, nTotalDamage, listDamageInfo, damageStageIndex)
    table.insert(skillResultList, skillResult)
  end
  return skillResultList
end
