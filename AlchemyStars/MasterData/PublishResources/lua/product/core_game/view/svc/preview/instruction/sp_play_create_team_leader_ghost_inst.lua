require("sp_base_inst")
_class("SkillPreviewPlayCreateTeamLeaderGhostInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCreateTeamLeaderGhostInstruction = SkillPreviewPlayCreateTeamLeaderGhostInstruction

function SkillPreviewPlayCreateTeamLeaderGhostInstruction:Constructor(params)
  self._type = params.Type
end

function SkillPreviewPlayCreateTeamLeaderGhostInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = casterEntity:GetOwnerWorld()
  local teamEntity = world:Player():GetPreviewTeamEntity()
  if casterEntity:HasPet() then
    teamEntity = casterEntity:Pet():GetOwnerTeamEntity()
  end
  local teamLeaderEntity = teamEntity:GetTeamLeaderPetEntity()
  local entitySvc = world:GetService("RenderEntity")
  if self._type == "Scope" then
    local scopeList = previewContext:GetScopeResult()
    for _, pos in pairs(scopeList) do
      entitySvc:CreateGhost(pos, teamLeaderEntity, "AtkUltPreview")
    end
  elseif self._type == "PickUp" then
    entitySvc:CreateGhost(previewContext:GetPickUpPos(), teamLeaderEntity, "AtkUltPreview")
  end
end
