require("sp_base_inst")
_class("SkillPreviewPlayDeleteCasterGhostInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayDeleteCasterGhostInstruction = SkillPreviewPlayDeleteCasterGhostInstruction

function SkillPreviewPlayDeleteCasterGhostInstruction:Constructor(params)
end

function SkillPreviewPlayDeleteCasterGhostInstruction:DoInstruction(TT, casterEntity, previewContext)
  local svc = casterEntity:GetOwnerWorld():GetService("RenderEntity")
  svc:DestroyGhost()
end
