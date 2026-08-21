require("calc_base")
_class("SkillEffectCalc_AngleFreeLine", SkillEffectCalc_Base)
SkillEffectCalc_AngleFreeLine = SkillEffectCalc_AngleFreeLine

function SkillEffectCalc_AngleFreeLine:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local pickupComponent = casterEntity:ActiveSkillPickUpComponent()
  if not pickupComponent then
    Log.error(self._className, "施法者没有ActiveSkillPickupComponent")
    return
  end
  local pickupPosArray = pickupComponent:GetAllValidPickUpGridPos()
  if #pickupPosArray == 0 then
    Log.error(self._className, "没有点选位置记录")
    return
  end
  local sep = skillEffectCalcParam.skillEffectParam
  local pickUpIndex = sep:GetPickupIndex()
  local selectedPickupPos = pickupPosArray[pickUpIndex]
  selectedPickupPos = selectedPickupPos or pickupPosArray[pickUpIndex - 1]
  local resultArray = {}
  local result = self:_CalcResultForSinglePickup(selectedPickupPos, casterEntity, skillEffectCalcParam)
  table.insert(resultArray, result)
  return resultArray
end

function SkillEffectCalc_AngleFreeLine:_CalcResultForSinglePickup(selectedPickupPos, casterEntity, skillEffectCalcParam)
  local sep = skillEffectCalcParam.skillEffectParam
  local scopeType = sep:GetSkillEffectScopeType()
  local scopeParamRaw = sep:GetSkillEffectScopeParam()
  local configSvc = self._world:GetService("Config")
  local helper = configSvc._skillConfigHelper
  local parser = helper._scopeParamParser
  local scopeParam = parser:ParseScopeParam(scopeType, scopeParamRaw)
  if scopeType == nil or scopeParam == nil then
    local configService = self._world:GetService("Config")
    local skillConfigData = configService:GetSkillConfigData(skillEffectCalcParam.skillID, casterEntity)
    scopeType = skillConfigData:GetSkillScopeType()
    scopeParam = skillConfigData:GetSkillScopeParam()
  end
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local scopeCalc = utilScopeSvc:GetSkillScopeCalc()
  local scopeResult = scopeCalc:ComputeScopeRange(scopeType, scopeParam, selectedPickupPos, casterEntity:BodyArea():GetArea(), casterEntity:GetGridDirection(), SkillTargetType.MonsterTrap, casterEntity:GetGridPosition())
  local targetSelector = self._world:GetSkillScopeTargetSelector()
  local targetIDArray = targetSelector:DoSelectSkillTarget(casterEntity, SkillTargetType.MonsterTrap, scopeResult, skillEffectCalcParam.skillID)
  local logicService = self._world:GetService("SkillLogic")
  local activeSkillCalc = logicService._activeSkillCalculator
  local foreachEffectCalc = activeSkillCalc._foreachEffectCalculator
  local generalEffectCalc = foreachEffectCalc._generalEffectCalculator
  local foreachTargetCalc = generalEffectCalc._foreachTargetCalculator
  local configService = self._world:GetService("Config")
  local skillConfigData = configService:GetSkillConfigData(skillEffectCalcParam.skillID, casterEntity)
  local scopeFilterParam = skillConfigData:GetScopeFilterParam()
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local skillEffectType = skillEffectParam:GetEffectType()
  local effectScopeFilterParam = skillEffectParam:GetScopeFilterParam()
  local finalScopeFilterParam = effectScopeFilterParam:IsDefault() and scopeFilterParam or effectScopeFilterParam
  local originParam = skillEffectCalcParam.skillEffectParam
  local damageParam = SkillDamageEffectParam:New({
    target = originParam:GetTargetType(),
    percent = originParam:GetDamagePercent(),
    formulaID = originParam:GetDamageFormulaID()
  })
  local targetIDs = {}
  for _, id in ipairs(targetIDArray) do
    if not table.icontains(targetIDs, id) then
      table.insert(targetIDs, id)
    end
  end
  local buffLogicService = self._world:GetService("BuffLogic")
  local buffSeq
  local increaseMul = 0
  local buffComponent = casterEntity:BuffComponent()
  if buffComponent then
    buffSeq = buffComponent:GetBuffValue("IncreaseActiveDamageSkillSeqID")
    increaseMul = buffComponent:GetBuffValue("IncreaseActiveSkillDamageMul") or 0
  end
  if buffSeq then
    buffLogicService:ChangeBaseAttack(casterEntity, buffSeq, ModifyBaseAttackType.AttackPercentage, increaseMul)
  end
  local damageResults = foreachTargetCalc:DoTargetEffectCalculate(casterEntity, scopeResult, targetIDs, damageParam, finalScopeFilterParam)
  if buffSeq then
    buffLogicService:RemoveBaseAttack(casterEntity, buffSeq, ModifyBaseAttackType.AttackPercentage)
  end
  local result = SkillEffectAngleFreeLineDamageResult:New(casterEntity:GetGridPosition(), selectedPickupPos, damageResults)
  return result
end
