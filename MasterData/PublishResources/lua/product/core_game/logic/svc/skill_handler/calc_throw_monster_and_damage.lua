_class("SkillEffectCalc_ThrowMonsterAndDamage", Object)
SkillEffectCalc_ThrowMonsterAndDamage = SkillEffectCalc_ThrowMonsterAndDamage

function SkillEffectCalc_ThrowMonsterAndDamage:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_ThrowMonsterAndDamage:DoSkillEffectCalculator(skillEffectCalcParam)
  local monsterEntityIDs = self:GatherMonsterEntityIDs(skillEffectCalcParam)
  if #monsterEntityIDs == 0 then
    return
  end
  local damageRes = self:CalculateDamageResult(skillEffectCalcParam, monsterEntityIDs)
  local result = SkillEffectThrowMonsterAndDamageResult:New(monsterEntityIDs, damageRes)
  return {result}
end

function SkillEffectCalc_ThrowMonsterAndDamage:GatherMonsterEntityIDs(skillEffectCalcParam)
  local effectParam = skillEffectCalcParam:GetSkillEffectParam()
  local monsterClassID = effectParam:GetMonsterClassID()
  local monsterEntityIDs = {}
  local monsterGroup = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  for _, monsterEntity in ipairs(monsterGroup:GetEntities()) do
    local monsterIDCmpt = monsterEntity:MonsterID()
    if monsterIDCmpt and monsterClassID == monsterIDCmpt:GetMonsterClassID() and not monsterEntity:HasDeadMark() then
      table.insert(monsterEntityIDs, monsterEntity:GetID())
    end
  end
  return monsterEntityIDs
end

function SkillEffectCalc_ThrowMonsterAndDamage:CalculateDamageResult(skillEffectCalcParam, monsterEntityIDs)
  if #monsterEntityIDs == 0 then
    return nil
  end
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local basePercent = param:GetBasePercent()
  local addPercent = param:GetAddPercent()
  local curFormulaID = param:GetFormulaID()
  if curFormulaID == nil then
    curFormulaID = 2
  end
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local casterPos = casterEntity:GetGridPosition()
  local defenderEntity = self._world:Player():GetLocalTeamEntity()
  local defenderPos = defenderEntity:GetGridPosition()
  local attackCount = #monsterEntityIDs
  local percentList = {
    basePercent + addPercent * attackCount
  }
  local skillDamageParam = SkillDamageEffectParam:New({
    percent = percentList,
    formulaID = curFormulaID,
    damageStageIndex = 1
  })
  local nTotalDamage, listDamageInfo = self._skillEffectService:ComputeSkillDamage(casterEntity, casterPos, defenderEntity, defenderPos, skillEffectCalcParam:GetSkillID(), skillDamageParam, SkillEffectType.ThrowMonsterAndDamage, 1)
  local damageRes = self._skillEffectService:NewSkillDamageEffectResult(defenderPos, defenderEntity:GetID(), nTotalDamage, listDamageInfo)
  return damageRes
end
