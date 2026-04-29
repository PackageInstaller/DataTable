_class("SkillEffectCalc_TeleportAndReplaceBodyArea", Object)
SkillEffectCalc_TeleportAndReplaceBodyArea = SkillEffectCalc_TeleportAndReplaceBodyArea

function SkillEffectCalc_TeleportAndReplaceBodyArea:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_TeleportAndReplaceBodyArea:DoSkillEffectCalculator(skillEffectCalcParam)
  local results = {}
  local targets = skillEffectCalcParam:GetTargetEntityIDs()
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local targetID = targets[1]
  local targetEntity = self._world:GetEntityByID(targetID)
  if targetEntity then
    casterEntity = targetEntity
  end
  local utilData = self._world:GetService("UtilData")
  local sourcePos = casterEntity:GetGridPosition()
  local stageIndex = skillEffectCalcParam.skillEffectParam:GetSkillEffectDamageStageIndex()
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local boardSvc = self._world:GetService("BoardLogic")
  boardSvc:RemovePosBlock(casterEntity, sourcePos, BlockFlag.MonsterLand)
  local pos = param:GetTargetPos()
  local vDir = param:GetTargetDir()
  local newBodyArea = param:GetReplaceBodyArea()
  boardSvc:SetEntityBlockFlag(casterEntity, pos, BlockFlag.MonsterLand)
  local gridOffSet = param:GetReplaceGridOffSet()
  local damageOffSet = param:GetReplaceDamageOffSet()
  casterEntity:SetGridOffsetAndDamageOffset(gridOffSet, damageOffSet)
  local colorOld = utilData:FindPieceElement(sourcePos)
  local skillEffectResultChangeBodyArea = SkillEffectResultChangeBodyArea:New(casterEntity:GetID(), newBodyArea)
  table.insert(results, skillEffectResultChangeBodyArea)
  local result = SkillEffectResult_Teleport:New(casterEntity:GetID(), sourcePos, colorOld, pos, vDir, stageIndex)
  table.insert(results, result)
  return results
end
