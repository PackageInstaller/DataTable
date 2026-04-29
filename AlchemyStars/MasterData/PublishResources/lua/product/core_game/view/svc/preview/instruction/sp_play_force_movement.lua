require("sp_base_inst")
_class("SkillPreviewPlayForceMovementInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayForceMovementInstruction = SkillPreviewPlayForceMovementInstruction

function SkillPreviewPlayForceMovementInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewEffectCalcService = world:GetService("PreviewCalcEffect")
  local scopeGridList = previewContext:GetScopeResult()
  local effect = previewContext:GetEffect(SkillEffectType.ForceMovement)
  local effectParam = previewEffectCalcService:CreateSkillEffectParam(SkillEffectType.ForceMovement, effect)
  local result = previewEffectCalcService:CalcForceMovement(casterEntity, previewContext, effectParam)
  self:_DoPresentation(TT, world, result)
end

function SkillPreviewPlayForceMovementInstruction:_DoPresentation(TT, world, result)
  local taskIDs = {}
  local array = result:GetMoveResult()
  for _, info in ipairs(array) do
    local entity = world:GetEntityByID(info.targetID)
    if info.isMoved then
      local tid = self:_DoSingleTarget(TT, world, info, entity)
      if tid then
        table.insert(taskIDs, tid)
      end
    end
  end
  while not TaskHelper:GetInstance():IsAllTaskFinished(taskIDs) do
    YIELD(TT)
  end
end

function SkillPreviewPlayForceMovementInstruction:_DoSingleTarget(TT, world, info, entity)
  local boardServiceRender = world:GetService("BoardRender")
  local entitySvc = world:GetService("RenderEntity")
  local ghostEntity = entitySvc:CreateGhost(info.v2OldPos, entity, "AtkUltPreview")
  ghostEntity:AddGridMove(BattleConst.ForceMovementPreviewSpeed, info.v2NewPos, info.v2OldPos)
  return GameGlobal.TaskManager():CoreGameStartTask(self._IsMoveFinished, self, ghostEntity)
end

function SkillPreviewPlayForceMovementInstruction:_IsMoveFinished(TT, entity)
  return not entity:HasGridMove()
end
