require("sp_base_inst")
_class("SkillPreviewPlayCasterMaterialAnimInstruction", SkillPreviewBaseInstruction)
SkillPreviewPlayCasterMaterialAnimInstruction = SkillPreviewPlayCasterMaterialAnimInstruction

function SkillPreviewPlayCasterMaterialAnimInstruction:Constructor(params)
  self._anim = params.Anim
  self._isPet1702361 = tonumber(params.isPet1702361)
end

function SkillPreviewPlayCasterMaterialAnimInstruction:DoInstruction(TT, casterEntity, previewContext)
  local playEntity = casterEntity
  if self._isPet1702361 == 1 then
    local sPreviewSkill = previewContext:GetWorld():GetService("PreviewActiveSkill")
    playEntity = sPreviewSkill:GetPet1702361Entity(casterEntity, previewContext)
  end
  if self._anim == "Flash" then
    playEntity:NewEnableFlash()
  elseif self._anim == "Transparent" then
    playEntity:NewEnableTransparent()
  elseif self._anim == "Ghost" then
    playEntity:NewEnableGhost()
  else
    playEntity:PlayMaterialAnim(self._anim)
  end
end
