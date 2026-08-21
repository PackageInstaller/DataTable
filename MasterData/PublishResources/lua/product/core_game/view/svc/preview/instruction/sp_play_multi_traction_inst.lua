require("sp_base_inst")
_class("SkillPreviewPlayMultiTractionInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayMultiTractionInstruction = SkillPreviewPlayMultiTractionInstruction

function SkillPreviewPlayMultiTractionInstruction:Constructor(params)
  self._transCenter = tonumber(params.transCenter)
end

function SkillPreviewPlayMultiTractionInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewEffectCalcService = world:GetService("PreviewCalcEffect")
  local scopeGridList = previewContext:GetScopeResult()
  local effect = previewContext:GetEffect(SkillEffectType.MultiTraction)
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.MultiTraction, effect)
  local transContextCenter = self._transCenter and self._transCenter == 1
  local result = previewEffectCalcService:CalcMultiTraction(casterEntity, previewContext, effectParam, transContextCenter)
  self:_DoPresentation(TT, world, result)
end

function SkillPreviewPlayMultiTractionInstruction:_DoPresentation(TT, world, result)
  local taskIDs = {}
  if result then
    local array = result:GetResultArray()
    for _, info in ipairs(array) do
      local entity = world:GetEntityByID(info.entityID)
      local startPos = entity:GetGridPosition()
      local endPos = info.finalPos
      if startPos ~= endPos then
        table.insert(taskIDs, self:_DoSingleTarget(TT, world, info, entity))
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
    YIELD(TT)
  end
  return InstructionConst.PhaseEnd
end

function SkillPreviewPlayMultiTractionInstruction:_DoSingleTarget(TT, world, info, entity)
  local boardServiceRender = world:GetService("BoardRender")
  local entitySvc = world:GetService("RenderEntity")
  local gridPos = entity:GetGridPosition()
  local ghostEntity = entitySvc:CreateGhost(gridPos, entity)
  ghostEntity:AddGridMove(BattleConst.TractionSpeed, info.finalPos, gridPos)
  return GameGlobal.TaskManager():CoreGameStartTask(self._IsMoveFinished, self, ghostEntity)
end

function SkillPreviewPlayMultiTractionInstruction:_IsMoveFinished(TT, entity)
  return not entity:HasGridMove()
end
