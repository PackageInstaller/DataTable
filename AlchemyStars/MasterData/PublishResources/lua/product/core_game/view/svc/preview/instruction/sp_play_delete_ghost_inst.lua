require("sp_base_inst")
_class("SkillPreviewPlayDeleteGhostInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayDeleteGhostInstruction = SkillPreviewPlayDeleteGhostInstruction

function SkillPreviewPlayDeleteGhostInstruction:Constructor(params)
end

function SkillPreviewPlayDeleteGhostInstruction:DoInstruction(TT, casterEntity, previewContext)
  local svc = casterEntity:GetOwnerWorld():GetService("RenderEntity")
  svc:DestroyGhost()
end
