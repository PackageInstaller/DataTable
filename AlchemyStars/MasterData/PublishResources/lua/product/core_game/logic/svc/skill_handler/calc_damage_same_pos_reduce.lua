_class("SkillEffectCalcDamageSamePosReduce", Object)
SkillEffectCalcDamageSamePosReduce = SkillEffectCalcDamageSamePosReduce

function SkillEffectCalcDamageSamePosReduce:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalcDamageSamePosReduce:DoSkillEffectCalculator(skillEffectCalcParam)
  local skillDamageParam = skillEffectCalcParam.skillEffectParam
  local range = skillEffectCalcParam.skillRange
  local targetIDs = skillEffectCalcParam:GetTargetEntityIDs()
  if #targetIDs == 1 and targetIDs[1] == -1 then
    local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
    local skillResult = self._skillEffectService:NewSkillDamageEffectResult(nil, -1, 0, nil, damageStageIndex)
    return {skillResult}
  end
  local casterID = skillEffectCalcParam.casterEntityID
  local casterEntity = self._world:GetEntityByID(casterID)
  local reduce = skillDamageParam:GetDampPercent()
  local posReduce = {}
  local effectCalcSvc = self._skillEffectService
  local damageStageIndex = skillDamageParam:GetSkillEffectDamageStageIndex()
  local attackPos = casterEntity:GetGridPosition()
  local retResult = {}
  local buffLogicService = self._world:GetService("BuffLogic")
  local finalEffectType = skillDamageParam:GetFinalEffectType()
  for i, pos in ipairs(range) do
    local targetID = self:GetTargetIDByPos(targetIDs, pos)
    if targetID then
      local targetEntity = self._world:GetEntityByID(targetID)
      local targetPos = pos
      local targetPosIndex = Vector2.Pos2Index(pos)
      if not posReduce[targetPosIndex] then
        posReduce[targetPosIndex] = 0
      end
      buffLogicService:ChangeSkillFinalParam(casterEntity, SkillEffectType.DamageSamePosReduce, finalEffectType, posReduce[targetPosIndex])
      local nTotalDamage, listDamageInfo = effectCalcSvc:ComputeSkillDamage(casterEntity, attackPos, targetEntity, targetPos, skillEffectCalcParam.skillID, skillDamageParam, SkillEffectType.DamageSamePosReduce, damageStageIndex)
      local skillResult = effectCalcSvc:NewSkillDamageEffectResult(targetPos, targetEntity:GetID(), nTotalDamage, listDamageInfo, damageStageIndex)
      buffLogicService:RemoveSkillFinalParam(casterEntity, SkillEffectType.DamageSamePosReduce, finalEffectType)
      posReduce[targetPosIndex] = posReduce[targetPosIndex] - reduce
      table.insert(retResult, skillResult)
    end
  end
  return retResult
end

function SkillEffectCalcDamageSamePosReduce:GetTargetIDByPos(targetIDs, pos)
  for i, targetID in ipairs(targetIDs) do
    local targetEntity = self._world:GetEntityByID(targetID)
    local targetPos = targetEntity:GetGridPosition()
    local areCmpt = targetEntity:BodyArea()
    local bodyArea = areCmpt:GetArea()
    for i, v in ipairs(bodyArea) do
      local newPos = v + targetPos
      if newPos.x == pos.x and newPos.y == pos.y then
        return targetID
      end
    end
  end
end
