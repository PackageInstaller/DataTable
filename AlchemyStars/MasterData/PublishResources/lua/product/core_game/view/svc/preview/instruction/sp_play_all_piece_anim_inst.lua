require("sp_base_inst")
_class("SkillPreviewPlayAllPieceAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayAllPieceAnimInstruction = SkillPreviewPlayAllPieceAnimInstruction

function SkillPreviewPlayAllPieceAnimInstruction:Constructor(params)
  self._anim = params.Anim
end

function SkillPreviewPlayAllPieceAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local previewActiveSkillService = world:GetService("PreviewActiveSkill")
  local scopeGridList = {}
  previewActiveSkillService:DoConvert(scopeGridList, "Gray", self._anim)
end
