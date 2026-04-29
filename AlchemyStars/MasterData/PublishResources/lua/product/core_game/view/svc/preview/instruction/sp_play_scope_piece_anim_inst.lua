require("sp_base_inst")
_class("SkillPreviewPlayScopePieceAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayScopePieceAnimInstruction = SkillPreviewPlayScopePieceAnimInstruction

function SkillPreviewPlayScopePieceAnimInstruction:Constructor(params)
  self._scopeAnim = params.ScopeAnim
  self._otherAnim = params.OtherAnim
end

function SkillPreviewPlayScopePieceAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local scopeGridList = previewContext:GetScopeResult()
  if not scopeGridList then
    return
  end
  previewActiveSkillService:DoConvert(scopeGridList, self._scopeAnim, self._otherAnim)
end
