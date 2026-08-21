require("calc_base")
_class("SkillEffectCalc_AddBloodOverFlowForDamage", SkillEffectCalc_Base)
SkillEffectCalc_AddBloodOverFlowForDamage = SkillEffectCalc_AddBloodOverFlowForDamage

function SkillEffectCalc_AddBloodOverFlowForDamage:DoSkillEffectCalculator(skillEffectCalcParam)
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
      local damageParam = skillEffectParam:GetDamage()
      local skillDamageParam = SkillDamageEffectParam:New(skillEffectParam:GetDamage())
      if skillDamageParam then
        local effectCalcSvc = self._skillEffectService
        skillDamageParam.damageValue = spilled
        local skillRange = skillEffectCalcParam:GetSkillRange()
        local attackPos = skillEffectCalcParam:GetAttackPos()
        local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
        local curBodyArea = caster:BodyArea():GetArea()
        local utilScopeSvc = self._world:GetService("UtilScopeCalc")
        local scopeCalculator = utilScopeSvc:GetSkillScopeCalc()
        local scopeResult = scopeCalculator:ComputeScopeRange(damageParam.scopeType, damageParam.scopeParam, casterPos, curBodyArea)
        local targetSelector = self._world:GetSkillScopeTargetSelector()
        local targetEntityIDArray = targetSelector:DoSelectSkillTarget(caster, damageParam.scopeTargetType, scopeResult)
        local targetIDs = {}
        for _, targetID in ipairs(targetEntityIDArray) do
          if not table.intable(targetIDs, targetID) then
            table.insert(targetIDs, targetID)
          end
        end
        for _, targetID in ipairs(targetIDs) do
          local defender = self._world:GetEntityByID(targetID)
          if defender then
            local gridPos = defender:GetGridPosition()
            local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(caster, attackPos, defender, gridPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.Damage, damageStageIndex)
            local skillResult = effectCalcSvc:NewSkillDamageEffectResult(gridPos, targetID, nTotalDamage, listDamageInfo, damageStageIndex)
            skillEffectResultContainer:AddEffectResult(skillResult)
          end
        end
      end
    end
  end
end
