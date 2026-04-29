require("base_ins_r")
_class("PlayDeleteGhostInstruction", BaseInstruction)
PlayDeleteGhostInstruction = PlayDeleteGhostInstruction

function PlayDeleteGhostInstruction:DoInstruction(TT, casterEntity, phaseContext)
  local svc = casterEntity:GetOwnerWorld():GetService("RenderEntity")
  svc:DestroyGhost()
end
