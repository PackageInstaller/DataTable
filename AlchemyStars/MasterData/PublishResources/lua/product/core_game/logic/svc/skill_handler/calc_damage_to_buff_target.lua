require("calc_damage")
_class("SkillEffectCalc_DamageToBuffTarget", SkillEffectCalc_Damage)
SkillEffectCalc_DamageToBuffTarget = SkillEffectCalc_DamageToBuffTarget

function SkillEffectCalc_DamageToBuffTarget:DoSkillEffectCalculator(calcParam)
  local results = {}
  local effectParam = calcParam:GetSkillEffectParam()
  local specificBuffEffectType = effectParam:GetSpecificBuffEffectType()
  local lbuffsvc = self._world:GetService("BuffLogic")
  local targets = calcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local e = self._world:GetEntityByID(targetID)
    local cBuff = e:BuffComponent()
    local tBuff = cBuff:GetBuffArrayByBuffEffect(specificBuffEffectType)
    if 0 < #tBuff then
      local result = self:_CalculateSingleTarget(calcParam, targetID)
      if result then
        table.appendArray(results, result)
      end
    end
  end
  return results
end
