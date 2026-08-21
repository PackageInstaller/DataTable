_class("SkillEffectCalc_LeaveEnterBattleField", Object)
SkillEffectCalc_LeaveEnterBattleField = SkillEffectCalc_LeaveEnterBattleField

function SkillEffectCalc_LeaveEnterBattleField:Constructor(world)
  self._world = world
end

function SkillEffectCalc_LeaveEnterBattleField:DoSkillEffectCalculator(skillEffectCalcParam)
  local param = skillEffectCalcParam.skillEffectParam
  return SkillLeaveEnterBattleFieldResult:New(param:IsLeave(), param:EnterPos(), param:EnterDir())
end
