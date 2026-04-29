require("calc_base")
_class("SkillEffectCalcAttachMonster", SkillEffectCalc_Base)
SkillEffectCalcAttachMonster = SkillEffectCalcAttachMonster

function SkillEffectCalcAttachMonster:Constructor(world)
  self._world = world
end

function SkillEffectCalcAttachMonster:DoSkillEffectCalculator(skillEffectCalcParam)
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

function SkillEffectCalcAttachMonster:_CalculateSingleTarget(skillEffectCalcParam, targetID)
  local casterID = skillEffectCalcParam:GetCasterEntityID()
  local casterEntity = self._world:GetEntityByID(casterID)
  local targetEntity = self._world:GetEntityByID(targetID)
  local aiComponent = casterEntity:AI()
  aiComponent:SetRuntimeData("AttachMonsterID", targetID)
  self._world:GetService("Trigger"):Notify(NTAttachMonster:New(casterEntity, targetEntity))
  local eliteIDArray = self:_CalculateAddEliteIDArray(skillEffectCalcParam, casterEntity, targetEntity) or {}
  return SkillEffectAttachMonsterResult:New(targetID, eliteIDArray)
end

function SkillEffectCalcAttachMonster:_CalculateAddEliteIDArray(skillEffectCalcParam, casterEntity, targetEntity)
  local addEliteIDArray = {}
  local skillParam = skillEffectCalcParam:GetSkillEffectParam()
  if not skillParam:IsAddElite() then
    return
  end
  local casterMonsterIDCmpt = casterEntity:MonsterID()
  if not casterMonsterIDCmpt then
    return
  end
  local casterEliteIDArray = casterMonsterIDCmpt:GetEliteIDArray()
  if #casterEliteIDArray == 0 then
    return
  end
  local targetMonsterIDCmpt = targetEntity:MonsterID()
  if not targetMonsterIDCmpt then
    return
  end
  local targetEliteIDArray = targetMonsterIDCmpt:GetEliteIDArray()
  for _, id in ipairs(casterEliteIDArray) do
    if not table.icontains(targetEliteIDArray, id) then
      table.insert(addEliteIDArray, id)
    end
  end
  return addEliteIDArray
end
