_class("SkillEffectCalc_SummonTrapByTargetPos", Object)
SkillEffectCalc_SummonTrapByTargetPos = SkillEffectCalc_SummonTrapByTargetPos

function SkillEffectCalc_SummonTrapByTargetPos:Constructor(world)
  self._world = world
end

function SkillEffectCalc_SummonTrapByTargetPos:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local skillResultArray = self:_GetSkillResultByEffectType(casterEntity, SkillEffectType.DynamicCenterDamage)
  if not skillResultArray then
    return {}
  end
  local skillEffectParamSummon = skillEffectCalcParam.skillEffectParam
  local trapID = skillEffectParamSummon:GetTrapID()
  local results = {}
  for _, _result in pairs(skillResultArray) do
    table.insert(results, SkillSummonTrapEffectResult:New(trapID, _result:GetFinalCenter()))
  end
  return results
end

function SkillEffectCalc_SummonTrapByTargetPos:_GetSkillResultByEffectType(casterEntity, effectType)
  local petAttackData = casterEntity:SkillPetAttackData()
  if petAttackData then
    local chainAttackDataList = petAttackData:GetMultiStageChainAttackDataList()
    if chainAttackDataList then
      for _, chainAttackData in pairs(chainAttackDataList) do
        for _, skillChainAttackData in pairs(chainAttackData) do
          local skillEffectResult = skillChainAttackData:GetEffectResultsAsArray(effectType)
          if skillEffectResult then
            return skillEffectResult
          end
        end
      end
    end
  end
  return nil
end
