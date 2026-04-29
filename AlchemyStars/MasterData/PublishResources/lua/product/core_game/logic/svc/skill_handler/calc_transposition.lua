_class("SkillEffectCalc_Transposition", Object)
SkillEffectCalc_Transposition = SkillEffectCalc_Transposition

function SkillEffectCalc_Transposition:Constructor(world)
  self._world = world
end

function SkillEffectCalc_Transposition:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local skillEffectParam = skillEffectCalcParam.skillEffectParam
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  if skillEffectParam:IsUseSuper() and casterEntity:HasSuperEntity() then
    casterEntity = casterEntity:GetSuperEntity()
  end
  local targetMonsterClassID = skillEffectParam:GetMonsterClassID()
  local targetEntity
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local monsterList, monsterPosList = utilScopeSvc:SelectAllMonster()
  for i, e in ipairs(monsterList) do
    local monsterClassID = e:MonsterID():GetMonsterClassID()
    if monsterClassID == targetMonsterClassID then
      targetEntity = e
      break
    end
  end
  if not targetEntity then
    return {}
  end
  local resultCaster = self:_CalcTeleportResult(casterEntity, targetEntity, skillEffectCalcParam)
  table.insert(results, resultCaster)
  local resultTarget = self:_CalcTeleportResult(targetEntity, casterEntity, skillEffectCalcParam)
  table.insert(results, resultTarget)
  return results
end

function SkillEffectCalc_Transposition:_CalcTeleportResult(entity, targetEntity, skillEffectCalcParam)
  local posOld = entity:GetGridPosition()
  local posNew = targetEntity:GetGridPosition()
  local utilData = self._world:GetService("UtilData")
  local colorOld = utilData:FindPieceElement(posOld)
  local dirNew = posNew - posOld
  local stageIndex = skillEffectCalcParam.skillEffectParam:GetSkillEffectDamageStageIndex()
  local result = SkillEffectResult_Teleport:New(entity:GetID(), posOld, colorOld, posNew, dirNew, stageIndex)
  return result
end
