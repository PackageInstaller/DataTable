require("sp_base_inst")
_class("SkillPreviewSetHudBgAlphaInstruction", SkillPreviewBaseInstruction)
SkillPreviewSetHudBgAlphaInstruction = SkillPreviewSetHudBgAlphaInstruction

function SkillPreviewSetHudBgAlphaInstruction:Constructor(params)
  self._alpha = tonumber(params.alpha)
  self._isDark = params.isDark
end

function SkillPreviewSetHudBgAlphaInstruction:DoInstruction(TT, casterEntity, previewContext)
  local world = previewContext:GetWorld()
  local cMainCamera = world:MainCamera()
  if self._isDark then
    cMainCamera:EnableDarkCamera(true)
    cMainCamera:SetHudBgAlpha(self._alpha)
  else
    cMainCamera:EnableDarkCamera(false)
    cMainCamera:SetHudBgAlpha(0)
  end
end
