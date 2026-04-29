require("sp_base_inst")
_class("SkillPreviewPlayPet1702361AnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayPet1702361AnimInstruction = SkillPreviewPlayPet1702361AnimInstruction

function SkillPreviewPlayPet1702361AnimInstruction:Constructor(params)
  self._animNotTeamLeader = params.animNotTeamLeader
  self._animTeamLeader = params.animTeamLeader
end

function SkillPreviewPlayPet1702361AnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  self._world = previewContext:GetWorld()
  local sPreviewSkill = self._world:GetService("PreviewActiveSkill")
  local playerAnimEntity, isTeamLeader, hasTrap = sPreviewSkill:GetPet1702361Entity(casterEntity, previewContext)
  local playAnim
  if isTeamLeader then
    playAnim = self._animTeamLeader
  else
    playAnim = self._animNotTeamLeader
  end
  playerAnimEntity:SetAnimatorControllerTriggers({playAnim})
end
