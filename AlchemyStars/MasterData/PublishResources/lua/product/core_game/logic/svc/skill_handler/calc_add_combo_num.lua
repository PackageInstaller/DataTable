require("calc_base")
_class("SkillEffectCalc_AddComboNum", SkillEffectCalc_Base)
SkillEffectCalc_AddComboNum = SkillEffectCalc_AddComboNum

function SkillEffectCalc_AddComboNum:Constructor(world)
  self._world = world
end

function SkillEffectCalc_AddComboNum:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local battleSvc = self._world:GetService("Battle")
  local curComboNum = battleSvc:GetLogicComboNum()
  curComboNum = curComboNum + 1
  battleSvc:SetLogicComboNum(curComboNum)
  local battleStatComponent = self._world:BattleStat()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  battleStatComponent:SetOneChainMaxNormalAttack(teamEntity, curComboNum)
  return SkillAddComboNumEffectResult:New()
end
