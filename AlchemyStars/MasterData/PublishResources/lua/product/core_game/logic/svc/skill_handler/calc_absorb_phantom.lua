require("calc_base")
_class("SkillEffectCalc_AbsorbPhantom", SkillEffectCalc_Base)
SkillEffectCalc_AbsorbPhantom = SkillEffectCalc_AbsorbPhantom

function SkillEffectCalc_AbsorbPhantom:Constructor(world)
  self._world = world
end

function SkillEffectCalc_AbsorbPhantom:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  for _, targetID in ipairs(targets) do
    local result = self:_CalculateSingleTarget(skillEffectCalcParam, targetID)
    if result then
      table.insert(results, result)
    end
  end
  return results
end

function SkillEffectCalc_AbsorbPhantom:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local skillParam = skillEffectCalcParam:GetSkillEffectParam()
  local target = targetID
  local caster = skillEffectCalcParam:GetCasterEntityID()
  local phantom = self._world:GetEntityByID(target)
  if target == nil or phantom == nil then
    return nil
  end
  local casterEntity = self._world:GetEntityByID(caster)
  local revocerHP = casterEntity:Attributes():CalcMaxHp() * skillParam:GetHpRecoverPercent()
  return SkillAbsorbPhantomEffectResult:New(target, math.floor(revocerHP))
end
