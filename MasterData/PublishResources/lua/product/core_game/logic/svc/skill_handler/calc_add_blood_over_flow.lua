require("calc_base")
_class("SkillEffectCalc_AddBloodOverFlow", SkillEffectCalc_Base)
SkillEffectCalc_AddBloodOverFlow = SkillEffectCalc_AddBloodOverFlow

function SkillEffectCalc_AddBloodOverFlow:DoSkillEffectCalculator(skillEffectCalcParam)
  local sSkillEffectCalc = self._world:GetService("SkillEffectCalc")
  local sBattle = self._world:GetService("Battle")
  local casterEntityId = skillEffectCalcParam:GetCasterEntityID()
  local caster = self._world:GetEntityByID(casterEntityId)
  local eTeam = caster:Pet():GetOwnerTeamEntity()
  local targetEntityIds = {
    eTeam:GetID()
  }
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local skillEffectParamAddBlood = SkillEffectParam_AddBlood:New(skillEffectParam:GetAddBlood())
  local skillId = skillEffectCalcParam:GetSkillID()
  local casterPos = caster:GridLocation():GetGridPos()
  local range = {casterPos}
  local param = SkillEffectCalcParam:New(casterEntityId, targetEntityIds, skillEffectParamAddBlood, skillId, range, casterPos, casterPos)
  local resultList = sSkillEffectCalc:CalcSkillEffectByType(param)
  local skillEffectResultContainer = caster:SkillContext():GetResultContainer()
  for index, result in ipairs(resultList) do
    skillEffectResultContainer:AddEffectResult(result)
    local addValue = result:GetAddValue()
    local maxHP = eTeam:Attributes():CalcMaxHp()
    local curHP = eTeam:Attributes():GetCurrentHP()
    local spilled = addValue + curHP - maxHP
    if 0 < spilled then
      local skillEffectParamSummonTrap = SkillSummonTrapEffectParam:New(skillEffectParam:GetSummonTrap())
      local targetIds = skillEffectCalcParam:GetTargetEntityIDs()
      local skillRange = skillEffectCalcParam:GetSkillRange()
      local attackPos = skillEffectCalcParam:GetAttackPos()
      local param = SkillEffectCalcParam:New(casterEntityId, targetIds, skillEffectParamSummonTrap, skillId, skillRange, attackPos, casterPos)
      local resultSummonTrap = sSkillEffectCalc:CalcSkillEffectByType(param)
      skillEffectResultContainer:AddEffectResult(resultSummonTrap)
    end
  end
end
