require("sp_base_inst")
_class("SkillPreviewPlayOnlyScopePieceAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayOnlyScopePieceAnimInstruction = SkillPreviewPlayOnlyScopePieceAnimInstruction

function SkillPreviewPlayOnlyScopePieceAnimInstruction:Constructor(params)
  self._scopeAnim = params.ScopeAnim
end

function SkillPreviewPlayOnlyScopePieceAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local scopeGridList = previewContext:GetScopeResult()
  if not scopeGridList then
    return
  end
  previewActiveSkillService:DoAnim(scopeGridList, self._scopeAnim)
end
