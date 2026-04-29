require("calc_base")
_class("SkillEffectCalc_DamageBySelectPieceCount", SkillEffectCalc_Base)
SkillEffectCalc_DamageBySelectPieceCount = SkillEffectCalc_DamageBySelectPieceCount

function SkillEffectCalc_DamageBySelectPieceCount:Constructor(world)
  self._world = world
end

function SkillEffectCalc_DamageBySelectPieceCount:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectService = self._world:GetService("SkillEffectCalc")
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local attacker = self._world:GetEntityByID(skillEffectCalcParam.casterEntityID)
  local attackPos = skillEffectCalcParam.attackPos
  local gridPos = skillEffectCalcParam.gridPos
  local damageStageIndex = skillEffectParam:GetSkillEffectDamageStageIndex()
  local pieceTypeList = skillEffectParam:GetPieceTypeList()
  local boardServiceLogic = self._world:GetService("BoardLogic")
  local pieceRange = boardServiceLogic:GetGridPosByPieceType(pieceTypeList)
  local basePercent = skillEffectParam:GetBaseValue()
  local changeValue = skillEffectParam:GetChangeValue()
  local addPercent = changeValue * table.count(pieceRange)
  local damageParam = SkillDamageEffectParam:New({
    percent = {basePercent},
    formulaID = skillEffectParam:GetDamageFormulaID(),
    damageStageIndex = damageStageIndex,
    addPercent = addPercent
  })
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local target = self._world:GetEntityByID(targetID)
    if target then
      local nTotalDamage, listDamageInfo = skillEffectService:ComputeSkillDamage(attacker, attackPos, target, gridPos, skillEffectCalcParam.skillID, damageParam, SkillEffectType.Damage, damageStageIndex)
      local skillResult = skillEffectService:NewSkillDamageEffectResult(gridPos, targetID, nTotalDamage, listDamageInfo, damageStageIndex)
      table.insert(results, skillResult)
    end
  end
  return results
end
